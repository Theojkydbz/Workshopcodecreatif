class Tweetos  {
  String name, msg;
  float kcal, postxt;
  
  Tweetos(String _name, String _msg, float energie, float posy){
    this.name = _name;
    this.msg = _msg;
    this.kcal = energie;
    this.postxt = posy ;
  }
  
  void update(int i){
    postxt -= 50;
    if (postxt < 30) tweets.remove(i);
  }
  
  void display(){
    pushStyle();
    fill(0);
    rect(40,0,320, ( height / 2 ) + 50) ;
    popStyle();
    text(name, 50, postxt);
    text(msg, 50, postxt + 30, 300, height/2); 
   // println("texte affiché");
  }
}
