//Authorship Vlad Manea 

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

    fill(0, 180, 220);
    textSize(12);
    text("Showing " + flights.size() + " flights", width / 2, 48);

    textSize(10);
    fill(255);
    text("Key:\n Green: Early\n Red: Late", CORNER + 200, CORNER + 15);

    ArrayList<String> airlines = new ArrayList<String>();
    ArrayList<Float> totals = new ArrayList<Float>();
    ArrayList<Integer> counts = new ArrayList<Integer>();

    for (DataPoint dp : flights) {
      if (dp.cancelled == 1 || dp.depTime < 0) continue;
      int i = airlines.indexOf(dp.airline);
      if (i == -1) {
        airlines.add(dp.airline);
        totals.add(dp.getDelay());
        counts.add(1);
      } else {
        totals.set(i, totals.get(i) + dp.getDelay());
        counts.set(i, counts.get(i) + 1);
      }
    }

    int numOfAirlines = airlines.size();
    if (numOfAirlines == 0) return;
    
// get averages and find max
    float[] avgs = new float[numOfAirlines];
    float maxVal = 1;
    for (int i = 0; i < numOfAirlines; i++) {
      avgs[i] = totals.get(i) / counts.get(i);
      if (abs(avgs[i]) > maxVal) maxVal = abs(avgs[i]);
    }

// draw bar chart
    float spacing = (width - 160) / numOfAirlines;
    float barWidth = spacing * 0.6;

    for (int i = 0; i < numOfAirlines; i++) {
      float x = 160 + spacing * i + (spacing - barWidth) / 2;
      float barHeight = map(abs(avgs[i]), 0, maxVal, 0, 300);
      float y = height - 130 - barHeight;

// red if avg delay greater than 0
      noStroke();
      fill(avgs[i] >= 0 ? color(230, 76, 60) : color(46, 204, 113));
      rect(x, y, barWidth, barHeight, 4, 4, 0, 0);

      fill(255);
      textSize(11);
      text(nf(avgs[i], 0, 1) + " min", x + barWidth / 2, y - 10);

      fill(200);
      textSize(13);
      text(airlines.get(i), x + barWidth / 2, height - 105);
    }
  }
}