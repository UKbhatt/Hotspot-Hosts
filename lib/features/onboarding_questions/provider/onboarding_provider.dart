import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod/legacy.dart';

final questionTextProvider = StateProvider<String>((ref) => '');
final audioPathProvider = StateProvider<String?>((ref) => null);
final videoPathProvider = StateProvider<String?>((ref) => null);
