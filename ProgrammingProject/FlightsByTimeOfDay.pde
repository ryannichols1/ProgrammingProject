class FlightsByTimeOfDay {
  ArrayList<DataPoint> flights;

  FlightsByTimeOfDay(ArrayList<DataPoint> flights) {
    this.flights = flights;
  }

  void draw() {
    background(5, 15, 40);
    
    // Title
    fill(0, 180, 220);
    noStroke();
    rect(0, 0, width, 4);
    fill(255);
    textAlign(CENTER, TOP);
    textSize(22);
    text("Flights by Time of Day (24-Hour Clock)", width / 2, 20);

    // Key probs useless
    textSize(10);
    fill(255, 200, 0); 
    text("Key:\nYellow: Busiest Hour", CORNER + 50, CORNER + 15);

    // Count the data
    int[] hourlyCounts = new int[24];
    int maxCount = 0;

    for (int i = 0; i < flights.size(); i++) 
    {
      DataPoint dp = flights.get(i);
      if (dp.scheduledDepTime >= 0) 
      { 
        int hour = dp.scheduledDepTime / 100; 
        if (hour >= 0 && hour <= 23) 
        {
          hourlyCounts[hour]++;
          if (hourlyCounts[hour] > maxCount) 
          {
            maxCount = hourlyCounts[hour];
          }
        }
      }
    }

    // Clock Math
    float cx = width / 2;
    float cy = height / 2 ;
    float angleStep = TWO_PI / 24; // This divides a full circle into 24 equal slices

    // Draw the 24 pie slices
    for (int i = 0; i < 24; i++) {
      // Map the flight count to the size (width/height) of the pie slice
      float sliceSize = map(hourlyCounts[i], 0, maxCount, 120, 450); 
      
      // Calculate where this slice starts and stops (-HALF_PI puts 0:00 at the top)
      float startAngle = (i * angleStep) - HALF_PI;
      float stopAngle = startAngle + angleStep;

      // Color the busiest hour gold, rest are blue
      if (hourlyCounts[i] == maxCount && maxCount > 0) 
      {
        fill(255, 200, 0); 
      } else 
      {
        fill(0, 180, 220); 
      }

      stroke(5, 15, 40); // Dark border around slice 
      strokeWeight(2);
      
      // Draw the pie slice!
      arc(cx, cy, sliceSize, sliceSize, startAngle, stopAngle, PIE);

      // Draw the text labels
      float textRadius = 230; 
      float midAngle = startAngle + (angleStep / 2); 
      
      float textX = cx + (cos(midAngle) * textRadius);
      float textY = cy + (sin(midAngle) * textRadius);

      fill(255);
      textAlign(CENTER, CENTER);
      textSize(11);
      
      text(i + ":00\n(" + hourlyCounts[i] + ")", textX, textY);
    }

    // Draw a circle
    fill(5, 15, 40);
    noStroke();
    ellipse(cx, cy, 100, 100);
    
    fill(200);
    text("24 HRS", cx, cy);

  
  }
}