class circlezone {
  float rotation = 0;
  float maxSize = 0.75;
  float minSize = 0.1;
  float currSize = 0.1;
  float ease = 0.1;

  void updater() {
    currSize+=((maxSize-currSize)*ease);
    drawBlackHole(width*0.5, height*0.5, currSize);
  }
  void drawBlackHole(float x, float y, float size) {
    //centers pen
    translate(x, y);
    //loops through 10 times
    for (int i=0; i<10; i++) {
      //rotates semi-randomly to add vaiation to the black hole
      rotation += random(0.05, 0.1);
      rotate(rotation);
      noFill();
      stroke(20, 20, 254);
      ellipse(0, 0, random(1, 300*size), 400*size);
      rotate(rotation+90);
      ellipse(0, 0, random(1, 300*size), 400*size);
    }
  }
  void reset() {
    currSize = minSize;
  }
}
