
class Particle {
  PVector location, vitesse, acceleration;
  float mass, size, seuil;  
  int dir;

  Particle(int x, int y, float _mass, float _size, float _seuil) {
    // particle class should have location, vitesse, acceleration, friction, and gravity
    // particles should be attracted to mouse
    location = new PVector(x, y);
    vitesse = new PVector(0, 0);
    acceleration = new PVector(0, 0);
    mass = _mass;
    size = _size;
    seuil = _seuil;

    //set rotation direction
    dir = (int(random(0, 2)) < 1) ? 1: -1;
  }

  void display() {
    ellipse(location.x, location.y, size*2, size*2);
  }

  PVector calculateFriction() {
    PVector friction = vitesse.get();
    friction.normalize();
    friction.mult(-1); //produit scalaire
    friction.mult(coefFriction);

    return friction;
  }

  PVector calculateGravity() {
    PVector gravity = PVector.sub(mouse, location); //make vector pointing towards mouse
    float distance = gravity.mag(); //distance between particle and mouse
    float mouseMass = 500.0; //arbitrary value
    float m = (9.81 * mouseMass * mass)/(distance * distance); //formule de gravité pour calculer la force = l'accélération
    gravity.normalize(); 
    gravity.mult(m);
    return gravity; //presque le vecteur vitesse
  }

  PVector calculateTangent(PVector gravity) {
    PVector tangent;

    if (dir == 1) {
      tangent =  new PVector(-gravity.y, gravity.x);
    } else {
      tangent =  new PVector(gravity.y, -gravity.x);
    }
    tangent.mult(gravity.mag()); //mag() = dist() = distance du vecteur
    return tangent;
  }

  void applyForce(PVector force) {
    PVector f = PVector.div(force, mass);
    acceleration.add(f); //update de l'accélération
  }

  void check() {
    //ensure that the particles remain on screen
    if (location.x > width || location.x < 0) {
      vitesse.x = -vitesse.x;
    }
    if (location.y > height || location.y < 0) {
      vitesse.y = -vitesse.y;
    }
  }

  void update() {  
    PVector gravity = calculateGravity();
    PVector friction = calculateFriction();
    //float distance = PVector.dist(location, mouse);

    //particles should be repelled on click
    if (mousePressed) {
      PVector antigrav = calculateGravity();
      antigrav.mult(-1.1);
      applyForce(antigrav);
    }

    applyForce(gravity);
    applyForce(friction); //ici le vecteur accélération est calculé

    if (PVector.dist(location, mouse) <= seuil) { //seuil de gravité
      PVector tangent = calculateTangent(gravity);
      applyForce(tangent);
    }

    vitesse.add(acceleration); //la vitesse = dérivée de l'accélération

    vitesse.limit(5); //vitesse max
    location.add(vitesse); // vecteur position = dérivée de la vitesse
    check();
    acceleration.mult(0); //clear acceleration each frame
  }
};
