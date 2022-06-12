
class DateParseHelper {
  static int getFormatTime(DateTime date) {
    return int.parse("${date.year}${makeTwoDigit(date.month)}${makeTwoDigit(date.day)}");
  }

  static DateTime numToDateTime(int date) {
    String dateStr = date.toString();
    var year = int.parse(dateStr.substring(0, 4));
    var month = int.parse(dateStr.substring(4, 6));
    var day = int.parse(dateStr.substring(6, 8));
    return DateTime(year, month, day);
  }

  static String makeTwoDigit(int num) {
    return num.toString().padLeft(2, "0");
  }
}