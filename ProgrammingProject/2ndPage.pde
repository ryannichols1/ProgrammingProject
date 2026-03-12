currentScreen = 1;

void drawInfo(){
  background(255);
  
  fill(0);
  textSize(18);
  text("Flight Data", 20, 30);
  
  // column headers
  textSize(11);
  fill(80);
  int y = 55;
  text("Date", 20, y);
  text("Airline", 110, y);
  text("Flight#", 170, y);
  text("From", 230, y);
  text("To", 350, y);
  text("Distance", 470, y);
  text("Status", 550, y);
  
  // draw each row
  for (int i = 0; i < flights.size(); i++) {
    int rowY = y + 20 + i * 16;
    if (rowY > height - 10) break;
    
    DataPoint f = flights.get(i);
    fill(0);
    text(f.flightDate, 20, rowY);
    text(f.airline, 110, rowY);
    text(str(f.flightNumber), 170, rowY);
    text(f.origin, 230, rowY);
    text(f.dest, 350, rowY);
    text(nf(f.distance, 0, 0), 470, rowY);
    
    if (f.cancelled == 1) {
      fill(255, 0, 0);
      text("Cancelled", 550, rowY);
    } else {
      fill(0, 150, 0);
      text("OK", 550, rowY);
    }
  }
}


