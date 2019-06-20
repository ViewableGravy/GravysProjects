import java.net.*;

public static class GameClient {
  static String sendRequest(String msg) {
    try {
      final DatagramSocket socket = new DatagramSocket();
      final byte[] buf;
      final InetAddress address = InetAddress.getByName("localhost");

      buf = msg.getBytes();
      DatagramPacket packet = new DatagramPacket(buf, buf.length, address, 25565);
      socket.send(packet);
      packet = new DatagramPacket(buf, buf.length);
      socket.receive(packet);
      String received = new String(packet.getData(), 0, packet.getLength());
       socket.close();
      return received;
    } catch (Exception e) {
      return "Error: something went wrong";
    } 
  }
}
