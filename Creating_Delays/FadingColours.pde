PVector pos;
int mill;

void setup() {
  //size(600, 600);
  fullScreen();
  background(255);
  fill(255, 255);
  pos = new PVector(width/2, height/2);
  mill = millis();
}

void draw() {
  if (millis() > mill + 500) {
    mill = millis();
    //EllipseFade(floor(random(0, width)), floor(random(0, height)), floor(random(0, 255)), floor(random(0, 255)), floor(random(0, 255)));
    if (mousePressed) {
      timely(width/2, height/2, 255, 255, 255, 100);
    }
  }
}

void EllipseFade(int posx, int posy, int r, int g, int b) {
  for (int i = 500; i > 0; i--) {
    float alph = 50 - map(i, 500, 0, 40, 5);
    stroke(r, g, b, alph);
    ellipse(posx, posy, i, i);
  }
}

void timely(int posx, int posy, int r, int g, int b, int time) {
  while (time > 0) {
    time--;
    println(time);
    if (time == 0) {
      println("fuck you");
      time = 100;
      return;
    }
  }
}
