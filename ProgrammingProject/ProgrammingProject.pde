ArrayList<DataPoint> flights;
int currentScreen = 0; // 0 = home/table view

void setup() {
  size(1200, 800);
  flights = new ArrayList<DataPoint>();
  loadData("flights2k(1) (1).csv");
  println("Loaded " + flights.size() + " flights.");
}

void draw() {
  background(30);
  
  // Title
  fill(255);
  textSize(24);
  textAlign(LEFT, TOP);
  text("Flight Data Explorer", 20, 15);
  
  // Display flight table
  textSize(12);
  fill(200);
  
  // Column headers
  int y = 60;
  text("Date", 20, y);
  text("Airline", 120, y);
  text("Flight#", 180, y);
  text("Origin", 250, y);
  text("Origin City", 330, y);
  text("Dest", 520, y);
  text("Dest City", 600, y);
  text("Distance", 790, y);
  text("Dep Time", 870, y);
  text("Status", 950, y);
  
  stroke(100);
  line(20, y + 18, width - 20, y + 18);
  
  // Show first ~40 rows that fit on screen
  int rowsToShow = min(flights.size(), 40);
  for (int i = 0; i < rowsToShow; i++) {
    DataPoint f = flights.get(i);
    int rowY = y + 25 + i * 17;
    
    if (rowY > height - 20) break;
    
    fill(f.cancelled == 1 ? color(255, 100, 100) : color(220));
    text(f.flightDate, 20, rowY);
    text(f.airline, 120, rowY);
    text(str(f.flightNumber), 180, rowY);
    text(f.origin, 250, rowY);
    text(f.originCity, 330, rowY);
    text(f.dest, 520, rowY);
    text(f.destCity, 600, rowY);
    text(nf(f.distance, 0, 1), 790, rowY);
    text(f.crsDepTime, 870, rowY);
    text(f.cancelled == 1 ? "CANCELLED" : "OK", 950, rowY);
  }
  
  // Footer info
  fill(150);
  textSize(11);
  text("Showing " + min(rowsToShow, 40) + " of " + flights.size() + " flights", 20, height - 15);
}

void loadData(String filename) {
  String[] lines = loadStrings(filename);
  if (lines == null) {
    println("ERROR: Could not load " + filename);
    return;
  }
  
  // Skip header row (line 0)
  for (int i = 1; i < lines.length; i++) {
    String line = lines[i].trim();
    if (line.length() == 0) continue;
    
    String[] cols = split(line, ',');
    
    // Defensive: skip rows with too few columns
    if (cols.length < 17) continue;
    
    DataPoint dp = new DataPoint(cols);
    flights.add(dp);
  }
}

void keyPressed() {
  // Placeholder for future query switching
  if (key == '1') {
    println("Query 1 selected - flights by airport (TODO)");
  }
  if (key == '2') {
    println("Query 2 selected - flights by date range (TODO)");
  }
  if (key == '3') {
    println("Query 3 selected - sorted by lateness (TODO)");
  }
}

