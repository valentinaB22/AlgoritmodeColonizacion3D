class Leaf {
  PVector pos;
  boolean reached = false;

  Leaf(float x, float y, float z) {
    pos = new PVector(x,y,z);
   // pos = PVector.random3D();
    //pos.mult(random(width/2));
    pos.y -= 0;
    //height/10;
  }

  void reached() {
    reached = true;
  }

  void show() {
    fill(255);
    noStroke();
   pushMatrix();
    translate(pos.x, pos.y, pos.z);
    //sphere(1);
    ellipse(0,0, 1 , 1);
   popMatrix();
  }
}
