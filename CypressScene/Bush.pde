class Brush {
  public ArrayList<Point> points;
  public MenuPosition menuPosition;
  
  public Brush(MenuPosition mp) {
    points = new ArrayList<Point>();
    menuPosition = mp;
    for (int i = mp.topLeft.x; i < mp.bottomRight.x; i+=6) {
      for (int j = mp.topLeft.y; j < mp.bottomRight.y; j+=6) {
        points.add(new Point(i, j));
      }
    }
  }
  
  public void draw() {
    throw new RuntimeException("This should be overwritten by sub-class.");
  }
  
  public boolean isInMenu(int x, int y) {
    return menuPosition.isInMenu(x, y);
  }
  
  public void selectMenu() {
    menuPosition.selectMenu();
  }
}
