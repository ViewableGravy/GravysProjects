public class GravyHelmet extends WearableItem implements MiscItem {

  boolean mousePreviousFrame = true;
  public GravyHelmet() {
    super("GravyHelmet", new CurrencyPurse(0, 0, 100, 0), categoryEnum.Armour, bodyPart.Helmet,  "A high level Helmet representing your commitment to the GravyBoat");
  }

  public GravyHelmet(float _x, float _y, int _wid, int _hei) {
    super(_x, _y, "GravyHelmet", new CurrencyPurse(0, 0, 100, 0), 0, categoryEnum.Armour,bodyPart.Helmet, "A high level Helmet representing your commitment to the GravyBoat");
    wid = _wid;
    hei = _hei;
  }

  public categoryEnum GetCategory() {
    return MiscItem.category;
  }

  public WearableItem CreateNewInstance() {
    return new GravyHelmet();
  }
}
