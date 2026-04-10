// Authorship Callum Hughes

class DepartingFlights {
  ArrayList<DataPoint> flights;

  DepartingFlights(ArrayList<DataPoint> flights) {
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
    text("Flights per Departure Airport", width / 2, 20);

    // tmp vairbales to count how many flights depart per each airport
    String[] tempAirports = new String[flights.size()];
    int[] tempCounts = new int[flights.size()];
    int numAirports = 0;

    // goes through data and if an airport code is already in the tmpAirports array, it adds 1 to the correlating index in tempCounts. 
    // if it doesnt find the airport code it adds the code to the end of the tmp array to start a count for that airport 
    
    for (int i = 0; i < flights.size(); i++) {
      String orig = flights.get(i).origin;
      boolean found = false;
      for (int j = 0; j < numAirports; j++) {
        if (tempAirports[j].equals(orig)) {
          tempCounts[j]++;
          found = true;
          break;
        }
      }
      if (!found) {
        tempAirports[numAirports] = orig;
        tempCounts[numAirports] = 1;
        numAirports++;
      }
    }

    // bubble sort to arrnage from busiest to quietest 
    for (int i = 0; i < numAirports - 1; i++) {
      for (int j = 0; j < numAirports - 1 - i; j++) {
        if (tempCounts[j] < tempCounts[j + 1]) {
          int tmpC = tempCounts[j];
          tempCounts[j] = tempCounts[j + 1];
          tempCounts[j + 1] = tmpC;
          String tmpA = tempAirports[j];
          tempAirports[j] = tempAirports[j + 1];
          tempAirports[j + 1] = tmpA;
        }
      }
    }

    int display = min(numAirports, 10);

    float maxVal = 1;
    for (int i = 0; i < display; i++) {
      if (tempCounts[i] > maxVal) maxVal = tempCounts[i];
    }

    float spacing = (width - 160) / display;
    float barWidth = spacing * 0.6;

    // draws each bar 
    for (int i = 0; i < display; i++) {
      float x = 160 + spacing * i + (spacing - barWidth) / 2;
      float barHeight = map(tempCounts[i], 0, maxVal, 0, 350);
      float y = height - 130 - barHeight;

      noStroke();
      fill(0, 180, 220);
      rect(x, y, barWidth, barHeight, 4, 4, 0, 0);

      // displays flight count abvoe bar 
      fill(255);
      textAlign(CENTER, CENTER);
      textSize(11);
      text(str(tempCounts[i]), x + barWidth / 2, y - 10);

      // displays airport code below bar 
      fill(200);
      textSize(13);
      text(tempAirports[i], x + barWidth / 2, height - 120);
    }
  }
}
