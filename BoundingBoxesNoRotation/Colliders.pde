public static class Colliders {
  public static boolean Collide(PVector point, Rectangle rectangle) {
    return point.x < rectangle.pos.x + rectangle.wid && 
           point.x > rectangle.pos.x && 
           point.y < rectangle.pos.y + rectangle.hei &&
           point.y > rectangle.pos.y;
  }
  
  public static boolean Collide(Rectangle rectangleA, Rectangle rectangleB) {
    return  rectangleA.pos.x < rectangleB.pos.x + rectangleB.wid && 
           rectangleA.pos.x + rectangleA.wid > rectangleB.pos.x && 
           rectangleA.pos.y < rectangleB.pos.y + rectangleB.hei &&
           rectangleA.pos.y + rectangleA.hei > rectangleB.pos.y;
  }
  
}
