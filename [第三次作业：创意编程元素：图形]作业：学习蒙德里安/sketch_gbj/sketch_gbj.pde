import processing.pdf.*;
void setup() {
  String filename = this.getClass().getName();
  beginRecord(PDF, filename+".pdf");
  size(1000, 1000);

  background(255);
  stroke(0);
  noFill();
  render();
  endRecord();
}




//自定义render函数
void render() {
  VisLine[] lines =new VisLine[80];

  for (int i=0; i<lines.length; i++) {
    float x=map(i, -1, lines.length, 0, width);//设置等间隔x坐标
    Point p1=new Point(x, random(height));
    Point p2=new Point(x, random(height));
    lines[i]=new VisLine(p1, p2);  //创建
    float alpha=map(lines[i].length(), 0, height, 0, 100);
    lines[i].setColor(color(0,alpha));
  }

  for (int time=0; time<150; time++) {
    for (VisLine line : lines) {
      
      
      line.p1.rotate(line.p2, 0.01);
      //第一个端点以第二端点旋转
      line.display();
    }
  }
}
