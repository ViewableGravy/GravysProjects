
public class Merchant extends Entity {

  Merchant(float _x, float _y, int rad, String _name) {
    super(_x, _y, rad, _name);
  }


  void display(int angle) {
    // implement movement at later date (no need to use angle for now)
    text("Merchant", pos.x + 1, pos.y - 20);
    ellipse(pos.x, pos.y, RAD, RAD);
  }
  
  public int GetDirection() {
    // currently does not move, so no direction necessary
    return 0;
  }

  Entity interact(char key) {
    text("[e]", pos.x + 1, pos.y - 35);
    if (!keyPressed) {
      return null;
    } 
    if (!InteractEntity(key)) {
      return null;
    }
    return this;
  }

  boolean InteractEntity(char key) {
    if (key == 'e') {
      return true;
    }
    return false;
  }
}
