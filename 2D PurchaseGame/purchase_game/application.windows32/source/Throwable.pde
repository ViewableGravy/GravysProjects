public interface Throwable {
 
  // determine if the object is still in motion
  //public  abstract boolean moving ;
  //public abstract int direction ;
  
  // set the objects positon to the players
  public abstract void SetToPlayerLocation(float x, float y);
  // sets the velocity direction of the object
  public abstract void SetDirection(PVector playerDirection);
  // adds it's velocity to position
  public abstract void ThrowingMechanics();
  // shows the object in the world
  public abstract void display();
  
}
