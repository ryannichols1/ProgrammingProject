int currentScreen = 0;
ArrayList<DataPoint> flights;
DelayBarChart delayChart;
PopularDestinations popularDestinations;
DepartingFlights departingFlightsChart;
FlightsByTimeOfDay timeOfDayChart;
flightsByDate flightsByDate;
String[] pageNames = {"Home", "Info", "DelayChart", "Departures", "Destinations", "Time of Day", "Flights by Day"};
int sideBarW = 160;
PImage planeImg;

// Flight dots
float[][] flightPaths = new float[5][4];
float[] flightT = new float[5];

ArrayList<DataPoint> currentData;
String currentQuery = "All Flights";
SearchBox searchBox;

<<<<<<< Updated upstream
=======
boolean twoK = true;
>>>>>>> Stashed changes
void setup() {
  size(1200, 700);
  planeImg = loadImage("Airplanes.png");
  planeImg.resize(40, 40);
  flights = new ArrayList<DataPoint>();
  loadData("flights2k(1) (1).csv");
<<<<<<< Updated upstream
  searchBox = new SearchBox(width/2 - 150, height - 60, 300, 30);
=======
  
  // loadData("flights10k(1) (1).csv");
  // loadData("flights100k(1) (1).csv");
  // loadData("flights_full (1).csv");
  
  searchBox = new SearchBox(10, height - 80, sideBarW - 20, 28);
  
>>>>>>> Stashed changes
  currentData = flights;
  delayChart = new DelayBarChart(currentData);
  departingFlightsChart = new DepartingFlights(currentData);
  popularDestinations = new PopularDestinations(currentData);
  timeOfDayChart = new FlightsByTimeOfDay(currentData);
  flightsByDate = new flightsByDate(currentData);
  setUpFlights();
}

void rebuildCharts() {
  delayChart = new DelayBarChart(currentData);
  departingFlightsChart = new DepartingFlights(currentData);
  popularDestinations = new PopularDestinations(currentData);
  timeOfDayChart = new FlightsByTimeOfDay(currentData);
  flightsByDate = new flightsByDate(currentData);
}

void draw() {
  if (currentScreen == 0) {
    drawHomeScreen();
    drawButtonHomePage();
  } else if (currentScreen == 1) {
    drawInfo();
  } else if (currentScreen == 2) {
    delayChart.draw();
  } else if (currentScreen == 3) {
    departingFlightsChart.draw();
  } else if (currentScreen == 4) {
    popularDestinations.draw();
  } else if (currentScreen == 5) {
    timeOfDayChart.draw();
  } else if (currentScreen == 6) {
    flightsByDate.draw();
  }
  drawSidebar();
  drawSearchBar();
}

void drawHomeScreen() {
  background(5, 15, 40);
  fill(0, 220, 220, 50);
  noStroke();
  randomSeed(42);
  for (int i = 0; i < 40; i++) {
    ellipse(random(sideBarW + 30, width - 30), random(30, height - 30), 4, 4);
  }
  randomSeed((int) random(10000));
  for (int i = 0; i < 5; i++) {
    float sx = flightPaths[i][0];
    float sy = flightPaths[i][1];
    float ex = flightPaths[i][2];
    float ey = flightPaths[i][3];
    stroke(0, 220, 220, 30);
    line(sx, sy, ex, ey);
    float t = flightT[i];
    imageMode(CENTER);
    tint(0, 220, 220);
    image(planeImg, lerp(sx, ex, t), lerp(sy, ey, t));
    noTint();
    flightT[i] += 0.003;
    if (flightT[i] > 1) {
      flightT[i] = 0;
    }
    noStroke();
    fill(0, 180, 220);
    rect(0, 0, width, 4);
    fill(255);
    textAlign(CENTER, CENTER);
    textSize(42);
    text("Welcome to Flight Tracker", width/2, height/2 - 80);
    fill(140, 170, 200);
    textSize(15);
    text("International Commercial Flight Data", width/2, height/2 - 30);
  }
}

