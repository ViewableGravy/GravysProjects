public class GravyArmour extends Item implements ArmourItem {

  int x, y, wid, hei;
  public GravyArmour() {
    super(0.0, 0.0, 5, "GravyArmour", new CurrencyPurse(0, 0, 300, 0), 0, categoryEnum.Armour, "A high level set of armour representing your commitment to the GravyBoat");
  }
  
  public GravyArmour(int _x, int _y, int _wid, int _hei) {
    super(0.0, 0.0, 5, "GravyArmour", new CurrencyPurse(0, 0, 300, 0), 0, categoryEnum.Armour, "A high level set of armour representing your commitment to the GravyBoat");
    x = _x;
    y = _y;
    wid = _wid;
    hei = _hei;
  }

  public categoryEnum GetCategory() {
    return ArmourItem.category;
  }

  public Item CreateNewInstance() {
    return new GravyArmour();
  }

  public void DisplayButton() {
    rect(x, y, wid, hei);
  }

  public void SetButton(int _x, int _y, int _wid, int _hei) {
    x = _x;
    y = _y;
    wid = _wid;
    hei = _hei;
  }

  public boolean Clicked(float mousex, float mousey) {
    return (mousex > x && mousex < x + wid && mousey < y + hei && mousey > y && mousePressed);
  }
}
