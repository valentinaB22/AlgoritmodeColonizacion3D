
import peasy.*;

Tree tree;

PeasyCam cam;

float min_dist = 5;
float max_dist = 200;

void setup() {
  size(1000, 1000, P3D);
  cam = new PeasyCam(this, 500);
  tree = new Tree();
}

void draw() {
  background(51);
  tree.show();
  tree.grow();
}
