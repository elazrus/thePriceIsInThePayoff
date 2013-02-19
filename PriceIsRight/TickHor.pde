public class TickHor extends Tick {
  public TickHor(float tx, float ty, float sx, float sy, String s) {
    super(tx, ty, sx, sy, s);
  }

  public TickHor(Point tp, Point sp, String s) {
    super(tp, sp, s);
  }

  public void render() {
    line(tp.x-5, tp.y, tp.x+5, tp.y);
    textAlign(CENTER, CENTER);
    text(s, sp.x, sp.y);
  }
}

