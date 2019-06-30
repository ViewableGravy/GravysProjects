
class CollideableEntity {
  ArrayList<BoundingBox> boxes = new ArrayList<BoundingBox>();
  BoundingBox surroundingBox; //stores image dimension properites
  PImage sprite = loadImage("noback.png"); // the image
  String name; //name
  String location;

  CollideableEntity(BufferedReader reader) throws IOException {
    String currentLine = null;
    try {
      String check = null;
      do {
        check = reader.readLine();
        if (check == null) throw new IOException();
      } while (!check.contains("Player: {"));
      currentLine = reader.readLine(); //name
      name = trim(currentLine.substring(currentLine.lastIndexOf(":") + 1));
      reader.readLine(); //position
      currentLine = reader.readLine(); //x
      int x = parseInt(currentLine.substring(currentLine.lastIndexOf(":") + 1).replaceAll("\\s+", "")); //x
      currentLine = reader.readLine();//y
      int y = parseInt(currentLine.substring(currentLine.lastIndexOf(":") + 1).replaceAll("\\s+", "")); //y
      reader.readLine(); //end pos
      currentLine = reader.readLine(); //h
      int wid = parseInt(currentLine.substring(currentLine.lastIndexOf(":") + 1).replaceAll("\\s+", "")); //wid
      currentLine = reader.readLine();//wid
      int hei = parseInt(currentLine.substring(currentLine.lastIndexOf(":") + 1).replaceAll("\\s+", "")); //hei
      SetSurroundBox(x, y, wid, hei);//hei

      currentLine = reader.readLine(); //loc
      location = currentLine.substring(currentLine.lastIndexOf(":") + 1).replaceAll("\\s+", "");
      sprite = loadImage(location); //loc

      reader.readLine(); //boxes[]
      do {
        currentLine = reader.readLine();//box[]
        if (currentLine.contains("null")) {
         break; 
        }
        reader.readLine();//position
        currentLine = reader.readLine(); //x
        x = parseInt(currentLine.substring(currentLine.lastIndexOf(":") + 1).replaceAll("\\s+", "")); //x
        currentLine = reader.readLine(); //y
        y = parseInt(currentLine.substring(currentLine.lastIndexOf(":") + 1).replaceAll("\\s+", "")); //y
        reader.readLine(); //}position
        currentLine = reader.readLine(); //w
        wid = parseInt(currentLine.substring(currentLine.lastIndexOf(":") + 1).replaceAll("\\s+", "")); //wid
        currentLine = reader.readLine(); //h
        hei = parseInt(currentLine.substring(currentLine.lastIndexOf(":") + 1).replaceAll("\\s+", "")); //hei
        currentLine = reader.readLine();
        boxes.add(new BoundingBox(x, y, wid, hei));
      } while (currentLine.contains(","));
      reader.readLine(); //]
    } 
    catch (IOException e) {
      throw e;
    }
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

  void LoadSprite(String file) {
    sprite = loadImage(file);
  }

  public void SaveMk2(PrintWriter output, String indent, boolean lastElement) {
    output.println(indent + "Player: {");
    indent += "  ";
    output.println(indent + "Name: " + name);
    output.println(indent + "Position {");
    output.println(indent + "  " + "x: " + surroundingBox.rectangle.pos.x);
    output.println(indent + "  " + "y: " + surroundingBox.rectangle.pos.y);
    output.println(indent + "}");
    output.println(indent + "Width: " + surroundingBox.rectangle.wid);
    output.println(indent + "Height: " + surroundingBox.rectangle.hei);
    output.println(indent + "Location: " + location);
    output.println(indent + "boxes: ["); //this is an array of boxes

    if (boxes.size() <= 0)
      output.println(indent + "  null");
    else {
      for (int j = 0; j < boxes.size(); j++) {
        boxes.get(j).Save(output, indent + "  ", j == boxes.size() - 1);
      }
    }

    output.println(indent + "]");
    if (lastElement)
      output.println(indent.substring(2) + "}");
    else 
    output.println(indent.substring(2) + "},");
  }

  private void SetSurroundBox(int x, int y, int wid, int hei) {
    surroundingBox = new BoundingBox(x, y, wid, hei);
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
