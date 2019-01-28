PShape ground, cube;
float dist = 0;
boolean jump = false;
int jheight = 0;
float fallspeed = 0;
float jumpspeed = 10;
float lr = 0, fb = 0;
float cx, cy, cz;
int[] buttons, arr;
boolean keyreleased = true;
PVector eye = new PVector(0, 0, 0);
PVector obj = new PVector(0, 0, 0);
float rotation = 0;

void setup() {
  size(600, 600, P3D);
  buttons = new int[5];
  arr = new int[5];
  ground = createShape();
  ground.beginShape();
  ground.vertex(-500, -500, -400);
  ground.vertex(500, -500, -400);
  ground.vertex(500, 500, -400);
  ground.vertex(-500, 500, -400);
  ground.endShape(CLOSE);
}

void draw() {
  buttonCheck();
  jumping();
  HCheck();
  positioning();
  println(frameRate);
}

void keyReleased() {
  for (int i = 0; i <= 4; i++) {
    if (keyCode == buttons[i]) {
      buttons[i] = 0;
    }
  }
}

void keyPressed() {
  if (key == ' ') {
    buttons[0] = 32;
  }
  if (keyCode == LEFT) {
    buttons[1] = 37;
  }
  if (keyCode == RIGHT ) {
    buttons[2] = 39;
  }
  if (keyCode == UP) {
    buttons[3] = 38;
  }
  if (keyCode == DOWN) {
    buttons[4] = 40;
  }
}

void buttonCheck() {
  if (buttons[0] == 32) {
    jump = true;
    jumpspeed = 10;
  }
  if (buttons[1] == 37) {
    lr -= 10;
  }
  if (buttons[2] == 39 ) {
    lr += 10;
  }
  if (buttons[3] == 38) {
    fb -= 10;
  }
  if (buttons[4] == 40 ) {
    fb += 10;
  }
}

void jumping() {
  if (jump) {
    dist -= jumpspeed;
    jumpspeed -= 0.3;
    if (jumpspeed <= 0) {
      jump = false;
      jumpspeed = 10;
      fallspeed = 0;
    }
  }
}

void HCheck() {
  if (dist < 400 && jump == false) {
    dist += fallspeed;
    fallspeed += 0.3;
  } else if (dist > 400 ) {
    dist = 400;
  }
}

void positioning() {
  background(200);
  pushMatrix();
    float rotationA = map(mouseX,0,width,0,TWO_PI);
    translate(width/2, height/2);
    rotateZ(rotationA);
    shape(ground);
    translate(0,0,-400);
    pushMatrix();
      float adj = 50 + lr;
      float opp = fb;
      float up = -dist + 490;
      float rotationB = (-rotationA);
      translate(adj, opp, up);
      rotateZ(-rotationB);
      float rotx = modelX(0,0,0);
      float roty = modelY(0,0,0);
      float rotz = modelZ(0,0,0);
      box(150);
    popMatrix();
  popMatrix();
  obj.add(rotx,roty,rotz);
  // x: translation of eye, left and right from cube.
  // y: translation of eye, away from cube
  // z: translation of eye, up and down from cube.
  eye.add(obj);
  eye.add(100, -1000, 500);
  camera(eye.x, eye.y, eye.z, obj.x, obj.y, obj.z, 0, 0, -1);  
  
  
  
  eye.mult(0);
  obj.mult(0);
}
