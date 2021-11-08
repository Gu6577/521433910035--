class Point {
  float x, y;

  Point(float x, float y) {
    this.x=x;
    this.y=y;
  }
  Point() {
    x=0;
    y=0;
  }
  Point copy() {
    return new Point(x, y);
  }



  void rotate(Point p,float q){
    float dx=x-p.x;
    float dy=y-p.y;
    x=p.x+cos(q)*dx-sin(q)*dy;
    y=p.y+sin(q)*dx+cos(q)*dy;
  }
  
  

  //距离公式
  float distance(Point p) {
    float dx=x-p.x;
    float dy =y-p.y;
    return sqrt(dx*dx+dy*dy);
  }
}
