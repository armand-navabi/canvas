ArrayList<Brush> brushes;
Brush currentBrush;

Brush wheatBrush;
Brush treeBrush;
Brush flowerBrush;
Brush skySplash;

int HEIGHT = 350;
int WIDTH = 350;

void setup() {
  size(350, 350);
  currentBrush = null;
  brushes = new ArrayList<Brush>();
  wheatBrush = new WheatBrush(new MenuPosition(new Point(0, HEIGHT - 20), new Point(20, HEIGHT)));
  brushes.add(wheatBrush);
  treeBrush = new TreeBrush(new MenuPosition(new Point(50, HEIGHT - 20), new Point(70, HEIGHT)));
  brushes.add(treeBrush);
  flowerBrush = new FlowerBrush(new MenuPosition(new Point(100, HEIGHT - 20), new Point(120, HEIGHT)));
  brushes.add(flowerBrush);
  skySplash = new SkySplash(new MenuPosition(new Point(150, HEIGHT - 20), new Point(170, HEIGHT)));
  brushes.add(skySplash);
  for (int x = 0; x < WIDTH; x = x + (WIDTH / 16)) {
    for (int y = 0; y < (HEIGHT * .65); y = y + (WIDTH / 16)) {
      float probability = 1.0 - (y / (HEIGHT * .65));
      if (random(0, 1) < probability)
        skySplash.points.add(new Point(x, y));
    }
  }
}

void draw() {
  randomSeed(16);

  drawSkyBackground();
 
  if (mousePressed && mouseY < HEIGHT - 20 && currentBrush != null) {
    currentBrush.points.add(new Point(mouseX, mouseY));
  }
  
  for (Brush brush : brushes) {
    brush.draw();
  }

  // Draw the sun
  stroke(250, 241, 157);
  fill(245, 230, 106);
  ellipse((WIDTH / 2.0), 140, 100, 100);
}

void mouseClicked() {
  for (Brush b : brushes) {
    if (b.isInMenu(mouseX, mouseY)) {
      currentBrush = b;
      b.selectMenu();
      return;
    }
  }
}

void setSkyColor(int y) {
  stroke(250, 240 - (y * .5), 160 - y);
}

void drawSkyBackground() {
  strokeWeight(4);
  int r = 250;
  int g = 241;
  int b = 157;
  for (int y = 0; y < (HEIGHT * .75); y = y + 4) {
    setSkyColor(y);
    line(0, y, WIDTH, y);
    g = g - 2;
    b = b - 4;
  }
}
