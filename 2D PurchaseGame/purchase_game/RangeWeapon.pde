
public abstract class RangedWeapon extends WeaponItem {
  
 protected int range;
 protected int ProjectileSpeed;
 
 public RangedWeapon(float x, float y, String name, CurrencyPurse _cost, int _weight, float _damage, int _range, int _projectileSpeed, String _desc) {
    super(x, y, name, _cost, _weight,_damage,_desc);
    damage = _damage;
    range = _range;
    ProjectileSpeed = _projectileSpeed;
  }
  
  //generic
   public RangedWeapon(String name, CurrencyPurse _cost, float _damage, int _range, int _projectileSpeed, String _desc) {
    super(name, _cost, _damage,  _desc);
    range =_range;
    ProjectileSpeed = _projectileSpeed;
  }
  
  public abstract RangedWeapon CreateNewInstance();
  
}
