

public abstract class WorldObject {
  public PVector pos;
  public final int RAD;
  protected String name;
  WorldObject(float _x, float _y, int rad, String _name) {
    pos = new PVector(_x, _y);
    RAD = rad;
    name = _name;
  }
  
  public abstract void display(int angle);
  
  public void PrintInteraction() {
    println("interacting with " + name);
  }

  
}
