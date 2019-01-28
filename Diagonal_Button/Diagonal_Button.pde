Shapes[] shapes;


void setup() {
  size(500, 500);
  // define the length of the shapes array
  shapes = new Shapes[1];
  // create a new Shape at an index in shapes (this would be a for loop for each index of array
  shapes[0] = new Shapes();

  //manipulate shapes from here
  shapes[0].createQuadrilateral(100, 100, 200, 200, 300, 100, 200, 0);
  //shapes[0].createQuadrilateral(100, 100, 100, 200, 300, 200, 300, 100);
}

void draw() {
  background(100);
  shapes[0].displayQuadrilateral();
  shapes[0].buttonQuadrilateral();
}

class Shapes {
  PShape s;
  int number = 0;
  PVector position[] = new PVector[4];
  PVector arrayX[] = new PVector[4];
  PVector arrayY[] = new PVector[4];
  Coordinate[] coordinates;

  Shapes() {
    for (int i = 0; i < 4; i++) {
      arrayX[i] = new PVector();
      arrayY[i] = new PVector();
      position[i] = new PVector();
    }
  }

  void createQuadrilateral(int x1_, int y1_, int x2_, int y2_, int x3_, int y3_, int x4_, int y4_) {
    // this procedure assumes that x1 is the furthest left point and the points go counter clockwise
    coordinates = new Coordinate[4];
    position[0].x = x1_;
    position[0].y = y1_;
    position[1].x = x2_;
    position[1].y = y2_;
    position[2].x = x3_;
    position[2].y = y3_;
    position[3].x = x4_;
    position[3].y = y4_;

    for (int i = 0; i < 4; i++) {
      coordinates[i] = new Coordinate(position[i], i + 1);
    }

    //arrayX[0].x = x1_; 
    //arrayX[0].y = 1;
    //arrayX[1].x = x2_; 
    //arrayX[1].y = 2;
    //arrayX[2].x = x3_; 
    //arrayX[2].y = 3;
    //arrayX[3].x = x4_; 
    //arrayX[3].y = 4;

    //arrayY[0].x = y1_; 
    //arrayY[0].y = 1;
    //arrayY[1].x = y2_; 
    //arrayY[1].y = 2;
    //arrayY[2].x = y3_; 
    //arrayY[2].y = 3;
    //arrayY[3].x = y4_; 
    //arrayY[3].y = 4;

    Coordinate temp;
    for (int i = 0; i < arrayX.length - 1; i++) {
      if (coordinates[i + 1].point.x < coordinates[i].point.x) {
        temp = coordinates[i + 1];
        coordinates[i + 1] = coordinates[i];
        coordinates[i] = temp;
      }
    }

    println(coordinates[0].point.x, coordinates[1].point.x, coordinates[2].point.x, coordinates[3].point.x);
    println(coordinates[0].value, coordinates[1].value, coordinates[2].value, coordinates[3].value);

    s = createShape();
    s.beginShape();
    for (int i = 0; i < coordinates.length; i++) {
      if ( coordinates[i].value == 1) {
        for (int j = 0; j < coordinates.length; j++) {
          if (coordinates[j].value == 2 ) {
            for (int z = 0; z < coordinates.length; z++) {
              if (coordinates[z].value == 3) {
                for (int k = 0; k < coordinates.length; k++) {
                  if (coordinates[k].value == 4 ) {
                    s.vertex(coordinates[i].point.x, coordinates[i].point.y);
                    s.vertex(coordinates[j].point.x, coordinates[j].point.y);
                    s.vertex(coordinates[z].point.x, coordinates[z].point.y);
                    s.vertex(coordinates[k].point.x, coordinates[k].point.y);
                  }
                }
              }
            }
          }
        }
      }
    }
    s.endShape(CLOSE);
  }

  void buttonQuadrilateral() {
    //maths for the quadrilateral detection
    //if (((mouseX > minX && mouseX < largestX) && (mouseY > minX && mouseY < largestY)) && mousePressed) {
    //  println(largestX,largestY,minX,minY);
    //}
    float mDown, mUp;
    mUp = 0;
    mDown = 0;

    if (mouseX > coordinates[0].point.x && mouseX < coordinates[1].point.x) {
      for (int i = 0; i < coordinates.length; i++) {
        if ( coordinates[i].value == coordinates[0].value + 1 ) {
          mDown = (coordinates[0].point.y - coordinates[i].point.y) / (coordinates[i].point.x - coordinates[0].point.x);
          //println(mDown);
        }
        if (coordinates[0].value - 1 == 0) {
          if (coordinates[i].value == 4) {
            // calc m2
            mUp = (coordinates[0].point.y - coordinates[i].point.y) / (coordinates[i].point.x - coordinates[0].point.x);
            //println(mUp);
          }
        }
      }
      if (mouseY > -mUp * (mouseX - coordinates[0].point.x) + coordinates[0].point.y) {
        if ( mouseY < -mDown * (mouseX - coordinates[0].point.x) + coordinates[0].point.y) {
          println("fag", number);
          number++;
        }
      }
    }

    // ------------------------- //
    //       second half         //
    // ------------------------- //
  }
  //println(frameRate);
  //
  // if mouseY > mouseX * m2/m2 (depending which on is positive) && mouseY < mouseX * m1
  //

  //float mDown(int minX, coordinate IndexMin, int maxX, coordinate IndexMax, coordinate maxX2) {
  //  if (IndexMin
  //}


  void displayQuadrilateral() {
    shape(s, 0, 0);
  }
}

class Coordinate {
  PVector point = new PVector();
  int value;

  Coordinate(PVector inputP, int inputI) {
    point = inputP;
    value = inputI;
  }
}
