//Authorship: Vlad Manea, Ryan Nichols

// by airport (origin or destination)
ArrayList<DataPoint> queryByAirport(String airportCode, ArrayList<DataPoint> dataSet) {
  ArrayList<DataPoint> results = new ArrayList<DataPoint>();
  for (DataPoint dp : dataSet) {
    if (dp.origin.equals(airportCode) || dp.dest.equals(airportCode)) {
      results.add(dp);
    }
  }
  return results;
}

//by airline
ArrayList<DataPoint> queryByAirline(String airlineCode, ArrayList<DataPoint> dataSet) {
  ArrayList<DataPoint> results = new ArrayList<DataPoint>();
  for (DataPoint dp : dataSet) {
    if (dp.airline.equals(airlineCode)) {
      results.add(dp);
    }
  }
  return results;
}

//by date
ArrayList<DataPoint> queryByDay(String date, ArrayList<DataPoint> dataSet) {
  ArrayList<DataPoint> results = new ArrayList<DataPoint>();
  for (DataPoint dp : dataSet) {
    if (dp.flightDate.equals(date)) {
      results.add(dp);
    }
  }
  return results;
}
// by flight number
ArrayList<DataPoint> queryByFlightNum(int flightNum, ArrayList<DataPoint> dataSet) {
  ArrayList<DataPoint> results = new ArrayList<DataPoint>();
  for (DataPoint dp : dataSet) {
    if (dp.flightNumber == flightNum) {
      results.add(dp);
    }
  }
  return results;
}

ArrayList<DataPoint> queryByDateRange(String startDate, String endDate, ArrayList<DataPoint> dataSet) {
  ArrayList<DataPoint> results = new ArrayList<DataPoint>();

  int startNum = dateToInt(startDate);
  int endNum   = dateToInt(endDate);

  for (DataPoint dp : dataSet) {
    String dateOnly = dp.flightDate.substring(0, 10).trim();
    int d = dateToInt(dateOnly);
    if (d >= startNum && d <= endNum) {
      results.add(dp);
    }
  }
  return results;
}

int dateToInt(String date) {
  String[] parts = date.split("/");
  int mm   = int(parts[0]);
  int dd   = int(parts[1]);
  int yyyy = int(parts[2]);
  return yyyy * 10000 + mm * 100 + dd;
}