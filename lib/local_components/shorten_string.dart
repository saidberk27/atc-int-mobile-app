String shortenString({required String string, required int maxLength}) {
  if (string.length > maxLength) {
    string = "${string.substring(0, maxLength)}...";
    return string;
  }
  return string;
}
