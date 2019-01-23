class Hamburger  {
  float posX, posY, kcal ;
   
  float stepSize = 2;
  float xNoise =0;
  
  Hamburger(float xpos, float ypos, float calories){
    this.posX = xpos;
    this.posY = ypos;
    this.kcal = calories;
  }
  
  
  void update(){
    xNoise += 0.1
  }
  
  void display(){
    fill(255, 0, 0);
    ellipse(width*0.5, height*0.5, 30, 30);
    fill(255, 255, 255);
    noStroke();



    centerX = mouseX; 
    centerY = mouseY;
    float angle = radians(360/float(formResolution));
    float radius = initRadius * random(0.5, 1.0);

    beginShape();
    // start controlpoint
    curveVertex(xbeg[formResolution-1]+centerX, ybeg[formResolution-1]+centerY);
for (int i=0; i<formResolution; i++){
    xNoise+=0;
    stepSize=noise(xNoise)*2;
    xbeg[i] += random(-stepSize,stepSize);
    ybeg[i] += random(-stepSize,stepSize);
    // ellipse(x[i], y[i], 5, 5);
  }
    // only these points are drawn
    for (int i=0; i<formResolution; i++) {
      curveVertex(xbeg[i]+centerX, ybeg[i]+centerY);
    }
    curveVertex(xbeg[0]+centerX, ybeg[0]+centerY);

    // end controlpoint
    curveVertex(xbeg[1]+centerX, ybeg[1]+centerY);
    endShape();
  }
  }
}
