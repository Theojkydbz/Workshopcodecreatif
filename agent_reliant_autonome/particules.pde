class Particle {
  PVector location, vitesse, acceleration;
  float xT, yT;
  float[] xoff = new float[n];
  float[] yoff = new float[n];


  Particle(int x, int y) {
    // particle class should have location, vitesse, acceleration, friction, and attraction
    // particles should be attracted to mouse
    location = new PVector(x, y);
    vitesse = new PVector(0, 0);
    acceleration = new PVector(0, 0);
  }

  PVector calculAttraction() {
    //  fill(255,0,0);
    //  ellipse(target.x,target.y,5,5);
    // println("target :",target.x, "  ",target.y);
    // println("location :", location.x,"  ",location.y);
    PVector attraction = PVector.sub(target, location); //make vector pointing towards mouse
    float distance = attraction.mag(); //distance between particle and mouse
    float m = (1000)/(distance * distance); //formule de gravité pour calculer la force = l'accélération
    attraction.normalize(); //distance vecteur = 1
    attraction.mult(m);
    return attraction;
  }

  PVector calculFriction() {
    PVector friction = vitesse.get();
    friction.normalize();
    friction.mult(-1); //produit scalaire
    friction.mult(0.4);
    return friction;
  }

  void stayHereBro() {
    //ensure that the particles remain on screen
    if (location.x > width || location.x < 0) {
      vitesse.x = -vitesse.x;
      //println("sortie X");
    }
    if (location.y > height || location.y < 0) {
      vitesse.y = -vitesse.y;
      //   println("sortie Y");
    }
    
    //dégagez ! c'est le blackhole ici !
    float  trou = dist(width/2, height/2, location.x, location.y);    
    if (trou < 300) {
      vitesse.x = - vitesse.x ; 
      vitesse.y = - vitesse.y;
    }
  }

  void update() {  
    //set new noise value
    for (int i =0; i <particules.length; i ++) {
      xoff[i] += random(0.08);
      yoff[i] += random(0.01);
      //  float bou = map (noise(xoff[i],i*5,50), 0, 1, 0, width/2);
      //  float lou =  map (noise(yoff[i],i*23,15), 0, 1, -5, 5);
      // println(bou,"  ",lou);
      // xT = location.x + bou ;
      // yT = location.y + lou ;
      xT = noise (xoff[i]) * width ;
      yT = noise (yoff[i]) * height ;
      target = new PVector(xT, yT);
    }

    //test en attendant : lorsqu'un nouvel objet apprait, diriger les points vers le centre
    if (ok == true) {
      target = new PVector(width/2, height/2);
      xT = target.x; //update new values of my points
      yT = target.y;
      fill(255, 2, 2);
    } 

    PVector attraction = calculAttraction();
    PVector friction = calculFriction();
    //float distance = PVector.dist(location, mouse);


    acceleration.add(attraction);
    acceleration.add(friction); //ici le vecteur accélération est calculé
    vitesse.add(acceleration); //la vitesse = dérivée de l'accélération
    vitesse.limit(5); //vitesse max
    if (ok == false) stayHereBro();
    location.add(vitesse); // vecteur position = dérivée de la vitesse
    acceleration.mult(0); //clear acceleration each frame
  }

  void display() {
    noFill();
    ellipse(location.x, location.y, 5, 5);
    ellipse(width/2,height/2,300,300);
  }
}


/*
  for(int i = y.length-1 ; i > 0 ; i-- ){
 x[i] = x[i-1];
 y[i] = y[i-1];
 }
 x[0]= noise(xoff) * width;
 y[0]= noise(yoff) * height;
 
 fill(0);
 ellipse(x[0],y[0],1,1);
 
 for(int i=1; i<1000; i++){
 //Distance 
 float d = dist(x[0],y[0], x[i], y[i]);
 //Probabilité de rencontre
 float p = random(20);
 if(d <= 20 && p<1){
 line(x[0], y[0],x[i - 1], y[i - 1]);
 }
 }
 }*/
