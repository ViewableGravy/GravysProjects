

public class GameEngine {
  final int RAD = 20;
  final int COLLIDEANGLE = 30;
  final int THREESIXTY = 360;
  boolean display = true;
  Player player;
  Merchant entity, entity2;
  Entity currentInteractingEntity = null;
  boolean keyReleased = true;

  ArrayList<Entity> entities;

  public GameEngine(int wid, int hei) {
    player = new Player(wid/3, hei/2);
    entity = new Merchant(wid/2, hei/2, RAD, "entity 1", wid,hei);
    entity2 = new Merchant( wid/3, hei/3, RAD, "entity 2",wid,hei);
    entities = new ArrayList<Entity>();
    entities.add(entity);
    entities.add(entity2);
    textAlign(CENTER);
  }

  public void Display(float mousex, float mousey) {
    for ( Entity object : entities) {
      object.display(object.GetDirection());
    }
    player.display(player.Direction(mousex,mousey));
  }

  public void tick(float mousex, float mousey, char key) {
    ///////////////////////////
    // information displaying //
    
    // println(frameRate);
    int hei = 100;
    text("Copper: " + player.pocketMoney.copper + ", Silver: " + player.pocketMoney.silver + ", Peach: " + player.pocketMoney.peach , width/2, 50);
    for (Entity obj : player.inventory) {
      text(obj.name, width/2, hei);
      hei += 15;
    }
    
    ////////////
    
    
    if (currentInteractingEntity == null) {
      currentInteractingEntity = player.InteractDistanceEntity(player.Direction(mousex, mousey), entities, key, THREESIXTY, COLLIDEANGLE); //determine if player is interacting with entity
      Display(mousex, mousey); //Display all entities
      if (keyPressed) {
        player.move(key);
      }
    } else {
     //if the user clicks "enter" and this is therefore false then the interacting entity is removed and the game checks for interaction
     currentInteractingEntity.keyReleased = keyReleased;
     boolean ShowInteractionInterface = currentInteractingEntity.ShowInteractionInterface(player, mousex,mousey);
      if (ShowInteractionInterface == false) {
        currentInteractingEntity = null;
      }
    }
  }
}
