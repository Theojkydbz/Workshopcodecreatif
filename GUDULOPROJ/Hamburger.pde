class Hamburger {
  float posX, posY, kcal ;

  Hamburger(float xpos, float ypos, float calories) {
    this.posX = xpos;
    this.posY = ypos;
    this.kcal = calories;
  }

  void display() {
    pushStyle();
    fill(20,190,30);
    noStroke();
    ellipse(posX, posY, 50, 50);
    popStyle();
  }
}
