String getRawNumber(String number) {
  RegExp regex = RegExp(r'\d+');
  Iterable<Match> matches = regex.allMatches(number);

  StringBuffer buffer = StringBuffer();

  for (Match match in matches) {
    buffer.write(match.group(0));
  }

  return buffer.toString();
}
