class Brush {
  public MenuPosition menuPosition;
  
  public Brush(MenuPosition mp) {
    menuPosition = mp;
    for (int i = mp.topLeft.x; i < mp.bottomRight.x; i+=6) {
      for (int j = mp.topLeft.y; j < mp.bottomRight.y; j+=6) {
        points[i][j] = this;
      }
    }
  }
  
  public void draw(int x, int y) {
    throw new RuntimeException("This should be overwritten by sub-class.");
  }
  
  public boolean isInMenu(int x, int y) {
    return menuPosition.isInMenu(x, y);
  }
  
  // Just a visual alert highlighting selection
  public void selectMenu() {
    menuPosition.selectMenu();
  }
}
