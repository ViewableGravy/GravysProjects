
class CollideableEntity {
  ArrayList<BoundingBox> boxes = new ArrayList<BoundingBox>();
  BoundingBox surroundingBox;

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

  //Saves object to a file which can be loaded from.
  // output is a PrintWriter object that points to a textfile to write to
  // indent is the current indentation in the file, this is useful for proper formatting but is technically not needed
  // lastElement dictates if this is the lastElement in it's encapsulating datastructure.
  //     this should be true if it is the only one to save, otherwise determine if it is the last to be saved inside the Object
  public void Save(PrintWriter output, String indent, boolean lastElement) {
    output.println(indent + "Player: {");
    indent += "  ";
    output.println(indent + "boxes: [");
    indent += "  ";
    for (int j = 0; j < boxes.size(); j++) {
      output.println(indent + "box: {");
      boxes.get(j).Save(output, indent + "  ");
      if (j == boxes.size() - 1)
        output.println(indent + "}");
      else
        output.println(indent + "},");
    }
    indent = indent.substring(2);
    output.println(indent + "]");
    if (lastElement)
      output.println(indent.substring(2) + "}");
    else 
    output.println(indent.substring(2) + "},");
  }

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
    //surroundingBox.Display();
    for (BoundingBox box : boxes) {
      box.Display();
    }
  }

  public void RemoveAt(float x, float y) {
    for (BoundingBox box : boxes) {
      if ( box.Collide(x, y)) {
        boxes.remove(box);
        UpdateSurroundingBox();
        break; // only remove one box at a time (search top down to remove top)
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
