//Authorship Vlad Manea, Callum Hughes, function getFlightDayOfWeek was Ryan Nichols

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

  // takes a parsed CSV row as a String array and assigns each field
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


  // calculates delay
  float getDelay() {
    int scheduledDepHour = scheduledDepTime / 100;
    float scheduledDepMinute = scheduledDepTime % 100;
    int actualDepHour = (int) depTime / 100;
    float actualDepMinute = depTime % 100;
    return (actualDepHour * 60 + actualDepMinute) - (scheduledDepHour * 60 + scheduledDepMinute);
  }

    // calculates dayOfWeekIndex

  int getFlightDayOfWeek(){
    String day = flightDate.substring(3,5);
    int dayOfWeekIndex = Integer.parseInt(day);
    while(dayOfWeekIndex>7){
      dayOfWeekIndex-=7;
    }
    return dayOfWeekIndex;
  }
}