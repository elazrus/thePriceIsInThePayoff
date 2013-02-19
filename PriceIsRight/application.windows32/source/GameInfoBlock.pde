public class GameInfoBlock {
  int index;

  float x;
  float y;

  float w;
  float h;

  public GameInfoBlock(int index, float x, float y) {
    this.index = index;

    this.x = x;
    this.y = y;

    w = 200;
    h = 100;
  }

  public void render(GameData gameData) {
    // draw price tag
    noFill();
    stroke(BLUE);
    strokeWeight(7);
    bezier(x+w/10, y+h/2, x-w/10, y+3*h/4, x+10, y+9*h/8, x+10, y+9*h/8);

    noFill();
    stroke(WHITE);
    strokeWeight(2);
    bezier(x+w/10, y+h/2, x-w/10, y+3*h/4, x+10, y+9*h/8, x+10, y+9*h/8);

    fill(YELLOW);
    stroke(WHITE);
    strokeWeight(3);
    beginShape();
    vertex(x, y+h/4);
    vertex(x+w/6, y);
    vertex(x+7*w/6, y);
    vertex(x+7*w/6, y+h);
    vertex(x+w/6, y+h);
    vertex(x, y+3*h/4);
    endShape(CLOSE);
    //rectMode(CORNER);
    //rect(x, y, w, h);

    ellipseMode(CENTER);
    fill(ORANGE);
    stroke(WHITE);
    strokeWeight(3);
    ellipse(x+w/10, y+h/2, 15, 15);

    noFill();
    stroke(BLUE);
    strokeWeight(7);
    bezier(x+w/10, y+h/2, x+w/5, y+3*h/4, x, y+9*h/8, x, y+9*h/8);
    
    noFill();
    stroke(WHITE);
    strokeWeight(2);
    bezier(x+w/10, y+h/2, x+w/5, y+3*h/4, x, y+9*h/8, x, y+9*h/8);

    textAlign(LEFT, CENTER);
    String s;
    float textX = x+20+w/6;
    float textY = y+8;
    float textYOffset = 20;

    fill(RED);
    textFont(font_bold, 20);
    s = gameData.games.get(index);
    text(s, textX, textY + 0*textYOffset);

    fill(RED);
    textFont(font_normal, 14);
    s = "Payoff: " + gameData.averageWinnings.get(index);
    text(s, textX, textY + 1*textYOffset);

    fill(RED);
    textFont(font_normal, 14);
    s = "Max Possible Winnings: " + gameData.maxWinnings.get(index);
    text(s, textX, textY + 2*textYOffset);

    fill(RED);
    textFont(font_normal, 14);
    s = "Win Max " + gameData.maxWinningStats.get(index) + "of the Time";
    text(s, textX, textY + 3*textYOffset);

    fill(RED);
    textFont(font_normal, 14);
    s = "Is Played " + gameData.frequencies.get(index) + "of the Time";
    text(s, textX, textY + 4*textYOffset);
  }
}

