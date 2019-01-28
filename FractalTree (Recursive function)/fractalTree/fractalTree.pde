int recursion = 15;
float rotation = PI/12;
void setup() {
  size(600, 600);
  translate(width/2, height);
  drawLine(100);
}

void drawLine(float len) {
  line(0, 0, 0, -len);
  translate(0, -len);
  if (len > recursion) {
    pushMatrix();
    rotate(rotation);
    drawLine(len * 0.8);
    popMatrix();
    pushMatrix();
    rotate(-rotation);
    drawLine(len * 0.8);
    popMatrix();
  } else {
    if ( random(0, 20) < 2 ) {
      stroke(255);
      fill(200,0,0);
      ellipse(0, 0, 20, 20);
      stroke(0);
    }
  }
}
