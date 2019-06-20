Shape shape1, shape2;

void setup() {
  size(500, 500);

  shape1 = regularPolygon(width/2, height/2, 100, floor(random(2, 6)));
  shape2 = regularPolygon(mouseX, mouseY, 100, floor(random(2, 6)));

  noLoop();
}

void draw() {
  background(255);

  PVector[] axes = (PVector[])concat(shape1.axes, shape2.axes);
  if (SAT(axes, shape1.vertices, shape2.vertices)) {
    stroke(100, 200, 25);
    fill(100, 200, 25);
  } else {
    stroke(0);
    noFill();
  }

  shape1.show();
  shape2.show();
}

void mouseMoved() {
  shape2.translate(mouseX - pmouseX, mouseY - pmouseY); 
  redraw();
}

void mousePressed() {
  setup();
}
