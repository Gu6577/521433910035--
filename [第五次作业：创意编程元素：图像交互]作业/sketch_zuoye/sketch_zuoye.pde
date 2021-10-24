int R, G, B;
PImage img;
float ss=200;
void setup() {
  size(800, 600);
  background(255);
  rectMode(CORNERS);
  noStroke();
  initiate();
  noFill();
  frameRate(24);
}

void initiate() {

  img=loadImage("rgb.jpg");
  image(img, 30, 0);
  fill(180);
  noStroke();
  rect(80, 560, 780, 580);
}


void mousePressed() {
  if (mouseButton==RIGHT) {
    int imgC = get(mouseX, mouseY);
    R = (imgC >> 16) & 0xFF;
    G = (imgC >> 8) & 0xFF;
    B = imgC & 0xFF;
    println("Current position color: Red = "+R+", Green = "+G+", Blue = "+B);
  }
}

void draw() {
  fill(180);
  rect(80, 560, 780, 580);
  noFill();

  image(img, 30, 0);
  stroke(R, G, B, 155);
  if (mousePressed & mouseX>60) {
    flower();
  }
}

void flower() {
  int petals = int(random(5, 10 ));
  float w = sin(frameCount) * ss;
  float h = cos(frameCount) * ss;

  translate(mouseX, mouseY);
  for (int i = 0; i < petals; i++) {
    rotate(radians(360 / petals));
    ellipse(0, 0, w, h);
  }
}

void keyPressed() {
  if (key=='r') background(255);
  if (key=='w') ss+=20;
  if (key=='s') ss-=20;
}
