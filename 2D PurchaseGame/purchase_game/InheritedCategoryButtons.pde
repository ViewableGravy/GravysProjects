

class ArmourButton extends CategoryButton {


  ArmourButton(int x, int y, int wid, int hei) {
    super(categoryEnum.Armour, x, y, wid, hei, new CategoryItems(new ArrayList<Item>() {
      { 
        // add each Misc item to this arraylist which is passed up to parent classes
        add(new GravyArmour());
      }
    }
    , x, y, wid, hei));
  }
  }

class MiscButton extends CategoryButton {

  MiscButton(int x, int y, int wid, int hei) {
    super(categoryEnum.Misc, x, y, wid, hei, new CategoryItems(new ArrayList<Item>() {
      { 
        // add each Misc item to this arraylist which is passed up to parent classes
        add(new GravyBanner()); 
      }
    }
    , x, y, wid, hei));
  }

  //ArrayList<Item> _items, int _x, int _y, int _wid, int _hei
}
