class SkySplash extends Brush {
  public SkySplash(MenuPosition mp) {
    super(mp);
  }

  public void draw(int x, int y) {
    stroke(252, 216, 53);
    point(x, y);
    setSkyColor(y + 36);
    for (int i = 0; i < 16 * 16; i++) {
      Point p = randomPointInCircle(new Point(x, y), 16);
      point(p.x, p.y);
    }
  }

  private Point randomPointInCircle(Point center, int radius) {
    float len = random(0, radius);
    // Intentionally not using sqrt for uniform distribution
    // so that there are more random points close to center
    float angle = random(0, TWO_PI);
    return new Point(
       center.x + round(len * sin(angle)),
       center.y - round(len * cos(angle)));
  }
}
