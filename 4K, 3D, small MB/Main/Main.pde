TerrainRenderer terRend;
Rotation rotate;

void setup() 
{
  size(1200,900,P3D);
  frameRate(60);
  stroke(0,50);
  rotate = new Rotation();
  terRend = new TerrainRenderer();
  terRend.StoreTerrainPShape(); 
}


void draw() {
  rotate.RotateForward();
  terRend.RenderTerrainPShape(); 
}
