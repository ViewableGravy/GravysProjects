Circle circles;
void setup() {
  size(600,600);
  circles = new Circle();
}

void draw() {
  background(100);
  translate(width/2,height/2);
  fill(#2FC93A);
  rect(-width/3,-height/3,width - width/3,height - height/3);
  circles.Update();
  circles.Show();
  println(frameRate);
}
class Circle {
  
  PVector pos;
  PVector vel;
  PVector acc;
  float rot,x,y;
  PVector pos2;
  
  
  Circle() {
    this.rot = 0;
    pos = new PVector(0,0);
    vel = new PVector(random(-1,1),random(-1,1));
    acc = new PVector(0,0.1);
  }
  
  void Update() {
    if(this.rot > 360) {
      this.rot = 0;
    } else {
      this.rot += 5;
    }
    if (this.pos.y > (height/3) - 13) {
      this.vel.y = this.vel.y * -1;
    }
    if (this.pos.x > width/3 || this.pos.x < -width/3) {
      this.vel.x = this.vel.x * -1;
    }
    this.pos.add(this.vel);
    this.vel.add(this.acc);
    this.vel.limit(10);
    
    this.x = 100 * cos((this.rot/180) * PI);
    this.y = 100 * sin((this.rot/180) * PI);
    this.pos2 = new PVector(this.pos.x + x,this.pos.y + y);
    
  }
  
  void Show() {
    fill(#1E6C23);
    ellipse(this.pos.x,this.pos.y,20,20);
    noFill();
    ellipse(this.pos2.x, this.pos2.y,20,20);
  }
  
}