class backvoidreverse {
  float xposvoidrev;
  float yposvoidrev;
  float speedvoidrev = random(0.025);
  float tposvoidrev=random(0,TWO_PI);
  float radiusvoidrev =0;
  float sizevoidrev = random(3, 8);
  float sensvoidrev= random(0,1);
  

  void update(int index) {
    radiusvoidrev+=1;
    if (sensvoidrev < 0.5) {
      tposvoidrev += speedvoidrev;
    } else {
      tposvoidrev -= speedvoidrev;
    }
    float sinvalvoidrev = sin(tposvoidrev);
    float cosvalvoidrev = cos(tposvoidrev);
    xposvoidrev = (width / 2) + (cosvalvoidrev * radiusvoidrev);
    yposvoidrev = (height / 2) + (sinvalvoidrev * radiusvoidrev);
    if(radiusvoidrev > 150){
      Backvoidrev.remove(index);
    }
    
  }

  void display() {
    fill(0, 0, 204);
    noStroke();
    ellipse(xposvoidrev, yposvoidrev, sizevoidrev, sizevoidrev);
  }
}
