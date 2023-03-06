import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_story_app/common.dart';
import 'package:flutter_story_app/model/story.dart';
import 'package:flutter_story_app/provider/auth_provider.dart';
import 'package:flutter_story_app/provider/result_state.dart';
import 'package:flutter_story_app/provider/story_provider.dart';
import 'package:flutter_story_app/routes/page_manager.dart';
import 'package:flutter_story_app/screen/layout/main_layout.dart';
import 'package:flutter_story_app/utils/utils.dart';
import 'package:flutter_story_app/widgets/widget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

part 'splash_screen.dart';
part 'login_screen.dart';
part 'register_screen.dart';
part 'home_screen.dart';
part 'detail_screen.dart';
part 'add_story_screen.dart';