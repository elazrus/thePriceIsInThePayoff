public class Help {

  public Help() {
  }

  public void render() {
    String s;

    fill(WHITE, 100);
    noStroke();
    rectMode(CORNER);
    rect(0, 0, width-65, height);

    fill(RED);
    textAlign(CENTER, CENTER);
    textFont(font_bold, 20);
    s = "browse games by payoff by scrolling mouse over plotted points";
    text(s, graphX+graphWidth/2+4, 20);

    fill(RED);
    textAlign(CENTER, CENTER);
    textFont(font_bold, 20);
    s = "browse games alphabetically by scrolling mouse laterally";
    text(s, graphX+graphWidth/2+4, height-15);

    noFill();
    stroke(RED);
    strokeWeight(3);
    line(graphX, height-12, graphX+graphWidth/4, height-12);
    line(graphX+graphWidth-75, height-12, graphX+3*graphWidth/4, height-12);
    line(graphX, height-12, graphX-15, height-12-20);
    line(graphX+graphWidth-75, height-12, graphX+graphWidth-75+15, height-12-20);

    noFill();
    stroke(RED);
    strokeWeight(3);
    ellipseMode(CENTER);
    ArrayList<Point> points = gameGraph.points;
    for (int i=0; i < points.size(); i++) {
      Point point = points.get(i);
      if (point.y < height/3) ellipse(point.x, point.y, 20, 20);
    }
    
    fill(RED);
    textAlign(CENTER, CENTER);
    textFont(font_bold, 16);
    s = "browse game data extrema by scrolling vertically";
    for (int i=0; i < s.length(); i++) {
      char c = s.charAt(i);
      text(c, graphX+graphWidth+45, 170+i*10);
    }


    fill(BLUE);
    textAlign(LEFT, CENTER);
    textFont(font_bold, 20);
    s = "payoffs";
    text(s, 110, graphHeight/2+20);

    noFill();
    stroke(BLUE);
    strokeWeight(3);
    drawBracketOpenLeft(60, 20, 80, graphHeight+10);

    fill(BLUE);
    textAlign(RIGHT, CENTER);
    textFont(font_bold, 20);
    s = "extrema";
    text(s, graphX+graphWidth, graphHeight/2+126);

    noFill();
    stroke(BLUE);
    strokeWeight(3);
    drawBracketOpenRight(graphX+graphWidth+50, 150, 80, 3.05*height/4);

    fill(BLUE);
    textAlign(CENTER, CENTER);
    textFont(font_bold, 20);
    s = "games";
    text(s, graphX+graphWidth/2+4, graphY-50);

    noFill();
    stroke(BLUE);
    strokeWeight(3);
    drawBracketOpenDown(graphX+34, graphY+10, 80, 790);
  }

  public void drawBracketComponent(float x, float y, float w, float h) {
    beginShape();
    vertex(x, y);
    bezierVertex(x, y, x+w/2, y, x+w/2, y+h/15);
    vertex(x+w/2, y+14*h/15);
    bezierVertex(x+w/2, y+14*h/15, x+w/2, y+h, x+w, y+h);
    endShape();
  }

  public void drawBracketOpenLeft(float x, float y, float w, float h) {
    drawBracketComponent(x, y, w/2, h/2);
    drawBracketComponent(x, y+h, w/2, -h/2);
  }

  public void drawBracketOpenRight(float x, float y, float w, float h) {
    drawBracketOpenLeft(x, y, -w, h);
  }

  public void drawBracketOpenDown(float x, float y, float w, float h) {
    pushMatrix();
    translate(x, y);
    rotate(radians(-90));
    translate(-x, -y);
    drawBracketOpenLeft(x, y, w, h);
    popMatrix();
  }
}

