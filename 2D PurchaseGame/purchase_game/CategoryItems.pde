 //<>//
public class CategoryItems {

  public ArrayList<Item> items;
  int x, y, wid, hei;
  boolean ConfirmPurchase = false;
  boolean mouseReleased = false;

  public CategoryItems(ArrayList<Item> _items, int _x, int _y, int _wid, int _hei) {
    items = _items;
    x = _x;
    y = _y;
    wid = _wid;
    hei = _hei;

    int tempy = y;
    for (Item itm : items) {
      itm.SetButton(x, tempy, wid, hei);
      tempy += hei + 10;
    }
  }

  public void display() {

    for (Item itm : items) {
      itm.DisplayButton();
    }
  }

  public void DisplayItems(float mousex, float mousey) {
  }

  public void ItemMenu() {
  }

  int firstclick = 0;
  public Item Clicked(float mousex, float mousey) {
    for (Item itm : items) {
      itm.mousePreviousFrame = !mouseReleased;
      if (firstclick == 0) {
        firstclick = 1;
      }
      if (firstclick == 1) {
        if (mouseReleased) {
          firstclick = 2;
        }
      } else if (firstclick == 2) {
        if (itm.Clicked(mousex, mousey)) {
          firstclick = 0;
          return itm.CreateNewInstance();
        }
      }
    }

    return null;
  }
}
