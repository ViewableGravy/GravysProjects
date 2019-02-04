


GameEngine gameengine;

void setup() {
  fullScreen();
 // size(600, 600);
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
