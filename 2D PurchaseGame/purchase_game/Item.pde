
public abstract class Item extends Entity {
  protected CurrencyPurse cost;
  protected int weight;
  protected String desc;
  public categoryEnum category;

  Item(Float _x, Float _y, int rad, String _name, CurrencyPurse _cost, int _weight, categoryEnum _category, String _desc) {
    super(_x, _y, rad, _name); 
    cost = _cost;
    weight = _weight;
    desc = _desc;
    category = _category;
  }

  public Entity interact(char key) {
    return null; /*this is not implemented yet for this object */
  };
  public  int GetDirection() {
    return 0; /*this is not implemented yet for this object */
  };

  public  boolean ShowInteractionInterface(Player player, float mousex, float mousey) {
    return false; 
    /*this is not implemented yet for this object */
  };

  public abstract Item CreateNewInstance();
  public abstract categoryEnum GetCategory();
  public abstract void DisplayButton(int x, int y, int wid, int hei);

  public  void display(int angle) {/*this is not implemented yet for this object */
  };
}
