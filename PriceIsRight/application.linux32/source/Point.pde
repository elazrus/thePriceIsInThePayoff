public class Point {
  float x;
  float y;

  public Point(float x, float y) {
    this.x = x;
    this.y = y;
  }

  public void render(float r) {
    ellipseMode(CENTER);
    ellipse(x, y, r, r);
  }
}

