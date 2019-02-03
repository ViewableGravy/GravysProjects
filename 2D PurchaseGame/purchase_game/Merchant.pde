
public class Merchant extends Entity {

  Item PreparePurchase = null;

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

  public boolean ShowInteractionInterface(Player player) {
    rect(width/4, height/4, width/2, height/2);

    if (mousePressed) {
      PreparePurchase = new GravyBanner();
    } 

    if (PreparePurchase != null) {
      if (player.pocketMoney.peach >= 300) {
        fill(100, 0, 0);
        text("are you sure you want to purchase a " + PreparePurchase.name + " for " + PreparePurchase.cost.peach, width/2, height/2 - 50);
        fill(255);
        if (keyPressed) {
          if (key == 'y') {
            player.pocketMoney.peach -= 300;
            player.inventory.add(new GravyBanner());
            PreparePurchase = null;
          }
        }
      }
    }



    if (key == ENTER) {
      return false;
    }
    return true; //assuming nothing purchased then return false
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
