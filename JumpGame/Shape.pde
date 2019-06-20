Shape regularPolygon(float x, float y, float r, int n) {
  float startAngle = random(TWO_PI);
  
  PVector[] vertices = new PVector[n+1];
  for (int i=0; i<n+1; i++) {
    float angle = startAngle + map(i, 0, n, 0, TWO_PI);
    vertices[i] = new PVector(x + r*cos(angle), y + r*sin(angle));
  }
  return new Shape(vertices);
}

//A polygon or polyline:
class Shape {
  PVector[] vertices;
  PVector[] axes;
  
  Shape(PVector[] vertices) {
    this.vertices = vertices;
    this.axes = new PVector[vertices.length-1];
    
    for (int i=0; i<axes.length; i++) {
      axes[i] = getAxis(vertices[i], vertices[i+1]);
    }
  }
  
  PVector getAxis(PVector a, PVector b) {
    PVector axis = new PVector(b.y-a.y, a.x-b.x);
    axis.normalize();
    return axis;
  }
  
  void show() {
    beginShape();
    for (PVector vtx : vertices) {
      vertex(vtx.x, vtx.y);
    }
    endShape();
  }
  
  void translate(float dx, float dy) {
    for (PVector vtx : vertices) {
      vtx.x += dx;
      vtx.y += dy;
    }
  }
}
