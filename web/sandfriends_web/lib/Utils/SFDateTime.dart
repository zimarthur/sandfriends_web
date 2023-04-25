DateTime lastDayOfMonth(DateTime date) {
  return DateTime(date.year, date.month + 1, 0);
}

bool isSameDate(DateTime a, DateTime b) {
  return a.day == b.day && a.month == b.month && a.year == b.year;
}

bool isInCurrentMonth(DateTime a) {
  return a.month == DateTime.now().month && a.year == DateTime.now().year;
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
List<String> weekdayShort = [
  "seg",
  "ter",
  "qua",
  "qui",
  "sex",
  "sáb",
  "dom",
];

int getBRWeekday(int weekday) {
  if (weekday == 0) {
    return 6;
  } else {
    return weekday - 1;
  }
}

String getMonthYear(DateTime datetime) {
  return "${monthsPortuguese[datetime.month - 1]}/${datetime.year.toString().substring(datetime.year.toString().length - 2)}";
}
