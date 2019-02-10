public class GravyHelmet extends Item implements MiscItem {

  int x, y, wid, hei;
  boolean mousePreviousFrame = true;
  public GravyHelmet() {
    super(0.0, 0.0, 5, "GravyHelmet", new CurrencyPurse(0, 0, 100, 0), 0, categoryEnum.Armour, "A high level Helmet representing your commitment to the GravyBoat");
  }
  
  public GravyHelmet(int _x, int _y, int _wid, int _hei) {
    super(0.0, 0.0, 5, "GravyHelmet", new CurrencyPurse(0, 0, 100, 0), 0, categoryEnum.Armour, "A high level Helmet representing your commitment to the GravyBoat");
    x = _x;
    y = _y;
    wid = _wid;
    hei = _hei;
  }

  public categoryEnum GetCategory() {
    return MiscItem.category;
  }

  public Item CreateNewInstance() {
    return new GravyHelmet();
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
