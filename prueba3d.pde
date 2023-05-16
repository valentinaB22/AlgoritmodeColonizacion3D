import peasy.*;

Tree tree;

PeasyCam cam;

float min_dist = 2;
float max_dist = 15;

void setup() {
  size(1000, 1000, P3D);
  cam = new PeasyCam(this, 300);
  tree = new Tree();
}

void draw() {
  background(0);
  tree.show();
  tree.grow();
}
