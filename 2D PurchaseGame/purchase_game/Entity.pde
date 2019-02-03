
public abstract class Entity extends WorldObject {
  
 Entity(Float _x, Float _y, int rad, String _name) {
   super(_x, _y, rad, _name); 
 }
 
  public abstract Entity interact(char key);
  public abstract int GetDirection();
  public abstract boolean ShowInteractionInterface(Player player);
  public abstract void display(int angle);

}
