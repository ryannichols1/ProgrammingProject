class PopularDestinations {
  ArrayList<DataPoint> flights;

  String[] topCodes  = new String[10];
  String[] topNames  = new String[10];
  int[] topCounts  = new int[10];
  int totalFlights = 0;
  int maxCount   = 1;

  java.util.HashMap<String, float[]> airportCoords;
  
  PopularDestinations(ArrayList<DataPoint> flights) {
    this.flights = flights;
    buildTopDestinations();
    buildAirportCoords();
  }

  void buildTopDestinations() {
    java.util.HashMap<String, Integer> countMap = new java.util.HashMap<String, Integer>();

    for (DataPoint dp : flights) {
      if (dp.cancelled == 1) continue;
      String code = dp.dest;
      countMap.put(code, countMap.containsKey(code) ? countMap.get(code) + 1 : 1);
    }

    for (int i = 0; i < 10; i++) {
      topCodes[i]  = "";
      topCounts[i] = 0;
    }

    for (String code : countMap.keySet()) {
      int cnt = countMap.get(code);
      for (int i = 0; i < 10; i++) {
        if (cnt > topCounts[i]) {
          for (int j = 9; j > i; j--) {
            topCodes[j]  = topCodes[j-1];
            topCounts[j] = topCounts[j-1];
          }
          topCodes[i]  = code;
          topCounts[i] = cnt;
          break;
        }
      }
    }

    for (int cnt : countMap.values()) totalFlights += cnt;
    maxCount = topCounts[0];
  }

  void buildAirportCoords() {
    airportCoords = new java.util.HashMap<String, float[]>();
    airportCoords.put("ATL", new float[]{-84.4, 33.6});
    airportCoords.put("LAX", new float[]{-118.4, 33.9});
    airportCoords.put("ORD", new float[]{-87.9, 41.9});
    airportCoords.put("DFW", new float[]{-97.0, 32.9});
    airportCoords.put("DEN", new float[]{-104.7, 39.8});
    airportCoords.put("JFK", new float[]{-73.8, 40.6});
    airportCoords.put("SFO", new float[]{-122.4, 37.6});
    airportCoords.put("SEA", new float[]{-122.3, 47.4});
    airportCoords.put("LAS", new float[]{-115.2, 36.1});
    airportCoords.put("MCO", new float[]{-81.3, 28.4});
    airportCoords.put("MIA", new float[]{-80.3, 25.8});
    airportCoords.put("CLT", new float[]{-80.9, 35.2});
    airportCoords.put("PHX", new float[]{-112.0, 33.4});
    airportCoords.put("BOS", new float[]{-71.0, 42.4});
    airportCoords.put("EWR", new float[]{-74.2, 40.7});
    airportCoords.put("MSP", new float[]{-93.2, 44.9});
    airportCoords.put("DTW", new float[]{-83.4, 42.2});
    airportCoords.put("PHL", new float[]{-75.2, 40.0});
    airportCoords.put("LGA", new float[]{-73.9, 40.8});
    airportCoords.put("FLL", new float[]{-80.2, 26.1});
    airportCoords.put("BWI", new float[]{-76.7, 39.2});
    airportCoords.put("SLC", new float[]{-111.9, 40.8});
    airportCoords.put("IAH", new float[]{-95.3, 30.0});
    airportCoords.put("DCA", new float[]{-77.0, 38.9});
    airportCoords.put("SAN", new float[]{-117.2, 32.7});
    airportCoords.put("HNL", new float[]{-157.9, 21.3});
  }

  void draw() {
    background(5, 15, 40);

    noStroke();
    fill(0, 180, 220);
    rect(0, 0, width, 4);

    fill(255);
    textAlign(CENTER, TOP);
    textSize(22);
    text("Top 10 Most Popular Destinations", width / 2, 18);

    fill(100, 160, 200);
    textSize(12);
    text("Based on " + totalFlights + " flights  •  Non-cancelled only", width / 2, 48);

    float mapX = 30, mapY = 75, mapW = 620, mapH = 530;
    float listX = 670, listY = 75, listW = 510, listH = 530;

    drawMap(mapX, mapY, mapW, mapH);
    drawRankedList(listX, listY, listW, listH);

  }

  void drawMap(float mx, float my, float mw, float mh) {
    fill(8, 25, 60);
    stroke(0, 80, 120);
    strokeWeight(1);
    rect(mx, my, mw, mh); 

    float lonMin = -125, lonMax = -65;
    float latMin = 24,   latMax = 50;
    float padX = 30, padY = 30;

    for (int i = 0; i < 10; i++) {
      String code = topCodes[i];
      if (!airportCoords.containsKey(code)) continue;

      float[] coords = airportCoords.get(code);
      float lon = coords[0], lat = coords[1];
      if (lon < -130) continue;

      float sx = map(lon, lonMin, lonMax, mx + padX, mx + mw - padX);
      float sy = map(lat, latMax, latMin, my + padY, my + mh - padY);

      float rankFade = map(i, 0, 9, 1.0, 0.45);

      // Static dot only no rings
      float dotR = map(topCounts[i], 0, maxCount, 5, 16);
      noStroke();
      fill(lerpColor(color(0, 180, 220), color(255, 80, 80), (float)i / 9), 230 * rankFade);
      ellipse(sx, sy, dotR * 2, dotR * 2);

      // Airport code label
      fill(220, 240, 255, 220 * rankFade);
      textAlign(CENTER, BOTTOM);
      textSize(10);
      text(code, sx, sy - dotR - 3);

      // Rank badge for top 3
      if (i < 3) {
        fill(i == 0 ? color(255, 200, 0) : i == 1 ? color(180, 180, 180) : color(200, 120, 50));
        textSize(9);
        textAlign(CENTER, TOP);
        text("#" + (i + 1), sx, sy + dotR + 2);
      }
    }

    fill(60, 100, 140);
    textAlign(LEFT, BOTTOM);
    textSize(10);
    noStroke();
    text("US Flight Map", mx + 10, my + mh - 8);
  }

  void drawRankedList(float lx, float ly, float lw, float lh) {
    float rowH = lh / 10.5;
    // Fixed column positions
    float colRank   = lx + 22;
    float colCode   = lx + 50;
    float colPct    = lx + lw - 130;
    float colCount  = lx + lw - 10;

    for (int i = 0; i < 10; i++) {
      float rowY = ly + i * rowH;
      float midY = rowY + rowH / 2;

      // Row background
      boolean isTop3 = i < 3;
      fill(isTop3 ? color(0, 40, 80, 180) : color(10, 25, 55, 160));
      noStroke();
      rect(lx, rowY + 2, lw, rowH - 4);

      color medalCol = i == 0 ? color(255, 200, 0) :
                       i == 1 ? color(180, 180, 180) :
                       i == 2 ? color(200, 120, 50) :
                                color(0, 140, 180);

      // Rank number
      fill(medalCol);
      textAlign(CENTER, CENTER);
      textSize(i < 3 ? 17 : 14);
      text(i + 1, colRank, midY);

      // Airport code
      fill(255);
      textAlign(LEFT, CENTER);
      textSize(i < 3 ? 16 : 14);
      text(topCodes[i], colCode, midY);

      // Percentage — right-aligned before flight count
      float pct = 100.0 * topCounts[i] / totalFlights;
      fill(100, 160, 200);
      textAlign(RIGHT, CENTER);
      textSize(12);
      text(nf(pct, 0, 1) + "%", colPct, midY);

      // Flight count 0right edge
      fill(0, 180, 220);
      textAlign(RIGHT, CENTER);
      textSize(13);
      text(topCounts[i] + " flights", colCount, midY);
    }
  }
}