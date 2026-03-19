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
    text("Flights by Time of Day (Hourly)", width / 2, 20);

    // Create 24 buckets for each hour of the day (0-23)
    int[] hourlyCounts = new int[24];
    int maxCount = 0;

    // Count the flights per hour
    for (DataPoint dp : flights) {
      if (dp.scheduledDepTime >= 0) { // Ensure valid time
        int hour = dp.scheduledDepTime / 100; // Extract the hour (e.g., 1430 / 100 = 14)
        if (hour >= 0 && hour <= 23) {
          hourlyCounts[hour]++;
          if (hourlyCounts[hour] > maxCount) {
            maxCount = hourlyCounts[hour];
          }
        }
      }
    }

    // Draw the bars
    float spacing = (width - 160) / 24.0;
    float barWidth = spacing * 0.7;

    for (int i = 0; i < 24; i++) {
      float x = 80 + spacing * i + (spacing - barWidth) / 2;
      // Map the height relative to the busiest hour
      float barHeight = map(hourlyCounts[i], 0, maxCount, 0, 350);
      float y = height - 100 - barHeight;

      noStroke();
      fill(0, 180, 220);
      // Highlight the busiest hours in a different color
      if (hourlyCounts[i] == maxCount && maxCount > 0) {
        fill(255, 200, 0); 
      }
      rect(x, y, barWidth, barHeight, 4, 4, 0, 0);

      // Display the flight count above the bar
      fill(255);
      textAlign(CENTER, BOTTOM);
      textSize(10);
      text(hourlyCounts[i], x + barWidth / 2, y - 5);

      // Display the hour label below the bar
      fill(200);
      textAlign(CENTER, TOP);
      textSize(11);
      text(i + ":00", x + barWidth / 2, height - 90);
    }

    // Change the button text to 'Home' since this is the last screen
drawButton("Next ", width - 250, height - 60, 220, 45);  }
}