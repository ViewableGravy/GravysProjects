
class Details { 
 String name;
 int score;
 
 Details(String name, int score) {
   this.name = name;
   this.score = score;
 }
  
}

void setup() {
  BufferedReader reader = createReader("EyeLigma.txt");
  String line = "";
  int score = 0;
  try {
    while ((line = reader.readLine())!=null) {
      if (line.contains(":")) {
        println(score);
        score = 0;
      } else {
       score += parseInt(line);
      }
    }
    println(score);
  }
  catch (IOException e) {
  }
  
  
  
}
