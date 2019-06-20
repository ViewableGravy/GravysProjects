int Seconds = 0;
void setup() {
  new EchoServer().start(); //start server
  size(300,100);
  textSize(30);
  
  Test(); //run tests
  //println("done");
  //GameClient.sendRequest("end"); //close server
  
}

void draw() {
  background(1);
  Seconds++;
  frameRate(1);
  text("Status: Running", 30,40);
  text("Time  : " + Seconds, 30,80);
  //println("Status: Running");
  //println("Time  : " + Seconds);
  //println("");
}

void Test() {
  String echo = GameClient.sendRequest("hello server");
  println(echo);
  echo = GameClient.sendRequest("server is working");
  println(echo);
  echo = GameClient.sendRequest("100");
  println(echo);
}
