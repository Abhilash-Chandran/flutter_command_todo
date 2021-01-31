/// converts date object to string human readable format.
String convertDateToString(DateTime dateTime) {
  if (dateTime == null) return "No due date";
  return "${dateTime.toLocal()}".split(' ')[0];
}
