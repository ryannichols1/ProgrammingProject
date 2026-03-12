int currentScreen = 0;

void setup() {
  size(1200, 700);
}

void draw() {
  if (currentScreen == 0) {
    drawHomeScreen();
  } else {
    drawNextScreen();
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
  textAlign(CENTER, CENTER);
  textSize(42);
  text("Welcome to Flight Tracker", width/2, height/2 - 80);

  // subtitle
  fill(140, 170, 200);
  textSize(15);
  text("International Commercial Flight Data", width/2, height/2 - 30);

  // button
  float btnW = 220;
  float btnH = 55;
  float btnX = width/2 - btnW/2;
  float btnY = height/2 + 40;

  boolean hovering = mouseX > btnX && mouseX < btnX + btnW 
                  && mouseY > btnY && mouseY < btnY + btnH;

  fill(hovering ? color(0, 100, 200) : color(0, 180, 220));
  rect(btnX, btnY, btnW, btnH, 8);

  fill(255);
  textSize(18);
  text("Enter", width/2, btnY + btnH/2);

  cursor(hovering ? HAND : ARROW);
}

void drawNextScreen() {
  background(5, 15, 40);

  fill(255);
  textAlign(CENTER, CENTER);
  textSize(30);
  text("Next Page", width/2, height/2);

  fill(140, 170, 200);
  textSize(14);
  text("Press ESC to return home", width/2, height - 30);
}

void mousePressed() {
  if (currentScreen == 0) {
    float btnW = 220;
    float btnH = 55;
    float btnX = width/2 - btnW/2;
    float btnY = height/2 + 40;

    if (mouseX > btnX && mouseX < btnX + btnW 
     && mouseY > btnY && mouseY < btnY + btnH) {
      currentScreen = 1;
    }
  }
}

void keyPressed() {
  if (key == ESC) {
    key = 0;
    currentScreen = 0;
  }
}