public class GraphData {
  int category;
  GameGraph gameGraph;
  ArrayList<Integer> ordering;

  float lowerBound;
  float upperBound;
  float diff;

  int numGameTicks;
  int numPriceTicks;

  float wBtwTicks;
  float hBtwTicks;

  ArrayList<Line> horLines;

  ArrayList<TickHor> horTicks;
  ArrayList<TickVert> vertTicks;

  ArrayList<Point> points;
  ArrayList<Line> heights;

  ArrayList<GameInfoBlock> gameInfoBlocks;

  public GraphData(GameGraph gameGraph, int category) {
    this.category = category;
    this.gameGraph = gameGraph;

    switch(category) {
    case GameGraphConstants.PAYOFF:
      ordering = gameGraph.gameData.sortByMaxAverageWinnings();
      break;
    case GameGraphConstants.MAXWIN:
      ordering = gameGraph.gameData.sortByMaxMaxWinnings();
      break;
    case GameGraphConstants.MAXSTATS:
      ordering = gameGraph.gameData.sortByMaxMaxWinningStats();
      break;
    case GameGraphConstants.MAXFREQ:
      ordering = gameGraph.gameData.sortByMaxFrequencies();
      break;
    default:
      ordering = gameGraph.gameData.sortByMaxAverageWinnings();
      break;
    }    

    lowerBound = 0.0;  
    switch(category) {
    case GameGraphConstants.PAYOFF:
      upperBound = 15000.0;
      break;
    case GameGraphConstants.MAXWIN:
      upperBound = 100000.0;
      break;
    case GameGraphConstants.MAXSTATS:
      upperBound = 100.0;
      break;
    case GameGraphConstants.MAXFREQ:
      upperBound = 5.0;
      break;
    default:
      upperBound = 15000.0;
      break;
    }
    diff = upperBound-lowerBound;

    numGameTicks = gameGraph.gameData.games.size();

    switch(category) {
    case GameGraphConstants.PAYOFF:
      numPriceTicks = (int)(diff / 1500.0); 
      break;
    case GameGraphConstants.MAXWIN:
      numPriceTicks = (int)(diff / 10000.0); 
      break;
    case GameGraphConstants.MAXSTATS:
      numPriceTicks = (int)(diff / 10.0); 
      break;
    case GameGraphConstants.MAXFREQ: 
      numPriceTicks = (int)(diff / 0.5); 
      break;
    default:
      numPriceTicks = (int)(diff / 1500.0); 
      break;
    }
    numPriceTicks++;

    wBtwTicks = (gameGraph.graphWidth - 2*gameGraph.vertTickHorOffset) / numGameTicks;
    hBtwTicks = gameGraph.graphHeight / numPriceTicks;

    horLines = new ArrayList<Line>();

    horTicks = new ArrayList<TickHor>();
    vertTicks = new ArrayList<TickVert>();

    points = new ArrayList<Point>();
    heights = new ArrayList<Line>();

    gameInfoBlocks = new ArrayList<GameInfoBlock>();

    setUp();
  }

  public void setUp() {
    getLinesAndTicks();
    getCoords();
  }

  public void getLinesAndTicks() {
    getHorLinesAndTicks();
    getVertTicks();
  }

  public void getHorLinesAndTicks() {
    float x1, x2, startY;
    String str;

    for (int i=0; i < numPriceTicks+1; i++) {
      if (i>0) {
        x1 = gameGraph.graphX;
        x2 = x1 + gameGraph.graphWidth;
        startY = gameGraph.graphY;
        horLines.add(new Line(x1, startY-i*hBtwTicks, x2, startY-i*hBtwTicks));

        x2 = x1 - gameGraph.leftOffset/2;
        switch(category) {
        case GameGraphConstants.PAYOFF:
          str = "$" + ((int)(lowerBound + (i-1)*1500));
          break;
        case GameGraphConstants.MAXWIN:
          str = "$" + ((int)(lowerBound + (i-1)*100000));
          break;
        case GameGraphConstants.MAXSTATS:
          str = ((int)(lowerBound + (i-1)*10)) + "%";
          break;
        case GameGraphConstants.MAXFREQ:
          str = ((lowerBound + (i-1)*0.5)) + "%";
          break;
        default:
          str = "$" + ((int)(lowerBound + (i-1)*100));
          break;
        }
        horTicks.add(new TickHor(x1, startY-i*hBtwTicks, x2, startY-i*hBtwTicks, str));
      }
    }
  }

  public void getVertTicks() {
    float startX, y1, y2;
    String str;

    for (int i=0; i < numGameTicks+1; i++) {
      startX = gameGraph.graphX + gameGraph.vertTickHorOffset;
      y1 = gameGraph.graphY;
      y2 = height - gameGraph.vertTickVertOffset;
      if (i > 0) {
        str = gameGraph.gameData.games.get(ordering.get(i-1));
        vertTicks.add(new TickVert(startX+(i)*wBtwTicks, y1, startX+(i)*wBtwTicks-gameGraph.leftOffset/2-15, y2, str));
      }
    }
  }

  public void getCoords() {  
    for (int i=0; i < numGameTicks; i++) {
      int index = ordering.get(i);

      double value;
      switch(category) {
      case GameGraphConstants.PAYOFF:
        value = gameGraph.gameData.getAverageWinnings(index, gameData.averageWinnings);
        break;
      case GameGraphConstants.MAXWIN:
        value = gameGraph.gameData.getMaxWinnings(index, gameData.maxWinnings);
        break;
      case GameGraphConstants.MAXSTATS:
        value = gameGraph.gameData.getMaxWinningStats(index, gameData.maxWinningStats);
        break;
      case GameGraphConstants.MAXFREQ:
        value = gameGraph.gameData.getFrequencies(index, gameData.frequencies);
        break;
      default:
        value = gameGraph.gameData.getAverageWinnings(index, gameData.averageWinnings);
        break;
      }


      float xCoord = gameGraph.graphX + gameGraph.vertTickHorOffset + (i+1)*wBtwTicks;
      float yCoord = 
        map((float)value, lowerBound, upperBound, gameGraph.graphY-hBtwTicks, gameGraph.graphY-gameGraph.graphHeight);

      points.add(new Point(xCoord, yCoord));
      heights.add(new Line(xCoord, gameGraph.graphY, xCoord, yCoord));

      gameInfoBlocks.add(new GameInfoBlock(index, width-400, 35));
    }
  }
  
  public ArrayList<Integer> searchVertTicks(String substring) {
    substring = substring.toLowerCase();
    ArrayList<Integer> matchingIndices = new ArrayList<Integer>();
    for (int i=0; i < vertTicks.size(); i++) {
      String game = vertTicks.get(i).s.toLowerCase();
      if (game.startsWith(substring)) {
        matchingIndices.add(i);
      }
    }
    return matchingIndices;
  }
}

