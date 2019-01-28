


ArrayList<Tile> tile= new ArrayList<Tile>();
float acc = 0.01;
int points;
void setup() {
  size(400, 800);
  tile.add(new Tile(0, 0, width/4, height/6));
}

void draw() {
  background(100);

  line(width/4, 0, width/4, height);
  line(width/2, 0, width/2, height);
  line(3*width/4, 0, 3*width/4, height);

  acc += 0.001;
  for (int i = tile.size() - 1; i >= 0; i--) {
    tile.get(i).move(acc + 4);
    tile.get(i).display();

    if (tile.get(i).spawned == false) {
      if (tile.get(i).Collide(tile.get(i).x + tile.get(i).wid/2, tile.get(i).hei - 1)) {
        tile.add(new Tile(width/4, height/6));
        tile.get(i).spawned = true;
      }
    } else {
     if (tile.get(i).Collide(tile.get(i).x + tile.get(i).wid/2, height)) {
        noLoop();
      } 
    }
    
      textSize(32);
    text(points, width/2, 150);
  }
}

void mousePressed () {
  ArrayList copyList = new ArrayList(tile);
  for (Tile obj : tile) {
    if (obj.Collide(mouseX,mouseY)) {
      copyList.remove(obj); 
      points++;
    }
  }
  tile = copyList;
}
