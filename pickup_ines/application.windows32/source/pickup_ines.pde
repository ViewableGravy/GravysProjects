String[] lines;
void setup() {
  size(600, 600);
  lines = loadStrings("pickuplines.txt");
  textSize(50);
  fill(255, 0, 0);
  stroke(0, 255, 0);
  text("click left mouse button", width/8, height/4, width-width/4, height - height/4);
  //frameRate(1);
}

void draw() {
  
}

void mousePressed() {
  background(200);
  int pickupline = round(random(0, lines.length-1));
  if (lines[pickupline].trim().length() == 0) {
     pickupline++; 
  }
    text(lines[pickupline], width/8, height/4, width-width/4, height - height/4);
}
