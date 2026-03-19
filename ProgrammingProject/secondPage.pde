void drawInfo(){
  background(255);
  
  fill(0);
  textSize(18);
  text("Flight Data", 60, 30);
  
  // column headers
  textSize(11);
  fill(80);
  int y = 55;
  text("Date", 60, y);
  text("Airline", 120, y);
  text("Flight#", 180, y);
  text("From", 230, y);
  text("To", 350, y);
  text("Distance", 470, y);
  text("Status", 550, y);
  
  // draw each row
  for (int i = 0; i < flights.size(); i++) {
    int rowY = y + 30 + i * 16;
    if (rowY > height - 10) break;
    
    DataPoint f = flights.get(i);
    fill(0);
    textSize(13);
    text(f.flightDate, 60, rowY);
    text(f.airline, 120, rowY);
    text(str(f.flightNumber), 180, rowY);
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
    drawButton("Next ", width - 250, height - 60, 220, 45);
  }
}


