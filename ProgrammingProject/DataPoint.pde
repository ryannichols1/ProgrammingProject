class DataPoint {
  String flightDate;
  String airline;
  int flightNumber;
  String origin;
  String dest;
  float distance;
  int cancelled;
  float depTime;
  int scheduledDepTime;

  
  DataPoint(String[] cols) {
    flightDate = cols[0];
    airline = cols[1];
    flightNumber = int(cols[2]);
    origin = cols[3];
    dest = cols[7];
    scheduledDepTime = int(cols[11]);
    depTime = float(cols[12]);
      cancelled = int(cols[15]);
    distance = float(cols[17]);
  }
  float getDelay() {
    int scheduledDepHour = scheduledDepTime / 100;
    float scheduledDepMinute = scheduledDepTime % 100;
    int actualDepHour = (int) depTime / 100;
    float actualDepMinute = depTime % 100;
    return (actualDepHour * 60 + actualDepMinute) - (scheduledDepHour * 60 + scheduledDepMinute);

  }
}