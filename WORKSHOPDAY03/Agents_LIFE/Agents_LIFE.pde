float lvl=700;
float data;
float recoltealaseconde;
void  setup(){
  size(150,700);
  recoltealaseconde=0.9; //de 0.1(vidéo gros codec de fou) a 0.5 =Survie
  //de a 0.6 a de a 0.9 = chute de l'empire
  lvl=300; // niveau de départ de la vie
}


void  draw(){
  background(39, 1, 89);
  fill(176, 159, 198);
  noStroke();
  
  data = random(0,1);
  
  life();
}
void  life(){
  //food
  if(data>recoltealaseconde&&lvl>0){
    lvl-=3;
  }
  //hunger
  if(frameCount%2==0&&lvl<700){
    lvl+=3;
  }
  rect(width*0.3,lvl,width*0.4,height);
  println(lvl);
}
  
  
