
void setup() {
  size(1000, 1000);
  //fullScreen();
  float x0 = 1;
  float y0 = 1;
  float ESCAPE = 4;
  float x = 0;
  float y = 0;
  float xtemp;
  float iteration = 0;
  float MAX_ITERATION = 500;
  //background(0);
  for (int i = 0; i <= width; i++) {
    for (int j = 0; j <= height; j++) {
      x0 = map(i,0,width,-2.5,1);
      y0 = map(j,0,height,-2.5,1);
      x = 0;
      y = 0;
      iteration = 0;
      while ((x*x + y*y) <= ESCAPE && iteration < MAX_ITERATION) {
        xtemp = x*x - y*y + x0;
        y = 2*x*y + y0;
        x = xtemp;
        iteration = iteration + 1;
      }
      if (iteration == MAX_ITERATION) {
        stroke(0);
      } else {
        stroke(iteration);
      }
      point(i, j);
    }
  }
}
