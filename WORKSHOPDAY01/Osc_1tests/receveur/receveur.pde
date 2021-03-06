import oscP5.*;
import netP5.*;

OscP5 osc;
NetAddress myRemoteLocation;

float value,value2;
boolean gateOpen = false;

void setup() {
  size(400, 400);
  /* start osc, listening for incoming messages at port 9000 */
  osc = new OscP5(this, 9000);
  noStroke();
  fill(255);
}


void draw() {
    background(0);  
  text("receiving: " + value, 10, 20);
 // float valueConverted = map(value,0,width,0,height);
  
  if (gateOpen) ellipse(value,value2,50,50);
  gateOpen = false;
}

/* incoming osc message are forwarded to the oscEvent method. */
void oscEvent(OscMessage theOscMessage) {
  println(theOscMessage);
  if (theOscMessage.checkAddrPattern("/1/fader3")==true) {
    if (theOscMessage.checkTypetag("ff")) {
      value = theOscMessage.get(0).floatValue();
      value2 = theOscMessage.get(1).floatValue();
      gateOpen = true;
    }
  }

}
