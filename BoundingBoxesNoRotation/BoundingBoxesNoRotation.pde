

//CollideableEntity[] players;
ArrayList<CollideableEntity> players = new ArrayList<CollideableEntity>();
ArrayList<Character> keys = new ArrayList<Character>();
boolean ctrl = false;
int CurrentEntity = 1;
State currentMode = State.gameMode;

void setup() {
  strokeWeight(2);
  stroke(255);
  frameRate(60);
  size(500, 500);
  LoadMk2("PlayerData.txt");
  //LoadMk2("TestingFile.txt");
}

void draw() {
  background(0);

  //display
  for (CollideableEntity player : players) {
    player.Display();
  }

  switch(currentMode) {
  case insertMode:
    //Add hitbox
    if (temp != null) {
      temp.UpdateParameters(mouseX, mouseY); 
      temp.Display();
    }
    break;
  case deleteMode:
    break;
  case gameMode: 
    break;
  }

  //movement
  Move();

  textSize(20);
  stroke(0, 255, 0);
  text(CurrentEntity, 10, 30);
  text(currentMode.toString(), 10, 60);
}

BoundingBox temp = null;
void mouseClicked() {
  //if insert mode, deal with hitbox creation
  if (currentMode == State.insertMode) {
    if (temp == null) {
      temp = new BoundingBox(mouseX, mouseY);
    } else {
      players.get(CurrentEntity-1).addBox(temp);
      temp = null;
    }
  } else if (currentMode == State.deleteMode) {
    players.get(CurrentEntity - 1).RemoveAt(mouseX, mouseY);
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

void LoadMk2(String filename) {
  BufferedReader reader = createReader(filename);
  while (true) {
    try {
      players.add(new CollideableEntity(reader));
    } 
    catch (IOException e) { 
      break;
    }
  }
  try { 
    reader.close();
  } 
  catch (IOException e) {
  };
}

void Save() {
  PrintWriter output = createWriter("PlayerData.txt");
  for (int j = 0; j < players.size(); j++) {
    players.get(j).SaveMk2(output, "", j == players.size() - 1); // "" for no indentation
  }
  output.close(); // Finishes the file
}

enum State {
  deleteMode, 
    insertMode, 
    gameMode
}
