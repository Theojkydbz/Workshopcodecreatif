//




//::::::::::CARNIVORE::::::::::::\\
import java.util.Map;
import org.rsg.carnivore.*;
import org.rsg.lib.Log;


CarnivoreP5 c;
String testPrefix = "172";
int appareilsCo = 0;
int oldNumber;
int codecnumber=0;
HashMap<String, Integer> hm = new HashMap<String, Integer>();
////////////////  END CARNIVORE /////////////////////


//////////// particules ///////////
int nb =10000;
ArrayList<Particle> particules ;
ArrayList<Hamburger> hamburger ;
//Particle[] particules = new Particle[10];
PVector target;
float xoff, yoff;
float[] x = new float[nb]; 
float[] y = new float[nb]; 
boolean openDoor = false;
float timer, t_stamp, t_life; //timer d'excitation et décompte de la jauge de vie des particules
int Agents ; //nb d'agents
PVector manger;


///////////////////// Hamburger :////////:::
int formResolution = 15;
boolean isactive = false;
float distortionFactor = 1;
float initRadius = 150;
float centerX, centerY;
float[] xstart = new float[formResolution];
float[] ystart = new float[formResolution];
float[] xbeg = new float[formResolution];
float[] ybeg = new float[formResolution];


void setup() {
  size(500, 500);
  background(255);
  smooth();
  stroke(0, 64);
  manger = new PVector(width/2, height/2);

  particules = new ArrayList();
  hamburger = new ArrayList();
  for (int i = 0; i < 3; i++) {
    particules.add(new Particle(int(random(0, width)), int(random(0, height)), 255));
  }


  //::::::::::CARNIVORE::::::::::::\\
  Log.setDebug(true); // Uncomment for verbose mode
  c = new CarnivoreP5(this);
}

void draw() {
  pushMatrix();
  fill(255, 20);
  rect(0, 0, width, height);
  popMatrix();

  //si un objet apparait (et donc que le centre est accessible), je lance un timer pour les exciter avant qu'ils se lancent dans l'agrerssion du pauvre petit paquet qui a pop
  if (openDoor == true ) t_stamp = millis();

  for (int i = 0; i < particules.size(); i++) {
    Particle particucule = particules.get(i);
    particucule.update();
    particucule.display(i);
  }

 for (int i = 0; i < hamburger.size(); i++) {
    Hamburger frites = hamburger.get(i);
    frites.update();
    frites.display(i);
  }

  //verify if there is at least one hamburger on screen
  if (hamburger.size() == 0) { //if there isn't, so close access to center
    openDoor = false;
    timer = t_stamp + 1;
  }
}


//::::::::::CARNIVORE_EVENT::::::::::::\\
void packetEvent(CarnivorePacket p) {
  //println("(" + p.strTransportProtocol + " packet) " + p.senderSocket() + " > " + p.receiverSocket());

  String[] parts = p.senderSocket().split(":");
  String codec = p.ascii(); 
  codecnumber = codec.length();
  hm.put(parts[0], 1); //tableau d'affichage
  float energie = map (codecnumber, 0, 800, 0, 20) ;


  ////////////////// CONNEXIONS APPAREILS /////////////////
  for (Map.Entry me : hm.entrySet()) {
    String value = me.getKey().toString();
    value.substring(0, 3);
    if (value.substring(0, 3).equals(testPrefix)) {
      appareilsCo++;
    }
  }
  /////////////////////// REQUETES INTERNET /////////////////////
  if (energie != 0 && oldNumber == appareilsCo) { //avoid connexions packets
    println(codecnumber);
    hamburger.add(new Hamburger(random((width/2) - 50, (width / 2) + 50), random((height / 2 ) - 50, (height / 2) + 50), energie));
    openDoor = true;
    timer = millis() + 600; // timer pour l'excitation des particles
  }
  
/////////////// NOUVELLE CONNEXION ////////////////////
  if (oldNumber < appareilsCo) {
    println("Nouvelle connexion !");
    oldNumber = appareilsCo;
    particules.add(new Particle(int(random(0, width)), int(random(0, height)), 255));
  }

  println("Appareils connectés : ", appareilsCo);
  println("Nombre d'agents : ", particules.size());
  println("hmSize = ", hm.size());
  println("*****************************************************************");
 appareilsCo = 0; //clear the value
}


/*
void keyPressed() {
 if (keyCode == TAB) {
 openDoor = false;
 timer = t_stamp + 1;
 }
 if (keyCode == SHIFT) {
 openDoor = true;
 timer = millis() + 600; // timer pour l'excitation des particles
 }
 }
 */
