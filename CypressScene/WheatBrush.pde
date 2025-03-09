class WheatBrush extends Brush {
  public WheatBrush(MenuPosition mp) {
    super(mp);
  }
  
  public void draw(int x, int y) {
    drawGrass(1.0 * x, 1.0 * y);
  }
  
  void drawGrass(float x, float y) {
    float endX = x + random(16);
    float endY = y - random(16);
    float randColor = random(1);
    float randWeight = random(1);
    if (randColor < 0.33) {
      stroke(138, 166, 26);
    } else if (randColor < 0.66) {
      stroke(86, 66, 26);
    } else {
      stroke(226, 166, 36);
    }
    
    if (randWeight < 0.33) {
      strokeWeight(1);
    } else if (randWeight < 0.86) {
      strokeWeight(2);
    } else {
      strokeWeight(4);
    }
    
    line(x, y, endX, endY);
  }
}
