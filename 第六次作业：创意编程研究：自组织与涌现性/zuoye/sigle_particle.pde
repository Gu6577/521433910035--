class Particle{
  PVector exy,espeed,espeedadd;
  float elife;
  
  Particle(PVector lxy){
    exy=lxy.get();
    espeedadd=new PVector(0,0.05);
    espeed=new PVector(random(-1,1),random(-2,0));
    elife=250;
  }
  boolean isDead(){
    if(elife<0.0){
      return true;
    }else{
      return false;
    }
  }
  
  void update(){
    espeed.add(espeedadd);
    exy.add(espeed);
    elife-=2.0;
  }
  void display(){
    noStroke();
    fill(#FF5A70,elife);
    ellipse(exy.x,exy.y,8,8);
  }
}
    
