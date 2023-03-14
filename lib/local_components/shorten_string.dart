String shortenString({required String string, required int max_length}) {
  if (string.length > max_length) {
    string = string.substring(0, max_length) + "...";
    return string;
  }
  return string;
}
