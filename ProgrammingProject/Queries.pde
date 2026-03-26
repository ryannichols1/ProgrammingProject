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