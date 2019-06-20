CollideableEntity player1;
CollideableEntity player2;
CollideableEntity[] players = new CollideableEntity[2];
int CurrentEntity = 1;

void setup() {
  noFill();
  strokeWeight(2);
  stroke(255);
  frameRate(1000);
  size(500, 500);
  BoundingBox[] first = new BoundingBox[3];
  first[0] = new BoundingBox(100, 100, 100, 100);
  first[1] = new BoundingBox(150, 150, 100, 100);
  first[2] = new BoundingBox(50, 50, 100, 100);
  
  players[0] =  new CollideableEntity(first);

  first = new BoundingBox[3];
  first[0] = new BoundingBox(300, 200, 100, 100);
  first[1] = new BoundingBox(350, 250, 100, 100);
  first[2] = new BoundingBox(350, 350, 100, 100);
  
  players[1] = new CollideableEntity(first);
}

void draw() {
  background(0);
  for (CollideableEntity player : players) {
   player.Display(); 
  }
  if (temp != null) {
    temp.UpdateParameters(mouseX,mouseY); 
    temp.Display();
  }
  
  println(CurrentEntity);
  
}

BoundingBox temp = null;
void mouseClicked() {
  if (temp == null) {
    temp = new BoundingBox(mouseX,mouseY);
  } else {
    players[CurrentEntity-1].addBox(temp);
    temp = null;
  }
  
  
}
 List<char> keys = new ArrayList<char>();
void keyPressed() {
  
  
  if (key == 'u') {
    if (CurrentEntity != players.length + 1) {
      CurrentEntity++;
    }
    
  } else if (key == DOWN) {
    CurrentEntity--;
  }
  
  if (key == 'w') {
    players[0].translate(0, -1); 
    if (players[0].Collide(players[1])) {
      players[0].translate(0, 1);
      println(frameRate);
      stroke(100, 0, 0);
    } else {
      stroke(255);
    }
  } else if (key == 's') {
    players[0].translate(0, 1); 
    if (players[0].Collide(players[1])) {
      players[0].translate(0, -1);
      println(frameRate);
      stroke(100, 0, 0);
    } else {
      stroke(255);
    }
  } else if (key == 'd') {
    players[0].translate(1, 0); 
    if (players[0].Collide(players[1])) {
      players[0].translate(-1, 0);
      println(frameRate);
      stroke(100, 0, 0);
    } else {
      stroke(255);
    }
  } else if (key == 'a') {
    players[0].translate(-1, 0); 
    if (players[0].Collide(players[1])) {
      players[0].translate(1, 0);
      println(frameRate);
      stroke(100, 0, 0);
    } else {
      stroke(255);
    }
  }
}
