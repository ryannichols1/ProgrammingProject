void drawInfo(){
  background(255);
  
  fill(0);
  textSize(30);
  text("Flight Data", width/2 - 10, 30);
  
  // column headers
  textSize(11);
  fill(80);
  int y = 55;
  text("Date", 170, y);
  text("Airline", 300, y);
  text("Flight#", 360, y);
  text("From", 460, y);
  text("To", 700, y);
  text("Distance", 940, y);
  text("Status", 1100, y);
  
  // draw each row
  for (int i = 0; i < flights.size(); i++) {
    int rowY = y + 30 + i * 20;
    if (rowY > height - 10) break;
    
    DataPoint f = flights.get(i);
    fill(0);
    textSize(13);
    text(f.flightDate, 170, rowY);
    text(f.airline, 300, rowY);
    text(str(f.flightNumber), 360, rowY);
    text(f.origin, 460, rowY);
    text(f.dest, 700, rowY);
    text(nf(f.distance, 0, 0), 940, rowY);
    
    if (f.cancelled == 1) {
      fill(255, 0, 0);
      text("Cancelled", 1100, rowY);
    } else {
      fill(0, 150, 0);
      text("OK", 1100, rowY);
    }
  }
}


