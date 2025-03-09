class FlowerBrush extends Brush {
  public FlowerBrush(MenuPosition mp) {
    super(mp);
  }
  
  public void draw() {
    for (Point p : points) {
      drawFlower(p.x, p.y);
    }
  }
  
  void drawFlower(float rootX, float rootY) {
    stroke(62, 102, 56);
    strokeWeight(1);
    //line(rootX, rootY, rootX, rootY + 16);

    float x = rootX;
    float y = rootY;
    beginShape();
    curveVertex(x, y);
    curveVertex(x, y);
    curveVertex(x+random(-3, 3), y-4);
    curveVertex(x+random(-6, 6), y-8);
    curveVertex(x+10, y+16);
    curveVertex(x+10, y+16);
    endShape();
    
  }
}
