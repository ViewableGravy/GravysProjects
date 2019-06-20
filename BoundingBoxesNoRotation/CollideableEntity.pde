class CollideableEntity {
  BoundingBox[] boundingboxes;
  CollideableEntity(BoundingBox[] boundingboxes) {
    this.boundingboxes = boundingboxes;
  }

  public boolean Collide(CollideableEntity other) {
    for (BoundingBox box : boundingboxes) {
      for (BoundingBox otherbox : other.boundingboxes) {
        if (box.Collide(otherbox)) {
          return true;
        }
      }
    }
    return false;
  }
  
  public void Display() {
   for (BoundingBox box : boundingboxes) {
    box.Display(); 
   }
  }
  
  public void translate(int x, int y) {
    for (BoundingBox box : boundingboxes) {
     box.translate(x,y); 
    }
  }
}
