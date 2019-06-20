class CollideableEntity {
  ArrayList<BoundingBox> boxes = new ArrayList<BoundingBox>();
  
  CollideableEntity(BoundingBox[] boundingboxes) {
    for (BoundingBox box : boundingboxes) {
      boxes.add(box);
    }
  }
  
  public void addBox(BoundingBox box) {
    box.Confirm();
    boxes.add(box);
  }

  public boolean Collide(CollideableEntity other) {
    for (BoundingBox box : boxes) {
      for (BoundingBox otherbox : other.boxes) {
        if (box.Collide(otherbox)) {
          return true;
        }
      }
    }
    return false;
  }
  
  public void Display() {
   for (BoundingBox box : boxes) {
    box.Display(); 
   }
  }
  
  public void translate(int x, int y) {
    for (BoundingBox box : boxes) {
     box.translate(x,y); 
    }
  }
}
