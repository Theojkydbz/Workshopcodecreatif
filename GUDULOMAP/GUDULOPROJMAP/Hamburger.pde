class Hamburger {
  float posX, posY, kcal ;

  Hamburger(float xpos, float ypos, float calories) {
    this.posX = xpos;
    this.posY = ypos;
    this.kcal = calories;
  }

  void display() {
    pushStyle();
    fill(255);
    noStroke();
    //float x = random(width / 2 - 50, width / 2 + 50);
    //float y = random(height / 2 - 50, height / 2 + 50);
    float a = random(-PI, PI);
    float r = random(50);
    float x = width/2 + r * cos(a);
    float y = height/2 + r * sin(a);
    Popper1.display(x,y);
    Popper1.resizer();
    popStyle();
  }
}
