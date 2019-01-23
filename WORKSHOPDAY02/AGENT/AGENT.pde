int n=10000;
float[] x = new float[n]; 
float[] y = new float[n]; 
float xoff=0;

void setup(){
  size(500, 500);
  background(255);
  smooth();
  stroke(0, 64);
}

void draw(){
  xoff +=0.01;
  pushMatrix();
  fill(255,20);
  rect(0,0,width,height);
  popMatrix();
  for(int i=y.length-1; i>0; i--){
    x[i] = x[i-1];
    y[i] = y[i-1];
  }
  x[1]= noise(xoff) * width;
  y[1]= noise(xoff) * height;

  line(x[1],x[1], x[0], y[0]);
  for(int i=1; i<1000; i++){
    //Distance 
    float d = dist(mouseX, mouseY, x[i], y[i]);
    //Probabilité de rencontre
    float p = random(10);
    if(d <= 30 && p<1){
      line(mouseX, mouseY, x[i], y[i]);
    }
  }
}
