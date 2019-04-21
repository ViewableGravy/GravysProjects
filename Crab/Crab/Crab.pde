
float rotation = 0;

Thingy thing = new Thingy();

void setup() {
  size(800, 800);
}


void draw() {
  background(144);
  if (keyPressed && key =='r') {
    rotation+=0.01;
  }
  translate(width/2, height/2);
  rotate(rotation);
  thing.display();
}

class Thingy {
  Thingy() {
  }

  void display() {
    ellipse(0, 0, 100, 100);
    float widFortyFive = (cos(PI/4) * 50);
    float heiFortyFive = - (sin(PI/4) * 50);
    float widSix = (cos(PI/6) * 50);
    float heiSix = - (sin(PI/6) * 50);
    float widFour = (cos(PI/2 + PI/4) * 50);
    float heiFour = - (sin(PI/2 + PI/4) * 50);
    float widless =(cos(PI/2 + PI/3) * 50);
    float heiless =  - (sin(PI/2 + PI/3) * 50);

    line(widFortyFive, heiFortyFive, widFortyFive + 30, heiFortyFive - 80);
    line(widSix, heiSix, widSix + 40, heiSix - 100);
    line(widFour, heiFour, widFour - 30, heiFour - 80);
    line(widless, heiless, widless - 40, heiless - 100);
  }
}
