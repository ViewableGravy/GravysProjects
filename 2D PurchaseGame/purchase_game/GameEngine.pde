

public class GameEngine {
final int RAD = 20;
final int COLLIDEANGLE = 30;
final int THREESIXTY = 360;
PVector playerpos, entpos;

  public GameEngine(int wid,int hei) {
    entpos = new PVector(wid/2, hei/2);
    playerpos = new PVector(wid/3, hei/3);
    
  }

  public void Draw() {
    println(entpos.x,entpos.y);
    ellipse(playerpos.x, playerpos.y, RAD, RAD);
    ellipse(entpos.x, entpos.y, RAD, RAD);
    
  }
  
  public void tick(float mousex, float mousey) {
    Draw();
   
    if (InteractEntity(mousex, mousey)) {
      
    }
  }
  
  public void move(char key) {
    if (key == 'w') {
      playerpos.y-= 1;
    } 
    if (key == 's') {
      playerpos.y+=1;
    } 
    if (key == 'a') {
      playerpos.x-=1;
    } 
    if (key =='d') {
      playerpos.x+=1;
    }
  }

  boolean InteractEntity(float mousex, float mousey) {

    PVector EntClone = entpos.copy();

    PVector mousepos = new PVector(mousex, mousey);
    PVector heading = mousepos.sub(playerpos);
    int pointingCharAsDegree = round(map (atan2(heading.y, heading.x), PI, -PI, -180, 180)) ; 


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
        println(tempdegrees);
        if ((pointingCharAsDegree > pointingCharEntAsDegree  - COLLIDEANGLE)  || pointingCharAsDegree < tempdegrees) 
        {
          line (playerpos.x, playerpos.y, mousex, mousey);
          //open menu
        }
      } else if (pointingCharEntAsDegree < -160) 
      {
        int tempdegrees = THREESIXTY + pointingCharEntAsDegree - COLLIDEANGLE;
        println(tempdegrees);
        if ((pointingCharAsDegree < pointingCharEntAsDegree  + COLLIDEANGLE)  || pointingCharAsDegree > tempdegrees) 
        {
          line (playerpos.x, playerpos.y, mousex, mousey);
          //open menu
        }
      } else 
      {
        if (pointingCharEntAsDegree > pointingCharAsDegree - COLLIDEANGLE && pointingCharEntAsDegree < pointingCharAsDegree + COLLIDEANGLE) 
        {
          line (playerpos.x, playerpos.y, mousex, mousey);
          //open menu
        }
      }
    }
    return true;
  }
  
  
}
