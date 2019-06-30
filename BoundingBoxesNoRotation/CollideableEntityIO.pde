static class CEIO {
  public static void SaveMk3(PrintWriter output, String indent, boolean lastElement, CollideableEntity entity) {
    output.println(indent + "Player: {");
    indent += "  ";
    output.println(indent + "Version: 3");
    output.println(indent + "Name: " + entity.name);
    output.println(indent + "Position {");
    output.println(indent + "  " + "x: " + entity.surroundingBox.rectangle.pos.x);
    output.println(indent + "  " + "y: " + entity.surroundingBox.rectangle.pos.y);
    output.println(indent + "}");
    output.println(indent + "Width: " + entity.surroundingBox.rectangle.wid);
    output.println(indent + "Height: " + entity.surroundingBox.rectangle.hei);
    output.println(indent + "Location: " + entity.location);
    output.println(indent + "boxes: ["); //this is an array of boxes

    if (entity.boxes.size() <= 0)
      output.println(indent + "  null");
    else {
      for (int j = 0; j < entity.boxes.size(); j++) {
        entity.boxes.get(j).Save(output, indent + "  ", j == entity.boxes.size() - 1);
      }
    }

    output.println(indent + "]");
    if (lastElement)
      output.println(indent.substring(2) + "} Player");
    else 
      output.println(indent.substring(2) + "} Player,");
  }
  
  public static CollideableEntity LoadMk3(BufferedReader reader, BoundingBoxesNoRotation sketch) throws IOException {
    CollideableEntity temp = sketch.new CollideableEntity();
    String currentLine = null;
    try {
      String check = null;
      do {
        check = reader.readLine();
        if (check == null) throw new IOException();
      } while (!check.contains("Player: {"));
      reader.readLine(); //version
      currentLine = reader.readLine(); //name
      temp.name = trim(currentLine.substring(currentLine.lastIndexOf(":") + 1));
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
      temp.SetSurroundBox(x, y, wid, hei);//hei

      currentLine = reader.readLine(); //loc
      temp.location = currentLine.substring(currentLine.lastIndexOf(":") + 1).replaceAll("\\s+", "");
      temp.sprite = sketch.loadImage(temp.location);

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
        temp.boxes.add(sketch.new BoundingBox(x, y, wid, hei));
      } while (currentLine.contains(","));
      reader.readLine(); //]
    } 
    catch (IOException e) {
      throw e;
    }
    return temp;
  }
}
