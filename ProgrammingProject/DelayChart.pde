class DelayBarChart {
  ArrayList<DataPoint> flights;

  DelayBarChart(ArrayList<DataPoint> flights) {
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
    text("Average Departure Delay by Airline", width / 2, 20);

    textSize(10);
    fill(255); 
    text("Key:\n Green: Early\n Red: Late", CORNER + 30, CORNER + 15);

    String[] airlineCodes = {"AA", "AS", "B6", "DL", "F9", "G4", "HA", "NK", "UA", "WN"};
    int numOfAirlines = airlineCodes.length;
    float[] totalDelay = new float[numOfAirlines];
    int[] count = new int[numOfAirlines];

    for (DataPoint dp : flights) {
      if (dp.cancelled == 1 || dp.depTime < 0 || dp.scheduledDepTime < 0)continue;
      for (int i = 0; i < numOfAirlines; i++) {
        if (dp.airline.equals(airlineCodes[i])) { 
          totalDelay[i] += dp.getDelay();
          count[i]++;
          break;
        }
  
        }
    }

    float[] avgs = new float[numOfAirlines];
    float maxVal = 1;
    for (int i = 0; i < numOfAirlines; i++) {
    if (count[i] > 0) {
        avgs[i] = totalDelay[i] / count[i];
        }
    if (abs(avgs[i]) > maxVal) {
        maxVal = abs(avgs[i]);
        }
    }

    // draw bars
    float spacing = (width - 160) / numOfAirlines;
    float barWidth = spacing * 0.6;

    for (int i = 0; i < numOfAirlines; i++) {
      float x = 160 + spacing * i + (spacing - barWidth) / 2;
      float barHeight = map(abs(avgs[i]), 0, maxVal, 0, 350);
      float y = height - 80 - barHeight;

      noStroke();
      fill(avgs[i] >= 0 ? color(230, 76, 60) : color(46, 204, 113));
      rect(x, y, barWidth, barHeight, 4, 4, 0, 0);

      fill(255);
      textSize(11);
      text(nf(avgs[i], 0, 1) + " min", x + barWidth / 2, y - 10);

      fill(200);
      textSize(13);
      text(airlineCodes[i], x + barWidth / 2, height - 55);
    }
  

  }
}