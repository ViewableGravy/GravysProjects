public class BoundingBox {
  PVector pos;
  float wid,hei;
  boolean processing = false;
  
  public PVector GetPos() {
   return pos; 
  }
  
  public PVector GetWidHei() {
   return new PVector(wid,hei); 
  }
  
  
  
  BoundingBox(int x, int y, int wid, int hei) {
    this.pos = new PVector(x,y);
    this.wid = wid;
    this.hei = hei;
  }
  
  BoundingBox(int x, int y) {
    processing = true;
    this.pos = new PVector(x,y);
  }
  
  public void UpdateParameters(int x, int y) {
    if (processing) {
      this.wid = x - this.pos.x;
      this.hei = y - this.pos.y;
    }
  }
  
  public void Confirm() {
    
    if (wid < 0) { //<>//
     pos.x += wid;
     wid = abs(wid);
    }
    
    if (hei < 0) {
     pos.y += hei;
     hei = abs(hei);
    }
    
    processing = false;
  }
  
  public boolean Collide(BoundingBox other) {
   return  pos.x < other.pos.x + other.wid && 
           pos.x + wid > other.pos.x && 
           pos.y < other.pos.y + other.hei &&
           pos.y + hei > other.pos.y;
  }
  
  public boolean Collide(float x, float y) {
    return x > pos.x && 
           x < pos.x + wid &&
           y > pos.y && 
           y < pos.y + hei;
  }
  public void Display() {
   rect(pos.x,pos.y,wid,hei); 
  }
  
  public void translate(int x, int y) {
    this.pos.x += x;
    this.pos.y += y;
  }
  
  public void Save(PrintWriter output, String indentation) {
    output.println(indentation + "Position {");
    output.println(indentation + "  x: " + pos.x);
    output.println(indentation + "  y: " + pos.y);
    output.println(indentation + "},");
    output.println(indentation +"Width: " + wid);
    output.println(indentation +"Height: " + hei);
  }
}
