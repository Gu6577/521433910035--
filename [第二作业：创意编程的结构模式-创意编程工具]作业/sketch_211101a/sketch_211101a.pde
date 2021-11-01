import processing.pdf.*;



void setup() {
  String filename = this.getClass().getName();
  beginRecord(PDF, filename+".pdf");
  size(1000, 1000);
  ellipseMode(RADIUS);
  rectMode(CORNERS);
  background(255);
  stroke(0);
  noFill();
  translate(width/2,height/2);
  frameRate(3);
  render();
  endRecord();
}



void render() {
  
  //生成圆内的随机点
  Point[]points=new Point[180];

  for (int i=0; i<points.length; i++) {
    float rad=random(TAU);    //随机弧度
    float r=pow(random(1),0.4)*470;    //随机半径

    float x=cos(rad)*r;
    float y=sin(rad)*r;
    points[i]=new Point(x, y);
  }







  float maxDistance=300;//最大距离

  for (int i=9; i<points.length; i++) {
    Point a=points[i];
    for (int j=i+1; j<points.length; j++) {
      Point b=points[j];
      float d=a.distance(b);
      if (d<maxDistance) {
        float alpha=map(d, 0, maxDistance, 255, 0);
        //距离映射为线段不透明度
        float weight=map(d, 0, maxDistance, 2, 0);
        //距离映射为线段宽度
        stroke(random(255),random(255),random(255), alpha);
        strokeWeight(weight);
        line(a.x, a.y, b.x, b.y);
      }
    }
  }
}



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

  //距离公式
  float distance(Point p) {
    float dx=x-p.x;
    float dy =y-p.y;
    return sqrt(dx*dx+dy*dy);
  }
}

void draw(){
  translate(width/2,height/2);
  background(255);
  render();
}
