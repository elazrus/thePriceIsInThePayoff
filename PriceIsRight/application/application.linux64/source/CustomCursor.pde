public class CustomCursor {
  boolean overTop;

  float x;
  float y;

  public CustomCursor() {
    overTop = false;

    x = mouseX;
    y = mouseY;
  }

  public void render() {
    if (mouseX > graphX+graphWidth+42 || mouseY < graphY-22) {
      noStroke();
      if (!overTop) fill(BLUE);
      else fill(RED);
      float r;

      x = getTopX();
      y = getTopY();
      
      for (int i=0; i < gameGraph.points.size(); i++) {
        float dx = abs(x - gameGraph.points.get(i).x);
        float dy = abs(y - gameGraph.points.get(i).y);

        if (/*dx < gameGraph.wBtwTicks/2*/(dx*dx + dy*dy) <= 25) {
          x = gameGraph.points.get(i).x;
          y = gameGraph.points.get(i).y;
        }
      }

      if (overTop && mouseX <= graphX+graphWidth+22 ) {
        drawCircles(32, x, y);
      }
      drawCircles(18, x, y);
      drawCircles(10, x, y);
      drawCircles(5, x, y);
    }

    noFill();
    stroke(RED);
    strokeWeight(3);
    line(getBottomX(), height, getBottomX(), height-20);
  }
}

