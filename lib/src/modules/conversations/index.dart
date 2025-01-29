import 'dart:async';

import 'package:crowfunding_app_with_bloc/src/constants/graph_query.dart';
import 'package:crowfunding_app_with_bloc/src/constants/index.dart';
import 'package:crowfunding_app_with_bloc/src/data/exceptions.dart';
import 'package:crowfunding_app_with_bloc/src/data/provider/graphql/graph_QL.dart';
import 'package:crowfunding_app_with_bloc/src/data/store/events_store.dart';
import 'package:crowfunding_app_with_bloc/src/global/features/scaffold_custom/views/scaffold_custom_view.dart';
import 'package:crowfunding_app_with_bloc/src/global/styles/global_styles.dart';
import 'package:crowfunding_app_with_bloc/src/models/conversation.model.dart';
import 'package:crowfunding_app_with_bloc/src/models/events/typing.model.dart';
import 'package:crowfunding_app_with_bloc/src/routes/app_pages.dart';
import 'package:crowfunding_app_with_bloc/src/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

part 'bloc/conversations_bloc.dart';
part 'bloc/conversations_events.dart';
part 'bloc/conversations_state.dart';
part 'repository/conversations_repository.dart';
part 'views/conversations_view.dart';
