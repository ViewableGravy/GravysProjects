
public class Item extends Entity {
  protected CurrencyPurse cost;
  protected int weight;
  protected String desc;
  public categoryEnum Misc;
  
  Item(Float _x, Float _y, int rad, String _name, CurrencyPurse _cost, int _weight, categoryEnum Misc, String _desc) {
    super(_x, _y, rad, _name); 
    cost = _cost;
    weight = _weight;
    desc = _desc;
  }

  public Entity interact(char key) {
    return null; /*this is not implemented yet for this object */
  };
  public  int GetDirection() {
    return 0; /*this is not implemented yet for this object */
  };

  public  boolean ShowInteractionInterface(Player player) {
    return false; 
    /*this is not implemented yet for this object */
  };

  public  void display(int angle) {/*this is not implemented yet for this object */
  };
}
