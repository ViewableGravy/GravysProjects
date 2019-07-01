public class BoundingBox {
  //PVector pos;
  //float wid,hei;
  
  Rectangle rectangle;
  boolean processing = false;
  
  public PVector GetPos() {
   return rectangle.pos; 
  }
  
  public PVector GetWidHei() {
   return new PVector(rectangle.wid,rectangle.hei); 
  }
  
  
  
  BoundingBox(int x, int y, int wid, int hei) {
    rectangle = new Rectangle(new PVector(x,y),wid,hei);
   // this.pos = new PVector(x,y);
    //this.wid = wid;
    //this.hei = hei;
  }
  
  BoundingBox(int x, int y) {
    processing = true;
    this.rectangle = new Rectangle(new PVector(x,y),0,0);
    //this.rectangle.pos = new PVector(x,y);
  }
  
  public void UpdateParameters(int x, int y) {
    if (processing) {
      this.rectangle.wid = x - this.rectangle.pos.x;
      this.rectangle.hei = y - this.rectangle.pos.y;
    }
  }
   //<>//
  public void Confirm() {
    
    if (rectangle.wid < 0) {
     rectangle.pos.x += rectangle.wid;
     rectangle.wid = abs(rectangle.wid);
    }
    
    if (rectangle.hei < 0) {
     rectangle.pos.y += rectangle.hei;
     rectangle.hei = abs(rectangle.hei);
    }
    
    processing = false;
  }
  
  public boolean Collide(BoundingBox other) {
    return Colliders.Collide(other.rectangle, this.rectangle);
  }
  
  public boolean Collide(float x, float y) {
    return Colliders.Collide(new PVector(x,y), this.rectangle);
  }
  
  public void Display() {
   rect(rectangle.pos.x,rectangle.pos.y,rectangle.wid,rectangle.hei); 
  }
  
  public void translate(int x, int y) {
    this.rectangle.pos.x += x;
    this.rectangle.pos.y += y;
  }
  
  //pass in the current indentation, rather than the desired indentationn
  public void Save(PrintWriter output, String indentation, boolean lastElement) {
    output.println(indentation + "box: {");
    indentation += "  ";
    output.println(indentation + "Position {");
    output.println(indentation + "  x: " + rectangle.pos.x);
    output.println(indentation + "  y: " + rectangle.pos.y);
    output.println(indentation + "},");
    output.println(indentation +"Width: " + rectangle.wid);
    output.println(indentation +"Height: " + rectangle.hei);
    if (lastElement)
        output.println(indentation.substring(2) + "}");
      else
        output.println(indentation.substring(2) + "},");
  }
}
