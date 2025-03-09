class MenuPosition {
  public Point topLeft;
  public Point bottomRight;
  
  public MenuPosition(Point tl, Point br) {
    this.topLeft = tl;
    this.bottomRight = br;
  }

  public boolean isInMenu(int x, int y) {
    return (topLeft.x < x) && (x < bottomRight.x) && (topLeft.y < y) && (y < bottomRight.y);
  }

  public void selectMenu() {
    stroke(255, 255, 255, 255);
    strokeWeight(4);
    line(topLeft.x + 1, topLeft.y + 1, bottomRight.x - 1, topLeft.y + 1);
    line(topLeft.x, topLeft.y, topLeft.x, bottomRight.y);
    line(bottomRight.x, bottomRight.y, topLeft.x, bottomRight.y);
    line(bottomRight.x, bottomRight.y, bottomRight.x, topLeft.y);
  }
} 
