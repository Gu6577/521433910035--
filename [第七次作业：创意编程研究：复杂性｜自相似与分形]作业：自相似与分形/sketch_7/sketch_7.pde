float radL ;
float radR ;
float scaleL = 0.87;
float scaleR = 0.85;
float sheetaL=0;
float sheetaR=0;
int aA=0;
int aB;
float aX;
void setup() {
  size(1000, 540);
  background(255);
}

void mouseClicked(){
  aA=1;
  aX=mouseX;
  aB=int(map(mouseY,height,0,4,14));
}

void draw() {
  if ( aA==1) {
    background(255);
    translate(aX, height+80);
    growTree(aB);//SHU ZI SHI GAI BIAN SHENG ZHANG CI SHU

    radL = map(cos(radians(sheetaL)), -1, 1, radians(12), radians(26));
    scaleL=map(sin(radians(sheetaL)), -1, 1, 0.78, 0.88);
    radR = map(sin(radians(sheetaR)), -1, 1, radians(10), radians(28));
    //  scaleR=map(cos(radians(sheetaR)), -1, 1, 0.78, 0.88);
    sheetaL+=1.3;
    if (sheetaL>=360)sheetaL=0;
    sheetaR+=1.2;
    if (sheetaL>=360)sheetaL=0;
  }
}

void growTree(int level) {
  if (level>0) {
    strokeWeight(level+2);
    if (level>2) {
      stroke(#130c0e);
    } else {
      stroke(#7fb80e);
    }
    line(0, 0, 0, -100);
    translate(0, -100);
    pushMatrix();
    rotate(radL);
    scale(scaleL);
    growTree(level-1);
    popMatrix();

    pushMatrix();
    rotate(-radR);
    scale(scaleR);
    growTree(level-1);
    popMatrix();
  }
}
