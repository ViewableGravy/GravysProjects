import java.net.*;

class EchoServer extends Thread {
  private byte[] buf = new byte[256];
  private DatagramSocket socket;
  private boolean running;


  private String x = "100";
  public PVector PlayerPos = new PVector(500, 500);

  public EchoServer() {
    try {
      socket = new DatagramSocket(25565);
    } 
    catch (Exception e) {
      e.printStackTrace();
    }
  }

  public void run() {

    running = true;

    while (running) {
      try {
        DatagramPacket packet = new DatagramPacket(buf, buf.length);
        socket.receive(packet);


        InetAddress address = packet.getAddress();
        int port = packet.getPort();

        String received = new String(packet.getData(), 0, packet.getLength());

        if (received.contains("ViewableGravy.pos:")) {
          String[] receivedArr = new String[2];
          receivedArr = split(split(received, ':')[1], ',');
          PlayerPos.x = parseInt(receivedArr[0]);
          PlayerPos.y = parseInt(receivedArr[1]);
          String response = "Success";
          buf = response.getBytes();
        } else {
          if (received.equals("ViewableGravy.pos")) {
            println("run");
            String response =  str(PlayerPos.x) + ',' + str(PlayerPos.y);
            buf = response.getBytes();
            packet = new DatagramPacket(buf, buf.length, address, port);
          } else {
            if (received.equals("end")) {
              running = false;
              continue;
            }
          }
        }
        socket.send(packet);
        buf = new byte[256];
      } 
      catch (Exception e) {
        println(e);
      }
    }
  }
}
