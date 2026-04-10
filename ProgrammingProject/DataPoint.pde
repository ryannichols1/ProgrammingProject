//Authorship Vlad Manea, Callum Hughes, function getFlightDayOfWeek : Ryan Nichols

class DataPoint {

  // fields that are stored from every flight 
  String flightDate;
  String airline;
  int flightNumber;
  String origin;
  String dest;
  float distance;
  int cancelled;
  float depTime;
  int scheduledDepTime;

  // pulls the relevent columns from the csv row thats been parsed
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

  // calculates how early/late a dflight departed
  // negative means it departed early, positive means it departed late 
  float getDelay() {
    int scheduledDepHour = scheduledDepTime / 100;
    float scheduledDepMinute = scheduledDepTime % 100;
    int actualDepHour = (int) depTime / 100;
    float actualDepMinute = depTime % 100;
    return (actualDepHour * 60 + actualDepMinute) - (scheduledDepHour * 60 + scheduledDepMinute);

  }

  // works out which day fo the week it is from the flight data
  // does so by keep subtracting 7 until  falls within 1-7 range 
  int getFlightDayOfWeek(){
    String day = flightDate.substring(3,5);
    int dayOfWeekIndex = Integer.parseInt(day);
    while(dayOfWeekIndex>7){
      dayOfWeekIndex-=7;
    }
    return dayOfWeekIndex;
  }
}