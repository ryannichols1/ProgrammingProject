int currentScreen = 0;
ArrayList<DataPoint> flights;
DelayBarChart delayChart;
PopularDestinations popularDestinations;
DepartingFlights departingFlightsChart;
FlightsByTimeOfDay timeOfDayChart;
flightsByDate flightsByDate;
String[] pageNames = {"Home", "Info", "DelayChart", "Departures", "Destinations", "Time of Day", "Flights by Date"};
int sideBarW = 160;
PImage planeImg;

// Flight dots
float[][] flightPaths = new float[5][4]; // Where each flight goes, start and end point
float[] flightT = new float[5];


ArrayList<DataPoint> currentData;
String currentQuery = "All Flights";
SearchBox searchBox;


void setup() {
  size(1200, 700);

  planeImg = loadImage("Airplanes.png");
  planeImg.resize(40, 40);

  flights = new ArrayList<DataPoint>();
  loadData("flights2k(1) (1).csv");

  searchBox = new SearchBox(10, height - 80, sideBarW - 20, 28);
  
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
}

void drawHomeScreen() {
  background(5, 15, 40);

  // city dots
  fill(0, 220, 220, 50);
  noStroke();
  randomSeed(42); //  every frame gets the exact same "random" numbers, so the dots stay still.
  for (int i = 0; i < 40; i++) {
    ellipse(random(sideBarW + 30, width - 30), random(30, height - 30), 4, 4);
  }
  randomSeed((int) random(10000));

  // flight arcs
  for (int i = 0; i < 5; i++) {
    float sx = flightPaths[i][0]; // Start of x flight
    float sy = flightPaths[i][1]; // Start of y flight
    float ex = flightPaths[i][2]; // end of x flight
    float ey = flightPaths[i][3]; // end  of y flight

    stroke(0, 220, 220, 30);
    line(sx, sy, ex, ey); // the line of the full path the circle is moving


    float t = flightT[i];
    imageMode(CENTER);
    tint(0, 220, 220);
    image(planeImg, lerp(sx, ex, t), lerp(sy, ey, t));
    noTint();





    // lerp(start, end, t) = Linear Interpolation
    // It returns a value between start and end based on t.
    // Example: lerp(100, 500, 0.0) = 100  (at the start)
    //          lerp(100, 500, 0.5) = 300  (halfway

    flightT[i] += 0.003; // moves the dot based on the percentage of t in the lerp function
    if (flightT[i] > 1) {
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
  }
}


void mousePressed() {
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
// void runSearch(String input) {
//   if (input.length() == 0) {
//     currentData = flights;
//     currentQuery = "All Flights";
//     rebuildCharts();
//     return;
//   }

//   String upper = input.toUpperCase();

//   if (upper.length() == 3) {
//     currentData = queryByAirport(upper, flights);
//     currentQuery = "Airport: " + upper;
//   } else if (upper.length() == 2) {
//     currentData = queryByAirline(upper, flights);
//     currentQuery = "Airline: " + upper;
//   } else {
//     currentData = queryByAirport(upper, flights);
//     currentQuery = "Search: " + upper;
//   }

//   if (currentData.size() == 0) {
//     currentQuery = "No results for: " + input;
//     currentData = flights;
//   }

//   rebuildCharts();
// }

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
    flightPaths[i][2] = random(width * 0.6, width - 50 );
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
  searchBox.display();
  fill(0, 220, 220);
  textAlign(LEFT, BOTTOM);
  textSize(10);
  text("Filter: " + currentQuery, 10, height - 100);
  text("Press 0 to reset", 10, height - 88);
}
