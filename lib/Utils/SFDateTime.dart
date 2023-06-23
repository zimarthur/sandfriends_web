import '../SharedComponents/Model/Hour.dart';
import 'package:intl/intl.dart';

DateTime lastDayOfMonth(DateTime date) {
  return DateTime(date.year, date.month + 1, 0);
}

List monthsPortuguese = [
  'Jan',
  'Fev',
  'Mar',
  'Abr',
  'Mai',
  'Jun',
  'Jul',
  'Ago',
  'Set',
  'Out',
  'Nov',
  'Dez'
];

List<String> weekdayFull = [
  "Segunda-feira",
  "Terça-feira",
  "Quarta-feira",
  "Quinta-feira",
  "Sexta-feira",
  "Sábado",
  "Domingo",
];
List<String> weekday = [
  "segunda",
  "terça",
  "quarta",
  "quinta",
  "sexta",
  "sábado",
  "domingo",
];
List<String> weekdayRecurrent = [
  "segundas",
  "terças",
  "quartas",
  "quintas",
  "sextas",
  "sábados",
  "domingos",
];
List<String> weekdayShort = [
  "seg",
  "ter",
  "qua",
  "qui",
  "sex",
  "sáb",
  "dom",
];

int getSFWeekday(int weekday) {
  if (weekday == 0) {
    return 6;
  } else {
    return weekday - 1;
  }
}

int getSFMonthIndex(DateTime date) {
  return date.month - 1;
}

String getWeekdayTextFromDatetime(DateTime date) {
  return weekday[getSFWeekday(date.weekday)];
}

String getMonthYear(DateTime datetime) {
  return "${monthsPortuguese[datetime.month - 1]}/${datetime.year.toString().substring(datetime.year.toString().length - 2)}";
}

bool isInCurrentMonth(DateTime a) {
  return a.month == DateTime.now().month && a.year == DateTime.now().year;
}

bool areInTheSameDay(DateTime date, DateTime otherDate) {
  return date.day == otherDate.day &&
      date.month == otherDate.month &&
      date.year == otherDate.year;
}

bool areInTheSameMonth(DateTime date, DateTime otherDate) {
  return date.month == otherDate.month && date.year == otherDate.year;
}

bool isHourPast(DateTime date, Hour hour) {
  DateTime fullDateTime = DateTime(date.year, date.month, date.day,
      DateFormat('HH:mm').parse("${hour.hourString}").hour);

  return fullDateTime.isBefore(DateTime.now());
}
