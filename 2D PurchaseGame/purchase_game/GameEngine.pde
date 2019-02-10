

public class GameEngine {
  final int RAD = 20;
  final int COLLIDEANGLE = 30;
  final int THREESIXTY = 360;
  boolean display = true;
  Player player;
  Merchant entity, entity2;
  Entity currentInteractingEntity = null;
  boolean keyReleased = true;
  boolean mouseReleased = true;
  ArrayList<Entity> entities;

  // declare all entities in the game engine (the setup of the world)
  public GameEngine(int wid, int hei) {
    player = new Player(wid/3, hei/2);
    entity = new Merchant(wid/2, hei/2, RAD, "entity 1", wid,hei);
    entity2 = new Merchant( wid/3, hei/3, RAD, "entity 2",wid,hei);
    entities = new ArrayList<Entity>();
    entities.add(entity);
    entities.add(entity2);
    textAlign(CENTER);
  }

  // in charge of displaying all world entities
  public void Display(float mousex, float mousey) {
    //display entities other than player
    for ( Entity object : entities) {
      object.display(object.GetDirection());
    }
    
    
    //display the player
    player.display(player.Direction(mousex,mousey));
  }

  // what does the game need to do every frame? Ideally this is not linked to the frameRate but for now it is.
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
    
    // if the player is not interacting with an entity then show environment
    if (currentInteractingEntity == null) {
      currentInteractingEntity = player.InteractDistanceEntity(player.Direction(mousex, mousey), entities, key, THREESIXTY, COLLIDEANGLE); //determine if player is interacting with entity
      Display(mousex, mousey); //Display all entities
      if (keyPressed) {
        player.move(key);
      }
    } 
    // if the player is interacting with an entity then display the entities interaction interface
    else 
    {
     // tell the interacting entity whether or not a key has been released
     currentInteractingEntity.keyReleased = keyReleased;
     currentInteractingEntity.mouseReleased = mouseReleased;
     // run the InteractionInterface (this should return an object with purchased items 
     boolean ShowInteractionInterface = currentInteractingEntity.ShowInteractionInterface(player, mousex,mousey);
      if (!ShowInteractionInterface) {
        currentInteractingEntity = null;
      }
    }
  }
  
  
  
}
