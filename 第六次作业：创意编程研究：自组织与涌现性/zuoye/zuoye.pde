import java.util.Iterator;
ArrayList<ParticleSystem>systems;

void setup(){
  size(1000,1000);
 systems=new ArrayList<ParticleSystem>();
 
}
void draw(){
  background(#C2F0E6);
 for(ParticleSystem ps:systems){
   ps.run();
   ps.addParticle();
 }
}
void mousePressed(){
  systems.add(new ParticleSystem(new PVector(mouseX,mouseY)));
}





  
 
