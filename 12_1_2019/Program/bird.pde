
public class Bird {
  int _x, _y, _height, _width;

  boolean gotpoint = false;
  int points = 0;
  float acc = 0.4;
  float vel = 0;
  PImage bird = loadImage("yellowbird-midflap.png");

  public Bird(int x, int y, int wid, int hei) {
    _x = x;
    _y = y;
    _width = wid;
    _height = hei;
     bird.resize(_width,_height);
  }

  public void update() {
    vel += acc;
    _y += vel;
  }

  public void display() {
    pushMatrix();
    imageMode(CENTER);
    translate(_x + _width/2,_y + _height/2);
    rotate(map(vel,-10,10,PI/-4,PI/4));
   
    image(bird,0,0);
    //rect(0, 0, _width, _height);
    imageMode(CORNER);
    popMatrix();
  }

  public void jump() {
    vel = -10;
  }

  public void showscore() {
    textSize(32);
    text(points, width/2, 150);
  }

  public boolean collide(Pipe pipe) {
    boolean collided = false;
    if ( _y > height|| _y < 0) 
    {
      collided = true;
    } 
    else if (pipe._center.x < _x + _width) 
    {
      if (pipe._center.x + pipe._width > _x) 
      {
        if (gotpoint == false) 
        {
          points++;
        }
        gotpoint = true;
        if (_y > pipe._center.y - pipe._height || _y < pipe._center.y - pipe._height - 300) 
        {
          collided = true;
        }
      } 
      else
      {
        gotpoint = false;
      }
    }
    return collided;
  }
}
