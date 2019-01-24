class back {
  float xpos;
  float ypos;
  float speed = random(0.005);
  float tpos=0;
  float radius = random(150, 400);
  float size = random(3, 8);
  float sens= random(0,1);

  void update() {
    if (sens < 0.5) {
      tpos += speed;
    } else {
      tpos -= speed;
    }
    float sinval = sin(tpos);
    float cosval = cos(tpos);
    xpos = (width / 2) + (cosval * radius);
    ypos = (height / 2) + (sinval * radius);
  }

  void display() {
    fill(0, 0, 204);
    noStroke();
    ellipse(xpos, ypos, size, size);
  }
}
