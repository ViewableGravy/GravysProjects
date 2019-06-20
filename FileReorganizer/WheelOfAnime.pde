public enum State {
  prepare, 
    spin
}

public class WheelOfAnime {
  private int x, y, rad;
  private float rotation, spinTime, speed;
  private String[] items;
  private int[] colour;
  private State state;
  private String file, outFile;

  public WheelOfAnime(String _file, String _outFile) {
    this(width/2,height/2,width/2,_file,_outFile);
  }
  public WheelOfAnime(int _x, int _y, int _rad, String _file, String _outFile) {
    rad = _rad;
    x = _x;
    y = _y;
    spinTime = random(50, 100);
    rotation = 0;
    speed = 100;
    file = _file;
    
    ShuffleFile(file);
    items = loadStrings(file);
    
    state = State.prepare;
    outFile = _outFile;

    boolean PrevWhite = false;
    colour = new int[items.length];
    for (int i = 0; i < items.length; i++) {
      if (PrevWhite) {
        colour[i] = round(random(0, 3));
        PrevWhite = false;
      } else {
        colour[i] = 4;
        PrevWhite = true;
      }
    }

    textSize(24);
  }

  private void reset() {
    spinTime = random(50, 100);
    rotation = 0;
    speed = 100;
    ShuffleFile(file);
    items = loadStrings(file);
  }

  public void Run() {
    translate(x, y);
    pushMatrix();
    rotate(rotation);
    background(100);

    switch( state ) {
    case prepare :
      if (keyPressed) {
        if (key == ' ') {
          reset();
          state = State.spin;
        }
      }
      break;
    case spin :
      if (GetspinTime() > 0) {
        Spin();
      } else {
        state = State.prepare;
      }
      break;
    }

    Show();
    popMatrix();
    fill(0);
    triangle(-rad/2 - 20, -20, -rad/2 - 20, + 20, -rad/2 + 20, 0);
  }

  public void Show() {
    pushMatrix();
    float angle = (PI*2)/items.length;
    for (int clr : colour) {
      switch (clr) {
      case 0:
        fill(255, 0, 0);
        break;
      case 1:
        fill(0, 255, 0);
        break;
      case 2: 
        fill(0, 0, 255);
        break;
      case 3:
        fill(255, 255, 0);
        break;
      case 4:
        fill(255);
        break;
      }
      rotate(angle);
      arc(0, 0, rad, rad, 0, angle);
      fill(0);
    }

    popMatrix();
    pushMatrix();
    for (String str : items) {
      rotate(angle);
      text(str, (-rad/2) + 20, +10);
    }
    popMatrix();
    fill(255);
  }

  public float GetspinTime() {
    return spinTime;
  }

  public float GetRotation() {
    return rotation;
  }

  public void Spin() {
    speed-=0.001;
    if (spinTime > 100) {
      spinTime-= 1;
    } else if (spinTime > 25 ) {
      spinTime -=0.5;
    } else {
      spinTime -= 0.1;
    }
    for (int i = 0; i <10; i++ ) {
      rotation+=(PI/100)*spinTime/100;
    }
  }

  void ShuffleFile(String file) {
    saveStrings(file, Shuffle(file));
  }


  String[] Shuffle(String file) {
    String[] original = loadStrings(file);
    IntList positionsBefore = new IntList();
    IntList positionsAfter = new IntList();
    String[] reorganized = new String[original.length];

    for (int i = 0; i < original.length; i++) {
      positionsBefore.append(i); 
      positionsAfter.append(i);
    }

    for (int i = original.length - 1; i >= 0; i--) {
      int take = floor(random(0, positionsBefore.size()));
      int to = floor(random(0, positionsAfter.size()));
      int positionFrom = positionsBefore.get(take);
      int positionTo = positionsAfter.get(to);
      positionsBefore.remove(take);
      positionsAfter.remove(to);
      reorganized[positionTo] = original[positionFrom];
    }
    return reorganized;
  }

  void MoveToWatched(String stringToMove, String infile, String outfile) {
    String[] original = loadStrings(infile);
    StringList watcheddata = new StringList();
    StringList unwatcheddata = new StringList();
    for (String str : original) {
      if (str.contains(stringToMove)) {
        watcheddata.append(str);
      } else {
        unwatcheddata.append(str);
      }
    }
    saveStrings(infile, unwatcheddata.array());
    saveStrings(outfile, watcheddata.array());
  }
}
