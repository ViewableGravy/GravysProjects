
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
      itm.DisplayButton("merchant");
    }
  }

  public void DisplayItems(float mousex, float mousey) {
  }

  public void ItemMenu() {
  }

  int firstclick = 0;
  int test = 0;
  public Item Clicked(float mousex, float mousey) {
    // ------- if not first click
    if (firstclick == 0) {
      firstclick = 1;
    }
    if (firstclick == 1) {
      if (mouseReleased) {
        firstclick = 2;
      }
    } else if (firstclick == 2) {
      // ------- then check if a item is clicked
      for (Item itm : items) {
        itm.mousePreviousFrame = !mouseReleased; // previous frame was clicked if it wasn't released fam
        
        
        if (itm.Clicked(mousex, mousey)) {
          println(itm.name);
          String confirm = itm.Confirm(mousex, mousey);
          if (confirm == "show") {
            itm.ShowConfirmPurchase();
          } else if (confirm == "cancel") {
            firstclick = 0;
            itm.clicked = false;
          } else if (confirm == "confirm") {
            firstclick = 0;
            itm.clicked = false;
            return itm.CreateNewInstance();
          }
        }
      }
      // -------
    }
    test = 0;
    return null;
  }
}
