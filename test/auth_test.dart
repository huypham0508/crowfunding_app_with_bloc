import 'package:bloc_test/bloc_test.dart';
import 'package:crowfunding_app_with_bloc/app/data/local_data_source.dart';
import 'package:crowfunding_app_with_bloc/app/data/provider/graphql/graph_QL.dart';
import 'package:crowfunding_app_with_bloc/app/global_bloc/auth/auth_bloc.dart';
import 'package:crowfunding_app_with_bloc/app/modules/auth/sign_in/bloc/sign_in_bloc.dart';
import 'package:crowfunding_app_with_bloc/app/modules/auth/sign_up/bloc/sign_up_bloc.dart';
import 'package:crowfunding_app_with_bloc/app/services/biometric_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  TestWidgetsFlutterBinding.ensureInitialized();
  SharedPreferences.setMockInitialValues({});
  final sf = await SharedPreferences.getInstance();

  group(
    'Auth Feature',
    () {
      group('Auth Bloc', () {
        LocalDataSource localDataSource = LocalDataSource(sf);
        late AuthBloc authBloc;
        late SignInBloc signInBloc;
        late SignUpBloc signUpBloc;

        setUp(() {
          authBloc = AuthBloc(
            localDataSource: localDataSource,
            authRepository: AuthRepository(
              graphQLClient: GraphQlAPIClient.getInstance(
                localDataSource: localDataSource,
              ),
              localDataSource: localDataSource,
            ),
          );
          signInBloc = SignInBloc(
            biometric: BiometricService(),
            authRepository: AuthRepository(
              graphQLClient: GraphQlAPIClient.getInstance(
                localDataSource: localDataSource,
              ),
              localDataSource: localDataSource,
            ),
          );
          signUpBloc = SignUpBloc(
            authRepository: AuthRepository(
              graphQLClient: GraphQlAPIClient.getInstance(
                localDataSource: localDataSource,
              ),
              localDataSource: localDataSource,
            ),
          );
        });

        tearDown(() {
          authBloc.close();
          signInBloc.close();
          signUpBloc.close();
        });
        test('initial state AuthBloc', () {
          expect(
            authBloc.state,
            authInitialState,
          );
        });

        blocTest<AuthBloc, AuthState>(
          'Switch auth page',
          build: () => authBloc,
          act: (bloc) => bloc
            ..add(
              SwitchAuthPageEvent(authPage: AuthPage.signIn),
            ),
          expect: () => [
            isA<AuthState>()
                .having(
                  (state) => state.authPage,
                  'authPage',
                  AuthPage.signIn,
                )
                .having(
                  (state) => state.status,
                  'status',
                  AuthStatus.loginFailure,
                ),
          ],
        );
      });

      // group(
      //   'Auth Page',
      //   () {
      //     testWidgets('Validate form', (tester) async {
      //       final bloc = CounterBloc();
      //       await tester.pumpWidget(CounterPage(counterBloc: bloc));

      //       await tester.tap(find.byType(ElevatedButton));
      //       await tester.pump();

      //       expect(find.text('1'), findsOneWidget);
      //     });
      //   },
      // );

      //
    },
  );
}
