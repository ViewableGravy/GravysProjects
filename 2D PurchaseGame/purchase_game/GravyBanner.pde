public class GravyBanner extends Item implements MiscItem {

  boolean mousePreviousFrame = true;
  public GravyBanner() {
    super(0.0, 0.0, 5, "GravyBanner", new CurrencyPurse(0, 0, 300, 0), 0, categoryEnum.Misc, "A high level banner representing your commitment to the GravyBoat");
  }

  public GravyBanner(float _x, float _y, int _wid, int _hei) {
    super(_x,_y, 5, "GravyBanner", new CurrencyPurse(0, 0, 300, 0), 0, categoryEnum.Misc, "A high level banner representing your commitment to the GravyBoat");
    wid = _wid;
    hei = _hei;
  }

  public categoryEnum GetCategory() {
    return MiscItem.category;
  }

  public Item CreateNewInstance() {
    return new GravyBanner();
  }
}
