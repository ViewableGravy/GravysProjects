public class GravyArmour extends WearableItem implements ArmourItem {

  public GravyArmour() {
    super("GravyArmour", new CurrencyPurse(300000), categoryEnum.Armour, bodyPart.Chest, "A high level set of armour representing your commitment to the GravyBoat");
  }
  
  public GravyArmour(float _x, float _y, int _wid, int _hei) {
    super(_x, _y, "GravyArmour", new CurrencyPurse(300000), 0, categoryEnum.Armour, bodyPart.Chest, "A high level set of armour representing your commitment to the GravyBoat");
    wid = _wid;
    hei = _hei;
  }

  public categoryEnum GetCategory() {
    return ArmourItem.category;
  }

  public WearableItem CreateNewInstance() {
    return new GravyArmour();
  }
  
   public void WorldFunctionality(GameEngine world) {
    // nothing yet;
  };
}
