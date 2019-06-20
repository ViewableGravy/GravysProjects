
//a projection of a two dimensional shape onto an axis.
//a projection is essentially a one dimensional line
class Projection {
  float min, max;
  
  Projection(float min, float max) {
    this.min = min;
    this.max = max;
  }
}

//projects a two-dimensional shape onto an axis
//takes the vertices of a shape and an axis
Projection project(PVector[] vertices, PVector axis) {
  float min = axis.dot(vertices[0]);
  float max = min;
  //already dealt with first vertex
  for (int j = 1; j < vertices.length; j++) { 
    float p = axis.dot(vertices[j]);
    if (p < min) {
      min = p;  
    } else if (p > max) {
      max = p;
    }
  }
  
  return new Projection(min, max);
}
