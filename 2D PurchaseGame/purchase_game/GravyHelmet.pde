public class GravyHelmet extends Item implements MiscItem {

  boolean mousePreviousFrame = true;
  public GravyHelmet() {
    super(0.0, 0.0, 5, "GravyHelmet", new CurrencyPurse(0, 0, 100, 0), 0, categoryEnum.Armour, "A high level Helmet representing your commitment to the GravyBoat");
  }

  public GravyHelmet(float _x, float _y, int _wid, int _hei) {
    super(_x, _y, 5, "GravyHelmet", new CurrencyPurse(0, 0, 100, 0), 0, categoryEnum.Armour, "A high level Helmet representing your commitment to the GravyBoat");
    wid = _wid;
    hei = _hei;
  }

  public categoryEnum GetCategory() {
    return MiscItem.category;
  }

  public Item CreateNewInstance() {
    return new GravyHelmet();
  }
}
