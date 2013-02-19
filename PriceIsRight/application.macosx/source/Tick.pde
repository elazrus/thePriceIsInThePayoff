public abstract class Tick {
  Point tp;
  Point sp;
  String s;

  public Tick(float tx, float ty, float sx, float sy, String s) {
    tp = new Point(tx, ty);
    sp = new Point(sx, sy);
    this.s = s;
  }

  public Tick(Point tp, Point sp, String s) {
    this.tp = tp;
    this.sp = sp;
    this.s = s;
  }

  public abstract void render();
}

