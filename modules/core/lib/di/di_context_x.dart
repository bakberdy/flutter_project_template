import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

extension DiContextX on BuildContext {
  GetIt get di => GetIt.instance;
}
