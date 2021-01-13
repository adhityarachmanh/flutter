/*
module  : APP
creator : adhityarachmanh
os      : darwin19
created : Thu Dec 17 20:21:01 WIB 2020
product : ARH
version : v1.0
*/
import 'dart:async';
import 'dart:io';
import 'package:equatable/equatable.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path/path.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:math';
import 'dart:math' show cos, sqrt, asin;
import 'package:uuid/uuid.dart';
import 'package:web_socket_channel/io.dart';
part 'config.dart';
part 'index.dart';
part 'route.dart';
part 'styling.dart';
part 'shr/websocketFunction.dart';
part 'shr/routeFunction.dart';
part 'shr/global.dart';
part 'shr/api.dart';
part 'extensions/hex.extension.dart';
part 'models/user.model.dart';
part 'widgets/safearea.widget.dart';
part 'widgets/responsive.widget.dart';
part 'services/auth.service.dart';
part 'screens/splash.screen.dart';
part 'screens/splash.controller.dart';
