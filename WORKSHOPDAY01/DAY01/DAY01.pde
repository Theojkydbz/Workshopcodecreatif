// A Simple Carnivore Client -- print packets in Processing console
//
// Note: requires Carnivore Library for Processing (http://r-s-g.org/carnivore)
//
// + Windows:  first install winpcap (http://winpcap.org)
// + Mac:      first open a Terminal and execute this commmand: sudo chmod 777 /dev/bpf*
//             (must be done each time you reboot your mac)

import org.rsg.carnivore.*;
import org.rsg.lib.Log;

CarnivoreP5 c;
ArrayList<String> tab;

void setup() {
  size(600, 400);
  background(255);
  Log.setDebug(true); // Uncomment for verbose mode
  c = new CarnivoreP5(this); 
  //c.setVolumeLimit(4); //limit the output volume (optional)
  //c.setShouldSkipUDP(true); //tcp packets only (optional)
  tab = new ArrayList<String>();
}

void draw() {
}

// Called each time a new packet arrives
void packetEvent(CarnivorePacket p) {
  //println("(" + p.strTransportProtocol + " packet) " + p.senderSocket() + " > " + p.receiverSocket());
  if (tab.size() == 0) {
    tab.add(p.senderSocket());
  }
  for (int i=0; i <= tab.size(); i++) {
   // println(p.senderSocket() +"=" + (String)tab.get(i));
    if (p.senderSocket().compareTo((String)tab.get(i)) == 0) {
      println("okzopkzeza");
      break;
    } 
    else{
      tab.add(p.senderSocket());
      println("pas là");
      println("longeur tqbleau = " + tab.size());
    }
  }

  /// println(tab);

  //println("Payload: " + p.ascii());
  //println("---------------------------\n");
}
