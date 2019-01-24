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

CarnivoreP5 c;
String testPrefix = "172";
int appareilsCo = 0;
int oldNumber;
int codecnumber=0;
HashMap<String, Integer> hm = new HashMap<String, Integer>();
////////////////  END CARNIVORE /////////////////////

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
int formResolution = 16;
boolean isactive = false;
float distortionFactor = 1;
float initRadius = 150;
float centerX, centerY;
float[] xstart = new float[formResolution];
float[] ystart = new float[formResolution];
float[] xbeg = new float[formResolution];
float[] ybeg = new float[formResolution];


void setup() {
  fullScreen(P2D);
  pgPop = createGraphics(width,height);
  minim = new Minim(this);
  background(255);
  smooth();
  stroke(0, 64);
  manger = new PVector(width/2, height/2);
  Back = new ArrayList<back>(1000);
  particules = new ArrayList();
  hamburger = new ArrayList();


/////// INIT AGENTS //////
  for (int i = 0; i < 3; i++) {
    float angle = random(TWO_PI);
    float r = random(140, 200);
    float x = width/2 + r*cos(angle);
    float y = height/2 + r*sin(angle);
    particules.add(new Particle(x,y, 255));
  }

////// INIT POPPERS //////
  float angle = radians(360/float(formResolution));
    for (int i=0; i<formResolution; i++) {
      xbeg[i] = cos(angle*i) * initRadius;
      ybeg[i] = sin(angle*i) * initRadius;  
      xstart[i] =xbeg[i];
      ystart[i] =ybeg[i];
    }
      
  for (int i=0; i<1000; i++) {
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
if ( frameCount % 60 == 0) codecnumber = 0 ; // reset la quantité de codecs toutes les secondes


for (int i = 0; i < hamburger.size(); i++) {
  Hamburger frites = hamburger.get(i);
  frites.display();
}


for (int i = 0; i < particules.size(); i++) {
  Particle particucule = particules.get(i);
  particucule.update();
  particucule.display(i);
}

  if ( Pop.position() < Pop.length()&& Pop.isPlaying()) {
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
  codecnumber += codec.length();
  println("codeeecumber = ", codecnumber);
  hm.put(parts[0], 1); //tableau d'affichage
  constrain(codecnumber, 0, 3000);
  float energie = map (codecnumber, 0, 13135, 0, 40) ;  //13135 plus grande valeur observée sur plsueirus longueds observations

  ////////////////// CONNEXIONS APPAREILS /////////////////
  for (Map.Entry me : hm.entrySet()) {
    String value = me.getKey().toString();
    value.substring(0, 3);
    if (value.substring(0, 3).equals(testPrefix)) {
      appareilsCo++;
    }
  }


  /////////////////////// REQUETES INTERNET /////////////////////
  if (energie != 0 && oldNumber == appareilsCo && appareilsCo != 0) { //avoid connexions packets
    //println("coedc " , codecnumber);
    hamburger.add(new Hamburger(random((width/2) - 50, (width / 2) + 50), random((height / 2 ) - 50, (height / 2) + 50), energie)); //nouveau truc à manger
    playSound(Pop);
    openDoor = true;
    timer = millis() + 600; // timer pour l'excitation des particles
  }

  if (bestcodec < codecnumber) bestcodec = codecnumber ; 
  println("best codec = ", bestcodec);

 
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

void maj() {
  for (int u=0; u< Back.size(); u++) {
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
