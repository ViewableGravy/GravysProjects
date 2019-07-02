public class Rectangle {
 public PVector pos;
 public float wid, hei;
 
 Rectangle(PVector pos, float wid, float hei) {
   this.pos = pos;
   this.wid = wid;
   this.hei = hei;
 }
 
 public void Display() {
  rect(pos.x,pos.y,wid,hei); 
 }
}
