//import java.net.*;

//class EchoServer extends Thread {
 
//    private DatagramSocket socket;
//    private boolean running;
//    private byte[] buf = new byte[256];
    
//    private String x = "100";
//    public PVector 
 
//    EchoServer() {
//      try {
//          socket = new DatagramSocket(25565);
//      } catch (Exception e) {
//        e.printStackTrace();
//      }
      
//    }
 
//    public void run() {
//       try {
//         running = true;
 
//        while (running) {
//            DatagramPacket packet = new DatagramPacket(buf, buf.length);
//            socket.receive(packet);
            
             
//            InetAddress address = packet.getAddress();
//            int port = packet.getPort();
            
//            String received = new String(packet.getData(), 0, packet.getLength());
             
//             if (received.equals("x")) {
//               buf = x.getBytes();
//               socket.send( new DatagramPacket(buf,buf.length,address,port));
//               return;
//             } else {
//               if (received.equals("end")) {
//                 running = false;
//                 continue;
//               }
//             }
//             socket.send(packet);
//        }
//      } catch (Exception e) {
        
//      } finally {
//         socket.close();
//      }
       
       
//    }
//}
