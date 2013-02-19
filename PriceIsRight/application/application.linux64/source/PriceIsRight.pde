import processing.pdf.*;

public color WHITE = color(255);
public color ORANGE = color(250, 162, 27);
public color DARK_ORANGE = color(161, 95, 34);
public color RED = color(237, 53, 35);
public color YELLOW = color(255, 221, 0);
public color BLUE = color(79, 144, 195);
public color LIGHT_BLUE = color(115, 168, 193);

boolean startedCapture;

PFont font_normal;
PFont font_bold;

float graphX;
float graphY;
float graphWidth;
float graphHeight;

TextReader textReader;
GameData gameData;
GameGraph gameGraph;

ButtonStrip buttonStrip;
About about;
Help help;

CustomCursor customCursor;

void setup() {
  size(1024, 680);
  noCursor();
  smooth();

  startedCapture = false;

  font_normal = loadFont("Utsaah-48.vlw");
  font_bold = loadFont("Utsaah-Bold-48.vlw");

  graphX = 50;
  graphY = height-75-20;
  graphWidth = width-75-25-25-25-25;
  graphHeight = height-75-25-20;

  textReader = new TextReader("priceIsRightGamesFinal.txt");
  gameData = new GameData();
  gameGraph = new GameGraph(gameData, graphX, graphY, graphWidth, graphHeight);

  buttonStrip = new ButtonStrip(gameData, width-60, 0, 55, height);
  about = new About(width/8, height/4, 600, 300);
  help = new Help();

  customCursor = new CustomCursor();

  textReader.readHeader(1);

  String ln;
  while ( (ln = textReader.readLine ()) != null) {
    ln = ln.replace("\"", "");

    String[] elements = split(ln, TAB);
    gameData.insertGame(elements);
  }
}

void draw() {
  update();
  render();
}

void update() {  
  gameGraph.update();
}

void render() {
  background(ORANGE);
  gameGraph.render();
}

void drawCircles(float r, float x, float y) {
  ellipseMode(CENTER);
  for (int i=0; i < 10; i++) {
    pushMatrix();
    translate(x, y);
    rotate(radians(i * 36));
    translate(-x, -y);
    ellipse(x, y-r, r/2, r/2);
    popMatrix();
  }
}

float getBottomX() {
  float bottomX = map(mouseX, 0, width, 3, width-1);
  if (mouseX <= graphX+graphWidth && mouseY < graphY-22) {
    bottomX = map(getTopX()-45, 0, width, 3, width-1);
  }
  if (mouseX > graphX+graphWidth) bottomX = graphX+graphWidth;
  return bottomX;
}

float getTopX() {
  float topX = map(mouseX, 0, width, graphX+22, width-27);
  if (mouseX > graphX+graphWidth+22) topX = width-32.1;
  return topX;
}

float getTopY() {
  float topY = map(mouseY, 0, graphY-22, 22, graphY-22);
  if (mouseX > graphX+graphWidth+22) {
    float quadHeight = height/10;
    topY = 23.9+getQuadrant(quadHeight)*quadHeight;
  }
  return topY;
}

float getQuadrant(float quadHeight) {
  return (int)(mouseY/quadHeight);
}

void keyPressed() {
  /*if (key == 'r') {
    if (!startedCapture) {
      startedCapture = true;
      beginRecord(PDF, "priceIsRight.pdf");
    }
    else {
      startedCapture = false;
      endRecord();
      exit();
    }
  }*/
}
