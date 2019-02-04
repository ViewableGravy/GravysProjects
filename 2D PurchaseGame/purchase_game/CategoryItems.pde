
public class CategoryItems {

  public ArrayList<Item> items;
  int x, y, wid, hei;
  boolean ConfirmPurchase = false;

  public CategoryItems(ArrayList<Item> _items, int _x, int _y, int _wid, int _hei) {
    items = _items;
    x = _x;
    y = _y;
    wid = _wid;
    hei = _hei;
  }

  public boolean display() {

    rect(x, y, wid, hei);
    return true;
    // context. this will not be a boolean but rather return the entity that is purchased
    // text(category.name(), x, y);
  }

  public void DisplayItems(float mousex, float mousey) {}

  public void ItemMenu() {}

  public boolean Clicked(float mousex, float mousey) {
    return false;
  }
}
