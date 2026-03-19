int currentScreen = 0;
ArrayList<DataPoint> flights;
DelayBarChart delayChart;
PopularDestinations popularDestinations;
DepartingFlights departingFlightsChart;
FlightsByTimeOfDay timeOfDayChart;
flightsByDate flightsByDate;
String[] pageNames = {"Home", "Info", "DelayChart", "Departures", "Destinations", "Time of Day", "Flights by Date"}; 
int sideBarW = 160;

// Flight dots
float[][] flightPaths = new float[5][4]; // Where each flight goes, start and end point
float[] flightT = new float[5];





void setup() {
  size(1200, 700);
  flights = new ArrayList<DataPoint>();
  loadData("flights2k(1) (1).csv");
  delayChart = new DelayBarChart(flights);
  departingFlightsChart = new DepartingFlights(flights);
  popularDestinations = new PopularDestinations(flights);
  timeOfDayChart = new FlightsByTimeOfDay(flights);
  flightsByDate = new flightsByDate(flights);
  setUpFlights();
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
  else if (currentScreen == 3) {
  departingFlightsChart.draw();
  }
  else if (currentScreen == 4) {
  popularDestinations.draw();
  }
  else if (currentScreen == 5) {
    timeOfDayChart.draw();
  }
  else if (currentScreen == 6) {
    flightsByDate.draw();
  }
  drawSidebar();

}

void drawHomeScreen() {
  background(5, 15, 40);

  // city dots
  fill(0, 220, 220, 50);
  noStroke();
  randomSeed(42);
  for (int i = 0; i < 40; i++) {
    ellipse(random(sideBarW + 30, width - 30), random(30, height - 30), 4, 4);
  }
  randomSeed((int) random(10000));

  // flight arcs
  for (int i = 0; i < 5; i++) {
    float sx = flightPaths[i][0];
    float sy = flightPaths[i][1];
    float ex = flightPaths[i][2];
    float ey = flightPaths[i][3];

    stroke(0, 220, 220, 30);
    line(sx,sy,ex,ey);


    float t = flightT[i];
    noStroke();
    fill(0, 220, 220);
    ellipse(lerp(sx, ex, t), lerp(sy, ey, t), 8, 8);

    flightT[i] += 0.003;
    if (flightT[i] > 1){
      flightT[i] = 0;
    }
  


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

 

}}


void mousePressed() {
  if (mouseX < sideBarW) {
    for (int i = 0; i < pageNames.length; i++) {
      float y = 100 + i * 50;
    if (mouseY > y - 15 && mouseY < y + 15){
      currentScreen = i;
    }
  }
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
  
  for (int i = 1; i < lines.length; i++) {
    String[] cols = parseCSVLine(lines[i]);
    if (cols.length < 17) continue;
    DataPoint dp = new DataPoint(cols);
    flights.add(dp);
  }
}

String[] parseCSVLine(String line) {
  ArrayList<String> fields = new ArrayList<String>();
  boolean inQuotes = false;
  StringBuilder current = new StringBuilder();
  
  for (int i = 0; i < line.length(); i++) {
    char c = line.charAt(i);
    if (c == '"') {
      inQuotes = !inQuotes;
    } else if (c == ',' && !inQuotes) {
      fields.add(current.toString().trim());
      current = new StringBuilder();
    } else {
      current.append(c);
    }
  }
  fields.add(current.toString().trim());
  
  String[] result = new String[fields.size()];
  return fields.toArray(result);
}


void setUpFlights(){
  for(int i = 0; i < 5; i++){
    flightPaths[i][0] = random(200, width * 0.4);
    flightPaths[i][1] = random(120,height - 120);
    flightPaths[i][2] = random(width * 0.6,width - 50 );
    flightPaths[i][3] = random(120, height - 120);
    flightT[1] = random(1);
  }
}


void drawSidebar(){
  
  noStroke();
  fill(10, 15, 30);
  rect(0, 0, sideBarW, height);

  for(int i = 0; i < pageNames.length; i++){
    float y = 100 + i * 50;

    if (i == currentScreen) fill(0, 220, 220);
    else fill(120);

    textAlign(LEFT, CENTER);
    textSize(15);
    text(pageNames[i], 20, y);
  }



}