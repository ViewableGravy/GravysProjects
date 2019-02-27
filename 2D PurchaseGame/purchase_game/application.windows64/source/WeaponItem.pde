
public abstract class WeaponItem extends Item {

  protected float damage;
  //specific details
  public WeaponItem(float x, float y, String name, CurrencyPurse _cost, int _weight, float _damage, String _desc) {
    super(x, y, 5, name, _cost, _weight, categoryEnum.Weapons, _desc);
    damage = _damage;
  }
  
  //generic
   public WeaponItem(String name, CurrencyPurse _cost, float _damage, String _desc) {
    super(name, _cost, categoryEnum.Weapons, _desc);
    damage = _damage;
  }

  public abstract WeaponItem CreateNewInstance();
}
