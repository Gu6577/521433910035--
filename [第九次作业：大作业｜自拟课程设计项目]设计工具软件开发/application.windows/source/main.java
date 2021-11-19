/* autogenerated by Processing revision 1277 on 2021-11-18 */
import processing.core.*;
import processing.data.*;
import processing.event.*;
import processing.opengl.*;

import controlP5.*;

import java.util.HashMap;
import java.util.ArrayList;
import java.io.File;
import java.io.BufferedReader;
import java.io.PrintWriter;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.IOException;

public class main extends PApplet {



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

 public void setup(){
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

 public void draw(){
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

 public void gui(){
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
    .setValue(1.1f)
    .moveTo(g1)
    .setFont(pfont)
    ;
  cp5.addSlider("Width Variance")
    .setPosition(gap2X, gap2Y*5)
    .setSize(gap1X-4*gap2X, gap2Y)
    .setRange(1, 2.5f)
    .setValue(1.25f)
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
    .setPosition(gap2X, gap2Y*11.5f)
    .setSize(gap2Y*3, gap2Y)
    .moveTo(g1)
    .setValue(false)
    .setFont(pfont)
    .setMode(ControlP5.SWITCH)
    .moveTo(g1)
    ;
}

 public void keyPressed(){
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

 public boolean out_of_range(float x, float y){
  //return (x<=0||y<=0||x>img.width||y>img.height);
  return (x<0||y<0||x>=img.width||y>=img.height);
}

 public void Clear(){
  buffer = createGraphics(displayWidth, displayHeight);
  buffer.beginDraw();
  buffer.background(255);
  buffer.noStroke();
  buffer.endDraw();
}

 public void mousePressed(){
  if (settings) return;
  if (img==null){
    selectInput("Select an image to process:", "selectImage");
    return;
  }
  balls.add(new Ball(img.width/2, img.height, mouseX, mouseY, ballWidth, Acc*10, ++BallNum, Split?1:0));
}

 public void mouseDragged(){
  if (img==null) return;
  if (settings) return;
  if (++cnt%10!=0) return;
  balls.add(new Ball(img.width/2, img.height, mouseX, mouseY, ballWidth, Acc*10, ++BallNum, Split?1:0));
}

 public void selectImage(File selection){
  if (selection==null) return;
  else
    img = loadImage(selection.getAbsolutePath());
}

public void Export(){
  selectOutput("Select a path to save in:", "saveImage");
}

 public void saveImage(File selection){
  if (selection==null) return;
  saveFrame(selection.getAbsolutePath());
}
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
  
   public void move(float interval){
    float dx = destx-x, dy = desty-y;
    float distance = sqrt(dx*dx+dy*dy);
    float v=sqrt(2*distance*a);
    float angle = atan2(dy, dx);
    x += v*cos(angle)*interval*0.01f;
    y += v*sin(angle)*interval*0.01f;
  }
  
   public void split(){
    BallNum--;
    if (life==0) return;
    for (int i=1; i<=min(maxBallNum-BallNum, 8); ++i){
      float dis=W*0.8f*random(1/SVariance, SVariance);
      float alpha=random(-pi, pi);
      float newx=x+cos(alpha)*dis;
      float newy=y+sin(alpha)*dis;
      if (out_of_range(newx, newy)) continue;
      balls.add(new Ball(x, y, newx, newy, W/random(SRatio/DVariance,SRatio*DVariance), Acc, balls.size()+1, 0));
      BallNum++;
    }
  }
  
   public boolean finished(){
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
      buffer.fill(img.get(PApplet.parseInt(destx), PApplet.parseInt(desty)), 128);
      buffer.ellipse(x, y, W, W);
      buffer.endDraw();
    }
    return finish;
  }
  
   public void display(){
    float dx = destx-x, dy = desty-y;
    if (_dx*dx<=0&&_dy*dy<=0){ x=destx; y=desty; }
    if (out_of_range(destx, desty)) return;
    fill(img.get(PApplet.parseInt(destx), PApplet.parseInt(desty)), 128);
    ellipse(x, y, W, W);
  }
}


  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "main" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
