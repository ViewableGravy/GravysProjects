public class EntityCreator {
  Rectangle rectangle;
 
 public EntityCreator(int x, int y, int w, int h) {
    rectangle = new Rectangle(new PVector(x,y),w,h);
 }
 
 private boolean Collide(PVector point) {
   return Colliders.Collide(point,rectangle);
 }
  
}
