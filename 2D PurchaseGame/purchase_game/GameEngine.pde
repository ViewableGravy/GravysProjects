

public class GameEngine {
  final int RAD = 20;
  final int COLLIDEANGLE = 30;
  final int THREESIXTY = 360;
  boolean display = true;
  PVector playerpos, entpos;

  public GameEngine(int wid, int hei) {
    entpos = new PVector(wid/2, hei/2);
    playerpos = new PVector(wid/3, hei/3);
    textAlign(CENTER);
  }

  public void Display(float mousex, float mousey) {
    pushMatrix();

    translate(playerpos.x, playerpos.y);
    rotate(-radians(Direction(mousex, mousey)));

    triangle(RAD - 10, -5, RAD - 3, 0, RAD - 10, 5);
    popMatrix();

    ellipse(playerpos.x, playerpos.y, RAD, RAD);
    ellipse(entpos.x, entpos.y, RAD, RAD);
  }

  public void tick(float mousex, float mousey, char key) {


    if (DisplayMerchant(mousex,mousey,key)) {
      MerchantMenu();
      println("displaying menu");
    } else {
      Display(mousex, mousey);
    }

    if (keyPressed) {
      gameengine.move(key);
    }
  }
  
  void MerchantMenu() {
    
  }

  public boolean DisplayMerchant(float mousex, float mousey, char key) {
    if (!InteractDistanceEntity(Direction(mousex, mousey))) {
      return false;
    }
    text("[e]", entpos.x + 1, entpos.y - 20);
    if (!keyPressed) {
      return false;
    } 
    if (!InteractEntity(key)) {
      return false;
    }
    return true;
  }
  
  public boolean InteractEntity(char key) {

    if (key == 'e') {
      return true;
    }
    return false;
  }

  public void move(char key) {

    switch (key) {
    case 'w':  
      playerpos.y-= 1;
      break;
    case 's': 
      playerpos.y+=1;
      break;
    case 'a' :
      playerpos.x-=1;
      break;
    case 'd' : 
      playerpos.x+=1;
      break;
    }
  }

  int Direction(float mousex, float mousey) {
    PVector mousepos = new PVector(mousex, mousey);
    PVector heading = mousepos.sub(playerpos);
    int pointingCharAsDegree = round(map (atan2(heading.y, heading.x), PI, -PI, -180, 180)) ;
    return pointingCharAsDegree;
  }

  boolean InteractDistanceEntity(int pointingCharAsDegree) {

    PVector EntClone = entpos.copy();
    PVector headingent = EntClone.sub(playerpos);
    int pointingCharEntAsDegree = round(map(atan2(headingent.y, headingent.x), PI, -PI, -180, 180)) ; 

    if (headingent.magSq() < sq(RAD)) 
    {
      //collision logic
    } else if (headingent.magSq() < sq(40)) 
    {
      if (pointingCharEntAsDegree > 160) 
      {
        int tempdegrees = -THREESIXTY + pointingCharEntAsDegree + COLLIDEANGLE;
        if ((pointingCharAsDegree > pointingCharEntAsDegree  - COLLIDEANGLE)  || pointingCharAsDegree < tempdegrees) 
        {
          return true;
        }
      } else if (pointingCharEntAsDegree < -160) 
      {
        int tempdegrees = THREESIXTY + pointingCharEntAsDegree - COLLIDEANGLE;
        if ((pointingCharAsDegree < pointingCharEntAsDegree  + COLLIDEANGLE)  || pointingCharAsDegree > tempdegrees) 
        {
          return true;
        }
      } else 
      {
        if (pointingCharEntAsDegree > pointingCharAsDegree - COLLIDEANGLE && pointingCharEntAsDegree < pointingCharAsDegree + COLLIDEANGLE) 
        {
          return true;
        }
      }
    }
    return false;
  }
}
