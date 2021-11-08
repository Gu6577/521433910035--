PFont font;//字体
String s="31415926535897932384626433832795028841971693993751058209749445923078164062862089986280348253421170679";//关于文本的变量
char c;
float rad=0;
float xx=500;float yy=500;
int time=0;
VisLine[] lines;
void setup() {
  size(1000, 1000);
  background(255);
  font = createFont("Arial", 24);//字体
  //s=loadStrings("testTest.txt");
  stroke(0);
  strokeWeight(5);
  fill(0);
  frameRate(3);
  render();

}

void render(){

  //VisLine[] lines =new VisLine[s.length()];
  lines =new VisLine[s.length()];
  println(s.length());
  for(int i=0;i<lines.length;i++){
    Point p1=new Point(xx,yy);
    Point p2=new Point(xx,yy+50);
    lines[i]=new VisLine(p1,p2);
    doRad(i);
    //println(rad);
    lines[i].p2.rotate(lines[i].p1,rad);
    xx=lines[i].p2.x;
    yy=lines[i].p2.y;
    //lines[i].display();
}
  
  //for (VisLine line : lines) {
    //  line.display();
    //}
}


void play(){
  lines[time].display();
  if (time>=lines.length-1) noLoop();
  time=time+1;
  
}



void doRad(int i) {
  c=s.charAt(i);
  float cc=int(c)-48;
  rad=cc/10*TAU;
  println(cc);
  println(rad);
}



void draw() {
  play();
}
