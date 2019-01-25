ArrayList<back> Back;
ArrayList<backvoid> Backvoid;
ArrayList<backvoidreverse> Backvoidrev;
circlezone Circlezone = new circlezone(); 

void setup() {
  size(800, 800);
  Back = new ArrayList<back>();
  Backvoid = new ArrayList<backvoid>();
  Backvoidrev = new ArrayList<backvoidreverse>();
  initback();
}
void draw() {
  background(0);
  maj();
    
  if (keyPressed == true) {
    majvoid();
  } else {
    majvoidrev();
  }

  if (mousePressed) {
    Circlezone.updater();
  } else {
    Circlezone.reset();
  }
}



void initback() {
  for (int i=0; i<1000; i++) {
    Back.add(new back());
  }
}

void maj() {
  for (int u=0; u<1000; u++) {
    back maj = Back.get(u);
    maj.update();
    maj.display();
  }
}
void majvoid() {
  float chancevoid=random(0, 1);
  if (chancevoid>0.8) {
    Backvoid.add(new backvoid());
  }
  for (int j=0; j<Backvoid.size(); j++) {
    backvoid majvoid = Backvoid.get(j);
    majvoid.update(j);
    majvoid.display();
  }
}
void majvoidrev() {
  float chancevoidrev=random(0, 1);
  if (chancevoidrev>0.8) {
    Backvoidrev.add(new backvoidreverse());
  }
  for (int k=0; k<Backvoidrev.size(); k++) {
    backvoidreverse majvoidrev = Backvoidrev.get(k);
    majvoidrev.update(k);
    majvoidrev.display();
  }
}
