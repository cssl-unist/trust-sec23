#!/bin/bash
cp ./nightly_commands.txt ../target/release/deps/.
cd ../target/release/deps

SVF=$PRJHOME"/mpk-svf/Release-build/bin/dvf"
echo "SVF directory : "$SVF
SVFARGS="-cxt -query=all -max-cxt=10 -flow-bg=1000 -field-limit=0 -cxt-bg=1000"
LLVM_DIR=$PRJHOME"/rust/build/x86_64-unknown-linux-gnu/llvm/bin"
echo "LLVM directory : "$LLVM_DIR
LLVM_OPT="$LLVM_DIR/opt"
LLVM_OPT_ARGS="-mpk-isolation -mpk-isolation-gates"
LLVM_LLC="$LLVM_DIR/llc"
LLVM_LLC_ARGS="-relocation-model=pic -filetype=obj"
PROCESSED_BCS=""
while IFS= read -r line;
do
    processed=${line//\"/}
    if [[ "$processed" == *"build_script_build"* ]]; then
        continue
    fi
    
    STR_ARRAY=(`echo $processed | tr " " "\n"`)

    prev=""
    lib=0
    for str in "${STR_ARRAY[@]}"
    do
        if [[ "$str" == *".so"* ]]; then
            echo $str
            echo $prev
            if [[ "$prev" == "-o" ]]; then
                lib=1
                break
            fi
        fi
        prev=$str
    done

    if [[ $lib == 1 ]]; then
        continue
    fi 

    echo "matchinng bc files"
    for bc_file in $(ls *.bc);
    do
        if [[ "$PROCESSED_BCS" == *"$bc_file"* ]]; then
            continue;
        fi 
        stripped_bc=${bc_file/%.bc/}
        stripped_bc=${stripped_bc/#./}
        #echo "Original: $bc_file, stripped: $stripped_bc"
        if [[ "$processed" == *"$stripped_bc"* ]]; then
            PROCESSED_BCS="$PROCESSED_BCS $bc_file"
            echo "Running SVF on $bc_file"
            eval $SVF $SVFARGS $bc_file &> output.txt; cat output.txt
            if [[ $? -ne 0 ]]; then
                cat output.txt
                exit -1
            fi
            echo "SVF successfully run"
            echo "Running OPT on $bc_file"
            $LLVM_OPT -mpk-isolation -mpk-isolation-gates $bc_file -o $bc_file &> output.txt
            if [[ $? -ne 0 ]]; then
                cat output.txt
                exit -1
            fi 
            echo "OPT successfully run"
            echo "Running LLC on $bc_file"
            $LLVM_LLC $bc_file -relocation-model=pic -filetype=obj &> output.txt
            
            if [[ $? -ne 0 ]]; then
                cat output.txt
                exit -1 
            fi 
            echo "LLC successfully run"
        fi
    done
    echo "Executing command:"
    processed="$processed -L$PRJHOME/mpk-library/build -lmpk"
    echo $processed
    eval "$processed" &> output.txt
    if [[ $? -ne 0 ]]; then
        cat output.txt
        exit -1
    fi
done < nightly_commands.txt

