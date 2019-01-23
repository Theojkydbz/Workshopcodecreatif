float lvl=700;
float data;
float recoltealaseconde;


//::::::::::CARNIVORE::::::::::::\\
import java.util.Map;
import org.rsg.carnivore.*;
import org.rsg.lib.Log;

CarnivoreP5 c;
String testPrefix = "172";
int n = 0;
int oldNumber;
int codecnumber=0;
//int timer_check, t_stamp_check ; //vérification périodique des IP connectées
//int IpNumber ; // liste d'IP connectés refreshed ré"gulièrement

HashMap<String, Integer> hm = new HashMap<String, Integer>();
//HashMap<String, Integer> IpList = new HashMap<String, Integer>()


void  setup() {
  size(150, 700);
  recoltealaseconde=0.8; //de 0.1(vidéo gros codec de fou) a 0.5 = Survie
  //de a 0.6 a de a 0.9 = chute de l'empire
  lvl=300; // niveau de départ de la vie

  //::::::::::CARNIVORE::::::::::::\\
  Log.setDebug(true); // Uncomment for verbose mode
  c = new CarnivoreP5(this);
}


void  draw() {
  background(39, 1, 89);
  fill(176, 159, 198);
  noStroke();

  life();
}
void  life() {
  //food

  //hunger
  if (frameCount%2==0&&lvl<700) {
    lvl+=1;
  }
  rect(width*0.3, lvl, width*0.4, height);
  //println(lvl);
}

void keyPressed() {
  if (lvl > 0 ) lvl -= 10;
}


//::::::::::CARNIVORE_EVENT::::::::::::\\
void packetEvent(CarnivorePacket p) {
  //println("(" + p.strTransportProtocol + " packet) " + p.senderSocket() + " > " + p.receiverSocket());

  // timer_check = millis() + 30000; //toutes les 30sec

  String[] parts = p.senderSocket().split(":");
  String part1 = parts[0]; 
  String part2 = parts[1]; 
  //String[] parties = "Nom de la string qui contient tout"().split("==");
  String codec = p.ascii(); 
  codecnumber+=codec.length();
  println(codecnumber);


  hm.put(parts[0], 1); //tableau d'affichage
  //IpList.put(parts[0],1); // tableau de verification
  // IpNumber = IpList.size(); //nombre actuel d'appareils connectés 

  /*
  for (Map.Entry me : hm.entrySet()) {
   // println(p.senderSocket() +"=" + (String)tab.get(i));
   hm.put(p.senderSocket(), 1);
   }*/
  for (Map.Entry me : hm.entrySet()) {

    String value = me.getKey().toString();
    value.substring(0, 3);
    if (value.substring(0, 3).equals(testPrefix)) {
      n ++;
      //print(me.getKey() + " is " + me.getValue());
    }
  }
  if (oldNumber < n) {
    println("Nouvelle connexion !");
    oldNumber = n;
  }
  println("Appareils connectés : ", n);
  n = 0;
  println("hm.size = ", hm.size());

  /// println(tab);
  //println("Payload: " + p.ascii());
  //println("---------------------------\n");
}
