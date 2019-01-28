//Program Creating Button using PShapes and Colours

void setup() {
  
}

void draw() {
  
}

class Button {
  PVector corner1,corner2,corner3,corner4;
  PShape s,check;
  int minX,maxX,minY,maxY;
  
  Button(int x1_, int y1_, int x2_, int y2_, int x3_, int y3_, int x4_, int y4_) {
    corner1 = new PVector(x1_,y1_);
    corner2 = new PVector(x2_,y2_);
    corner3 = new PVector(x3_,y3_);
    corner4 = new PVector(x4_,y4_);
    for (int i = 0; i < 3; i++) {
      
    }
    s = createShape();
    s.beginShape();
      s.vertex(corner1.x,corner1.y);
      s.vertex(corner2.x,corner2.y);
      s.vertex(corner3.x,corner3.y);
      s.vertex(corner4.x,corner4.y);
    s.endShape();
    
    check = createShape();
    check.beginShape();
      check.fill(99);
      check.vertex(corner1.x,corner1.y);
      check.vertex(corner2.x,corner2.y);
      check.vertex(corner3.x,corner3.y);
      check.vertex(corner4.x,corner4.y);
    check.endShape();
  }
  
  void DrawButton() {
    shape(s,0,0);
  }
  
  void Click() {
    if ( mouseX < 
  }
  
}
