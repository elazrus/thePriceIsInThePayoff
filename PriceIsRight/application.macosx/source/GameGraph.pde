public class GameGraph {
  boolean setUp;

  float graphX; // left axis
  float graphY; // lower axis

  float graphWidth;
  float graphHeight;

  float leftOffset;
  float rightOffset;

  float upperOffset;
  float lowerOffset;

  float vertTickHorOffset;
  float vertTickVertOffset;

  int selected;
  int neighbor1;
  int neighbor2;

  GameData gameData;

  float upperBound;
  float lowerBound;
  float diff;

  int numGameTicks;
  int numPriceTicks;

  float wBtwTicks;
  float hBtwTicks;

  ArrayList<Line> axes;

  ArrayList<Line> horLines;
  ArrayList<Line> vertLines;

  ArrayList<TickHor> horTicks;
  ArrayList<TickVert> vertTicks;

  ArrayList<Point> points;
  ArrayList<Line> connectors;
  ArrayList<Line> heights;

  ArrayList<GameInfoBlock> gameInfoBlocks;

  ArrayList<Integer> pointColors;
  ArrayList<Integer> dataColors;
  ArrayList<Integer> lineColors;

  ArrayList<Float> dataFontSizes;
  ArrayList<PFont> dataFonts;
  ArrayList<Float> dataRadii;
  ArrayList<Float> dataLineWeights; 

  public GameGraph(GameData gameData, float graphX, float graphY, float graphWidth, float graphHeight) {
    setUp = false;

    this.graphX = graphX;
    this.graphY = graphY;  

    this.graphWidth = graphWidth;
    this.graphHeight = graphHeight;

    leftOffset = 0 + graphX;
    rightOffset = width - (graphX+graphWidth);

    upperOffset = 0 + (graphY-graphHeight);
    lowerOffset = height - graphY;

    vertTickHorOffset = 35;
    vertTickVertOffset = 75;

    selected = -1;
    neighbor1 = -1;
    neighbor2 = -1;

    this.gameData = gameData;

    upperBound = 0;
    lowerBound = 0;

    numGameTicks = 0;
    numPriceTicks = 0;

    wBtwTicks = 0;
    hBtwTicks = 0;

    axes = new ArrayList<Line>();

    horLines = new ArrayList<Line>();
    vertLines = new ArrayList<Line>();

    horTicks = new ArrayList<TickHor>();
    vertTicks = new ArrayList<TickVert>();

    points = new ArrayList<Point>();
    connectors = new ArrayList<Line>();
    heights = new ArrayList<Line>();

    gameInfoBlocks = new ArrayList<GameInfoBlock>();

    pointColors = new ArrayList<Integer>();
    dataColors = new ArrayList<Integer>();
    lineColors = new ArrayList<Integer>();

    dataFontSizes = new ArrayList<Float>();
    dataFonts = new ArrayList<PFont>();
    dataRadii = new ArrayList<Float>();
    dataLineWeights = new ArrayList<Float>();
  }

  public boolean setUp() {
    lowerBound = 0.0;
    //100*floor((float)(gameData.minAverageWinnings()/100));
    upperBound = 15000.0; 
    //100*ceil((float)(gameData.maxAverageWinnings()/100));
    diff = upperBound - lowerBound;

    numGameTicks = gameData.games.size();
    numPriceTicks = ((int)diff / 100); 

    wBtwTicks = (graphWidth - 2*vertTickHorOffset) / numGameTicks;
    hBtwTicks = graphHeight / numPriceTicks;

    getAxes();

    getTicks();

    getCoords();

    return true;
  }

  public void getAxes() {
    axes.add(new Line(graphX, graphY, graphX, graphY-graphHeight)); // vert axis
    axes.add(new Line(graphX, graphY, graphX+graphWidth, graphY)); // hor axis
  }

  public void getTicks() { 
    for (int i=0; i < numGameTicks+1; i++) {
      vertLines.add(new Line(graphX+vertTickHorOffset+i*wBtwTicks, graphY, graphX+36+i*wBtwTicks, graphY-graphHeight));
      if (i > 0) 
        vertTicks.add(new TickVert(graphX+vertTickHorOffset+i*wBtwTicks, graphY, graphX+vertTickHorOffset-leftOffset/2+i*wBtwTicks-20, (graphY+vertTickVertOffset)-5, gameData.games.get(i-1)));
    }

    for (int i=0; i < numPriceTicks+1; i++) {
      if (i % 10 == 0) {
        horLines.add(new Line(graphX, graphY-i*hBtwTicks, graphX+graphWidth, graphY-i*hBtwTicks));
        String str = "$" + ((int)(lowerBound + i*100));
        horTicks.add(new TickHor(graphX, graphY-i*hBtwTicks, graphX - leftOffset/2, graphY-i*hBtwTicks, str));
      }
    }
  }

  public void getCoords() {  
    for (int i=0; i < numGameTicks; i++) {
      double winnings = gameData.getAverageWinnings(i);

      float xCoord = graphX + vertTickHorOffset + (i+1)*wBtwTicks;
      float yCoord = 
        map((float)winnings, lowerBound, upperBound, graphY, graphY-graphHeight);

      points.add(new Point(xCoord, yCoord));
      heights.add(new Line(xCoord, graphY, xCoord, yCoord));

      gameInfoBlocks.add(new GameInfoBlock(i, 85, 35));

      pointColors.add(WHITE);
      dataColors.add(WHITE);
      lineColors.add(YELLOW);

      dataFonts.add(font_normal);
      dataFontSizes.add(12.0);
      dataRadii.add(5.0);
      dataLineWeights.add(1.0);

      if (i > 0) {
        connectors.add(new Line(points.get(i), points.get(i-1)));
      }
    }
  }

  public void update() {
    if (!setUp) setUp = setUp();

    boolean overtop = false;

    buttonStrip.update();
    int selectedData = buttonStrip.getSelectedData();
    if (selectedData > -1 
      || buttonStrip.buttons[0].selected
      || buttonStrip.buttons[1].selected) overtop = true;

    for (int i=0; i < points.size(); i++) {
      float dx = abs(getTopX() - points.get(i).x);
      float dy = abs(getTopY() - points.get(i).y);

      float dh = mouseY - graphY;      
      float dw = points.get(i).x - getBottomX();

      if ((dx*dx + dy*dy) <= 25/*dx < gameGraph.wBtwTicks/2*/) {
        pointColors.set(i, YELLOW);
        dataColors.set(i, BLUE);
        lineColors.set(i, WHITE);

        dataFonts.set(i, font_bold);  
        dataFontSizes.set(i, 40.0);
        dataRadii.set(i, 8.0);
        dataLineWeights.set(i, 3.0);

        overtop = true;
        selected = i;
        neighbor1 = i-1;
        neighbor2 = i+1;
      } 
      else if (mouseY >= graphY-22 && 35 < dw && dw < 45 || i == selectedData) {
        pointColors.set(i, RED);
        dataColors.set(i, BLUE);
        lineColors.set(i, WHITE);

        dataFonts.set(i, font_bold);  
        dataFontSizes.set(i, 40.0);
        dataRadii.set(i, 12.0);
        dataLineWeights.set(i, 2.0);

        overtop = true;
        selected = i;
        neighbor1 = i-1;
        neighbor2 = i+1;
      }
      else {
        pointColors.set(i, WHITE);
        dataColors.set(i, WHITE);
        lineColors.set(i, YELLOW);

        dataFontSizes.set(i, 12.0);
        dataFonts.set(i, font_normal);
        dataRadii.set(i, 5.0);
        dataLineWeights.set(i, 1.0);
      }
    }

    if (overtop) {
      customCursor.overTop = true;
      if (buttonStrip.buttons[0].selected
        || buttonStrip.buttons[1].selected) {
        selected = -1;
        neighbor1 = -1;
        neighbor2 = -1;
      }
    }
    else {
      customCursor.overTop = false;
      selected = -1;
      neighbor1 = -1;
      neighbor2 = -2;
    }

    /*if (neighbor1 >= 0) {
      //pointColors.set(neightbor1, YELLOW);
      dataColors.set(neighbor1, RED);
      //lineColors.set(neighbor1, WHITE);

      dataFonts.set(neighbor1, font_bold);  
      dataFontSizes.set(neighbor1, 20.0);
      //dataRadii.set(neighbor1, 6.0);
      //dataLineWeights.set(neighbor1, 3.0);
    }
    if (0 < neighbor2 && neighbor2 < points.size()) {
      //pointColors.set(neightbor2, YELLOW);
      dataColors.set(neighbor2, RED);
      //lineColors.set(neighbor2, WHITE);

      dataFonts.set(neighbor2, font_bold);  
      dataFontSizes.set(neighbor2, 20.0);
      //dataRadii.set(neighbor2, 6.0);
      //dataLineWeights.set(neighbor2, 3.0);
    }*/
  }

  public void render() {
    for (int i=0; i < axes.size(); i++) {
      stroke(RED);
      strokeWeight(2);
      axes.get(i).render();
    }

    for (int i=0; i < horLines.size(); i++) {
      stroke(RED);
      strokeWeight(0.25);
      horLines.get(i).render();
    }

    for (int i=0; i < heights.size(); i++) {
      stroke(lineColors.get(i));
      strokeWeight(dataLineWeights.get(i));
      heights.get(i).render();
    }

    for (int i=0; i < horTicks.size(); i++) {
      fill(RED);
      stroke(RED);
      strokeWeight(2);
      textAlign(RIGHT, CENTER);
      textFont(font_normal, 16);
      horTicks.get(i).render();
    }

    for (int i=0; i < vertTicks.size(); i++) {
      fill(dataColors.get(i));
      stroke(lineColors.get(i));
      strokeWeight(dataLineWeights.get(i));
      textFont(dataFonts.get(i), dataFontSizes.get(i));
      if (selected != i /*&& neighbor1 != i && neighbor2 != i*/) vertTicks.get(i).render();
    }

    buttonStrip.render();

    for (int i=0; i < points.size(); i++) {
      fill(pointColors.get(i));
      noStroke();
      points.get(i).render(dataRadii.get(i));
    }

    customCursor.render();
    
    /*if (0 <= neighbor1) {
      fill(dataColors.get(neighbor1));
      stroke(lineColors.get(neighbor1));
      strokeWeight(dataLineWeights.get(neighbor1));
      textFont(dataFonts.get(neighbor1), dataFontSizes.get(neighbor1));
      vertTicks.get(neighbor1).render();

      gameInfoBlocks.get(neighbor1).render(gameData);
    }
    
    if (0 < neighbor2 && neighbor2 < points.size()) {
      fill(dataColors.get(neighbor2));
      stroke(lineColors.get(neighbor2));
      strokeWeight(dataLineWeights.get(neighbor2));
      textFont(dataFonts.get(neighbor1), dataFontSizes.get(neighbor2));
      vertTicks.get(neighbor2).render();

      gameInfoBlocks.get(neighbor2).render(gameData);
    }*/

    if (selected != -1) {
      fill(dataColors.get(selected));
      stroke(lineColors.get(selected));
      strokeWeight(dataLineWeights.get(selected));
      textFont(dataFonts.get(selected), dataFontSizes.get(selected));
      vertTicks.get(selected).render();

      gameInfoBlocks.get(selected).render(gameData);
    }

    if (buttonStrip.buttons[0].selected) {
      about.render();
    }

    if (buttonStrip.buttons[1].selected) {
      help.render();
    }
  }
}

