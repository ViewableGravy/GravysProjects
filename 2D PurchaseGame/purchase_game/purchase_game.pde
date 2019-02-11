

PFont fairyDust;
GameEngine gameengine;

void setup() {
  fullScreen();
 // size(600, 600);
 fairyDust = createFont("FairyDustB.ttf", 12);
 textFont(fairyDust);
  gameengine =  new GameEngine(width, height);
}

void draw() {
  background(100);

  gameengine.tick(mouseX, mouseY, key);

 
}

void keyReleased() {
  gameengine.keyReleased = true;
}

void keyPressed() {
 gameengine.keyReleased = false; 
}

void mouseReleased() {
 gameengine.mouseReleased = true;
}

void mousePressed() {
 gameengine.mouseReleased = false; 
}
