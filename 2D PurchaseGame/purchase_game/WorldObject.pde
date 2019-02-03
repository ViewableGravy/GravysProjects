

public abstract class WorldObject {
  public PVector pos;
  public final int RAD;
  protected String name;
  WorldObject(Float _x, Float _y, int rad, String _name) {
    pos = new PVector(_x, _y);
    RAD = rad;
    name = _name;
  }
  

  
}
