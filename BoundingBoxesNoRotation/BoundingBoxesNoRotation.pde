CollideableEntity player1;
CollideableEntity player2;
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
  player1 = new CollideableEntity(first);

  first = new BoundingBox[3];
  first[0] = new BoundingBox(300, 200, 100, 100);
  first[1] = new BoundingBox(350, 250, 100, 100);
  first[2] = new BoundingBox(350, 350, 100, 100);
  player2 = new CollideableEntity(first);
}

void draw() {
  background(0);
  player1.Display();
  player2.Display();
}

void keyPressed() {
  if (key == 'w') {
    player1.translate(0, -1); 
    if (player1.Collide(player2)) {
      player1.translate(0, 1);
      println(frameRate);
      stroke(100, 0, 0);
    } else {
      stroke(255);
    }
  } else if (key == 's') {
    player1.translate(0, 1); 
    if (player1.Collide(player2)) {
      player1.translate(0, -1);
      println(frameRate);
      stroke(100, 0, 0);
    } else {
      stroke(255);
    }
  } else if (key == 'd') {
    player1.translate(1, 0); 
    if (player1.Collide(player2)) {
      player1.translate(-1, 0);
      println(frameRate);
      stroke(100, 0, 0);
    } else {
      stroke(255);
    }
  } else if (key == 'a') {
    player1.translate(-1, 0); 
    if (player1.Collide(player2)) {
      player1.translate(1, 0);
      println(frameRate);
      stroke(100, 0, 0);
    } else {
      stroke(255);
    }
  }
}
