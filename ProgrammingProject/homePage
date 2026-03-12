int currentScreen = 0;

void setup() {
  size(1200, 800);
  flights = new ArrayList<DataPoint>();
  loadData("flights2k(1) (1).csv");
  println("Loaded " + flights.size() + " flights.");
}

void draw() {
  if (currentScreen == 0) {
    drawHomeScreen();
  } else if (currentScreen == 1) {
    drawInfo();
  }
}

void drawHomeScreen() {
  background(5, 15, 40);

  // top accent bar
  noStroke();
  fill(0, 180, 220);
  rect(0, 0, width, 4);

  // title
  fill(255);
  textAlign(CENTER,CENTER);
  textSize(30);
  text("Next Page", width/2, height/2);

  fill(140, 170, 200);
  textSize(14);
  text("Press ESC to return home", width/2, height - 30);
}

void mousePressed() {
  if (currentScreen == 0) {
    float btnW = 220;
    float btnH = 50;
    float btnX = width/2 - btnW/2;
    float btnY = height/2 + 40;

     if (mouseX > btnX && mouseX < btnX + btnW 
     && mouseY > btnY && mouseY < btnY + btnH) {
      currentScreen = 1;
    }
  }
}

void keyPressed(){
    if(key == ESC){
        key = 0;
        currentScreen = 0;
    }
}


