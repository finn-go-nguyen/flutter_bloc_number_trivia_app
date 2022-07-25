import 'dart:io';

String fixture(String name) =>
    File('${Directory.current.path..replaceAll('\\', '/')}/test/fixtures/$name')
        .readAsStringSync();
