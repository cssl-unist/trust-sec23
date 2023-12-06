import java.io.File;
import java.io.FileNotFoundException;
import java.util.Scanner;

public class ProcessCommands {
  public static void main(String[] args){
    try {
      File commandsFile = new File("nightly_commands.txt");
      Scanner reader = new Scanner(commandsFile);
      String wholeFile = "";
      String mpkLibraryHome = "/home/martin/projects/mpk-rust/mpk-library/build";
      String mpkLibraryLink = " -lmpk";
      String customToolChainPath = "rust/build/lib/rustlib/x86_64-unknown-linux-gnu/lib";
      String nightlyToolChainPath = ".rustup/toolchains/nightly-x86_64-unknown-linux-gnu/lib/rustlib/x86_64-unknown-linux-gnu/lib";
      String customLibsString = "libaddr2line-332cb94bf345094b.rlib,libgimli-574b2ef29d4f20c5.rlib,libproc_macro-f7af62e934e91dc5.rlib,libterm-37dcd3cea7d9be4d.rlib,libadler-79ca49f3556701a4.rlib,libhashbrown-96ceb36319f90397.rlib,librustc_demangle-fe649840dc443879.rlib,libtest-14ac1fa0657f8ce9.rlib,liballoc-fe9f96fdcdfe4199.rlib,liblibc-fc24b68582e61891.rlib,librustc_std_workspace_alloc-358f99852a855d0c.rlib,libtest-14ac1fa0657f8ce9.so,libcfg_if-822e432ce2db6e62.rlib,libminiz_oxide-fe73ed392107a322.rlib,librustc_std_workspace_core-19ff454e2880fb3f.rlib,libunicode_width-ec0ab05272513c79.rlib,libcompiler_builtins-906b6a065e57e3b0.rlib,libobject-d3897e5b78a79908.rlib,librustc_std_workspace_std-ec903595daa2d8e4.rlib,libunwind-5f3a6e512e002a67.rlib,libcore-7f60aaeb82b6bf4d.rlib,libpanic_abort-a4cf26a03fcee531.rlib,libstd-c66143a79f112c56.rlib,libgetopts-b45426f1a67ad7d9.rlib,libpanic_unwind-2a21e5ef94ceb829.rlib,libstd-c66143a79f112c56.so";
      String [] customLibs = customLibsString.split(",");

      String finalCommand = "";
      while(reader.hasNextLine()){
        String data = reader.nextLine();
        wholeFile += data;
      }

      String [] words = wholeFile.split("\"cc\"");
      for(String word: words){
        if(!word.isEmpty()){
          finalCommand += "cc "+word+" -L"+mpkLibraryHome+mpkLibraryLink+" \n";
        }
      }
      finalCommand = finalCommand.replace("\"", "");
      System.out.println(finalCommand);
      reader.close();
    } catch (FileNotFoundException e){
      System.out.println("Unable to open file: nightly_commands.txt");
      e.printStackTrace();
    }
  }
}
