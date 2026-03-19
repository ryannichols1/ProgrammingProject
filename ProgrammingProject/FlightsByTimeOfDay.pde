class FlightsByTimeOfDay {
  ArrayList<DataPoint> flights;

  FlightsByTimeOfDay(ArrayList<DataPoint> flights) {
    this.flights = flights;
  }

  void draw() {
    background(5, 15, 40);
    noStroke();
    fill(0, 180, 220);
    rect(0, 0, width, 4);

    fill(255);
    textAlign(CENTER, TOP);
    textSize(22);
    text("Flights by Time of Day (24-Hour Clock)", width / 2, 20);

    int[] hourlyCounts = new int[24];
    int maxCount = 0;

    for (DataPoint dp : flights) {
      if (dp.scheduledDepTime >= 0) { 
        int hour = dp.scheduledDepTime / 100; 
        if (hour >= 0 && hour <= 23) {
          hourlyCounts[hour]++;
          if (hourlyCounts[hour] > maxCount) {
            maxCount = hourlyCounts[hour];
          }
        }
      }
    }

    // Chart center coordinates
    float cx = width / 2;
    float cy = height / 2 + 20;
    float innerRadius = 80;
    float maxRadius = 250;

    boolean showTooltip = false;
    int hoverHour = -1;

    // Calculate mouse angle and distance from center for the hover effect
    float d = dist(mouseX, mouseY, cx, cy);
    float mouseAngle = atan2(mouseY - cy, mouseX - cx);
    if (mouseAngle < -HALF_PI) mouseAngle += TWO_PI; // Adjust so 0 starts at the top

    pushMatrix();
    translate(cx, cy);

    for (int i = 0; i < 24; i++) {
      // Map the hour to a 360-degree circle (starting at -HALF_PI, which is the top/12 o'clock)
      float angle = map(i, 0, 24, 0, TWO_PI) - HALF_PI;
      float nextAngle = map(i + 1, 0, 24, 0, TWO_PI) - HALF_PI;
      
      float barLength = map(hourlyCounts[i], 0, maxCount, innerRadius, maxRadius);

      // Check if mouse is hovering over this specific slice of the "pie"
      boolean isHovering = d > innerRadius && d < barLength && mouseAngle >= angle && mouseAngle < nextAngle;

      // Draw the radial bar (using a thick stroke)
      strokeCap(SQUARE);
      strokeWeight(12);
      
      if (isHovering) {
        stroke(100, 220, 255); // Highlight color
        showTooltip = true;
        hoverHour = i;
      } else if (hourlyCounts[i] == maxCount && maxCount > 0) {
        stroke(255, 200, 0); // Gold for the busiest hour
      } else {
        stroke(0, 180, 220); // Standard blue
      }
      
      line(cos(angle) * innerRadius, sin(angle) * innerRadius, cos(angle) * barLength, sin(angle) * barLength);

      // Draw the hour labels in a circle around the outside
      fill(200);
      noStroke();
      float labelX = cos(angle) * (maxRadius + 30);
      float labelY = sin(angle) * (maxRadius + 30);
      textAlign(CENTER, CENTER);
      textSize(11);
      text(i + ":00", labelX, labelY);
    }
    
    // Draw the inner circle to make it look clean
    fill(5, 15, 40);
    noStroke();
    ellipse(0, 0, innerRadius * 2 - 10, innerRadius * 2 - 10);
    
    // Put a clock icon or text in the center
    fill(100, 160, 200);
    textSize(14);
    text("24 HRS", 0, 0);

    popMatrix(); // Reset translation so the button and tooltip draw in the correct place!

    if (showTooltip) {
      drawTooltip(hoverHour, hourlyCounts[hoverHour], mouseX, mouseY);
    }

    drawButton("Home ", width - 250, height - 60, 220, 45);
  }
  
  void drawTooltip(int hour, int count, float mx, float my) {
    String timeText = String.format("%02d:00 - %02d:00", hour, (hour + 1) % 24);
    String countText = count + " total flights";
    
    float boxW = 130;
    float boxH = 50;
    float boxX = (mx + boxW + 20 > width) ? mx - boxW - 10 : mx + 15;
    float boxY = my - 25;

    fill(20, 35, 70, 240);
    stroke(0, 180, 220);
    strokeWeight(1.5);
    rect(boxX, boxY, boxW, boxH, 6);
    
    noStroke();
    fill(255);
    textAlign(LEFT, TOP);
    textSize(13);
    text(timeText, boxX + 10, boxY + 8);
    
    fill(180, 220, 255);
    textSize(11);
    text(countText, boxX + 10, boxY + 28);
  }
}