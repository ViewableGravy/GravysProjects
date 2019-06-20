
void setup() {
  new EchoServer().start(); //start server
  
  /*
  Test(); //run tests
  println("done");
  GameClient.sendRequest("end"); //close server
  */
}

void Test() {
  String echo = GameClient.sendRequest("hello server");
  println(echo);
  echo = GameClient.sendRequest("server is working");
  println(echo);
  echo = GameClient.sendRequest("100");
  println(echo);
}
