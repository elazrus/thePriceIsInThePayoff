public class GameData {
  ArrayList<String> games; // names
  ArrayList<String> averageWinnings; // in dollars
  ArrayList<String> maxWinnings; // in dollars
  ArrayList<String> maxWinningStats; // percentage
  ArrayList<String> frequencies; // percentage

  public GameData() {
    games = new ArrayList<String>();
    averageWinnings = new ArrayList<String>();
    maxWinnings = new ArrayList<String>();
    maxWinningStats = new ArrayList<String>();
    frequencies = new ArrayList<String>();
  }

  public void insertGame(String[] elements) {
    games.add(elements[0].replace("-", " "));
    averageWinnings.add(elements[1]);
    maxWinnings.add(elements[2]);
    maxWinningStats.add(elements[3]);  
    frequencies.add(elements[4]);
  }

  public double getAverageWinnings(int i) {
    String ln = averageWinnings.get(i);
    ln = ln.replace("$", "");
    ln = ln.replace(",", "");

    return Double.parseDouble(ln);
  }

  public double getMaxWinnings(int i) {
    String ln = maxWinnings.get(i);
    ln = ln.replace("$", "");
    ln = ln.replace(",", "");

    return Double.parseDouble(ln);
  }

  public double getMaxWinningStats(int i) {
    String ln = maxWinningStats.get(i);
    ln = ln.replace("%", "");

    return Double.parseDouble(ln);
  }

  public double getFrequencies(int i) {
    String ln = frequencies.get(i);
    ln = ln.replace("%", "");

    return Double.parseDouble(ln);
  }
  
  public int minAverageWinnings() {
    double min = getAverageWinnings(0);
    int j = 0;
    for (int i=0; i < averageWinnings.size(); i++) {
      if (getAverageWinnings(i) < min) {
        min = getAverageWinnings(i);
        j = i;
      }
    }
    return j;
  }
  
  public int maxAverageWinnings() {
    double max = getAverageWinnings(0);
    int j = 0;
    for (int i=0; i < averageWinnings.size(); i++) {
      if (getAverageWinnings(i) > max) {
        max = getAverageWinnings(i);
        j = i;
      }
    }
    return j;
  }
  
    public int minMaxWinnings() {
    double min = getMaxWinnings(0);
    int j = 0;
    for (int i=0; i < maxWinnings.size(); i++) {
      if (getMaxWinnings(i) < min) {
        min = getMaxWinnings(i);
        j = i;
      }
    }
    return j;
  }
  
  public int maxMaxWinnings() {
    double max = getMaxWinnings(0);
    int j = 0;
    for (int i=0; i < maxWinnings.size(); i++) {
      if (getMaxWinnings(i) > max) {
        max = getMaxWinnings(i);
        j = i;
      }
    }
    return j;
  }
  
    public int minMaxWinningStats() {
    double min = getMaxWinningStats(0);
    int j = 0;
    for (int i=0; i < maxWinningStats.size(); i++) {
      if (getMaxWinningStats(i) < min) {
        min = getMaxWinningStats(i);
        j = i;
      }
    }
    return j;
  }
  
  public int maxMaxWinningStats() {
    double max = getMaxWinningStats(0);
    int j = 0;
    for (int i=0; i < maxWinningStats.size(); i++) {
      if (getMaxWinningStats(i) > max) {
        max = getMaxWinningStats(i);
        j = i;
      }
    }
    return j;
  }
  
    public int minFrequencies() {
    double min = getFrequencies(0);
    int j = 0;
    for (int i=0; i < frequencies.size(); i++) {
      if (getFrequencies(i) < min) {
        min = getFrequencies(i);
        j = i;
      }
    }
    return j;
  }
  
  public int maxFrequencies() {
    double max = getFrequencies(0);
    int j = 0;
    for (int i=0; i < frequencies.size(); i++) {
      if (getFrequencies(i) > max) {
        max = getFrequencies(i);
        j = i;
      }
    }
    return j;
  }
}

