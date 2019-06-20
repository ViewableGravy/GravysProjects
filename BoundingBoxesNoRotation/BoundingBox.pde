public class BoundingBox {
  PVector pos;
  int wid,hei;
  BoundingBox(int x, int y, int wid, int hei) {
    this.pos = new PVector(x,y);
    this.wid = wid;
    this.hei = hei;
  }
  
  public boolean Collide(BoundingBox other) {
   return  pos.x < other.pos.x + other.wid && 
           pos.x + wid > other.pos.x && 
           pos.y < other.pos.y + other.hei &&
           pos.y + hei > other.pos.y;
  }
  
  public void Display() {
   rect(pos.x,pos.y,wid,hei); 
  }
  
  public void translate(int x, int y) {
    this.pos.x += x;
    this.pos.y += y;
  }
}
