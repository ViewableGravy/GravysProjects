


GameEngine gameengine;

void setup() {
  size(600, 600);
  gameengine =  new GameEngine(width, height);
}

void draw() {
  background(100);

  gameengine.tick(mouseX, mouseY);

  if (keyPressed) {
    gameengine.move(key);
  }
}
