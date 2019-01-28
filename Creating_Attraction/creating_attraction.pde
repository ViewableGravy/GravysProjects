Circle1 circle1;
Circle2 circle2;

int attractlvl = 1000;
void setup() {
  // size(600, 600);
  fullScreen();
  circle1 = new Circle1();
  circle2 = new Circle2();
  textAlign(CENTER);
  textSize(50);
}

void draw() {
  background(100);
  circle2.attract();
  circle2.update();
  circle2.Show();
  circle1.attract();
  circle1.update();
  circle1.Show();
}
class Circle1 {

  float something;
  PVector pos;
  PVector vel;
  PVector att;

  Circle1() {
    this.pos = new PVector(random(0, width), random(0, height));
    this.vel = new PVector(random(-1, 1), random(-1, 1));
  }

  void attract() {
    if (dist(this.pos.x, this.pos.y, circle2.pos.x, circle2.pos.y) > 20) {
      if (circle2.pos.x > this.pos.x ) {
        PVector sandwhich;
        sandwhich = new PVector(attractlvl/sq(dist(this.pos.x, this.pos.y, circle2.pos.x, circle2.pos.y)), 0);
        sandwhich.limit(20);
        this.vel.add(sandwhich);
      }
      if (circle2.pos.x < this.pos.x ) {
        PVector sandwhich;
        sandwhich = new PVector(-attractlvl/sq(dist(this.pos.x, this.pos.y, circle2.pos.x, circle2.pos.y)), 0);
        sandwhich.limit(20);
        this.vel.add(sandwhich);
      }
      if (circle2.pos.y > this.pos.y ) {
        PVector sandwhich;
        sandwhich = new PVector(0, attractlvl/sq(dist(this.pos.x, this.pos.y, circle2.pos.x, circle2.pos.y)));
        sandwhich.limit(20);
        this.vel.add(sandwhich);
      }
      if (circle2.pos.y < this.pos.y ) {
        PVector sandwhich;
        sandwhich = new PVector(0, -attractlvl/sq(dist(this.pos.x, this.pos.y, circle2.pos.x, circle2.pos.y)));
        sandwhich.limit(20);
        this.vel.add(sandwhich);
      }
    }
  }

  void update() {
    if (this.pos.y > height || this.pos.y < 0) {
      this.vel.y = this.vel.y * -1;
    }
    if (this.pos.x > width || this.pos.x < 0) {
      this.vel.x = this.vel.x * -1;
    }
    this.vel.limit(10);
    this.pos.add(this.vel);

    something = dist(this.pos.x, this.pos.y, circle2.pos.x, circle2.pos.y);
  }

  void Show() {
    line(this.pos.x, this.pos.y, this.pos.x + (20* this.vel.x), this.pos.y);
    line(this.pos.x, this.pos.y, this.pos.x, this.pos.y + (20*this.vel.y));
    text("x: " + String.format("%.2f", this.vel.x), this.pos.x, this.pos.y - 70);
    text("y: " + String.format("%.2f", this.vel.y), this.pos.x, this.pos.y - 20);
    ellipse(this.pos.x, this.pos.y, 30, 30);
    println(this.vel.x);
  }
}

class Circle2 {

  PVector pos;
  PVector vel;
  PVector att;

  Circle2() {
    this.pos = new PVector(random(0, width), random(0, height));
    this.vel = new PVector(random(-1, 1), random(-1, 1));
  }

  void attract() {
    if (dist(this.pos.x, this.pos.y, circle1.pos.x, circle1.pos.y) > 20) {
      if (circle1.pos.x > this.pos.x ) {
        PVector sandwhich;
        sandwhich = new PVector(attractlvl/sq(dist(this.pos.x, this.pos.y, circle1.pos.x, circle1.pos.y)), 0);
        sandwhich.limit(20);
        this.vel.add(sandwhich);
      }
      if (circle1.pos.x < this.pos.x ) {
        PVector sandwhich;
        sandwhich = new PVector(-attractlvl/sq(dist(this.pos.x, this.pos.y, circle1.pos.x, circle1.pos.y)), 0);
        sandwhich.limit(20);
        this.vel.add(sandwhich);
      }
      if (circle1.pos.y > this.pos.y ) {
        PVector sandwhich;
        sandwhich = new PVector(0, attractlvl/sq(dist(this.pos.x, this.pos.y, circle1.pos.x, circle1.pos.y)));
        sandwhich.limit(20);
        this.vel.add(sandwhich);
      }
      if (circle1.pos.y < this.pos.y ) {
        PVector sandwhich;
        sandwhich = new PVector(0, -attractlvl/sq(dist(this.pos.x, this.pos.y, circle1.pos.x, circle1.pos.y)));
        sandwhich.limit(10);
        this.vel.add(sandwhich);
      }
    }
  }

  void update() {

    if (this.pos.y > height || this.pos.y < 0) {
      this.vel.y = this.vel.y * -1;
    }
    if (this.pos.x > width || this.pos.x < 0) {
      this.vel.x = this.vel.x * -1;
    }
    this.vel.limit(10);
    this.pos.add(this.vel);
  }

  void Show() {
    line(this.pos.x, this.pos.y, this.pos.x + (20* this.vel.x), this.pos.y);
    line(this.pos.x, this.pos.y, this.pos.x, this.pos.y + (20*this.vel.y));
    text("x: " + String.format("%.2f", this.vel.x), this.pos.x, this.pos.y - 70);
    text("y: " + String.format("%.2f", this.vel.y), this.pos.x, this.pos.y - 20);
    ellipse(this.pos.x, this.pos.y, 30, 30);
  }
}