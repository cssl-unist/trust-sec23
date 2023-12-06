import java.io.BufferedReader;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.List;
import java.util.Scanner;



public class ProcessCommands {
  private static Runtime rt = Runtime.getRuntime();
  private static void runCommand(String command){
    System.out.println(command);
    String s = null;
    try {
        Process p = rt.exec(command);
        BufferedReader stdInput = new BufferedReader(new 
              InputStreamReader(p.getInputStream()));

        BufferedReader stdError = new BufferedReader(new 
              InputStreamReader(p.getErrorStream()));

        // read the output from the command
        System.out.println("Here is the standard output of the command:\n");
        while ((s = stdInput.readLine()) != null) {
            System.out.println(s);
        }
        
        // read any errors from the attempted command
        System.out.println("Here is the standard error of the command (if any):\n");
        while ((s = stdError.readLine()) != null) {
            System.out.println(s);
            System.out.println("Error occured");
            System.exit(-1);
        }
    } catch (IOException e) {
        e.printStackTrace();
    }
  }
  public static void main(String[] args){
    try {
      File commandsFile = new File("nightly_commands.txt");
      Scanner reader = new Scanner(commandsFile);
      String wholeFile = "";
      String mpkLibraryHome = "/home/martin/projects/mpk-rust/mpk-library/build";
      String mpkLibraryLink = " -lmpk";
      String LLVMDir = "/home/martin/rust/build/x86_64-unknown-linux-gnu/llvm/bin/";
      String LLVMOptArgs = "-mpk-isolation -mpk-isolation-gates ";
      String SVF = "/home/martin/projects/mpk-rust/SVF/bin/dvf ";
      String SVFArgs = " -cxt -query=all -max-cxt=100 -flow-bg=1000 -field-limit=0 -cxt-bg=1000 ";
      String currDir = System.getProperty("user.dir");
      String LLVMLLCArgs = " -relocation-model=pic -filetype=obj ";
      String finalCommand = "";
      while(reader.hasNextLine()){
        String data = reader.nextLine();
        wholeFile += data;
      }

      String [] words = wholeFile.split("\"clang\"");
      List<String> commands = new ArrayList<>();
      for(String word: words){
        if(!word.isEmpty()){
          String newCommand = "clang "+word+" -L"+mpkLibraryHome+mpkLibraryLink+" \n";
          commands.add(newCommand);
        }
      }
      for(String command: commands){
        if(command.contains("build_script_build"))
          continue;
        command = command.replace("\"", "");
        System.out.println(command);
        words = command.split(" ");
        List<String> objfiles = new ArrayList<>();
        for(String word: words){
          if(word.endsWith(".o")){
            word = word.substring(0, word.length()-2);
            word += ".bc ";
            objfiles.add(word);
            System.out.println("Working on "+word);
            String svf_cmd = SVF+SVFArgs+word;
            runCommand(svf_cmd);
          }
        }
        for(String obj: objfiles){
          System.out.println("Object file for opt: "+obj);
          Scanner myObj = new Scanner(System.in);  // Create a Scanner object
          System.out.println("Continue? ");

          String userName = myObj.nextLine();  // Read user input
          if(userName.equals("yes"));
          //String opt_cmd = LLVMDir+"opt "+LLVMOptArgs+obj+" -o "+obj;
          //runCommand(opt_cmd);
        }
        for(String obj: objfiles){
          String llc_cmd = LLVMDir+"llc "+obj+LLVMLLCArgs;
          runCommand(llc_cmd);
        }
        runCommand(command);
      }
      reader.close();
    } catch (FileNotFoundException e){
      System.out.println("Unable to open file: nightly_commands.txt");
      e.printStackTrace();
    }
  }
}