void mousePressed() {
  if(currentScreen == 0){
    if(mouseX > width/2 - 115 && mouseX < width/2 - 115 + 100 && mouseY > height/2 + 250 && mouseY < height/2 + 250 + 40){
       flights.clear();
      loadData("flights2k(1) (1).csv");
       currentData = flights;
       rebuildCharts();
       twoK = true;
      } else if(mouseX > width/2 - 5 && mouseX < width/2 - 5 + 100 && mouseY > height/2 + 250 && mouseY < height/2 + 250 + 40){
        flights.clear();
        loadData("flights10k(1) (1).csv");
        currentData = flights;
        rebuildCharts();
        twoK = false;
  
      }
    }
  
  searchBox.mousePressed();
  if (mouseX < sideBarW) {
    for (int i = 0; i < pageNames.length; i++) {
      float y = 100 + i * 50;
      if (mouseY > y - 15 && mouseY < y + 15) {
        currentScreen = i;
      }
    }
  }
}

void keyPressed() {
  if (searchBox.active) {
    searchBox.keyPressed();
    if (keyCode == ENTER) {
      runSearch(searchBox.text.trim());
    }
    if (key == ESC) key = 0;
    return;
  }
  if (key == ESC) {
    key = 0;
    currentScreen = 0;
  }
  if (key == '0') {
    currentData = flights;
    currentQuery = "All Flights";
    rebuildCharts();
  }
}

void runSearch(String input) {
  if (input.length() == 0) {
    currentData = flights;
    currentQuery = "All Flights";
    rebuildCharts();
    return;
  }
  if (input.contains("/")) {
    String[] parts = input.split("-");
    if (parts.length == 2) {
      String startDate = parts[0].trim();
      String endDate   = parts[1].trim();
      currentData = queryByDateRange(startDate, endDate, flights);
      currentQuery = "Dates: " + startDate + " to " + endDate;
    } else {
      currentQuery = "Bad date format. Use MM/DD/YYYY-MM/DD/YYYY";
      currentData = flights;
    }
    if (currentData.size() == 0) {
      currentQuery = "No flights in that range";
      currentData = flights;
    }
    rebuildCharts();
    return;
  }
  String upper = input.toUpperCase();
  if (upper.length() == 3) {
    currentData = queryByAirport(upper, flights);
    currentQuery = "Airport: " + upper;
  } else if (upper.length() == 2) {
    currentData = queryByAirline(upper, flights);
    currentQuery = "Airline: " + upper;
  } else {
    currentData = queryByAirport(upper, flights);
    currentQuery = "Search: " + upper;
  }
  if (currentData.size() == 0) {
    currentQuery = "No results for: " + input;
    currentData = flights;
  }
  rebuildCharts();
}

void drawButton(String label, float x, float y, float w, float h) {
  boolean hovering = mouseX > x && mouseX < x + w && mouseY > y && mouseY < y + h;
  if (hovering) {
    fill(0, 100, 200);
  } else {
    fill(0, 180, 220);
  }
  noStroke();
  rect(x, y, w, h, 8);
  fill(255);
  textAlign(CENTER, CENTER);
  textSize(16);
  text(label, x + w / 2, y + h / 2);
}
void drawButtonHomePage(){
    text("Choose Dataset:", width/2-20, height/2 +230);
    if(twoK){
      text("2K", width/2+45, height/2 + 230);
    }
    else{
      text("10K", width/2+45, height/2 + 230);
    }
    drawButton("2k", width/2 - 115, height/2 + 250, 100, 40);
    drawButton("10k", width/2 - 5, height/2 + 250, 100, 40);

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

void setUpFlights() {
  for (int i = 0; i < 5; i++) {
    flightPaths[i][0] = random(200, width * 0.4);
    flightPaths[i][1] = random(120, height - 120);
    flightPaths[i][2] = random(width * 0.6, width - 50);
    flightPaths[i][3] = random(120, height - 120);
    flightT[i] = random(1);
  }
}

void drawSidebar() {
  noStroke();
  fill(10, 15, 30);
  rect(0, 0, sideBarW, height);
  for (int i = 0; i < pageNames.length; i++) {
    float y = 100 + i * 50;
    if (i == currentScreen) fill(0, 220, 220);
    else fill(120);
    textAlign(LEFT, CENTER);
    textSize(15);
    text(pageNames[i], 20, y);
  }
}

void drawSearchBar() {
  fill(180);
  noStroke();
  textAlign(CENTER, CENTER);
  textSize(10);
  text("Search by Airline or Airport or Date Range", width/2, height - 75);
  searchBox.display();
}