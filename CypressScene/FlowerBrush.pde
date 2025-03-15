class FlowerBrush extends Brush {
  public FlowerBrush(MenuPosition mp) {
    super(mp);
  }
  
  public void draw(int x, int y) {
    drawFlower(1.0 * x, 1.0 * y);
  }
  
  void drawFlower(float rootX, float rootY) {
    drawFlowerHelper(rootX, rootY);
  }

  void drawFlowerHelper(float rootX, float rootY) {
    stroke(100, 147, 92);
    stroke(random(62, 100), random(102, 147), random(56, 92));
    strokeWeight(4);
    for (int i = -2; i < 4; i++) {
      float x = rootX;
      float y = rootY;
      beginShape();
      curveVertex(x, y);
      curveVertex(x, y);
      curveVertex(x + i, y-8);
      curveVertex(x + i -1, y-16);
      curveVertex(x + i -1, y-16);
      endShape();
    }
  }
}
