class Queries{
ArrayList<DataPoint> flights;
Queries(ArrayList<DataPoint> flights) {
    this.flights = flights;
  }

void queryByAirport(String airportCode){
    ArrayList<DataPoint> results = new ArrayList<DataPoint>();
    for (DataPoint dp : flights) {
        String origin = dp.origin;
        if ((origin).equals(airportCode)) {
            results.add(dp);
        }
    }
}
void queryByAirline(String airlineCode){
    ArrayList<DataPoint> results = new ArrayList<DataPoint>();
    for (DataPoint dp : flights) {
        String airline = dp.airline;
        if ((airline).equals(airlineCode)) {
            results.add(dp);
        }
    }
}
void queryByDay(String date){
ArrayList<DataPoint> results = new ArrayList<DataPoint>();
    for (DataPoint dp : flights) {
        String date1 = dp.flightDate;
        if ((date1).equals(date)) {
            results.add(dp);
        }
    }
}

void queryByFlightNum(int flightNum){ {
ArrayList<DataPoint> results = new ArrayList<DataPoint>();
    for (DataPoint dp : flights) {
        int num = dp.flightNumber;
        if (num==flightNum) {
            results.add(dp);
        }
    }
}
}}