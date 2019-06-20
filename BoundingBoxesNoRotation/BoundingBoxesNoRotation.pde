//CollideableEntity[] players;
ArrayList<CollideableEntity> players = new ArrayList<CollideableEntity>();
int CurrentEntity = 1;
ArrayList<Character> keys = new ArrayList<Character>();
boolean ctrl = false;

void setup() {
  fill(255);
  strokeWeight(2);
  stroke(255);
  frameRate(60);
  size(500, 500);
  Load("PlayerData.txt");
  /*
    players = new CollideableEntity[2];
   players[0] =  new CollideableEntity(new BoundingBox[]{new BoundingBox(100, 100, 100, 100)});
   players[1] = new CollideableEntity(new BoundingBox[]{new BoundingBox(350, 350, 100, 100)});
   */
}

void draw() {
  background(0);

  //display
  for (CollideableEntity player : players) {
    player.Display();
  }

  //Add hitbox
  if (temp != null) {
    temp.UpdateParameters(mouseX, mouseY); 
    temp.Display();
  }

  //movement
  Move();

  textSize(20);
  stroke(0, 255, 0);
  text(CurrentEntity, 10, 30);
}

BoundingBox temp = null;
void mouseClicked() {
  if (temp == null) {
    temp = new BoundingBox(mouseX, mouseY);
  } else {
    players.get(CurrentEntity-1).addBox(temp);
    temp = null;
  }
}

void keyReleased() {
  println(key);
  keys.remove((Character)key);

  if (keyCode == CONTROL) {
    ctrl = false;
  }
}


void keyPressed() {
  if (keyCode == CONTROL) {
    ctrl = true;
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

void Move() {

  //guarantee key's reset
  if (!keyPressed) {
    keys = new ArrayList<Character>();
  }
  if (keys.contains('s') && ctrl) {
    println("temp");
    Save();
  }

  if (keys.contains('w')) {
    players.get(0).translate(0, -1); 
    if (players.get(0).Collide(players.get(1))) {
      players.get(0).translate(0, 1);
      println(frameRate);
      stroke(100, 0, 0);
    } else {
      stroke(255);
    }
  } 
  if (keys.contains('s')) {
    players.get(0).translate(0, 1); 
    if (players.get(0).Collide(players.get(1))) {
      players.get(0).translate(0, -1);
      println(frameRate);
      stroke(100, 0, 0);
    } else {
      stroke(255);
    }
  }
  if (keys.contains('d')) {
    players.get(0).translate(1, 0); 
    if (players.get(0).Collide(players.get(1))) {
      players.get(0).translate(-1, 0);
      println(frameRate);
      stroke(100, 0, 0);
    } else {
      stroke(255);
    }
  } 
  if (keys.contains('a')) {
    players.get(0).translate(-1, 0); 
    if (players.get(0).Collide(players.get(1))) {
      players.get(0).translate(1, 0);
      println(frameRate);
      stroke(100, 0, 0);
    } else {
      stroke(255);
    }
  }
}

boolean GRAVYEndArray(String line) {
  return (line.contains("]") & !line.contains(","));
}

//Given that this has literally no error handling and doesn't apply for any object other than this, It still works
void Load(String filename) {
  ArrayList<CollideableEntity> tempArray = new ArrayList<CollideableEntity>();
  BufferedReader reader = createReader(filename);
  String line = null;
  try {
    do {
      ArrayList<BoundingBox> tempBoxes = new ArrayList<BoundingBox>(); 
      line = reader.readLine(); //Player: {
      line = reader.readLine(); //boxes: [
      while (!GRAVYEndArray(line)) {
        int x,y;
        int hei, wid;
        line = reader.readLine(); //box: {
        line = reader.readLine(); //Position {
        line = reader.readLine(); //x:
        x = (int)parseFloat(line.substring(line.lastIndexOf(":") + 1)); //error if NaN
        line = reader.readLine(); //y:
        y = (int)parseFloat(line.substring(line.lastIndexOf(":") + 1)); //error if NaN
        line = reader.readLine(); // },
        line = reader.readLine(); //Width:
        wid = (int)parseFloat(line.substring(line.lastIndexOf(":") + 1));
        line = reader.readLine(); //Height
        hei = (int)parseFloat(line.substring(line.lastIndexOf(":") + 1));
        tempBoxes.add(new BoundingBox(x, y, wid, hei));
        //println(x + "," + y + "," + hei + "," + wid);
        line = reader.readLine(); // },
        if (!line.contains("},")) break;
      }
      line = reader.readLine(); // "]"
      tempArray.add(new CollideableEntity(tempBoxes));
      line = reader.readLine();
    } while (!(line.contains("}") & !line.contains(",")));
    reader.close();
    players = tempArray;
  } 
  catch (IOException e) {
    e.printStackTrace();
  }
}

void Save() {
  PrintWriter output = createWriter("PlayerData.txt");
  int i = 1;

  for (int j = 0; j < players.size(); j++) {
    output.println("Player: {");
    String indent = "  ";
    players.get(j).Save(output, indent);
    if (j == players.size() - 1) {
      output.println("}");
    } else {
      output.println("},");
    }
  }
  output.flush(); // Writes the remaining data to the file
  output.close(); // Finishes the file
}
