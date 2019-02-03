
public abstract class Entity extends WorldObject {
  
 Entity(float _x, float _y, int rad, String _name) {
   super(_x, _y, rad, _name); 
 }
 
  public abstract Entity interact(char key);
  public abstract int GetDirection();
}
