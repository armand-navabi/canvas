ArrayList<Brush> brushes;
Brush currentBrush;

Brush wheatBrush;
Brush treeBrush;
Brush flowerBrush;
Brush flowerBrush2;
Brush skySplash;
Brush eraseBrush;

int HEIGHT = 350;
int WIDTH = 350;

Brush[][] points = new Brush[HEIGHT][WIDTH];

void setup() {
  size(350, 350);

  // Declare brushes, with none currently selected (currentBrush = null)
  currentBrush = null;
  brushes = new ArrayList<Brush>();
  wheatBrush = new WheatBrush(new MenuPosition(new Point(0, HEIGHT - 20), new Point(20, HEIGHT)));
  brushes.add(wheatBrush);
  treeBrush = new TreeBrush(new MenuPosition(new Point(40, HEIGHT - 20), new Point(60, HEIGHT)));
  brushes.add(treeBrush);
  flowerBrush2 = new FlowerBrush2(new MenuPosition(new Point(80, HEIGHT - 20), new Point(100, HEIGHT)));
  brushes.add(flowerBrush2);
  skySplash = new SkySplash(new MenuPosition(new Point(120, HEIGHT - 20), new Point(140, HEIGHT)));
  brushes.add(skySplash);
  flowerBrush = new FlowerBrush(new MenuPosition(new Point(160, HEIGHT - 20), new Point(180, HEIGHT)));
  brushes.add(flowerBrush);
  eraseBrush = new EraseBrush(new MenuPosition(new Point(180, HEIGHT - 20), new Point (200, HEIGHT)));
  brushes.add(eraseBrush);
}

void draw() {
  randomSeed(16);

  drawSkyBackground();
 
  if (currentBrush != null && mousePressed &&
      mouseX > 1 && mouseX < WIDTH &&
      mouseY > 1 && mouseY < HEIGHT - 20) {
        if (currentBrush == eraseBrush) {
          eraseAreaAround(mouseX, mouseY);
          redraw();
        } else {
          points[mouseX][mouseY] = currentBrush;
        }
  }

  for (int x = 0; x < points.length; x++) {
    for (int y = 0; y < points[0].length; y++) {
      if (points[x][y] != null) {
        points[x][y].draw(x, y);
      }
    }
  }

  // Draw the sun
  stroke(250, 241, 157);
  fill(245, 230, 106);
  ellipse((WIDTH / 2.0), 140, 100, 100);
}

void eraseAreaAround(int x, int y) {
  int minX = x - 10 > 0 ? x - 10 : 0;
  int maxX = x + 10 < WIDTH ? x + 10 : WIDTH - 1;
  int minY = y - 10 > 0 ? y - 10 : 0;
  int maxY = y + 10 < WIDTH ? y + 10 : WIDTH - 1;
  for (int i = minX; i < maxX; i++) {
    for (int j = minY; j < maxY; j++) {
      points[i][j] = null;
    }
  }
}

void mouseClicked() {
  for (Brush b : brushes) {
    if (b.isInMenu(mouseX, mouseY)) {
      currentBrush = b;
      b.selectMenu(); // a visiual alert of click
      return;
    }
  }
}

void setSkyColor(int y) {
  stroke(250, 240 - (y * .5), 160 - y);
}

void drawSkyBackground() {
  strokeWeight(4);
  for (int y = 0; y < (HEIGHT * .75); y = y + 4) {
    setSkyColor(y);
    line(0, y, WIDTH, y);
  }
}
