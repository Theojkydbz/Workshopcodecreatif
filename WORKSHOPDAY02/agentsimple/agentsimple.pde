float x;
  float y;
  float xoff = 0;
  float yoff = 0;
  
void setup(){
  size(500, 500);
  background(0);
  smooth();
  stroke(0, 64);
  
  
}

void draw(){
  xoff += random(-0.02,0.02);
  yoff += random(-0.02,0.02);
  ellipse(x,y,30,30);
  x=noise(xoff) * width;
  y=noise(yoff) * height;
}
