ArrayList<back> Back;

void setup() {
  size(800, 800);
  Back = new ArrayList<back>();
  initback();
}
void draw() {
  background(0);
  maj();
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
