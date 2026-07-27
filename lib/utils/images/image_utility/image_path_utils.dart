bool isNetworkImage(String path) {
  return path.startsWith('http://') || path.startsWith('https://');
}
