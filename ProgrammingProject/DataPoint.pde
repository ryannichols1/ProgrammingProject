
class DataPoint {
  String flightDate;
  String airline;
  int flightNumber;
  String origin;
  String originCity;
  String originState;
  int originWac;
  String dest;
  String destCity;
  String destState;
  int destWac;
  String crsDepTime;
  String depTime;
  String crsArrTime;
  String arrTime;
  int cancelled;
  int diverted;
  float distance;
  
  DataPoint(String[] cols) {
    flightDate = cols[0].trim().replace("\"", "");
    airline = cols[1].trim().replace("\"", "");
    flightNumber = parseIntSafe(cols[2]);
    origin = cols[3].trim().replace("\"", "");
    originCity = cols[4].trim().replace("\"", "");
    originState = cols[5].trim().replace("\"", "");
    originWac = parseIntSafe(cols[6]);
    dest = cols[7].trim().replace("\"", "");
    destCity = cols[8].trim().replace("\"", "");
    destState = cols[9].trim().replace("\"", "");
    destWac = parseIntSafe(cols[10]);
    crsDepTime = cols[11].trim().replace("\"", "");
    depTime = cols[12].trim().replace("\"", "");
    crsArrTime = cols[13].trim().replace("\"", "");
    arrTime = cols[14].trim().replace("\"", "");
    cancelled = parseIntSafe(cols[15]);
    diverted = parseIntSafe(cols[16]);
    distance = parseFloatSafe(cols.length > 17 ? cols[17] : "0");
  }
  
  // Safe parsing - returns 0 if field is empty or invalid
  int parseIntSafe(String s) {
    s = s.trim().replace("\"", "");
    if (s.length() == 0) return 0;
    try {
      // Handle decimals like "1.00"
      return int(float(s));
    } catch (Exception e) {
      return 0;
    }
  }
  
  float parseFloatSafe(String s) {
    s = s.trim().replace("\"", "");
    if (s.length() == 0) return 0.0;
    try {
      return float(s);
    } catch (Exception e) {
      return 0.0;
    }
  }
  
  // For println() debugging
  String toString() {
    return flightDate + " | " + airline + flightNumber + " | " +
           origin + " -> " + dest + " | " + distance + " mi" +
           (cancelled == 1 ? " [CANCELLED]" : "");
  }
}

