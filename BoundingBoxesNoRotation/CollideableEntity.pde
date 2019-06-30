
class CollideableEntity {
  protected ArrayList<BoundingBox> boxes = new ArrayList<BoundingBox>();
  protected BoundingBox surroundingBox; //stores image dimension properites
  protected PImage sprite;// = loadImage("noback.png"); // the image
  protected String name; //name
  protected String location;

  CollideableEntity() {
    //allows for class CEIO to modify contents
  }

  CollideableEntity(BoundingBox[] boundingboxes) {
    for (BoundingBox box : boundingboxes) {
      boxes.add(box);
    }
    UpdateSurroundingBox();
  }

  CollideableEntity(ArrayList<BoundingBox> boundingboxes) {
    for (BoundingBox box : boundingboxes) {
      boxes.add(box);
    }
    UpdateSurroundingBox();
  }

  private void SetSurroundBox(int x, int y, int wid, int hei) {
    surroundingBox = new BoundingBox(x, y, wid, hei);
  }

  //should not be used as this should stay the same (until resizing)
  private void UpdateSurroundingBox() {
    float minx = boxes.get(0).GetPos().x;
    float miny = boxes.get(0).GetPos().y;
    float maxx = boxes.get(0).GetPos().x;
    float maxy = boxes.get(0).GetPos().y;

    for (BoundingBox box : boxes) {
      PVector pos = box.GetPos();
      if (pos.x < minx) 
        minx = pos.x;
      if (pos.y < miny) 
        miny = pos.y; 
      PVector dim = box.GetWidHei();
      float right = pos.x + dim.x;
      if (right > maxx) {
        maxx = right;
      }
      float bottom = pos.y + dim.y;
      if (bottom > maxy) {
        maxy = bottom;
      }
    }
    surroundingBox = new BoundingBox(floor(minx), floor(miny), floor(maxx) - floor(minx), floor(maxy) - floor(miny));
  }

  public void addBox(BoundingBox box) {
    box.Confirm();
    boxes.add(box);
    UpdateSurroundingBox();
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
    fill(255,0,0);
    surroundingBox.Display();
    fill(0,0,255);
    for (BoundingBox box : boxes) {
      box.Display();
    }
    image(sprite, surroundingBox.rectangle.pos.x, surroundingBox.rectangle.pos.y);
  }

  public void RemoveAt(float x, float y) {
    for (BoundingBox box : boxes) {
      if ( box.Collide(x, y)) {
        boxes.remove(box);
        //UpdateSurroundingBox();
        break; // only remove one box at a time (search top down to remove top)
      }
    }
  }
  
  public void RemoveAt(BoundingBox remover) {
    remover.Confirm();
    for(int i = boxes.size() - 1; i >= 0; i--) {
      if (remover.Collide(boxes.get(i))) {
        boxes.remove(i);
      }
    }
  }

  public void translate(int x, int y) {
    for (BoundingBox box : boxes) {
      box.translate(x, y);
    }
    surroundingBox.translate(x, y);
  }
}
