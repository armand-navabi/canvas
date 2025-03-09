class TreeBrush extends Brush {
  public TreeBrush(MenuPosition mp) {
    super(mp);
  }
  
  public void draw() {
    for (Point p : points) {
      float startX = p.x;
      float startY = p.y;
      float initialLen =  4;
      float angle = random(20);
      int maxDepth = 2;  
      drawFractal(startX, startY, initialLen, angle, maxDepth);
    }
  }

  void drawFractal(float startX, float startY, float len, float angle, int depth) {
    if (depth == 0) {
      return;
    }
    
    float endX = (float) (startX + len * Math.cos(angle));
    float endY = (float) (startY - len * Math.sin(angle));
    
    if (depth % 3 == 0) {
      stroke(47, 220, 34);
    } else if (depth % 3 == 1) {
      stroke(48, 117, 43);    
    } else {
      stroke(30, 71, 4);
    }
      
    line(startX, startY, endX, endY);
  
    float nextLen = len * .75;
    int nextDepth = depth - 1;
    drawFractal(endX, endY, nextLen, (float) (angle - Math.toRadians(30.0)), nextDepth);
    drawFractal(endX, endY, nextLen, (float) (angle + Math.toRadians(30.0)), nextDepth);
  }
}
