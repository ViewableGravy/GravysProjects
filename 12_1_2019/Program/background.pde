

public class Background {
  int x, w;
  PImage img;

  public Background(int _x, int wid, PImage _img) {
    x = _x;
    w = wid;
    img = _img;
  }

  public void display() {
    image(img,x,0);
  }
  
  public void update() {
   x--; 
  }

  public void reset() { 
    if (x + w < 0) {
      x = width;
    }
  }
}
