import 'dart:async';

import 'package:crowfunding_app_with_bloc/app/constants/graph_query.dart';
import 'package:crowfunding_app_with_bloc/app/constants/index.dart';
import 'package:crowfunding_app_with_bloc/app/data/exceptions.dart';
import 'package:crowfunding_app_with_bloc/app/data/provider/graphql/graph_QL.dart';
import 'package:crowfunding_app_with_bloc/app/data/store/events_store.dart';
import 'package:crowfunding_app_with_bloc/app/global_feature/scaffold_custom/views/scaffold_custom_view.dart';
import 'package:crowfunding_app_with_bloc/app/global_styles/global_styles.dart';
import 'package:crowfunding_app_with_bloc/app/models/response/conversation_response.dart';
import 'package:crowfunding_app_with_bloc/app/models/response/events/typing_response.dart';
import 'package:crowfunding_app_with_bloc/app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

part 'bloc/conversations_bloc.dart';
part 'bloc/conversations_events.dart';
part 'bloc/conversations_state.dart';
part 'repository/conversations_repository.dart';
part 'views/conversations_view.dart';
