
public class MerchantInterface {
  ArrayList<CategoryButton> categories = new ArrayList<CategoryButton>(); 
  private int x, y, wid, hei;
  
  MerchantInterface(int _x, int _y, int _wid, int _hei) {
    x = _x;
    y = _y;
    wid = _wid;
    hei = _hei;
    final int tall = 80;
    final int edge = _wid/50;
    
    int tempy = _y + _hei/3;
    int increment = tall + 10;
    categories.add(new ArmourButton(_x + edge, tempy, _wid/3, tall));
    tempy += increment;
    categories.add(new MiscButton(_x + edge, tempy, _wid/3, tall, increment));
    tempy += increment;
    categories.add(new MiscButton(_x + edge, tempy, _wid/3, tall, 2*increment));
    tempy += increment;
    categories.add(new MiscButton(_x + edge, tempy, _wid/3, tall, 3*increment));
    tempy += increment;
    categories.add(new MiscButton(_x + edge, tempy, _wid/3, tall, 4*increment));
    tempy += increment;
    categories.add(new MiscButton(_x + edge, tempy, _wid/3, tall, 5*increment));
  }

  void DisplayOutline() {
    rect(x, y, wid, hei);
  }

  boolean keypress() {
    for (CategoryButton button : categories) {
      if (button.OpenMenu) {
        button.OpenMenu = false;
        button.firstclick = 0;
        return false;
      }
    }
    return true;
  }
  
  void mousePress(boolean mouseReleased) {
    for (CategoryButton button : categories) {
      button.mouseReleased = mouseReleased;
    }
  }

  void displayCategories(float mousex, float mousey) {
    boolean ChosenCategory = false;
    for (CategoryButton button : categories) {
      if (button.OpenMenu) {
        ChosenCategory = true;
      }
    }
    if (ChosenCategory) {
      for (CategoryButton button : categories) {
        if (button.OpenMenu) {
          button.DisplayCategory(mousex, mousey);
        }
      }
    } else {
      for (CategoryButton button : categories) {
        button.DisplayCategory(mousex, mousey);
      }
    }
  }

  void DisplayPlayerBalance() {
  }
}
