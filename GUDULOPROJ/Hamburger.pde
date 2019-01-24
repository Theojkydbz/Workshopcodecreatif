class Hamburger {
  float posX, posY, kcal ;

  Hamburger(float xpos, float ypos, float calories) {
    this.posX = xpos;
    this.posY = ypos;
    this.kcal = calories;
  }

  void display() {
    pushStyle();
    fill(20, 190, 30);
    noStroke();
    float x = random(width / 2 - 50, width / 2 + 50);
    float y = random(height / 2 - 50, height / 2 + 50);
    Popper1.display(x,y);
    Popper1.resizer();
    popStyle();
  }
}
