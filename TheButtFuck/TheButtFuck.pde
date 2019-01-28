int iteration = 1;
float sentenceWidth;
float sentenceHeight;
int i = 0;
int arraylength = 1;
int line2;
int[] line2Array;

void setup() {
  background(51);
  size(1200, 600);
  textSize(32);
  line2 = 0;
  sentenceWidth = (width/10);
  sentenceHeight = 4*height/5;
  line2Array = new int[arraylength];
  line2Array[0] = 0;
}

void draw() {
  //background(100);
  switch(iteration) {
  case 1 : 
    Sentence("Where am I, I asked the man. Looking around All i could "
      + "see was a cell. The usual, hard bed, bland walls and a sink "
      + "for whatever reason. The guard looked at me and responded"
      + " 'you are in a cell my dude' and then continued to walk away "
      + "best plot of a story ever i thought");
    break;
  default:
    println("end");
  }
}

void Sentence(String word) {
  text(word.charAt(i), sentenceWidth, sentenceHeight);
  sentenceWidth += textWidth(word.charAt(i));
  if (word.charAt(i) == ' ') {
    if (WithinBoundsX(sentenceWidth)) {
      sentenceHeight += 40;
      sentenceWidth = width/10;
      //if (line2 == 0) {
        arraylength++;
        
        line2Array = expand(line2Array, arraylength);
        
        line2Array[arraylength - 1] = i;
        
        //line2 = i;
      //}
    }
    if (!WithinBoundsY(sentenceHeight)) {
      sentenceHeight = 4*height/5;
      sentenceWidth = width/10;
      background(51);
      // use while loop
      // create j at the start of first sentence
      // continue until end of second line
      int j = line2Array[arraylength - 3];
      while (j < i) {
        text(word.charAt(j), sentenceWidth, sentenceHeight);
        sentenceWidth += textWidth(word.charAt(j));
        if (word.charAt(j) == ' ') {
          if (WithinBoundsX(sentenceWidth)) {
            sentenceHeight += 40;
            sentenceWidth = width/10;
            //if (line2 == j) {
            //  line2 = i;
            //}
          }
        }
        j++;
      }
    }
  }
  //Delay(0);
  //Could add another perameter to the procedure
  //to determine the slowness
  i ++;
  if ( i == word.length()) {
    i = 0;
    iteration++;
    sentenceWidth = (width/10);
    sentenceHeight = 7*height/10;
  }
}

boolean WithinBoundsX(float sentenceWidth) {
  if (sentenceWidth > width - (width/10)) {
    return true;
  }
  return false;
}

boolean WithinBoundsY(float sentenceHeight) {
  if (sentenceHeight < height - 20) {
    return true;
  }
  return false;
}

void Delay(int time) {
  int ms = millis();
  while ((millis() - ms) < time) {
    //Do nothing
  }
}
