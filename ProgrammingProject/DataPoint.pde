class DataPoint {
  String flightDate;
  String airline;
  int flightNumber;
  String origin;
  String dest;
  float distance;
  int cancelled;
  
  DataPoint(String[] cols) {
    flightDate = cols[0];
    airline = cols[1];
    flightNumber = int(cols[2]);
    origin = cols[3];
    dest = cols[7];
    distance = float(cols[17]);
    cancelled = int(cols[15]);
  }
}

