

class ArmourButton extends CategoryButton {


  ArmourButton(int x, int y, int wid, int hei) {
    super(categoryEnum.Armour, x, y, wid, hei, new CategoryItems(new ArrayList<Item>() {
      { 
        // add each Armour item to this arraylist which is passed up to parent classes
        add(new GravyArmour());
        add(new GravyHelmet());
      }
    }
    , x, y, wid, hei));
  }
  }

class MiscButton extends CategoryButton {

  MiscButton(int x, int y, int wid, int hei, int yminus) {
    super(categoryEnum.Misc, x, y, wid, hei, new CategoryItems(new ArrayList<Item>() {
      { 
        // add each Misc item to this arraylist which is passed up to parent classes
        add(new GravyBanner()); 
      }
    }
    , x, y - yminus, wid, hei));
  }

  //ArrayList<Item> _items, int _x, int _y, int _wid, int _hei
}
