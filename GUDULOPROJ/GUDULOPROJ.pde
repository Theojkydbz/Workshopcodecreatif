int n=10000;
Particle[] particules = new Particle[10];
//Agent[] agent_life = new AGENT_life[n];
PVector target;
float xoff, yoff;
float[] x = new float[n]; 
float[] y = new float[n]; 
boolean openDoor = false;
float timer, t_stamp, t_life; //timer d'excitation et décompte de la jauge de vie des particules
int Agents ; //nb d'agents
PVector manger;


void setup() {
  size(500, 500);
  background(255);
  smooth();
  stroke(0, 64);
  manger = new PVector(width/2,height/2);

  for (int i = 0; i < particules.length; i++) {
    particules[i] = new Particle(int(random(0, width)), int(random(0, height)), 255);
  }
}

void draw() {
  pushMatrix();
  fill(255, 20);
  rect(0, 0, width, height);
  popMatrix();

if (openDoor == true ) t_stamp = millis();
  for (int i =0; i < particules.length; i++) {
    particules[i].update();
    particules[i].display(i);
  }
  fill(0);
  
  //en attendant
//  println("openDoor = ", openDoor); 
}

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
