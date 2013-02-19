public class TextReader {
  BufferedReader bufferedReader;

  public TextReader(String filename) {
      bufferedReader = createReader(filename);
      
      println("file loaded successfully");
  }

  public String[] readHeader(int numLines) {
    try {
      String[] header = new String[numLines];
      for (int i=0; i < numLines; i++) {
        header[i] = bufferedReader.readLine();
      }
      return header;
    }
    catch (IOException e) {
      println("Error: " + e.getMessage());
    }
    return null;
  }

  public String readLine() {
    try {
      return bufferedReader.readLine();
    }
    catch (IOException e) {
      println("Error: " + e.getMessage());
    }
    return null;
  }
}

