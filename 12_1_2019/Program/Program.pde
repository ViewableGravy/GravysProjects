
// pipes
// bird
Bird bird;
ArrayList<Pipe> pipes = new ArrayList<Pipe>();
Pipe pipe;
PImage background1,background2;
Background bg1,bg2;
void setup() {
 // size(800, 800);
 fullScreen();
 background1 = loadImage("Untitled.png");
 background2 = background1;
 
 bg1 = new Background(0,1920, background1);
 bg2 = new Background(1920,1920,background2);
 
// background.resize(1920,1080);
  bird = new Bird(100,height/2,80,60);
  pipes.add(new Pipe(width, 120, 200));
  pipes.add(new Pipe(width + width/3, 120, 100));
  pipes.add(new Pipe(width + (2*width/3), 120, 100));
}

void draw() {
 // image(background,0,0);
  boolean stop = false;
  
  bg1.reset();
  bg1.display();
  bg1.update();
  bg2.reset();
  bg2.display();
  bg2.update();
  
  
  //background(background);
 // line(0,200,width,200);
  //line(0,height - 200, width, height - 200);
  for (Pipe pipe : pipes) {
    if (bird.collide(pipe)) {
      noLoop();
      stop = true;
    }
    pipe.update();
    pipe.reset();
    pipe.draw();
  }
  
  bird.update();
  bird.display();
  bird.showscore();
  
  if (stop == true) {
    textSize(32);
    text("LOSE",width/2,height/2);
  }
}

void keyPressed() {
 if (key == ' ') {
  bird.jump(); 
 }
}
