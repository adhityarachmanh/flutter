import 'dart:async';
import 'dart:ffi';
import 'dart:io';
import 'package:equatable/equatable.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path/path.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:math';
import 'dart:math' show cos, sqrt, asin;
part 'config.dart';
part 'index.controller.dart';
part 'route.dart';
part 'styles.dart';
part 'models/api.model.dart';
part 'shr/routeFunction.dart';
part 'shr/global.dart';
part 'shr/api.dart';
part 'app/splash.screen.dart';
part 'app/splash.controller.dart';
part 'extensions/hex.extension.dart';
part 'models/auth.model.dart';
part 'app/auth/login.screen.dart';

part 'app/auth/login.controller.dart';

part 'app/auth/register.screen.dart';

part 'app/auth/register.controller.dart';
