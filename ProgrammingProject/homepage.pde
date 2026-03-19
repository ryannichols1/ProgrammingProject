int currentScreen = 0;
ArrayList<DataPoint> flights;
DelayBarChart delayChart;

void setup() {
  size(1200, 700);
  flights = new ArrayList<DataPoint>();
  loadData("flights2k(1) (1).csv");
  delayChart = new DelayBarChart(flights);
}

void draw() {
  if (currentScreen == 0) {
    drawHomeScreen();
  } else if(currentScreen == 1){
    drawInfo();
  }
   else if (currentScreen == 2) {
    delayChart.draw();
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
    if (mouseX > width - 250 && mouseX < width - 30 
   && mouseY > height - 60 && mouseY < height - 15) {
    currentScreen++;
  }
}

void keyPressed() {
  if (key == ESC) {
    key = 0;
    currentScreen = 0;
  }
}


void drawButton(String label, float x, float y, float w, float h) {
  boolean hovering = mouseX > x && mouseX < x + w && mouseY > y && mouseY < y + h;
  if (hovering) {
    fill(0, 100, 200);
  } else {
    fill(0, 180, 220);
  }  noStroke();
  rect(x, y, w, h, 8);
  fill(255);
  textAlign(CENTER, CENTER);
  textSize(16);
  text(label, x + w / 2, y + h / 2);
}

void loadData(String filename) {
  String[] lines = loadStrings(filename);
  
  // start at 1 to skip header
  for (int i = 1; i < lines.length; i++) {
    String[] cols = split(lines[i], ',');
    if (cols.length < 17) continue;
    
    DataPoint dp = new DataPoint(cols);
    flights.add(dp);
  }
}
