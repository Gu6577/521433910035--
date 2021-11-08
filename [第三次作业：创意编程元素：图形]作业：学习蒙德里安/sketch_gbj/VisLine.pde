class VisLine extends Line {
  float w;
  color c;

  VisLine(Point p1, Point p2, float w, color c) {
    super(p1, p2);
    this.w=w;
    this.c=c;
  }

  VisLine(Point p1, Point p2) {  //初始化宽度和颜色
    super(p1, p2);
    this.w=1;
    this.c=color(0);
  }

  void setWeight(float w) {  //设置宽度
    this.w=w;
  }

  void setColor(color c) {  //设置颜色
    this.c=c;
  }
  void display() {
    stroke(c);
    strokeWeight(w);
    line(p1.x, p1.y, p2.x, p2.y);
  }
}
