
public class Rotation
{
  
  Rotation()
  {
    
  }
  
  public void RotateForward() 
  {
    translate(0,0,0);
    rotateX(PI/3);
    translate(-width * 1.5,-width*7,-2000);
  }
  
}
