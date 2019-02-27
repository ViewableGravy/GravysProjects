import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class purchase_game extends PApplet {



PFont fairyDust;
GameEngine gameengine;

public void setup() {
  
 // size(600, 600);
 fairyDust = createFont("FairyDustB.ttf", 12);
 textFont(fairyDust);
  gameengine =  new GameEngine(width, height);
}

public void draw() {
  background(100);

  gameengine.tick(mouseX, mouseY, key);

 
}

public void keyReleased() {
  gameengine.keyReleased = true;
}

public void keyPressed() {
 gameengine.keyReleased = false; 
}

public void mouseReleased() {
 gameengine.mouseReleased = true;
}

public void mousePressed() {
 gameengine.mouseReleased = false; 
}
public class Boomerang extends RangedWeapon implements Throwable {

  public PVector pointOfRotation;
  public boolean moving = false;
  public PVector direction = new PVector();
  public Boomerang() {
    super("boomerang", new CurrencyPurse(0, 0, 21, 0), 10.0f,300,1, "A ranged weapon, affordable to beginners");
  }

  public Boomerang(float _x, float _y, int _wid, int _hei, int _weight) {
    super(_x, _y,"boomerang", new CurrencyPurse(0, 0, 21, 0),_weight, 10.0f,20,1, "A ranged weapon, affordable to beginners");
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
    
    
   
    angle+=0.5f;
    
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

public class CategoryButton {

  categoryEnum category;
  boolean OpenMenu = false;
  int x, y, wid, hei;
  public CategoryItems itemcategory;
  private ArrayList<Item> shoppingCart = new ArrayList<Item>();
  boolean mouseReleased = false;


  public CategoryButton(categoryEnum _category, int _x, int _y, int _wid, int _hei, CategoryItems cat) {
    x = _x;
    y = _y;
    wid = _wid;
    hei = _hei;
    category = _category;
    itemcategory = cat;
    //note, this will take permameters such as category picture and other display details from inherited classes
  }

  // for displaying the interface of the merchant. This includes the category buttons, confirm purchase button and other visual interface
  public void display() {

    final int IMG = hei - 20;
    fill(100, 0, 0);
    rect(x, y, wid, hei);
    fill(0, 100, 0);
    textAlign(RIGHT);
    textSize(32);
    //
    text(category.name(), x + wid - 20, y + 2*hei/3 + hei/6); //category name
    rect(x +10, y + 10, IMG, IMG);                            //represents Category image
    //
    textSize(12);
    textAlign(CENTER);
    fill(255);
  }

  // Runs per frame and decides whether to display the category buttons or their Item buttons
  int firstclick = 0;
  public void DisplayCategory(float mousex, float mousey) {
    if (Clicked(mousex, mousey)) {
      
      ItemMenu(mousex, mousey);
    } else {
      display();
    }
  }


  // has the ability to both display item buttons for category and store items in the shopping cart
  public void ItemMenu(float mousex, float mousey) {
    itemcategory.mouseReleased = mouseReleased;
    itemcategory.display();
    if (firstclick == 0) {
        firstclick = 1;
      }
    if (firstclick == 1) {
      if (mouseReleased) {
        firstclick = 2;
      }
    } else {
      Item item = itemcategory.Clicked(mousex, mousey);
      if (item != null) {
        shoppingCart.add(item);
        item = null;
      }
    }
  }

  //check if the user has clicked on the category button
  public boolean Clicked(float mousex, float mousey) {
    if (OpenMenu || (mousex > x && mousex < x+wid && mousey > y && mousey < y + hei && mousePressed)) { 
      return OpenMenu = true;
    } 
    return OpenMenu = false;
  }
}

public class CategoryItems {

  public ArrayList<Item> items;
  int x, y, wid, hei;
  boolean ConfirmPurchase = false;
  boolean mouseReleased = false;

  public CategoryItems(ArrayList<Item> _items, int _x, int _y, int _wid, int _hei) {
    items = _items;
    x = _x;
    y = _y;
    wid = _wid;
    hei = _hei;

    int tempy = y;
    for (Item itm : items) {
      itm.SetButton(x, tempy, wid, hei);
      tempy += hei + 10;
    }
  }

  public void display() {

    for (Item itm : items) {
      itm.DisplayButton("merchant");
    }
  }

  public void DisplayItems(float mousex, float mousey) {
  }

  public void ItemMenu() {
  }

  int firstclick = 0;
  int test = 0;
  public Item Clicked(float mousex, float mousey) {
    // ------- if not first click
    if (firstclick == 0) {
      firstclick = 1;
    }
    if (firstclick == 1) {
      if (mouseReleased) {
        firstclick = 2;
      }
    } else if (firstclick == 2) {
      // ------- then check if a item is clicked
      for (Item itm : items) {
        itm.mousePreviousFrame = !mouseReleased; // previous frame was clicked if it wasn't released fam
        
        
        if (itm.Clicked(mousex, mousey)) {
          println(itm.name);
          String confirm = itm.Confirm(mousex, mousey);
          if (confirm == "show") {
            itm.ShowConfirmPurchase();
          } else if (confirm == "cancel") {
            firstclick = 0;
            itm.clicked = false;
          } else if (confirm == "confirm") {
            firstclick = 0;
            itm.clicked = false;
            return itm.CreateNewInstance();
          }
        }
      }
      // -------
    }
    test = 0;
    return null;
  }
}

class CurrencyPurse {
  public int copper, silver, peach, gravy;
  CurrencyPurse(String username) {
    String temp = "";
    try {
    JSONObject something = loadJSONObject("https://api.streamelements.com/kappa/v2/points/5c235339072350ec38cd501f/top");
    JSONArray users = something.getJSONArray("users");
    //println(users);
    
    for(int i = 0; i < users.size(); i++) {
      JSONObject user = users.getJSONObject(i);
      if (user.get("username").equals(username.toLowerCase())) {
        temp = user.get("points").toString(); 
      }
    }
    println("done");
  } 
  catch (Exception e) {
  }
    copper = 0;
    silver = 0;
    peach = PApplet.parseInt(temp);
    gravy = 0;
  }
  
  CurrencyPurse(int cop, int sil, int _peach, int grav) {
     copper = cop;
    silver = sil;
    peach = _peach;
    gravy = grav;
  }
  
  
  // could have functions to calculate the amount in other currency e.g. gold to silver

  public void ConvertDown(int amount, String type) {
    switch(type) {
    case "silver" :
      if (silver >= amount) {
        copper+= amount*10;
        silver-= amount;
      }
      break;
    case "peach" :
      if (peach >= amount) {
        silver+= amount*10;
        peach-= amount;
      }
      break;
    case "gravy" :
      if (gravy >= amount) {
        peach += amount * 10;
        gravy -= amount;
      }
      break;
    default:
      println("Unknown currency");
    }
  }

  public void ConvertUp(int amount, String type) {
    switch(type) {
      case "silver" :
        if (silver >= amount && amount % 10 == 1) {
          peach+= amount/10;
          silver-= amount;
        }
        break;
      case "peach" :
        if (peach >= amount && amount % 10 == 1) {
          gravy+= amount/10;
          peach-= amount;
        }
        break;
      case "copper" :
        if (copper >= amount && amount % 10 == 1) {
          silver += amount/10;
          copper -= amount;
        }
        break;
      default:
        println("Unknown currency");
    }
  }
}

public abstract class Entity extends WorldObject {
  boolean keyReleased = true;
  boolean mouseReleased = true;
 Entity(Float _x, Float _y, int rad, String _name) {
   super(_x, _y, rad, _name); 
 }
 
  public abstract Entity interact(char key);
  public abstract int GetDirection();
  public abstract boolean ShowInteractionInterface(Player player, float mousex, float mousey);
  public abstract void display(int angle);

}


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
  boolean keyClickReady = true;

  // declare all entities in the game engine (the setup of the world)
  public GameEngine(int wid, int hei) {
    player = new Player(wid/3, hei/2);
    entity = new Merchant(wid/2, hei/2, RAD, "entity 1", wid, hei);
    entity2 = new Merchant( wid/3, hei/3, RAD, "entity 2", wid, hei);
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
      if (object instanceof Throwable) {
        Throwable temp = (Throwable)object;
        temp.ThrowingMechanics();
        temp.display();
      }
    }


    //display the player
    player.display(player.Direction(mousex, mousey));
  }

  // what does the game need to do every frame? Ideally this is not linked to the frameRate but for now it is.
  public void tick(float mousex, float mousey, char key) {
    ///////////////////////////
    // information displaying //

    // just show items in a list in the middle top of screen
    int hei = 100;
    text("Copper: " + player.pocketMoney.copper + ", Silver: " + player.pocketMoney.silver + ", Peach: " + player.pocketMoney.peach, width/2, 50);
    for (Entity obj : player.inventory) {
      text(obj.name, width/2, hei);
      hei += 15;
    }



    // if the player is not interacting with an entity then show environment
    if (currentInteractingEntity == null) {
      currentInteractingEntity = player.InteractDistanceEntity(player.Direction(mousex, mousey), entities, key, THREESIXTY, COLLIDEANGLE); //determine if player is interacting with entity
      
      Display(mousex, mousey); //Display all entities
      if (keyPressed) {        //Move mechanics
        player.move(key);
      }
      
      //Key only registers once per click
      if (keyReleased ) {
        keyClickReady = true;
      }
      if (keyClickReady) {
        if (keyPressed) {
          if (key == ' ') {
            keyClickReady = false;
            Entity temp = player.ThrowSelectedItem(mousex, mousey);
            if (temp != null) {
              entities.add(temp);
            }
          }
        }
      }
    } 
    
    
    
    
    // if the player is interacting with an entity then display the entities interaction interface
    else 
    {
      // tell the interacting entity whether or not a key/mousebutton has been released
      currentInteractingEntity.keyReleased = keyReleased;
      currentInteractingEntity.mouseReleased = mouseReleased;
      
      // run the InteractionInterface (this should return an object with purchased items (or none if none purchased)
      boolean ShowInteractionInterface = currentInteractingEntity.ShowInteractionInterface(player, mousex, mousey);
      if (!ShowInteractionInterface) {
        currentInteractingEntity = null;
      }
    }
  }
}
public class GravyArmour extends WearableItem implements ArmourItem {

  public GravyArmour() {
    super("GravyArmour", new CurrencyPurse(0, 0, 300, 0), categoryEnum.Armour, bodyPart.Chest, "A high level set of armour representing your commitment to the GravyBoat");
  }
  
  public GravyArmour(float _x, float _y, int _wid, int _hei) {
    super(_x, _y, "GravyArmour", new CurrencyPurse(0, 0, 300, 0), 0, categoryEnum.Armour, bodyPart.Chest, "A high level set of armour representing your commitment to the GravyBoat");
    wid = _wid;
    hei = _hei;
  }

  public categoryEnum GetCategory() {
    return ArmourItem.category;
  }

  public WearableItem CreateNewInstance() {
    return new GravyArmour();
  }
}
public class GravyBanner extends Item implements MiscItem {

  boolean mousePreviousFrame = true;
  public GravyBanner() {
    super("GravyBanner", new CurrencyPurse(0, 0, 300, 0), categoryEnum.Misc, "A high level banner representing your commitment to the GravyBoat");
  }

  public GravyBanner(float _x, float _y, int _wid, int _hei) {
    super(_x, _y, 5,"GravyBanner", new CurrencyPurse(0, 0, 300, 0), 0, categoryEnum.Misc, "A high level banner representing your commitment to the GravyBoat");
    wid = _wid;
    hei = _hei;
  }

  public categoryEnum GetCategory() {
    return MiscItem.category;
  }

  public Item CreateNewInstance() {
    return new GravyBanner();
  }
}
public class GravyHelmet extends WearableItem implements MiscItem {

  boolean mousePreviousFrame = true;
  public GravyHelmet() {
    super("GravyHelmet", new CurrencyPurse(0, 0, 100, 0), categoryEnum.Armour, bodyPart.Helmet,  "A high level Helmet representing your commitment to the GravyBoat");
  }

  public GravyHelmet(float _x, float _y, int _wid, int _hei) {
    super(_x, _y, "GravyHelmet", new CurrencyPurse(0, 0, 100, 0), 0, categoryEnum.Armour,bodyPart.Helmet, "A high level Helmet representing your commitment to the GravyBoat");
    wid = _wid;
    hei = _hei;
  }

  public categoryEnum GetCategory() {
    return MiscItem.category;
  }

  public WearableItem CreateNewInstance() {
    return new GravyHelmet();
  }
}


class ArmourButton extends CategoryButton {


  ArmourButton(int x, int y, int wid, int hei) {
    super(categoryEnum.Armour, x, y, wid, hei, new CategoryItems(new ArrayList<Item>() {
      { 
        // add each Armour item to this arraylist which is passed up to parent classes
        add(new GravyArmour());
        add(new GravyHelmet());
      }
    }
    , x, y, wid, hei));
  }
  }

class MiscButton extends CategoryButton {

  MiscButton(int x, int y, int wid, int hei, int yminus) {
    super(categoryEnum.Misc, x, y, wid, hei, new CategoryItems(new ArrayList<Item>() {
      { 
        // add each Misc item to this arraylist which is passed up to parent classes
        add(new GravyBanner()); 
      }
    }
    , x, y - yminus, wid, hei));
  }

  //ArrayList<Item> _items, int _x, int _y, int _wid, int _hei
}

class WeaponButton extends CategoryButton {

  WeaponButton(int x, int y, int wid, int hei, int yminus) {
    super(categoryEnum.Weapons, x, y, wid, hei, new CategoryItems(new ArrayList<Item>() {
      { 
        // add each Misc item to this arraylist which is passed up to parent classes
        add(new Boomerang()); 
      }
    }
    , x, y - yminus, wid, hei));
  }

  //ArrayList<Item> _items, int _x, int _y, int _wid, int _hei
}
interface MiscItem {
  public categoryEnum category = categoryEnum.Misc;
}

interface ArmourItem {
  public categoryEnum category = categoryEnum.Armour;
}

//interface WeaponItem {
//  public categoryEnum category = categoryEnum.Weapons;
//}

public abstract class Item extends Entity {
  protected CurrencyPurse cost;
  protected int weight;
  protected String desc;
  public categoryEnum category;
  public boolean mousePreviousFrame = false;
  protected int wid, hei;

  Item(Float _x, Float _y, int rad, String _name, CurrencyPurse _cost, int _weight, categoryEnum _category, String _desc) {
    super(_x, _y, rad, _name); 
    cost = _cost;
    weight = _weight;
    desc = _desc;
    category = _category;
  }
  
  Item(String _name, CurrencyPurse _cost, categoryEnum _category, String _desc) {
    super(0.0f, 0.0f, 5, _name); 
    cost = _cost;
    weight = 5;
    desc = _desc;
    category = _category;
  }

  public Entity interact(char key) {
    return null; /*this is not implemented yet for this object */
  };
  public  int GetDirection() {
    return 0; /*this is not implemented yet for this object */
  };

  public  boolean ShowInteractionInterface(Player player, float mousex, float mousey) {
    return false; 
    /*this is not implemented yet for this object */
  };


   boolean clicked = false;
   public boolean Clicked(float mousex, float mousey) {
    if (clicked || mousex > pos.x && mousex < pos.x + wid && mousey < pos.y + hei && mousey > pos.y && mousePressed) {
     return clicked = true;
    }
    return clicked = false;
  }
  
  public abstract Item CreateNewInstance();
  public abstract categoryEnum GetCategory();
  
   public void SetButton(int _x, int _y, int _wid, int _hei) {
    pos.x = _x;
    pos.y = _y;
    wid = _wid;
    hei = _hei;
  }
  
  public void DisplayButton(String displayLocation) {
    //rect(x, y, wid, hei);
    switch (displayLocation) {
    case "merchant":
      final int IMG = hei - 20;
      fill(100, 0, 0);
      rect(pos.x, pos.y, wid, hei);
      fill(0, 100, 0);
      textAlign(RIGHT);
      textSize(32);
      //
      text(name, pos.x + wid - 20, pos.y + 2*hei/3 + hei/6); //category name
      rect(pos.x +10, pos.y + 10, IMG, IMG);                            //represents Category image
      //
      textSize(12);
      textAlign(CENTER);
      fill(255);
    }
  }
  
  public void ShowConfirmPurchase() {
   rect( width/2 - width/4, height/2 - height/4 ,width/2,height/2); 
  }
  
   int firstclick = 0;
  public String Confirm(float mousex, float mousey) {
    
    
    if (firstclick == 0) {
      mousePreviousFrame = true;
      firstclick = 1;
      }
      if (firstclick == 1) {
        if (!mousePreviousFrame) {
          firstclick = 2;
        }
      } else if (firstclick == 2) {
       if (mousex > width/2 - width/4 &&  mousey < height/2 + height/4 && mousex > width/2 - width/4 && mousey < height/2 + height/4 && mousePressed) {
          println("something");
   
          firstclick = 0;
          return "confirm";
        }
      }
    
    
    return "show";
  }

  public  void display(int angle) { //
  };
}

public class Merchant extends Entity {

  Item PreparePurchase = null;
  MerchantInterface Interface ;
  boolean keyprevframe = false;

  //----------------------------------------------------------------------------------
  Merchant(float _x, float _y, int rad, String _name, int wid, int hei) {
    super(_x, _y, rad, _name);
    //Interface = new MerchantInterface( wid/5, 0, 3*wid/5, hei);
    Interface = new MerchantInterface( wid/5 + 40, 0, 3*wid/5, hei);
  }

  //----------------------------------------------------------------------------------
  public void display(int angle) {
    // implement movement at later date (no need to use angle for now)
    text("Merchant", pos.x + 1, pos.y - 20);
    ellipse(pos.x, pos.y, RAD, RAD);
  }


  //----------------------------------------------------------------------------------
  public int GetDirection() {
    // currently does not move, so no direction necessary
    return 0;
  }

  boolean ready = true;
  public boolean ShowInteractionInterface(Player player, float mousex, float mousey) {

    Interface.mousePress(mouseReleased);


    Interface.DisplayOutline();
    Interface.displayCategories(mousex, mousey);
    if (keyPressed && ready) {
      keyprevframe = true;
      ready = false;
      if (key == ENTER) {
        if (Interface.keypress()) {
          PreparePurchase = null;
          for (Item itm : Interface.allItems) {
            player.inventory.add(itm);
          }
          Interface.allItems = new ArrayList<Item>();
          return false;
        } else {
          Interface.UpdateShoppingCart();
          Interface.ShowShoppingList();
        }
      }
    }
    if (keyReleased) {
      ready = true;
    }
    return true; //assuming nothing purchased then return false
    /*
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
     } else {
     fill(100, 0, 0);
     text("you do not have enough money to purchase " + PreparePurchase.name, width/2, height/2 - 50);
     fill(255);
     }
     }
     */
  }

  // check if the Player has chosen to interact with the entity by using the 'e' key
  public Entity interact(char key) {
    text("[e]", pos.x + 1, pos.y - 35);
    if (!keyPressed) {
      if (key == 'e') {
        return this;
      }
    } 
    return null;
  }
}

public class MerchantInterface {
  ArrayList<CategoryButton> categories = new ArrayList<CategoryButton>(); 
  private int x, y, wid, hei;
  private ArrayList<Item> allItems = new ArrayList<Item>();
  private PImage background = loadImage("TempMerchantInterface.png");

  MerchantInterface(int _x, int _y, int _wid, int _hei) {
    x = _x;
    y = _y;
    wid = _wid;
    hei = _hei;
    final int tall = 80;
    final int edge = _wid/50;

    int tempy = _y + _hei/3;
   // int increment = tall + 10;
   int increment = tall + 70;
    categories.add(new ArmourButton(_x + edge, tempy, _wid/3, tall));
    tempy += increment;
    categories.add(new MiscButton(_x + edge, tempy, _wid/3, tall, increment));
    tempy += increment;
    categories.add(new WeaponButton(_x + edge, tempy, _wid/3, tall, 2*increment));
    tempy += increment;
    categories.add(new MiscButton(_x + edge, tempy, _wid/3, tall, 3*increment));
    tempy += increment;
    categories.add(new MiscButton(_x + edge, tempy, _wid/3, tall, 4*increment));
    tempy += increment;
    categories.add(new MiscButton(_x + edge, tempy, _wid/3, tall, 5*increment));
  }

  public void DisplayOutline() {
    //rect(x, y, wid, hei);
    image(background,0,0);
  }

  public void UpdateShoppingCart() {
    for ( CategoryButton button : categories) {
      // add each item from the category into a universal array
      for (Item itm : button.shoppingCart) {
        allItems.add(itm);
      }
      //Reset the arraylist once the items have been taken from it
      button.shoppingCart = new ArrayList<Item>();
    }
  }

  public boolean keypress() {
    for (CategoryButton button : categories) {
      if (button.OpenMenu) {
        button.OpenMenu = false;
        button.firstclick = 0;
        return false;
      }
    }
    return true;
  }
  
  public void ShowShoppingList() {
   println(allItems); 
  }

  public void mousePress(boolean mouseReleased) {
    for (CategoryButton button : categories) {
      button.mouseReleased = mouseReleased;
    }
  }

  public void displayCategories(float mousex, float mousey) {
    boolean ChosenCategory = false;
    for (CategoryButton button : categories) {
      if (button.OpenMenu) {
        ChosenCategory = true;
      }
    }
    if (ChosenCategory) {
      for (CategoryButton button : categories) {
        if (button.OpenMenu) {
          button.DisplayCategory(mousex, mousey);
        }
      }
    } else {
      for (CategoryButton button : categories) {
        button.DisplayCategory(mousex, mousey);
      }
    }
  }

  public void DisplayPlayerBalance() {
  }
}

public class Player extends WorldObject {

  public ArrayList<Entity> inventory = new ArrayList<Entity>(); //probably should change to private

  // for now i will just make this me but future should be able to create your character with personal details
  public CurrencyPurse pocketMoney = new CurrencyPurse(name); 

  Player(float x, float y) {
    super(x, y, 20, "Fuzedpeach");
  }

  public void display() {
  }

  public void display(int angle) {
    pushMatrix();

    translate(pos.x, pos.y);
    rotate(-radians(angle));

    triangle(RAD - 10, -5, RAD - 3, 0, RAD - 10, 5);
    popMatrix(); 

    text(name, pos.x + 1, pos.y - 20);
    ellipse(pos.x, pos.y, RAD, RAD);
  }

  public int Direction(float mousex, float mousey) {
    PVector heading = Heading(mousex, mousey);
    int pointingCharAsDegree = round(map (atan2(heading.y, heading.x), PI, -PI, -180, 180)) ;
    return pointingCharAsDegree;
  }

  public PVector Heading(float mousex, float mousey) {
    PVector mousepos = new PVector(mousex, mousey);
    return mousepos.sub(pos);
  }

  public Entity InteractDistanceEntity(int pointingCharAsDegree, ArrayList<Entity> entities, char key, int THREESIXTY, int COLLIDEANGLE) {

    for (Entity obj : entities ) {
      PVector EntClone = obj.pos.copy();
      PVector headingent = EntClone.sub(pos);
      int pointingCharEntAsDegree = round(map(atan2(headingent.y, headingent.x), PI, -PI, -180, 180)) ; 

      if (headingent.magSq() < sq(RAD)) {
        //collision logic
      } else if (headingent.magSq() < sq(40)) {
        if (pointingCharEntAsDegree > 160) {
          int tempdegrees = -THREESIXTY + pointingCharEntAsDegree + COLLIDEANGLE;
          if ((pointingCharAsDegree > pointingCharEntAsDegree  - COLLIDEANGLE)  || pointingCharAsDegree < tempdegrees) {
            return obj.interact(key);
          }
        } else if (pointingCharEntAsDegree < -160) {
          int tempdegrees = THREESIXTY + pointingCharEntAsDegree - COLLIDEANGLE;
          if ((pointingCharAsDegree < pointingCharEntAsDegree  + COLLIDEANGLE)  || pointingCharAsDegree > tempdegrees) {
            return obj.interact(key);
          }
        } else {
          if (pointingCharEntAsDegree > pointingCharAsDegree - COLLIDEANGLE && pointingCharEntAsDegree < pointingCharAsDegree + COLLIDEANGLE) {
            return obj.interact(key);
          }
        }
      }
    }
    return null;
  }

  public Entity ThrowSelectedItem(float mousex, float mousey) {
    Throwable temp = null;
    for (Entity itm : inventory) {
      if (itm instanceof Throwable) {
        temp = (Throwable)itm;
        inventory.remove(itm);
        temp.SetDirection(Heading(mousex,mousey));
        temp.SetToPlayerLocation(pos.x,pos.y);
        break;
      }
    }
    return (Entity)temp;
  }

public void move(char key) {
  //not finished movement
  switch (key) {
  case 'w':  
    pos.y-= 2;
    break;
  case 's': 
    pos.y+=2;
    break;
  case 'a' :
    pos.x-=2;
    break;
  case 'd' : 
    pos.x+=2;
    break;
  }
}
}

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

public abstract class WearableItem extends Item {
  
 private bodyPart bodypart;
 public WearableItem(float x, float y, String name, CurrencyPurse _cost, int _weight, categoryEnum _category, bodyPart _body, String _desc) {
    super(x, y, 5, name, _cost, _weight,_category, _desc);
    bodypart = _body;
 }
 
  public WearableItem(String name, CurrencyPurse _cost, categoryEnum _category, bodyPart _body, String _desc) {
    super(name, _cost, _category, _desc);
    bodypart = _body;
 }
 
 
 public bodyPart GetBodyPart() {
   return bodypart;
 }
 
 public abstract WearableItem CreateNewInstance();
 
}


public abstract class WorldObject {
  public PVector pos;
  public final int RAD;
  protected final String name;
  WorldObject(Float _x, Float _y, int rad, String _name) {
    pos = new PVector(_x, _y);
    RAD = rad;
    name = _name;
  }
  

  
}


enum categoryEnum {
  
  Misc,
  Armour,
  Weapons,
  Food,
  Potions,
  Scrolls,
  Slaves
  
}

enum bodyPart {
 
  Chest,
  Legs,
  Gloves,
  Boots,
  Helmet,
  Finger
  
}
  public void settings() {  fullScreen(); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "purchase_game" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
