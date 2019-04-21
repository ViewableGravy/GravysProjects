 
 
 public abstract class CollidableObject extends WorldObject {
   public CollidableObject(Float _x, Float _y, int rad, String _name) {
     super(_x, _y, rad, _name); 
   }
   
   public abstract boolean Collide(CollidableObject object);
 }
 
