public class Line {
  Point p1;
  Point p2;

  public Line(float x1, float y1, float x2, float y2) {
    p1 = new Point(x1, y1);
    p2 = new Point(x2, y2);
  }

  public Line(Point p1, Point p2) {
    this.p1 = p1;
    this.p2 = p2;
  }

  public void render() {
    line(p1.x, p1.y, p2.x, p2.y);
  }
}

