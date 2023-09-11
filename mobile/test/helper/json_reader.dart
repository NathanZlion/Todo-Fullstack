import 'dart:io';

String jsonReader(String name) {
  var dir = Directory.current.path;
  return File('$dir/test/helper/stubs/$name').readAsStringSync();
}
