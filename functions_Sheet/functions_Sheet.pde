float rotate = 0;
void setup() {
  size(500,500);
}

void draw() {
  rotate+= 0.1;
  PVector time = RotateZ_Calculations(100,100,rotate);
  println(time);
  ellipse(200 + time.x,200 + time.y,20,20);
}

//input all translations and an angle in the current angleMode
//returns a PVector with x/y position of the rotation
// note: only works on RotateZ.
//e.g. RotateZ_Calculations(1,0,PI/2) returns [ -1, 0, 0]
// note: the modelX and modelY functions also work perfectly for this situation
PVector RotateZ_Calculations(float x_translation,float y_translation,float rotation_Angle) {
  float rotationA = rotation_Angle;
  float adj = x_translation;
  float opp = y_translation;
  float hyp = sqrt(sq(adj) + sq(opp));
  float x = acos(adj/hyp);
  float y = asin(opp/hyp);
  float rotx = (cos(rotationA + x)*hyp);
  float roty = (sin(rotationA + y)*hyp);
  PVector P = new PVector(rotx,roty);
  if (P.x < 0.001 && P.x > -0.001) {
    P.x = round(P.x);
  }
  if (P.y < 0.001 && P.y > -0.001) {
    P.y = round(P.y);
  }
  return P;
}
