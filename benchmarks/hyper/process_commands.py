import subprocess
from cgi import print_form
from code import compile_command
from distutils.util import execute
import glob, os, sys;
from subprocess import(Popen, PIPE)
import shlex
import re
import time

args = sys.argv
if len(args) == 1:
    SVFArgs = "-cxt -query=all -max-cxt=100 -flow-bg=1000000 -field-limit=0 -cxt-bg=1000000"
elif (len(args) > 1) and (len(args) < 4):
    print("Please provide full arguments for SVF or opt for default args")
    exit(-1)
else:
    SVFArgs = "-cxt -query=all -max-cxt="+args[1]+" -flow-bg="+args[2]+" -field-limit=0 -cxt-bg="+args[3]
    
buildTarget = "x86_64-unknown-linux-gnu"
SVF = "/home/martin/projects/mpk-rust/SVF/bin/dvf"
llvmDir = "/home/martin/rust/build/x86_64-unknown-linux-gnu/llvm/bin"
llvmLinker = llvmDir+"/llvm-link"
llvmCompiler = llvmDir+"/llc"
llvmOpt = llvmDir+"/opt"
llvmOptArgs = " -mpk-isolation -mpk-isolation-gates "
llvmCompilerFlags = " -relocation-model=pic -filetype=obj "
LIB_MPK_DIR="/home/martin/projects/mpk-rust/mpk-library/build"
LIB_MPK="-lmpk"

nightlyCommandsFile = open("nightly_commands.txt","r")
commands =  nightlyCommandsFile.readlines(); 

print("Changing directory ")
currDir = os.getcwd()
print("Current Directory: ",currDir)

local_rlibs = []
command_to_objectFiles = {}
command_to_rlibs = {}
command_to_binary = {}
local_rlib_to_singleBC = {}

os.chdir(currDir+"/target/release/deps")
currDir = os.getcwd()
print("Current Directory: ",currDir)

print("Erasing unoptimized bitcode files")
for no_opt in glob.glob("*no-opt.bc"):
    os.remove(no_opt)
    
def execute_command(command, success_msg, failure_msg):
    print("Running command: ",command)
    with Popen(command, stdout=PIPE, stderr=PIPE, shell=True, universal_newlines=True) as proc:
        for line in proc.stdout:
            print(line, end='')
    if proc.returncode != 0:
        print("{}\n".format(failure_msg), proc.stderr.read())
        exit(-1)
    time.sleep(5)
    print(success_msg)

numCommands = len(commands)
for i in range(numCommands):
    commands[i] = commands[i].replace('\"','')
    print("Command: \n", commands[i]);
    
    command = commands[i]
    command_to_objectFiles.setdefault(command,[])
    command_to_rlibs.setdefault(command,[])
    
    libs = command.split(" ")
    for lib in libs:
        
        if lib.endswith(".rlib") and currDir in lib and lib not in local_rlibs:
            local_rlibs.append(lib)
            command_to_rlibs[command].append(lib)
        elif lib in local_rlibs and lib not in command_to_rlibs[command]:
            command_to_rlibs[command].append(lib)
        elif lib.endswith(".o") and lib not in command_to_objectFiles[command]:
            command_to_objectFiles[command].append(lib)
            
    command_to_binary[command] = libs[libs.index("-o")+1]
    binary = command_to_binary[command]
   
for lib in local_rlibs:
    lib = str(lib)
    lib_dirs = lib.split("/")
    stripped_name = lib_dirs[-1]
    stripped_name = stripped_name.replace(".rlib","")
    stripped_name = stripped_name[3:]
    
    linker_bc = stripped_name+".bc "
    local_rlib_to_singleBC.setdefault(lib,linker_bc)
    
for command in commands:
    finalBinary = command_to_binary[command]
    
    if "build_script" in finalBinary:
        continue
    
    bc_files = []
    """for lib in command_to_rlibs[command]:
        bc_file = local_rlib_to_singleBC[lib]
        ##################### Run SVF ####################
        print("Running SVF on: ",bc_file)
        svf_command = SVF + " "+bc_file+ " "+SVFArgs
        svf_command = shlex.split(svf_command)
        execute_command(svf_command,"Completed Pointer Analysis successfully", "SVF failed to complete")
        
        ##################### Applying MPK Backend ############
        print("Applying MPK Backend Passes on: ",bc_file)
        opt_command = llvmOpt+llvmOptArgs+bc_file+" -o "+bc_file
        opt_command = shlex.split(opt_command)
        execute_command(opt_command, "Applied MPK Isolation Passes successfully","Faied to apply MPK Isolation Passes")
        bc_files.append(bc_file)"""
    
    for obj in command_to_objectFiles[command]:
        obj = str(obj)
        stripped_obj = obj.replace(".o",".bc")
        if stripped_obj in bc_files:
            continue
        ##################### Run SVF ####################
        print("Running SVF on: ",stripped_obj)
        svf_command = SVF + " "+SVFArgs+" "+stripped_obj
        #svf_command = shlex.split(svf_command)
        execute_command(svf_command,"Completed Pointer Analysis successfully", "SVF failed to complete")
        
        ##################### Applying MPK Backend ############
        print("Applying MPK Backend Passes on: ",stripped_obj)
        print(stripped_obj)
    move_on = input("Continue? ")
    while "yes" not in move_on:
        move_on = input("Continue? ")
        if "end" in move_on:
            exit(0)
    """       
        opt_command = llvmOpt+llvmOptArgs+stripped_obj+" -o "+stripped_obj
        opt_command.replace(currDir+"/",'')
        subprocess.run(opt_command)
        #opt_command = shlex.split(opt_command)
        execute_command(opt_command, "Applied MPK Isolation Passes successfully","Faied to apply MPK Isolation Passes")
        bc_files.append(stripped_obj)
        
        ##################### Compiling .bc to .o #######################
        print("\nCompiling bitcode to object code")
        compile_command = llvmCompiler + " "+stripped_obj + llvmCompilerFlags
        compile_command.replace(currDir+"/",'')
        #compile_command = shlex.split(compile_command)
        execute_command(compile_command, "Compiled .bc to .o files successfully", "Object code compilation failed")
    """
    
    ########################## Link llvm-bitcode files ##################
    """finalLinkable = finalBinary+".bc"
    linkables = ' '.join(bc_files)
    linkerArgs = linkables+" -o "+finalLinkable
    print("Running Linker ...")
    print("Link command: ",llvmLinker,linkerArgs)
    link_command = llvmLinker+" "+linkerArgs;
    link_command = shlex.split(link_command)
        
    execute_command(link_command,"BC files linked successfully","Failed to link bc files")
    """
        
    
    ####################### Compiling final binary ###############################
    
    print("Compiling final binary")
    
    finalCommand = command
    finalCommand = finalCommand.replace("\n"," -L "+LIB_MPK_DIR+" "+LIB_MPK+"\n")
    
    """for lib in command_to_rlibs[command]:
        if lib in local_rlibs:
            finalCommand = finalCommand.replace(lib,'')
        
    print("Final Binary: ",finalBinary)
    for obj in command_to_objectFiles[command]:
        if finalBinary+".o" not in finalCommand:
            finalCommand = finalCommand.replace(obj, finalBinary+".o")
        elif finalBinary+".o" not in obj:
            finalCommand = finalCommand.replace(obj,'')"""
    
    print("Previous Command: {}\n".format(command))
    print("Final Command: ",finalCommand)
    #finalCommand = shlex.split(finalCommand)
    execute_command(finalCommand, "Final Build compiled successfully", "Failed to compile final binary")




        
