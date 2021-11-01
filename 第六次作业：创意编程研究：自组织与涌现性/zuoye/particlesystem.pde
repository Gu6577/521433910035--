class ParticleSystem{
 ArrayList<Particle>plist;
 PVector psxy;
 
  ParticleSystem(PVector setxy){
    psxy=setxy.get();
    plist=new ArrayList<Particle>();
  }
  void addParticle(){
    plist.add(new Particle(psxy));
  }
  void run(){
   Iterator<Particle>it=plist.iterator();
   while(it.hasNext()){
     Particle p=it.next();
     p.update();
     p.display();
     if(p.isDead()){
       it.remove();
     }
   }
  }
}
