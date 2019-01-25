import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;


//::::::::::CARNIVORE::::::::::::\\
import java.util.Map;
import org.rsg.carnivore.*;
import org.rsg.lib.Log;

Minim minim;
AudioPlayer Pop;
AudioPlayer Ambiance;

float timePop ;
float soundDuration;
PGraphics pgPop;
PVector initPos;

CarnivoreP5 c;
String testPrefix = "172";
int appareilsCo = 0;
int oldNumber;
int codecnumber=0;
HashMap<String, Integer> hm = new HashMap<String, Integer>();
////////////////  END CARNIVORE /////////////////////




/////// DEBUG SLIDERS ////////

import controlP5.*;

ControlP5 cp5;
float radiusG;
float sliderValue = 0.79;
float sliderValueY = 1.07;
float sliderMinX = 1.06;
float sliderMinY = 1.39;
boolean displaySliders  = false ;




float bestcodec = 0 ;
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
float timer, t_stamp, t_life; //timer = excitation et décompte de la jauge de vie des particules : t_agglo = pour agglomérer la taille des codecs / sec 
int Agents ; //nb d'agents
PVector manger;


///////////////////// BACKGROUND :///////////////
ArrayList<back> Back;
circlezone Circlezone = new circlezone(); 

/////////////////////// REQUEST POP //////////////////////
float noisoff=0;
float val=0;
popper Popper1 = new popper(); 
int formResolution = 6;
boolean isactive = false;
float distortionFactor = 1;
float Radius = 30;
float centerX, centerY;
float[] xstart = new float[formResolution];
float[] ystart = new float[formResolution];
float[] xbeg = new float[formResolution];
float[] ybeg = new float[formResolution];
float energie ;

void setup() {
  fullScreen(P2D);
  pgPop = createGraphics(width, height);
  minim = new Minim(this);
  background(255);
  smooth();
  stroke(0, 64);
  manger = new PVector(width/2, height/2);
  Back = new ArrayList<back>(1000);
  particules = new ArrayList();
  hamburger = new ArrayList();


  ///////////SLIDER///////////
  /* cp5 = new ControlP5(this);
   
   // add a horizontal sliders, the value of this slider will be linked
   // to variable 'sliderValue' 
   cp5.addSlider("sliderValue")
   .setPosition(100, 50)
   .setRange(-0.7878, 0.79)
   ;
   cp5.addSlider("sliderValueY")
   .setPosition(100, 100)
   .setRange(1, 1.07)
   ;
   cp5.addSlider("sliderMinX")
   .setPosition(100, 150)
   .setRange(0.5, 1.06)
   ;
   cp5.addSlider("sliderMinY")
   .setPosition(100, 200)
   .setRange(0.5, 1.39)
   ;
   */

  /////// INIT AGENTS //////
  for (int i = 0; i < 3; i++) {
    newPos(140, 200);
    particules.add(new Particle(initPos.x, initPos.y, 255));
  }


  for (int i = 0; i < 1000; i++) {
    Back.add(new back());
  }

  Pop = minim.loadFile("POPCOURT.wav");
  Ambiance = minim.loadFile("AMBIANCE3.wav");
  Ambiance.loop();

  //::::::::::CARNIVORE::::::::::::\\
  Log.setDebug(true); // Uncomment for verbose mode
  c = new CarnivoreP5(this);

  pixelDensity(1);
}


void draw() {
  pushMatrix();
  fill(0, 10);
  rect(0, 0, width, height);
  popMatrix();

  maj();

  //si un objet apparait (et donc que le centre est accessible), je lance un timer pour les exciter avant qu'ils se lancent dans l'agrerssion du pauvre petit paquet qui a pop
  if (openDoor == true ) t_stamp = millis();
  if ( frameCount % 20 == 0) codecnumber = 0 ; // reset la quantité de codecs 


  for (int i = 0; i < hamburger.size(); i++) {
    Hamburger frites = hamburger.get(i);
    frites.hambStyle();
  }


  for (int i = 0; i < particules.size(); i++) {
    Particle particucule = particules.get(i);
    particucule.update();
    particucule.display(i);
  }

  if ( Pop.position() < Pop.length() * random(0.5) && Pop.isPlaying()) {
    Circlezone.updater();
  } else Circlezone.reset();

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
  hm.put(parts[0], 1); //tableau d'affichage
  codecnumber += codec.length();
  println("codeeecumber = ", codecnumber);

  constrain(codecnumber, 0, 300);
  energie = map (codecnumber, 200, 2000, 5, 25) ;  //8000 plus grande valeur observée sur plsueirus longueds observations
  if (energie > 25) energie = 25 ;

  ////////////////// CONNEXIONS APPAREILS /////////////////
  for (Map.Entry me : hm.entrySet()) {
    String value = me.getKey().toString();
    value.substring(0, 3);
    if (value.substring(0, 3).equals(testPrefix)) {
      appareilsCo++;
    }
  }


  /////////////////////// REQUETES INTERNET /////////////////////
  if (codecnumber > 200 && oldNumber == appareilsCo && appareilsCo != 0) { // 1) pour eviter les requetes passives en tache de fond, 2) eviter les requetes de connexion de nouveaux appareils 

    //println("coedc " , codecnumber);
    newPos(0, 100);
    hamburger.add(new Hamburger(initPos.x, initPos.y, energie)); //nouveau truc à manger
    playSound(Pop);
    openDoor = true;
    timer = millis() + 800; // timer pour l'excitation des particles
  }

  if (bestcodec < codecnumber) bestcodec = codecnumber ; 
  println("best codec = ", bestcodec);


  /////////////// NOUVELLE CONNEXION ////////////////////
  if (oldNumber < appareilsCo) {
    println("Nouvelle connexion !");
    oldNumber = appareilsCo;
    newPos(140, 200);
    particules.add(new Particle(initPos.x, initPos.y, 255));
  }

  println("Appareils connectés : ", appareilsCo);
  println("Nombre d'agents : ", particules.size());
  println("hmSize = ", hm.size());
  println("*****************************************************************");
  appareilsCo = 0; //clear the value
}

void maj() {
  for (int u = 0; u < Back.size(); u++) {
    back maj = Back.get(u);
    maj.update();
    maj.display();
  }
}

void playSound(AudioPlayer sound) {
  if (sound.isPlaying() == true) {
    sound.pause();
    sound.rewind();
    sound.play();
  } else {
    sound.rewind();
    sound.play();
  }
}


void slider(float thevalue) {
  radiusG = thevalue ;
}

PVector newPos(int r1, int r2) {
  float angle = random(TWO_PI);
  float r = random(r1, r2);
  float x = width/2 + r * cos(angle);
  float y = height/2 + r * sin(angle);
  initPos = new PVector(x, y);

  return initPos;
}

void keyPressed() {
  if (key == SHIFT) {
    newPos(140, 200);
    particules.add(new Particle(initPos.x, initPos.y, 255));
    println("add new particule");
  }

  if (key == TAB) particules.remove(0);
}
