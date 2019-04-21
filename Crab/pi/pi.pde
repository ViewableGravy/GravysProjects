
Square sq1, sq2;
int bounces = 0;
long iterations = 1;
int numbs = 1;
void setup() {
  
  long weight = (long)pow(100, (numbs-1)) ;
  long speed = -5/iterations; //<>//
  size(800, 800);
  sq1 = new Square(1, 50, 20, 0);
  sq2 = new Square(weight, 100, 20, speed);
}

void draw() {
  background(144);
  line(10, 10, 10, height-10);
  line(10, height/2 + 20, width - 10, height/2 + 20);

  for (int i = 0; i < iterations; i++) {
    if (sq1.Collide(sq2)) {
      long v1 = sq1.bounce(sq2);
      long v2 = sq2.bounce(sq1);
      sq1.vel = v1;
      sq2.vel = v2;
      bounces++;
    }
    if (sq1.Wall()) {
      sq1.Reverse();
      bounces++;
    }
    sq2.Wall();
    sq1.Wall();
    sq1.Update();
    sq2.Update();
   
  }
   sq1.display();
   sq2.display();

  println(bounces);
}



public class Square {
  long  x, wid;
  long vel;
  long mass;
  Square(long _mass, int _x, int _wid, long _intvel) {
    mass = _mass;
    x = _x;
    wid = _wid;
    vel = _intvel;
  }

  long bounce(Square other) {
    long sumM = mass + other.mass;
    long newV = (mass-other.mass)/sumM * vel;
    return newV += (2*other.mass / sumM) * other.vel;
  }

  Boolean Wall() {
    return (x <= 0);
  }

  void Reverse() {
    vel = vel * -1;
  }

  void Update() {
    x += vel;
  }

  void display() {
    rect(x, height/2, wid, wid);
  }

  Boolean Collide(Square other) {
    return !(x + wid < other.x || x > other.x + other.wid );
  }
}
