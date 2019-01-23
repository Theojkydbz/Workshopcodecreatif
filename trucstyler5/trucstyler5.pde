
float xoff=0;
float val=0;

popper Popper1 = new popper(); 
int formResolution = 15;
boolean isactive = false;
float distortionFactor = 1;
float initRadius = 150;
float centerX, centerY;
float[] xstart = new float[formResolution];
float[] ystart = new float[formResolution];
float[] xbeg = new float[formResolution];
float[] ybeg = new float[formResolution];
void setup() {
  size(1200, 800);
}
void  draw() {
  fill(0, 20);
  rect(0, 0, width, height);
  xoff += 0.1;
  if (keyPressed == true) {
    float angle = radians(360/float(formResolution));
    for (int i=0; i<formResolution; i++) {
      xbeg[i] = cos(angle*i) * initRadius;
      ybeg[i] = sin(angle*i) * initRadius;  
      xstart[i] =xbeg[i];
      ystart[i] =ybeg[i];
    }
    isactive = true;
    poPing();
  }
  if (isactive==true) {
    Popper1.update(); 
    Popper1.display();
  }
  
}
void  poPing() {
  float size=100;
  for (float i =0; i<1200; i+=0.5) {
    size+=1;
    stroke(255);
    noFill();
    ellipse(mouseX, mouseY, size, size);
    ellipse(0,0,50,50);
  }
}
