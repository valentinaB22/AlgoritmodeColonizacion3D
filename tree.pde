class Tree {
  ArrayList<Branch> branches = new ArrayList<Branch>();
  ArrayList<Leaf> leaves = new ArrayList<Leaf>();

  Tree() {
    String[] lines = loadStrings("puntos.txt");
    //println("there are " + lines.length + " lines");
    String xs = lines[0];
    String ys = lines[1];
    String zs = lines[2];
    
    //Puntos X, separacion de puntos + eliminar primer y ultimo corchete.
    String [] puntosX = xs.split(", ");
    puntosX[0] = puntosX[0].substring(1);
    puntosX[puntosX.length-1] = puntosX[puntosX.length-1].substring(0,puntosX[puntosX.length-1].length()-1);
    
    //Puntos Y, separacion de puntos + eliminar primer y ultimo corchete.
    String [] puntosY = ys.split(", ");
    puntosY[0] = puntosY[0].substring(1);
    puntosY[puntosY.length-1] = puntosY[puntosY.length-1].substring(0,puntosY[puntosY.length-1].length()-1);
    
    //Puntos Z, separacion de puntos + eliminar primer y ultimo corchete.
    String [] puntosZ = zs.split(", ");
    puntosZ[0] = puntosZ[0].substring(1);
    puntosZ[puntosZ.length-1] = puntosZ[puntosZ.length-1].substring(0,puntosZ[puntosZ.length-1].length()-1);
    
    for (int i=0; i < puntosX.length; i++)
      leaves.add(new Leaf(Float.parseFloat(puntosX[i]),Float.parseFloat(puntosY[i]),Float.parseFloat(puntosZ[i])));
  
    Branch root = new Branch(new PVector(0,height/2), new PVector(0, -1));
    branches.add(root);
    Branch current = new Branch(root);

    while (!closeEnough(current)) {
      Branch trunk = new Branch(current);
      branches.add(trunk);
      current = trunk;
    }
  }

  boolean closeEnough(Branch b) {

    for (Leaf l : leaves) {
      float d = PVector.dist(b.pos, l.pos);
      if (d < max_dist) {
        return true;
      }
    }
    return false;
  }

  void grow() {
    for (Leaf l : leaves) {
      Branch closest = null;
      PVector closestDir = null;
      float record = -1;

      for (Branch b : branches) {
        PVector dir = PVector.sub(l.pos, b.pos);
        float d = dir.mag();
        if (d < min_dist) {
          l.reached();
          closest = null;
          break;
        } else if (d > max_dist) {
        } else if (closest == null || d < record) {
          closest = b;
          closestDir = dir;
          record = d;
        }
      }
      if (closest != null) {
        closestDir.normalize();
        closest.dir.add(closestDir);
        closest.count++;
      }
    }

    for (int i = leaves.size()-1; i >= 0; i--) {
      if (leaves.get(i).reached) {
        leaves.remove(i);
      }
    }

    for (int i = branches.size()-1; i >= 0; i--) {
      Branch b = branches.get(i);
      if (b.count > 0) {
        b.dir.div(b.count);
        PVector rand = PVector.random2D();
        rand.setMag(0.3);
        b.dir.add(rand);
        b.dir.normalize();
        Branch newB = new Branch(b);
        branches.add(newB);
        b.reset();
      }
    }
  }

  void show() {
    for (Leaf l : leaves) {
      l.show();
    }    
    //for (Branch b : branches) {
    for (int i = 0; i < branches.size(); i++) {
      Branch b = branches.get(i);
      if (b.parent != null) {
        float sw = map(i, 0, branches.size(), 6, 0);
        strokeWeight(sw);
        stroke(255);
        line(b.pos.x, b.pos.y, b.pos.z, b.parent.pos.x, b.parent.pos.y, b.parent.pos.z);
      }
    }
  }
}
