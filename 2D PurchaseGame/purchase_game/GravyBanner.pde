public class GravyBanner extends Item implements MiscItem {

  boolean mousePreviousFrame = true;
  public GravyBanner() {
    super("GravyBanner", new CurrencyPurse(300), categoryEnum.Misc, "A high level banner representing your commitment to the GravyBoat");
  }

  public GravyBanner(float _x, float _y, int _wid, int _hei) {
    super(_x, _y, 5,"GravyBanner", new CurrencyPurse(300), 0, categoryEnum.Misc, "A high level banner representing your commitment to the GravyBoat");
    wid = _wid;
    hei = _hei;
  }

  public categoryEnum GetCategory() {
    return MiscItem.category;
  }

  public Item CreateNewInstance() {
    return new GravyBanner();
  }
  
  public void WorldFunctionality(GameEngine world) {
    // nothing yet;
  };
  
}
