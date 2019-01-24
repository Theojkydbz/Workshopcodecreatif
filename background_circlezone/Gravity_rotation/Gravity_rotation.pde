PFont font;
float coefFriction = 0.8; //coefficient of friction;
Particle[] particles = new Particle[1000];
PVector mouse;

void setup() {
  background(30);
  mouse = new PVector(mouseX, mouseY);
  size(1900, 900);


  //initialize paticles
  for (int i = 0; i < particles.length; i++) {
    particles[i] = new Particle(int(random(0, width)), //x
      int(random(0, height)), //y
      random(2, 50), //mass
      random(1, 4), //size
      random(100, 150)); //rotation seuil
  }
}

void draw() {
  noStroke();
  fill(30, 20);
  rect(0, 0, width, height);
   mouse.x = mouseX;
   mouse.y = mouseY;

  fill(23, 175, 135);
  for (int i = 0; i < particles.length; i++) {
    particles[i].update();
    particles[i].display();
  }
}
