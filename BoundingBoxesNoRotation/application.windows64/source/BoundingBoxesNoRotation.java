import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class BoundingBoxesNoRotation extends PApplet {



//CollideableEntity[] players;
ArrayList<CollideableEntity> players = new ArrayList<CollideableEntity>();
ArrayList<Character> keys = new ArrayList<Character>();
boolean ctrl = false;
int CurrentEntity = 1;
State currentMode = State.gameMode;

public void setup() {
  strokeWeight(2);
  stroke(255);
  frameRate(60);
  
  //LoadMk2("PlayerData.txt");
  LoadMk2("TestingFile.txt");
  //LoadPlayer("TestingFile.txt","view");
  //LoadPlayer("TestingFile.txt","ViewableGravy");
}

public void draw() {
  background(0);

  //display
  for (CollideableEntity player : players) {
    player.Display();
  }

  switch(currentMode) {
  case insertMode:
    //Add hitbox
    CollideableEntity current = players.get(CurrentEntity-1);
    if (!current.newHitboxNull()) {
      current.AddHitbox(true, mouseX, mouseY);
      try {
        current.DisplayAddingHitbox();
      } 
      catch (Exception e) {
        println("hitbox does not exist yet");
      }
    }
    break;
  case deleteMode:
    if (remover != null) {
      remover.UpdateParameters(mouseX, mouseY); 
      remover.Display();
    }
    break;
  case gameMode: 
    //movement
    Move();
    break;
  }



  textSize(20);
  stroke(0, 255, 0);
  text(CurrentEntity, 10, 30);
  text(currentMode.toString(), 10, 60);
}

BoundingBox remover = null;
public void mouseClicked() {
  //if insert mode, deal with hitbox creation
  if (currentMode == State.insertMode) {
    players.get(CurrentEntity-1).AddHitbox(false, mouseX, mouseY);
  } else if (currentMode == State.deleteMode) {
    if (remover == null) {
      remover = new BoundingBox(mouseX, mouseY);
    } else {
      players.get(CurrentEntity-1).RemoveAt(remover);
      remover = null;
    }
  }
}

public void keyReleased() {
  println(key);
  keys.remove((Character)key);

  if (keyCode == CONTROL) {
    ctrl = false;
  }
}


public void keyPressed() {
  if (keyCode == CONTROL) {
    ctrl = true;
  }

  if (key == 'r') {
    currentMode = State.deleteMode;
  }

  if (key == 'e') {
    currentMode = State.insertMode;
  }

  if (key == 'g') {
    currentMode = State.gameMode;
  }

  if (!keys.contains((Character)key)) {
    keys.add((Character)key);
  }

  if (keys.contains('u')) {
    if (CurrentEntity != players.size()) {
      CurrentEntity++;
    }
  } else if (keys.contains('i')) {
    if (CurrentEntity != 1) {
      CurrentEntity--;
    }
  }
}

public void Move() {

  //guarantee key's reset
  if (!keyPressed) {
    keys = new ArrayList<Character>();
  }
  if (keys.contains('s') && ctrl) {
    println("temp");
    Save();
  }

  if (keys.contains('w')) {
    players.get(CurrentEntity - 1).translate(0, -1); 
    for (int i = 0; i < players.size(); i++) {
      if (i != CurrentEntity - 1) {
        if (players.get(CurrentEntity - 1).Collide(players.get(i))) {
          players.get(CurrentEntity - 1).translate(0, 1);
          println(frameRate);
          stroke(100, 0, 0);
        } else {
          stroke(255);
        }
      }
    }
  }
  if (keys.contains('s')) {
    players.get(CurrentEntity - 1).translate(0, 1); 
    for (int i = 0; i < players.size(); i++) {
      if (i != CurrentEntity - 1) {
        if (players.get(CurrentEntity - 1).Collide(players.get(i))) {
          players.get(CurrentEntity - 1).translate(0, -1);
          stroke(100, 0, 0);
        } else {
          stroke(255);
        }
      }
    }
  }
  if (keys.contains('d')) {
    players.get(CurrentEntity - 1).translate(1, 0); 
    for (int i = 0; i < players.size(); i++) {
      if (i != CurrentEntity - 1) {
        if (players.get(CurrentEntity - 1).Collide(players.get(i))) {
          players.get(CurrentEntity - 1).translate(-1, 0);
          stroke(100, 0, 0);
        } else {
          stroke(255);
        }
      }
    }
  } 
  if (keys.contains('a')) {
    players.get(CurrentEntity - 1).translate(-1, 0); 
    for (int i = 0; i < players.size(); i++) {
      if (i != CurrentEntity - 1) {
        if (players.get(CurrentEntity - 1).Collide(players.get(i))) {
          players.get(CurrentEntity - 1).translate(1, 0);
          stroke(100, 0, 0);
        } else {
          stroke(255);
        }
      }
    }
  }
}

public void LoadPlayer(String filename, String name) {
  BufferedReader reader = createReader(filename);
  try {
    players.add(CEIO.LoadMk3(reader, name, this) );
    reader.close();
  } 
  catch (Exception e) {
    println("Entity with name \"" + name + "\" Was not found");
  }
}

public void LoadMk2(String filename) {
  BufferedReader reader = createReader(filename);
  while (true) {
    try {
      players.add(CEIO.LoadMk3(reader, this));
    } 
    catch (IOException e) { 
      break;
    }
  }
  try { 
    reader.close();
  } 
  catch (IOException e) {
    e.printStackTrace();
  };
}

public void Save() {
  //PrintWriter output = createWriter("PlayerData.txt");
  PrintWriter output = createWriter("TestingFile.txt");
  for (int j = 0; j < players.size(); j++) {
    CEIO.SaveMk3(output, "", j == players.size() - 1, players.get(j));
  }
  output.close(); // Finishes the file
}

enum State {
  deleteMode, 
    insertMode, 
    gameMode
}

public class BoundingBox {
  //PVector pos;
  //float wid,hei;
  
  Rectangle rectangle;
  boolean processing = false;
  
  public PVector GetPos() {
   return rectangle.pos; 
  }
  
  public PVector GetWidHei() {
   return new PVector(rectangle.wid,rectangle.hei); 
  }
  
  BoundingBox(int x, int y, int wid, int hei) {
    rectangle = new Rectangle(new PVector(x,y),wid,hei);
  }
  
  BoundingBox(int x, int y) {
    processing = true;
    this.rectangle = new Rectangle(new PVector(x,y),0,0);
  }
  
  public void UpdateParameters(int x, int y) {
    if (processing) {
      this.rectangle.wid = x - this.rectangle.pos.x;
      this.rectangle.hei = y - this.rectangle.pos.y;
    }
  }
  
  public void Confirm() {
    
    if (rectangle.wid < 0) {
     rectangle.pos.x += rectangle.wid;
     rectangle.wid = abs(rectangle.wid);
    }
    
    if (rectangle.hei < 0) {
     rectangle.pos.y += rectangle.hei;
     rectangle.hei = abs(rectangle.hei);
    }
    
    processing = false;
  }
  
  public boolean Collide(BoundingBox other) {
    return Colliders.Collide(other.rectangle, this.rectangle);
  }
  
  public boolean Collide(float x, float y) {
    return Colliders.Collide(new PVector(x,y), this.rectangle);
  }
  
  public void Display() {
   rect(rectangle.pos.x,rectangle.pos.y,rectangle.wid,rectangle.hei); 
  }
  
  public void translate(int x, int y) {
    this.rectangle.pos.x += x;
    this.rectangle.pos.y += y;
  }
  
  //pass in the current indentation, rather than the desired indentationn
  public void Save(PrintWriter output, String indentation, boolean lastElement) {
    output.println(indentation + "box: {");
    indentation += "  ";
    output.println(indentation + "Position {");
    output.println(indentation + "  x: " + rectangle.pos.x);
    output.println(indentation + "  y: " + rectangle.pos.y);
    output.println(indentation + "},");
    output.println(indentation +"Width: " + rectangle.wid);
    output.println(indentation +"Height: " + rectangle.hei);
    if (lastElement)
        output.println(indentation.substring(2) + "}");
      else
        output.println(indentation.substring(2) + "},");
  }
}

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
    //fill(255, 0, 0);
    noFill();
    strokeWeight(0.2f);
    stroke(255);
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
//this is a button for creating an Entity. The constructor creates a rectangle and collide will take the mouse position
// to determine if it is being clicked.
public class EntityCreator {
  Rectangle rectangle;
 
 public EntityCreator(int x, int y, int w, int h) {
    rectangle = new Rectangle(new PVector(x,y),w,h);
 }
 
 private boolean Collide(PVector point) {
   return Colliders.Collide(point,rectangle);
 }
  
}
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

  ///should be run when reader is one line before position
  // name: myName <-- reader
  // Position {
  //   x: ...
  private static void SetSurroundingBox(BufferedReader reader, CollideableEntity temp) throws IOException {
    String currentLine;
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
    println(temp.surroundingBox.GetPos());
  }

  //
  private static void ReadBox(BufferedReader reader, CollideableEntity temp, BoundingBoxesNoRotation sketch) throws IOException {

    String currentLine = reader.readLine();//box[]
    if (currentLine.contains("null")) {
      return;
    }
    reader.readLine();//position
    currentLine = reader.readLine(); //x
    int x = parseInt(currentLine.substring(currentLine.lastIndexOf(":") + 1).replaceAll("\\s+", "")); //x
    currentLine = reader.readLine(); //y
    int y = parseInt(currentLine.substring(currentLine.lastIndexOf(":") + 1).replaceAll("\\s+", "")); //y
    reader.readLine(); //}position
    currentLine = reader.readLine(); //w
    int wid = parseInt(currentLine.substring(currentLine.lastIndexOf(":") + 1).replaceAll("\\s+", "")); //wid
    currentLine = reader.readLine(); //h
    int hei = parseInt(currentLine.substring(currentLine.lastIndexOf(":") + 1).replaceAll("\\s+", "")); //hei
    temp.boxes.add(sketch.new BoundingBox(x, y, wid, hei));
  }

  public static CollideableEntity LoadMk3(BufferedReader reader, String name, BoundingBoxesNoRotation sketch) throws IOException {
    CollideableEntity temp = null;
    String currentLine = null;
    try {
      String check = null;
      do {
        check = reader.readLine();
        if (check == null) throw new IOException();
      } while (!check.contains("Player: {"));
      do {
        if (reader.readLine().contains("3")) { //version {
          currentLine = reader.readLine();
          currentLine = trim(currentLine.substring(currentLine.lastIndexOf(":") + 1));
          if (currentLine.equalsIgnoreCase(name)) { //name
            temp = sketch.new CollideableEntity();
            temp.name = name;

            SetSurroundingBox(reader, temp);

            currentLine = reader.readLine(); //loc
            temp.location = currentLine.substring(currentLine.lastIndexOf(":") + 1).replaceAll("\\s+", "");
            temp.sprite = sketch.loadImage(temp.location);

            reader.readLine(); //boxes[]
            do {
              ReadBox(reader, temp, sketch);
            } while (reader.readLine().contains(","));
            currentLine = reader.readLine(); //]
          }
        } else {
          println("Invalid version number");
        }

        do
          currentLine = reader.readLine();
        while (!currentLine.contains("} Player"));
        
        if (!currentLine.contains(","))
          break;
          
        reader.readLine();
      } while (true);
    } 
    catch (IOException e) {
      throw e;
    }
    if (temp == null)
      throw new IOException();
    return temp;
  }
}
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
public class Rectangle {
 public PVector pos;
 public float wid, hei;
 
 Rectangle(PVector pos, float wid, float hei) {
   this.pos = pos;
   this.wid = wid;
   this.hei = hei;
 }
 
 public void Display() {
  rect(pos.x,pos.y,wid,hei); 
 }
}
  public void settings() {  size(800, 800); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "--present", "--window-color=#666666", "--stop-color=#cccccc", "BoundingBoxesNoRotation" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
