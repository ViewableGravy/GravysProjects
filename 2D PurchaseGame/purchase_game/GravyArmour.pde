public class GravyArmour extends Item implements ArmourItem {

  public GravyArmour() {
    super(0.0, 0.0, 5, "GravyArmour", new CurrencyPurse(0, 0, 300, 0), 0, categoryEnum.Armour, "A high level set of armour representing your commitment to the GravyBoat");
  }
  
  public GravyArmour(float _x, float _y, int _wid, int _hei) {
    super(_x, _y, 5, "GravyArmour", new CurrencyPurse(0, 0, 300, 0), 0, categoryEnum.Armour, "A high level set of armour representing your commitment to the GravyBoat");
    wid = _wid;
    hei = _hei;
  }

  public categoryEnum GetCategory() {
    return ArmourItem.category;
  }

  public Item CreateNewInstance() {
    return new GravyArmour();
  }
}
