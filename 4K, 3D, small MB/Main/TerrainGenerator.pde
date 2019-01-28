 //<>//
public class TerrainGenerator
{
  private int scl = 20;
  private int w = width * 8;
  private int h = height * 6;
  private int rows = w / scl;
  private int columns = h / scl; 

  public TerrainGenerator()
  {
  }

  public PShape[] Generate2DTriangleStrip() 
  {
    float[][] terrain = new float[columns][rows];
    float yoff = 0;
    for (int y = 0; y < rows; y++)
    {
      float xoff = 0;
      for (int x = 0; x < columns; x++)
      {
        terrain[x][y] = map(noise(xoff,yoff),0,1,-500,1000);
        xoff+=0.01;
      }
      yoff+= 0.01;
    }
    
    PShape[] _shape = new PShape[columns];
    for (int i = 0; i < columns - 1; i++) 
    {
      _shape[i] = createShape();
      _shape[i].beginShape(TRIANGLE_STRIP);
      for (int j = 0; j < rows; j++) 
      {
        _shape[i].vertex(i * scl,j * scl, terrain[i][j]);
        _shape[i].vertex((i + 1) * scl, j * scl, terrain[i+1][j]);
      }
      _shape[i].endShape(CLOSE);
    }
    return _shape; //not done
  }
}
