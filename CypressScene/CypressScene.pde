class Point {
  public int x;
  public int y;
  
  public Point(int x, int y) {
    this.x = x;
    this.y = y;
  }
}

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

class Brush {
  public ArrayList<Point> points;
  public MenuPosition menuPosition;
  
  public Brush(MenuPosition mp) {
    points = new ArrayList<Point>();
    menuPosition = mp;
    for (int i = mp.topLeft.x; i < mp.bottomRight.x; i+=4) {
      for (int j = mp.topLeft.y; j < mp.bottomRight.y; j+=4) {
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

class SkySplash extends Brush {
  public SkySplash(MenuPosition mp) {
    super(mp);
  }

  public void draw() {
    stroke(252, 216, 53);
    for (Point center : points) {
      point(center.x, center.y);
      for (int i = 0; i < 16 * 16; i++) {
        Point p = randomPointInCircle(new Point(center.x, center.y), 16);
        point(p.x, p.y);
      }
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

class WheatBrush extends Brush {
  public WheatBrush(MenuPosition mp) {
    super(mp);
  }
  
  public void draw() {
    for (Point p : points) {
      drawGrass(p.x, p.y);
    }
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
  for (int x = 16; x < WIDTH; x = x + 32) {
    for (int y = 16; y < (HEIGHT * .75); y = y + 32) {
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
  ellipse((WIDTH / 2.0), 140, 120, 120);
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

void drawSkyBackground() {
  strokeWeight(4);
  int r = 250;
  int g = 241;
  int b = 157;
  for (int i = 0; i < (HEIGHT * .75); i = i + 4) {
    stroke(r, g, b);
    line(0, i, WIDTH, i);
    g = g - 2;
    b = b - 4;
  }
}
