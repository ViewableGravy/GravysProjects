public class Boomerang extends RangedWeapon implements Throwable {

  public PVector pointOfRotation;
  public boolean moving = false;
  public PVector direction = new PVector();
  public Boomerang() {
    super("boomerang", new CurrencyPurse(0, 0, 21, 0), 10.0,300,5, "A ranged weapon, affordable to beginners");
  }

  public Boomerang(float _x, float _y, int _wid, int _hei, int _weight) {
    super(_x, _y,"boomerang", new CurrencyPurse(0, 0, 21, 0),_weight, 10.0,20,5, "A ranged weapon, affordable to beginners");
    wid = _wid;
    hei = _hei;
  }

  public categoryEnum GetCategory() {
    return MiscItem.category;
  }

  public RangedWeapon CreateNewInstance() {
    return new Boomerang();
  }
  
  public int GetDirection() {
    return 0;
  }
  
  // implementing Throwable
  // set the objects positon to the players
  public void SetToPlayerLocation(float x, float y) {
    pos.x = x;
    pos.y = y;
  }
  
  // sets the velocity direction of the object
  public void SetDirection(PVector playerDirection) {
   direction = playerDirection;
   direction.mult(ProjectileSpeed);
  }
  
  PVector Velocity = new PVector(0,0);
  int flyFrames = 0;
  public void ThrowingMechanics(GameEngine world) {
    flyFrames++;
     direction.add( world.player.pos.copy().sub(pos).normalize().mult(0.1));
     direction.limit(ProjectileSpeed);
     pos.add(direction);
  }
  
  public void Collision(GameEngine world) {
   if ( PVector.dist(pos,world.player.pos) < (RAD + world.player.RAD)  && flyFrames > 20) {
    world.entities.remove(this);
    world.player.inventory.add(this);
    flyFrames = 0;
   }
  }
  
  public void WorldFunctionality(GameEngine world) {
   Collision(world);
   // determines how long it can fly for
   if (flyFrames < 250) {
     ThrowingMechanics(world);
   }
   ellipse(pos.x,pos.y,RAD,RAD); 
  }
  
}
