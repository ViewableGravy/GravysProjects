// this should be split into separate files


public class GravyBanner extends Item implements MiscItem {

  int x, y, wid, hei;
  boolean mousePreviousFrame = true;
  public GravyBanner() {
    super(0.0, 0.0, 5, "GravyBanner", new CurrencyPurse(0, 0, 300, 0), 0, categoryEnum.Misc, "A high level banner representing your commitment to the GravyBoat");
  }

  public categoryEnum GetCategory() {
    return MiscItem.category;
  }

  public Item CreateNewInstance() {
    return new GravyBanner();
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
    return (mousex > x && mousex < x + wid && mousey < y + hei && mousey > y && mousePressed)
  }
}



interface MiscItem {
  public categoryEnum category = categoryEnum.Misc;
}

interface ArmourItem {
  public categoryEnum category = categoryEnum.Armour;
}
