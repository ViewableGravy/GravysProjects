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

public class pickup_ines extends PApplet {

String[] lines;
public void setup() {
  
  lines = loadStrings("pickuplines.txt");
  textSize(50);
  fill(255, 0, 0);
  stroke(0, 255, 0);
  text("click left mouse button", width/8, height/4, width-width/4, height - height/4);
  //frameRate(1);
}

public void draw() {
  
}

public void mousePressed() {
  background(200);
  int pickupline = round(random(0, lines.length-1));
  if (lines[pickupline].trim().length() == 0) {
     pickupline++; 
  }
    text(lines[pickupline], width/8, height/4, width-width/4, height - height/4);
}
  public void settings() {  size(600, 600); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "pickup_ines" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
