int order = 7; // Try changing this value!
int N = (int) pow(2, order);
int total = N * N;
int counter = 0;
PVector[] path = new PVector[total];
PImage img;

void setup() {
  size(512, 512);
  // Put the path of your image file here
  String imagePath = "";
  img = loadImage(imagePath);
  img.resize(512, 512);
  img.loadPixels();

  for (int i = 0; i < total; i++) {
    path[i] = hilbert(i);
    int len = width / N;
    path[i].mult(len);
    path[i].add(len / 2, len / 2);
  }
}

void draw() {
  background(0);
  strokeWeight(2);
  for (int i = 0; i < counter - 1; i++) {
    color c = img.get(int(path[i].x), int(path[i].y));
    float r = red(c);
    float g = green(c);
    float b  = blue(c);
    stroke(r, g, b);
    line(path[i].x, path[i].y, path[i+1].x, path[i+1].y);
  }

  counter += 25;
  if (counter >= total) {
    counter = 0;
    noLoop();
  }
  // saveFrame("Images/###.png");
}

PVector hilbert(int i) {
  PVector[] points = {
    new PVector(0, 0), 
    new PVector(0, 1), 
    new PVector(1, 1), 
    new PVector(1, 0)
  };

  int index = i & 3;
  PVector v = points[index];

  for (int j = 1; j < order; j++) {
    i = i >>> 2;
    index = i & 3;

    float len = pow(2, j);
    if (index == 0) {
      float temp = v.x;
      v.x = v.y;
      v.y = temp;
    } else if (index == 1) {
      v.y += len;
    } else if (index == 2) {
      v.x += len;
      v.y += len;
    } else if (index == 3) {
      float temp = len - 1 - v .x;
      v.x = len - 1 - v.y;
      v.y = temp;
      v.x += len;
    }
  }
  return v;
}
