import 'package:flutter/material.dart';

@immutable
class RouteArguments<T> {
  T data;

  RouteArguments({required this.data});
}
