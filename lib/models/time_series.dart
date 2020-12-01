
class TimeSeries{
  DateTime date;
  int number;
  TimeSeries(String dateInString, int cases){
    number = cases;
    List mdy = dateInString.split('/');
    date = new DateTime(int.parse(mdy[2]), int.parse(mdy[0]), int.parse(mdy[1]));
  }
}