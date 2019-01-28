PVector pos;
PVector vel;
Ball balls[];
Circle circles[];
int ballcount = 50;
int circlecount = 20;
int maxspeed = 1;
float time = 0;
int timemax = 50;
float one = 0.5;
void setup() {
  size(1400, 800);
  //fullScreen();
  circles = new Circle[circlecount];
  balls = new Ball[ballcount];
  for (int i = 0; i < ballcount; i++) {
    balls[i] = new Ball();
  }
  for (int i = 0; i < circlecount; i++) {
    circles[i] = new Circle();
  }
}

void draw() {
  println(frameRate);
  background(#136889, 10);
  for (int i = 0; i < circlecount; i++) {
    circles[i].show();
  }  
  for (int i = 0; i < ballcount; i++) {
    balls[i].Move();
    balls[i].Show();
  }

  if (time > timemax || time < 0) {
    one = one * -1;
  }
  if (time == 0) {
    for (int i = 0; i < circlecount; i++) {
      circles[i].col();
    }
  }
  time += one;
  check();
}

void check() {
  for (int i = 0; i < ballcount; i++) {
    for (int j = 0; j < ballcount; j++) {
      int closeness = round(dist(balls[i].pos.x, balls[i].pos.y, balls[j].pos.x, balls[j].pos.y));
      if (closeness < 300) {
       //change stroke colour here
        line(balls[i].pos.x, balls[i].pos.y, balls[j].pos.x, balls[j].pos.y);
      }
    }
  }
}

class Ball {

  PVector pos;
  PVector vel;

  Ball() {
    pos = new PVector(random(0, width), random(0, height));
    vel = new PVector(random(-maxspeed, maxspeed), random(-maxspeed, maxspeed));
  }

  void Move() {
    if (this.pos.x > width || this.pos.x < 0) {
      this.vel.x = this.vel.x * -1;
    }
    if (this.pos.y < 0 || this.pos.y > height) {
      this.vel.y = this.vel.y * -1;
    }
    this.pos.add(this.vel);
  }

  void Show() {
    stroke(0, 191, 255);
    fill(30, 144, 255);
    ellipse(this.pos.x, this.pos.y, 5, 5);
  }
}

class Circle {
  PVector pos;
  int size;
  PVector colour;
  Circle() {
    size = round(random(100, 400));
    pos = new PVector(random(0, width), random(0, height));
    colour = new PVector(0, 255, 255);
  }

  void col() {
    colour = new PVector(0, 0, 0);
    int col = round(random(0, 3));
    if (col == 0) {
      colour = new PVector(  0, 255, 255);
    } else if (col == 1) {
      colour = new PVector(  65, 105, 225);
    } else if (col == 2) {
      colour = new PVector(25, 25, 112);
    } else if (col == 3) {
      colour = new PVector(  0, 191, 255);
    }
    pos = new PVector(random(0, width), random(0, height));
  }

  void show() {
    noStroke();
    fill(this.colour.x, this.colour.y, this.colour.z, time);
    ellipse(this.pos.x, this.pos.y, size, size);
  }
}
