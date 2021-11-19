class Ball{
  float x, y;
  float vx, vy;
  float a;
  float destx;
  float desty;
  float speed;
  float W;
  float _dx, _dy;
  int id, life;
  boolean finish=false;
  
  Ball(float tempX, float tempY, float destX, float destY, float tempW, float tempA, int ID, int Life){
    x = tempX;
    y = tempY;
    destx=destX;
    desty=destY;
    W = tempW;
    a = tempA;
    id = ID;
    life=Life;
    _dx=destx-x;
    _dy=desty-y;
  }
  
  void move(float interval){
    float dx = destx-x, dy = desty-y;
    float distance = sqrt(dx*dx+dy*dy);
    float v=sqrt(2*distance*a);
    float angle = atan2(dy, dx);
    x += v*cos(angle)*interval*0.01;
    y += v*sin(angle)*interval*0.01;
  }
  
  void split(){
    BallNum--;
    if (life==0) return;
    for (int i=1; i<=min(maxBallNum-BallNum, 8); ++i){
      float dis=W*0.8*random(1/SVariance, SVariance);
      float alpha=random(-pi, pi);
      float newx=x+cos(alpha)*dis;
      float newy=y+sin(alpha)*dis;
      if (out_of_range(newx, newy)) continue;
      balls.add(new Ball(x, y, newx, newy, W/random(SRatio/DVariance,SRatio*DVariance), Acc, balls.size()+1, 0));
      BallNum++;
    }
  }
  
  boolean finished(){
    if (finish) return true;
    float dx = destx-x, dy = desty-y;
    if (_dx*dx<=0&&_dy*dy<=0){
      x = destx;
      y = desty;
      display();
      finish=true;
      split();
      if (out_of_range(x, y)) return true;
      buffer.beginDraw();
      buffer.fill(img.get(int(destx), int(desty)), 128);
      buffer.ellipse(x, y, W, W);
      buffer.endDraw();
    }
    return finish;
  }
  
  void display(){
    float dx = destx-x, dy = desty-y;
    if (_dx*dx<=0&&_dy*dy<=0){ x=destx; y=desty; }
    if (out_of_range(destx, desty)) return;
    fill(img.get(int(destx), int(desty)), 128);
    ellipse(x, y, W, W);
  }
}
