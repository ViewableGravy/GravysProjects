//this is a button for creating an Entity. The constructor creates a rectangle and collide will take the mouse position
// to determine if it is being clicked.
public class EntityCreator {
  Rectangle rectangle;
 
 public EntityCreator(int x, int y, int w, int h) {
    rectangle = new Rectangle(new PVector(x,y),w,h);
 }
 
 private boolean Collide(PVector point) {
   return Colliders.Collide(point,rectangle);
 }
  
}
