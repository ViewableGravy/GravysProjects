

public class GameEngine {
  final int RAD = 20;
  final int COLLIDEANGLE = 30;
  final int THREESIXTY = 360;
  boolean display = true;
  Player player;
  Merchant entity, entity2;
  Entity currentInteractingEntity = null;

  ArrayList<Entity> entities;

  public GameEngine(int wid, int hei) {
    player = new Player(wid/3, hei/3);
    entity = new Merchant(wid/2, hei/2, RAD, "entity 1");
    entity2 = new Merchant( wid/3, hei/3, RAD, "entity 2");
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
    println(frameRate);
    if (currentInteractingEntity == null) {
      currentInteractingEntity = player.InteractDistanceEntity(player.Direction(mousex, mousey), entities, key, THREESIXTY, COLLIDEANGLE);
      Display(mousex, mousey);
      if (keyPressed) {
        player.move(key);
      }
    } else {
      currentInteractingEntity.PrintInteraction();
      if (key == ENTER) {
        currentInteractingEntity = null;
      }
    }
  }
}
