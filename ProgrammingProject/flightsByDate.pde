class flightsByDate {
  ArrayList<DataPoint> flights;
  int[] counts = new int[7];
  String[] weeklyCount = {
    "Saturday",
    "Sunday",
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday"
  };

  flightsByDate(ArrayList<DataPoint> flights) {
    this.flights = flights;
    countByDay();
  }

  void countByDay() {
    int satCount = 0;
    int sunCount = 0;
    int monCount = 0;
    int tueCount = 0;
    int wedCount = 0;
    int thursCount = 0;
    int friCount = 0;

    if (flights == null) {
      // keep counts at zero
      for (int i = 0; i < 7; i++) {
        counts[i] = 0;
      }
      return;
    }

    for (DataPoint dp : flights) {
      if (dp.flightDate != null) {
        int index = dp.getFlightDayOfWeek();
        if (index == 1) {
          satCount++;
        } else if (index == 2) {
          sunCount++;
        } else if (index == 3) {
          monCount++;
        } else if (index == 4) {
          tueCount++;
        } else if (index == 5) {
          wedCount++;
        } else if (index == 6) {
          thursCount++;
        } else if (index == 7) {
          friCount++;
        }
      }
    }

    counts[0] = satCount;
    counts[1] = sunCount;
    counts[2] = monCount;
    counts[3] = tueCount;
    counts[4] = wedCount;
    counts[5] = thursCount;
    counts[6] = friCount;
    for(int x = 0; x < 7; x++){
      println(weeklyCount[x] + ": " + counts[x]);
    }
  }

void draw() {
    countByDay();
    background(5, 15, 40);
    noStroke();
    fill(0, 180, 220);
    rect(0, 0, width, 4);

    fill(255);
    textAlign(CENTER, TOP);
    textSize(22);
    text("Flights by Date", width / 2, 20);

    float spacing = (width - 160) / 7.0;
    float barWidth = spacing * 0.7;
    float scale = 1.0;
    for (int i = 0; i < 7; i++) {
      float x = 160 + spacing * i + (spacing - barWidth) / 2;
      float barHeight = counts[i]*scale;
      float y = height - 100 - barHeight;
      fill(0,180,220);
      rect(x,y,barWidth,barHeight);

      noStroke();
      fill(0, 180, 220);
      // Display the flight count above the bar
      fill(255);
      textAlign(CENTER, BOTTOM);
      textSize(10);
      text(counts[i], x + barWidth / 2, y - 5);

      // Display the day label below the bar
      fill(200);
      textAlign(CENTER, TOP);
      textSize(11);
      text(weeklyCount[i], x + barWidth / 2, height - 90);
    }

  
  }
}