#!/bin/bash
your_module=$1
if [ -z "$1" ]; then
your_module="newModule"
fi


toupper() {
  local str=$1
  local res=""

  for (( i=0; i<${#str}; i++ )); do
    if [[ "${str:$i:1}" == "_" && "${str:$((i+1)):1}" =~ [a-z] ]]; then
      letter="${str:$((i+1)):1}"
      res+=$(echo ${letter} | tr '[:lower:]' '[:upper:]')
      i=$((i+1))
    else
      res+="${str:$i:1}"
    fi
  done

  echo $res
}

# setup
first_letter=$(echo ${your_module:0:1} | tr '[:lower:]' '[:upper:]')
rest_of_module="${your_module:1}"
capitalized_module="$first_letter$rest_of_module"
variable_name=$(toupper $your_module)
capitalized_module=$(toupper $capitalized_module)

path=./lib/src/modules/${your_module}


# create folder
mkdir ${path}
mkdir ${path}/bloc
mkdir ${path}/components
mkdir ${path}/views
mkdir ${path}/repository
mkdir ${path}/models

# create bloc file
touch ${path}/bloc/${your_module}_bloc.dart
cat << EOF >> "${path}/bloc/${your_module}_bloc.dart"
part of '../index.dart';

class ${capitalized_module}Bloc extends Bloc<${capitalized_module}Event, ${capitalized_module}State> {
  final ${capitalized_module}Repository ${variable_name}Repository;

  ${capitalized_module}Bloc({required this.${variable_name}Repository}) : super(initState${capitalized_module}) {
    on<Init${capitalized_module}Event>(_init);
  }

  _init(Init${capitalized_module}Event event, Emitter<${capitalized_module}State> emit) async {}
}

EOF


touch ${path}/bloc/${your_module}_events.dart
cat << EOF >>  "${path}/bloc/${your_module}_events.dart"
part of '../index.dart';

abstract class ${capitalized_module}Event {}

class Init${capitalized_module}Event extends ${capitalized_module}Event {}

EOF


touch ${path}/bloc/${your_module}_state.dart
cat << EOF >>  "${path}/bloc/${your_module}_state.dart"
part of '../index.dart';

${capitalized_module}State initState${capitalized_module} = ${capitalized_module}State(status: ${capitalized_module}Status.loading);

enum ${capitalized_module}Status { loading, loaded, error }

final class ${capitalized_module}State {
  final ${capitalized_module}Status status;

  ${capitalized_module}State({
    this.status = ${capitalized_module}Status.loading
  });

  ${capitalized_module}State copyWith({
    ${capitalized_module}Status? status
  }) {
    return ${capitalized_module}State(
      status: status ?? this.status,
    );
  }
}

EOF

#create views file
touch ${path}/views/${your_module}_views.dart
cat << EOF >>  "${path}/views/${your_module}_views.dart"
part of '../index.dart';

class ${capitalized_module}Page extends StatelessWidget {
  const ${capitalized_module}Page({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ${capitalized_module}Bloc(
        ${variable_name}Repository: ${capitalized_module}Repository(
          context.read<RestAPIClient>(),
        ),
      )..add(Init${capitalized_module}Event()),
      child: const Scaffold(),
    );
  }
}
EOF

#create repository file
touch ${path}/repository/${your_module}_repository.dart
cat << EOF >>  "${path}/repository/${your_module}_repository.dart"
part of '../index.dart';

class ${capitalized_module}Repository extends I${capitalized_module}Adapter {
  final RestAPIClient _restAPIClient;

  ${capitalized_module}Repository(this._restAPIClient);

  @override
  Future<List<String>> increment() {
    _restAPIClient.toString();
    throw UnimplementedError();
  }
}
EOF


touch ${path}/repository/${your_module}_adapter.dart
cat << EOF >>  "${path}/repository/${your_module}_adapter.dart"
part of '../index.dart';

abstract class I${capitalized_module}Adapter {
  Future<List<String>> increment();
}

EOF


#create index file
touch ${path}/index.dart
# import data
cat << EOF >>  "${path}/index.dart"
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nuskinasset/src/services/provider/rest.dart';

part './bloc/${your_module}_bloc.dart';
part './bloc/${your_module}_events.dart';
part './bloc/${your_module}_state.dart';
part './views/${your_module}_views.dart';
part './repository/${your_module}_adapter.dart';
part './repository/${your_module}_repository.dart';
EOF

echo "
..
..
..
..
CREATE YOUR MODULE SUCCESSFULLY ${your_module}
"