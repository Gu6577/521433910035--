class Line {
  Point p1, p2;


  Line(Point p1, Point p2) {
    this.p1=p1;
    this.p2=p2;
  }

  float length() {  //返回线段长度
    return p1.distance(p2);
  }
}
