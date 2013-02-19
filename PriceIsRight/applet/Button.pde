public class Button {
  float x;
  float y;
  String[] s;
  int quad;
  float quadHeight;

  boolean selected;  

  public Button(float x, float y, String[] s, int quad, float quadHeight) {
    this.x = x;
    this.y = y;
    this.s = s;
    this.quad = quad;
    this.quadHeight = quadHeight;
    
    selected = false;
  }

  public void render() {
    drawCircles(18, x, y);
    drawCircles(10, x, y);
    drawCircles(5, x, y);

    for (int i=0; i < s.length; i++) {
      text(s[i], x, y+25+10*i);
    }
  }
  
  public void update() {
      if (mouseX > graphX+graphWidth+22 && quad == getQuadrant(quadHeight)) {
        selected = true;
      }    
      else {
        selected = false;
      }
  }
}

