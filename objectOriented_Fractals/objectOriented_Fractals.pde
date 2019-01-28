Branch tree[];
int recursion = 5;
void setup() {
  size(600,600);
  background(0);
  
  PVector beginning = new PVector(width/2,height);
  PVector ending = new PVector(width/2,height - 100);
  
  tree = new Branch[5];
  tree[0] = new Branch(beginning,ending);
  //tree[1] = tree[0].branchingA();
  //tree[2] = tree[0].branchingB();
}

void mousePressed() {
  for(int i = tree.length - 1; i >= 0; i--) {
    // i need to add branching to the array??
    println(tree[i].branchingA());
    //tree.push(tree[i].branchingA());
    //tree.push(tree[i].branchingB());
  }
}

void draw() {
  for (int i = 0; i < tree.length; i++) {
    println(i);
    if (tree[i] != null) {
    tree[i].Show();
    }
  }
}


class Branch {
  boolean finished = false;
  PVector begin;
  PVector end;

  Branch(PVector beg, PVector en) {
    begin = beg; 
    end = en;
  }
  
  void Show() {
    stroke(255);
    line(begin.x,begin.y,end.x,end.y);
  }
  
  Branch branchingA() {
    pushMatrix();
    PVector dir = PVector.sub(end,begin);
    dir.rotate(PI/4);
    dir.mult(0.67);
    PVector newend = PVector.add(end,dir);
    Branch a = new Branch(end,newend);
    popMatrix();
    return a; 
  }
  
  Branch branchingB() {
    pushMatrix();
    PVector dir = PVector.sub(end,begin);
    dir.rotate(-PI/4);
    dir.mult(0.67);
    PVector newend = PVector.add(end,dir);
    Branch a = new Branch(end,newend);
    popMatrix();
    return a;
  }
  
  
}
