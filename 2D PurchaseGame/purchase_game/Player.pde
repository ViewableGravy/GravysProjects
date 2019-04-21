
public class Player extends WorldObject {

  public ArrayList<Entity> inventory = new ArrayList<Entity>(); //probably should change to private


  public CurrencyPurse pocketMoney; 

//currently works off a string but will input based on username
  Player(float x, float y) {
    super(x, y, 20, "ViewableGravy");
    
    
    try {
      int temp = 0;
      JSONObject something = loadJSONObject("https://api.streamelements.com/kappa/v2/points/5c235339072350ec38cd501f/top");
      JSONArray users = something.getJSONArray("users");
      //println(users);
    
      for(int i = 0; i < users.size(); i++) {
        JSONObject user = users.getJSONObject(i);
        if (user.get("username").equals("ViewableGravy".toLowerCase())) {
          temp = (int)user.get("points");
        }
      }
      
      pocketMoney = new CurrencyPurse(temp * 100);
      //pocketMoney = new CurrencyPurse(2983729);
      println("Created Player Currency Purse");
      
    } 
    catch (Exception e) {}
     
       
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

  Entity InteractDistanceEntity(int pointingCharAsDegree, ArrayList<Entity> entities, char key, int THREESIXTY, int COLLIDEANGLE) {

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
