public class Boomerang extends RangedWeapon implements Throwable {

  public PVector pointOfRotation;
  public boolean moving = false;
  public PVector direction = new PVector();
  public Boomerang() {
    super("boomerang", new CurrencyPurse(0, 0, 21, 0), 10.0,300,1, "A ranged weapon, affordable to beginners");
  }

  public Boomerang(float _x, float _y, int _wid, int _hei, int _weight) {
    super(_x, _y,"boomerang", new CurrencyPurse(0, 0, 21, 0),_weight, 10.0,20,1, "A ranged weapon, affordable to beginners");
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
    // currently does not move, so no direction necessary
    return 0;
  }
  
  // implementing Throwable
  // set the objects positon to the players
  float angle;
  public void SetToPlayerLocation(float x, float y) {
    pos.x = x;
    pos.y = y;
    
    // initially determine the center of rotation
    PVector temp = direction.copy();
    PVector perp = new PVector(temp.y, -temp.x).normalize();
    pointOfRotation = perp.mult(range/2).add(pos);
    
    // determine angle
    angle = (pos.y - pointOfRotation.y) / (sin(dist(pos.x,pos.y, pointOfRotation.x,pointOfRotation.y )));
  }
  // sets the velocity direction of the object
  public void SetDirection(PVector playerDirection) {
   direction = playerDirection;
  }
  // adds it's velocity to position
  public void ThrowingMechanics() {
    
    // There is something wrong with the logic so should work on that
    
    
    pos.add(direction.normalize().mult(ProjectileSpeed));
    direction.mult(1);
    
    
    ellipse(pointOfRotation.x,pointOfRotation.y,10,10);
    
    
   
    angle+=0.5;
    
     PVector temppos = new PVector();
     temppos.x= pointOfRotation.x + (range/2 * -cos(radians(angle)));
     temppos.y = pointOfRotation.y + (range/2 * sin(radians(angle)));
    
    
    direction = temppos.copy().sub(pos.copy());
    //float x = pointOfRotation + perp.mag()/2;
    
    //pos.add(temp.normalize().mult(ProjectileSpeed));
  
  }
  // shows the object in the world
  public void display() {
   ThrowingMechanics();
   ellipse(pos.x,pos.y,RAD,RAD); 
  }
  
}
