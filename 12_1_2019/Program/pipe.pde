public class Pipe {
  
  // max height is 200
  // bottom is height - 200
  int _width, _height;
  PVector _center;
  
  PImage bottom = loadImage("pipebottom.png");
  Pipe(int x, int wid, int hei) {
    _width = wid;
    _height = hei;
    _center = new PVector(x,height);
    bottom.resize(_width,720);
  }
  
  public void draw() {
    int dist = round(_center.y) - _height;
    
    image(bottom,_center.x,_center.y - _height);
    pushMatrix();
    translate(_center.x + _width,_center.y - _height - 300);
    rotate(PI);
    //bottom = loadImage("pipebottom.png");
    //bottom.resize(_width, dist - 100);
    image(bottom,0,0);
    popMatrix();// rect(_center.x,_center.y,_width,-_height); //bottom
    
   // rect(_center.x,200, _width, dist - 300);
  }
  
  public void update() {
    _center.x-= 5; 
  }
  
  public void reset() {
    if (_center.x < -_width) {
      _height = round(random(200,650));
      _center.x = width;
    }
  }
  
 
  
}
