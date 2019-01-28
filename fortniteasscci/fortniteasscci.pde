import processing.video.*;
Capture video;
HScrollbar hs1;
void setup() {
  size(1280, 960);
  video = new Capture(this, 1280, 960);
  video.start();
  hs1 = new HScrollbar(0, height-8, width, 16, 16);
}

void draw() {
  background(255);
  if (video.available()) {
    video.read();
  }
  fill(255,0,0);
   
  noStroke();
  hs1.update();
   int scrolltocol = round(map(hs1.getPos(),0,width,1,100));
  int cols = scrolltocol;
  int rows = cols;
  textSize(6);
  color colour = 0;
  char letter = '@';
 
  println(hs1.getPos());
  //video.loadPixels();
  /*
   for (int x = 0; x < width - cols; x = x + cols) {
    for (int y = 0; y < height - rows; y = y + rows) {
      int loc ;
      for (int i = 0; i < cols; i++) {
        loc =  x+i+y*width;
        colour = colour + video.pixels[loc];
      }
      for (int j = 0; j < rows; j++) {
        loc = x+j+y*width; 
       // colour = colour + video.pixels[loc];
      }
      colour = round(colour/100); 

      fill(colour);
      rect(x,y,10,10);  
    }
    
  }
  */
  ///*
  for (int x = 0; x < width - cols; x = x + cols) {
    for (int y = 0; y < height - rows; y = y + rows) {
      int loc = x + y * video.width;
      color c = video.pixels[loc];
      fill(c);
      rect(x,y,cols,rows);
      
    }
  }
  //*/
  /*
  // image(video, 0, 0);
  video.filter(GRAY);
  
 

  textSize(6);
  colour = 0;
  video.loadPixels();

  for (int x = 0; x < width - cols; x = x + cols) {
    for (int y = 0; y < height - rows; y = y + rows) {
      int loc ;
      for (int i = 0; i < cols; i++) {
        loc =  x+i+y*width;
        colour = colour + constrain(round(red(video.pixels[loc])), 0, 255);
      }
      for (int j = 0; j < rows; j++) {
        loc = x+j+y*width; 
        colour = colour + constrain(round(red(video.pixels[loc])), 0, 255);
      }
      colour = round(colour/50); 

      if (colour > 42) {
        letter = ' ';
      } else if (colour > 41) {
        letter = '.';
      } else if (colour > 40) {
        letter = '^';
      }else if (colour > 39) {
        letter = ':';
      }else if (colour > 38) {
        letter = 'I';
      }else if (colour > 37) {
        letter = '!';
      }else if (colour > 36) {
        letter = '>';
      }else if (colour > 35) {
        letter = '~';
      }else if (colour > 34) {
        letter = '+';
      }else if (colour > 32) {
        letter = '-';
      }else if (colour > 30) {
        letter = '?';
      }else if (colour > 28) {
        letter = '1';
      }else if (colour > 26) {
        letter = '|';
      }else if (colour > 24) {
        letter = 't';
      }else if (colour > 22) {
        letter = 'j';
      }else if (colour > 20) {
        letter = 'x';
      }else if (colour > 18) {
        letter = 'v';
      }else if (colour > 16) {
        letter = 'X';
      }else if (colour > 14) {
        letter = 'Y';
      }else if (colour > 12) {
        letter = 'Q';
      }else if (colour > 10) {
        letter = '0';
      }else if (colour > 9) {
        letter = 'm';
      }else if (colour > 8) {
        letter = 'w';
      }else if (colour > 7) {
        letter = 'b';
      }else if (colour > 6) {
        letter = '*';
      }else if (colour > 5) {
        letter = '#';
      }else if (colour > 4) {
        letter = 'W';
      }else if (colour > 3) {
        letter = '&';
      }else if (colour > 2) {
        letter = '%';
      }
      else {
        letter = '@';
      }

      fill(0);
      text(letter, x, y);
    }
  }
  video.updatePixels();
*/ 
    hs1.display();
}
