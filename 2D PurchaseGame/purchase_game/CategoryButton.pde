
public class CategoryButton {

  categoryEnum category;
  boolean OpenMenu = false;
  int x, y, wid, hei;
  CategoryItems itemcategory;

  public CategoryButton(categoryEnum _category, int _x, int _y, int _wid, int _hei, CategoryItems cat) {
    x = _x;
    y = _y;
    wid = _wid;
    hei = _hei;
    category = _category;
    itemcategory = cat;
    //note, this will take permameters such as category picture and other display details from inherited classes
  }

  public void display() {
    final int IMG = hei - 20;
    fill(100, 0, 0);
    rect(x, y, wid, hei);
    fill(0, 100, 0);
    textAlign(LEFT);
    textSize(64);
    //
    text(category.name(), x + IMG + 60, y + 2*hei/3 + hei/6); //category name
    rect(x +10, y + 10, IMG, IMG); //represents Category image
    //
    textSize(12);
    textAlign(CENTER);
    fill(255);
  }

  public void DisplayCategory(float mousex, float mousey) {
    if (Clicked(mousex, mousey)) {
      ItemMenu();
    } else {
      display();
    }
  }

  public void ItemMenu() {
    itemcategory.display();
  }

  public boolean Clicked(float mousex, float mousey) {
    if (!OpenMenu) {
      if (mousex > x && mousex < x+wid && mousey > y && mousey < y + hei) { 
        if (mousePressed) {
          return OpenMenu = true;
        } else {
          //hover variable
          return OpenMenu = false;
        }
      } else {
        return OpenMenu = false;
      }
    } 
    return true;
  }
  
  
}
