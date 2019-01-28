
public class TerrainRenderer 
{ 
  private PShape _shapeTerrain;
  private TerrainGenerator terGen;
  
  public TerrainRenderer() 
  {
    terGen = new TerrainGenerator();
  }
  
  public void StoreTerrainPShape() 
  {
    PShape[] temp = terGen.Generate2DTriangleStrip();
    _shapeTerrain = createShape(GROUP);
    
    for (int i = 0; i < temp.length; i++) 
    {
      _shapeTerrain.addChild(temp[i]);
    }
  }
  
  public void RenderTerrainPShape() 
  {
    shape(_shapeTerrain);
  }
}
