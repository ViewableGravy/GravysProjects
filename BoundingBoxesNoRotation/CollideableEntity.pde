
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

  public Boolean newHitboxNull() {
    return newHitbox == null;
  }

  public void DisplayAddingHitbox() throws Exception {
    newHitbox.Display();
  }

  private BoundingBox newHitbox = null;
  public void AddHitbox(boolean continueUpdating, float mousex, float mousey) {
    if (newHitbox == null) {
      if (Colliders.Collide(new PVector(mousex, mousey), surroundingBox.rectangle)) {
        newHitbox = new BoundingBox((int)mousex, (int)mousey);
      } else {
        //do nothing since you cannot create a hitbox at the current location
      }
    } else {
      if (continueUpdating) {
        if (Colliders.Collide(new PVector(mousex, mousey), surroundingBox.rectangle)) {
          newHitbox.UpdateParameters((int)mousex, (int)mousey);
        } else {
          int left = (int)surroundingBox.rectangle.pos.x;
          int right = (int)(surroundingBox.rectangle.pos.x + surroundingBox.rectangle.wid);
          int up = (int)surroundingBox.rectangle.pos.y;
          int down = (int)(surroundingBox.rectangle.pos.y + surroundingBox.rectangle.hei);

          if (mousex > right) {
            if (mousey > down) {
              newHitbox.UpdateParameters(right, down);
            } else if (mousey < up) {
              newHitbox.UpdateParameters(right, up) ;
            } else {
              newHitbox.UpdateParameters(right, (int)mousey);
            }
          } else if (mousex < left) {
            if (mousey > down) {
              newHitbox.UpdateParameters(left, down);
            } else if (mousey < up) {
              newHitbox.UpdateParameters(left, up) ;
            } else {
              newHitbox.UpdateParameters(left, (int)mousey) ;
            }
          } 
          if (mousey > down) {
            if (mousex > right) {
              newHitbox.UpdateParameters(right, down);
            } else if (mousex < left) {
              newHitbox.UpdateParameters(left, down) ;
            } else {
              newHitbox.UpdateParameters((int)mousex, down);
            }
          } else if (mousey < up) {
            if (mousex > right) {
              newHitbox.UpdateParameters(right, up);
            } else if (mousex < left) {
              newHitbox.UpdateParameters(left, up) ;
            } else {
              newHitbox.UpdateParameters((int)mousex, up) ;
            }
          }
        }
      } else {
        boxes.add(newHitbox);
        newHitbox = null;
      }
    }
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
    fill(255, 0, 0);
    surroundingBox.Display();
    fill(0, 0, 255);
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
    for (int i = boxes.size() - 1; i >= 0; i--) {
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
