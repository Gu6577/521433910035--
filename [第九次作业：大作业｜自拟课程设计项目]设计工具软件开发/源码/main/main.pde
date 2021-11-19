import controlP5.*;

int maxBallNum = 400;

float pi=acos(-1);
ArrayList<Ball> balls;
float ballWidth = 100;
int Acc=10;
int lastRecordedTime = 0;
int BallNum=0;
boolean settings=true;
int cnt=0;
float SVariance=0;
float DVariance=0;
float SRatio=0;
boolean Split=true;
boolean RandomSpill=false;

PImage img=null;
PGraphics buffer;
boolean resized=false;

ControlP5 cp5;
Group g1;
Toggle tog;

void setup(){
  selectInput("Select an image to process:", "selectImage");
  noStroke();
  background(255);
  surface.setTitle("Balls and Pixels");
  surface.setResizable(true);
  buffer = createGraphics(displayWidth, displayHeight);
  buffer.beginDraw();
  buffer.background(255);
  buffer.noStroke();
  buffer.endDraw();
  balls = new ArrayList<Ball>();
}

void draw(){
  if (img==null) return;
  if (resized==false){
    resized=true;
    surface.setSize(img.width, img.height);
    surface.setResizable(false);
    gui();
  }
  ballWidth = cp5.getController("Ball Width").getValue();
  SVariance = cp5.getController("Split Variance").getValue();
  DVariance = cp5.getController("Width Variance").getValue();
  SRatio = cp5.getController("Split Ratio").getValue();
  int interval = millis()-lastRecordedTime;
  lastRecordedTime = millis();
  image(buffer, 0, 0);
  if (settings) return;
  if (RandomSpill){
      if (++cnt%4==0)
      balls.add(new Ball(img.width/2, img.height, random(0, width+10)-5, random(0, height+10)-5, ballWidth, Acc*10, ++BallNum, Split?1:0));
  }
  for (int i = balls.size()-1; i>=0; i--){
    Ball ball = balls.get(i);
    if (!ball.finished()){
      ball.move(interval);
      ball.display();
    } else {
      balls.remove(i);
    }
  }
}

void gui(){
  cp5 = new ControlP5(this);
  int anchorX=width/4, anchorY=height/4;
  int gap1X=width/2, gap1Y=height/2;
  int gap2X=gap1X/10, gap2Y=gap1Y/15;
  PFont pfont = createFont("Arial",20,true);
  g1 = cp5.addGroup("Settings")
    .setBackgroundColor(color(0, 64))
    .setPosition(anchorX, anchorY)
    .setSize(gap1X, gap1Y)
    .setFont(pfont)
    .setBarHeight(25)
    ;
  cp5.addSlider("Ball Width")
    .setPosition(gap2X, gap2Y)
    .setSize(gap1X-4*gap2X, gap2Y)
    .setRange(20, 200)
    .setValue(100)
    .moveTo(g1)
    .setFont(pfont)
    ;
  cp5.addSlider("Split Variance")
    .setPosition(gap2X, gap2Y*3)
    .setSize(gap1X-4*gap2X, gap2Y)
    .setRange(1, 2)
    .setValue(1.1)
    .moveTo(g1)
    .setFont(pfont)
    ;
  cp5.addSlider("Width Variance")
    .setPosition(gap2X, gap2Y*5)
    .setSize(gap1X-4*gap2X, gap2Y)
    .setRange(1, 2.5)
    .setValue(1.25)
    .moveTo(g1)
    .setFont(pfont)
    ;
  cp5.addSlider("Split Ratio")
    .setPosition(gap2X, gap2Y*7)
    .setSize(gap1X-4*gap2X, gap2Y)
    .setRange(1, 5)
    .setValue(2)
    .moveTo(g1)
    .setFont(pfont)
    ;
  cp5.addToggle("Split")
    .setPosition(gap2X, gap2Y*9)
    .setSize(gap2Y*3, gap2Y)
    .setValue(true)
    .setMode(ControlP5.SWITCH)
    .moveTo(g1)
    .setFont(pfont)
    ;
  cp5.addButton("Export")
    .setPosition(gap2X*3, gap2Y*9)
    .setSize(gap2Y*3, gap2Y)
    .moveTo(g1)
    .setFont(pfont)
    ;
  cp5.addButton("Clear")
    .setPosition(gap2X*5, gap2Y*9)
    .setSize(gap2Y*3, gap2Y)
    .moveTo(g1)
    .setFont(pfont)
    ;
  tog=cp5.addToggle("RandomSpill")
    .setPosition(gap2X, gap2Y*11.5)
    .setSize(gap2Y*3, gap2Y)
    .moveTo(g1)
    .setValue(false)
    .setFont(pfont)
    .setMode(ControlP5.SWITCH)
    .moveTo(g1)
    ;
}

void keyPressed(){
  if (key=='s'||key=='S'){
    Export();
  }
  if (key=='h'){
    settings = !settings;
    if (settings) g1.show();
    else g1.hide();
  }
  if (key=='c'){
    Clear();
  }
  if (key=='r'){
    RandomSpill = !RandomSpill;
    tog.setState(RandomSpill);
  }
}

boolean out_of_range(float x, float y){
  //return (x<=0||y<=0||x>img.width||y>img.height);
  return (x<0||y<0||x>=img.width||y>=img.height);
}

void Clear(){
  buffer = createGraphics(displayWidth, displayHeight);
  buffer.beginDraw();
  buffer.background(255);
  buffer.noStroke();
  buffer.endDraw();
}

void mousePressed(){
  if (settings) return;
  if (img==null){
    selectInput("Select an image to process:", "selectImage");
    return;
  }
  balls.add(new Ball(img.width/2, img.height, mouseX, mouseY, ballWidth, Acc*10, ++BallNum, Split?1:0));
}

void mouseDragged(){
  if (img==null) return;
  if (settings) return;
  if (++cnt%10!=0) return;
  balls.add(new Ball(img.width/2, img.height, mouseX, mouseY, ballWidth, Acc*10, ++BallNum, Split?1:0));
}

void selectImage(File selection){
  if (selection==null) return;
  else
    img = loadImage(selection.getAbsolutePath());
}

public void Export(){
  selectOutput("Select a path to save in:", "saveImage");
}

void saveImage(File selection){
  if (selection==null) return;
  saveFrame(selection.getAbsolutePath());
}
