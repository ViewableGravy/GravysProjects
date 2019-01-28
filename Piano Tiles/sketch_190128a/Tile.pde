


public class Tile {
  public float y, x, wid, hei;
  public boolean spawned = false;

  public Tile(int _y, int _x, int _wid, int _hei) {
    y = _y;
    x = _x;
    wid = _wid;
    hei = _hei;
  }
  
  public Tile(int _wid,int _hei) {
    wid = _wid;
    hei = _hei;
    reset();
  }

  public void reset() {
      y = -hei;
      int temp = round(random(3));
      switch (temp) {
        case 0: x =0; break;
        case 1: x =2*width/8; break;
        case 2: x = 4*width/8; break;
        case 3:  x = 6 * width/8; break;
      }
  }

  public void move(float acc) {
    y+=acc;
  }

  public void display() {
    rect(x, y, wid, hei);
  }

  public boolean Collide(float mouseX, float mouseY) {
    if (mouseX < x + wid && mouseX > x) {
      if (mouseY < y + hei && mouseY > y) {
        return true;
      }
    }
    return false;
  }
}
