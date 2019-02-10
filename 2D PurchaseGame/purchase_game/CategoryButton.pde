
public class CategoryButton {

  categoryEnum category;
  boolean OpenMenu = false;
  int x, y, wid, hei;
  public CategoryItems itemcategory;
  private ArrayList<Item> shoppingCart = new ArrayList<Item>();
  boolean mouseReleased = false;
  

  public CategoryButton(categoryEnum _category, int _x, int _y, int _wid, int _hei, CategoryItems cat) {
    x = _x;
    y = _y;
    wid = _wid;
    hei = _hei;
    category = _category;
    itemcategory = cat;
    //note, this will take permameters such as category picture and other display details from inherited classes
  }

  // for displaying the interface of the merchant. This includes the category buttons, confirm purchase button and other visual interface
  public void display() {
    final int IMG = hei - 20;
    fill(100, 0, 0);
    rect(x, y, wid, hei);
    fill(0, 100, 0);
    textAlign(LEFT);
    textSize(64);
    //
    text(category.name(), x + IMG + 60, y + 2*hei/3 + hei/6); //category name
    rect(x +10, y + 10, IMG, IMG);                            //represents Category image
    //
    textSize(12);
    textAlign(CENTER);
    fill(255);
  }

  // Runs per frame and decides whether to display the category buttons or their Item buttons
  int firstclick = 0;
  public void DisplayCategory(float mousex, float mousey) {
    if (Clicked(mousex, mousey)) {
      if (firstclick == 0) {
        firstclick = 1;
      }
      ItemMenu(mousex, mousey);
    } else {
      display();
    }
  }


  // has the ability to both display item buttons for category and store items in the shopping cart
  public void ItemMenu(float mousex, float mousey) {
    itemcategory.mouseReleased = mouseReleased;
    itemcategory.display();
    if (firstclick == 1) {
      if (mouseReleased) {
        firstclick = 2;
      }
    } else {
      Item item = itemcategory.Clicked(mousex, mousey);
      if (item != null) {
        shoppingCart.add(item);
        item = null;
      }
    }
  }

  //check if the user has clicked on the category button
  public boolean Clicked(float mousex, float mousey) {
    if (OpenMenu || (mousex > x && mousex < x+wid && mousey > y && mousey < y + hei && mousePressed)) { 
      return OpenMenu = true;
    } 
    return OpenMenu = false;
  }
}
