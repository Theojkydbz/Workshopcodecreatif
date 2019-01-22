// A Simple Carnivore Client -- print packets in Processing console
//
// Note: requires Carnivore Library for Processing (http://r-s-g.org/carnivore)
//
// + Windows:  first install winpcap (http://winpcap.org)
// + Mac:      first open a Terminal and execute this commmand: sudo chmod 777 /dev/bpf*
//             (must be done each time you reboot your mac)

import java.util.Map;
import org.rsg.carnivore.*;
import org.rsg.lib.Log;

CarnivoreP5 c;


HashMap<String, Integer> hm = new HashMap<String, Integer>();

void setup() {
  size(600, 400);
  background(255);
  Log.setDebug(true); // Uncomment for verbose mode
  c = new CarnivoreP5(this); 
  //c.setVolumeLimit(4); //limit the output volume (optional)
  //c.setShouldSkipUDP(true); //tcp packets only (optional)
}

void draw() {
}

// Called each time a new packet arrives
void packetEvent(CarnivorePacket p) {
  //println("(" + p.strTransportProtocol + " packet) " + p.senderSocket() + " > " + p.receiverSocket());
  
  String[] parts = p.senderSocket().split(":");
  String part1 = parts[0]; // 004
  String part2 = parts[1]; // 034556
 
  
  
  hm.put(parts[0], 1);
  /*
  for (Map.Entry me : hm.entrySet()) {
    // println(p.senderSocket() +"=" + (String)tab.get(i));
    hm.put(p.senderSocket(), 1);
  }*/
  for (Map.Entry me : hm.entrySet()) {
 print(me.getKey() + " is ");
  println(me.getValue());
  }
  println(hm.size());

  /// println(tab);

  //println("Payload: " + p.ascii());
  //println("---------------------------\n");
}
