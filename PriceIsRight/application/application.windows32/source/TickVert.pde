public class TickVert extends Tick {
  public TickVert(float tx, float ty, float sx, float sy, String s) {
    super(tx, ty, sx, sy, s);
  }

  public TickVert(Point tp, Point sp, String s) {
    super(tp, sp, s);
  }

  public void render() {
    line(tp.x, tp.y-5, tp.x, tp.y+5);
    
    pushMatrix();
    translate(tp.x, tp.y+5);
    rotate(radians(-60));
    translate(-tp.x, -(tp.y+5));
    line(tp.x, tp.y+5, tp.x-75, tp.y+5);
    popMatrix();
    
    textAlign(LEFT, CENTER);
    pushMatrix();
    translate(sp.x, sp.y);
    rotate(radians(-60));
    translate(-sp.x, -sp.y);
    text(s, sp.x, sp.y);
    popMatrix();
  }
}

