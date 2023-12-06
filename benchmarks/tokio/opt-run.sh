#/bin/bash
benches=$(ls benches/*.rs)
echo "BENCHMARKS"
echo $benches
for bench in $benches;
do
	prefix="benches/"
	suffix=".rs"
	bench=${bench#"$prefix"}
	bench=${bench%"$suffix"}
	echo "Compiling $bench"
	cd target/release/deps
	pwd
	rm ${bench-*.$bench*.bc}
	ls ${bench-*.bc}
done
