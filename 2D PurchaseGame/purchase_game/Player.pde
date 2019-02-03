
public class Player extends WorldObject {

  Player(float x, float y) {
    super(x, y, 20, "player");
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
    PVector mousepos = new PVector(mousex, mousey);
    PVector heading = mousepos.sub(pos);
    int pointingCharAsDegree = round(map (atan2(heading.y, heading.x), PI, -PI, -180, 180)) ;
    return pointingCharAsDegree;
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
  
  

  public void move(char key) {

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
