class User {
  final String username;
  final String password;
  User({required this.username, required this.password});
}

abstract class IRemoteDataSource {
  Future<User> loginUser(User user);
}

class GraphqlRemoteDataSource implements IRemoteDataSource {
  @override
  Future<User> loginUser(User user) async {
    print('loginUser');
    return user;
  }
}

class BaseRepository {
  final IRemoteDataSource remoteDataSource;

  BaseRepository(this.remoteDataSource);
}

abstract class IUserRepository {
  late final User user;
  Future<void> loginUser(User user);
}

class UserRepository extends BaseRepository implements IUserRepository {
  @override
  late final User user;

  UserRepository(super.remoteDataSource);

  @override
  Future<void> loginUser(_) async {
    user = await remoteDataSource.loginUser(_);
    print('UserRepository');
    print(user.username);
  }
}

abstract class BaseInteractor {}

class UserInteractor extends BaseInteractor {
  final IUserRepository _userRepository;

  UserInteractor(this._userRepository);

  User get user => _userRepository.user;

  Future<void> login(User entity) async {
    return _userRepository.loginUser(entity);
  }
}

void main() {
  UserInteractor user = UserInteractor(
    UserRepository(
      GraphqlRemoteDataSource(),
    ),
  );
  // UserInteractor -> UserRepository -> GraphqlRemoteDataSource
  user.login(User(username: 'phuong uyen', password: '2704'));
}
