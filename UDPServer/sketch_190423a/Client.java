//import java.net.*;

//public static class EchoClient {
//  static String sendEcho(String msg) {
//    private DatagramSocket socket;
//    private InetAddress address;
//    private byte[] buf;
//    try {
//      socket = new DatagramSocket();
//      address = InetAddress.getByName("localhost");
//    }
//    catch (Exception e) {
//      e.printStackTrace();
//      println("Error creating datagram socket");
//    }

//    buf = msg.getBytes();
//    try {
//      DatagramPacket packet = new DatagramPacket(buf, buf.length, address, 25565);
//      socket.send(packet);
//      packet = new DatagramPacket(buf, buf.length);
//      socket.receive(packet);
//      String received = new String(
//        packet.getData(), 0, packet.getLength());
//      return received;
//    } 
//    catch (Exception e) {
//      e.printStackTrace(); 
//      return null;
//    }
//    socket.close();
//  }
//}
