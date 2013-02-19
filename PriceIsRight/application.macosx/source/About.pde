public class About {
  float x;
  float y;

  float w;
  float h;
  
  public About(float x, float y, float w, float h) {
    this.x = x;
    this.y = y;
    
    this.w = w;
    this.h = h;
  }
  
  public void render() {
    fill(WHITE, 200);
    noStroke();
    rectMode(CORNER);
    rect(0, 0, width-65, height);
    
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
    float textX = x+40+w/6;
    float textY = y+80;
    float textYOffset = 60;

    fill(RED);
    textFont(font_bold, 60);
    s = "The Price is in the Payoff";
    text(s, textX, textY);

    fill(RED);
    textFont(font_normal, 30);
    rectMode(CORNER);
    s = "A visualization of the payoffs of the currently played";
    text(s, textX, textY + 1*textYOffset);
    
    fill(RED);
    textFont(font_normal, 30);
    s = "Price is Right games, as determined by the ratio";
    text(s, textX, textY + 1.5*textYOffset);

    fill(RED);
    textFont(font_normal, 30);
    s = "of maximum possible dollar winnings to the probability";
    text(s, textX, textY + 2*textYOffset);

    fill(RED);
    textFont(font_normal, 30);
    s = "of winning each game";
    text(s, textX, textY + 2.5*textYOffset);
  }
}
