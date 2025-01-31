import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firebase_bloc_template/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:flutter_firebase_bloc_template/features/auth/presentation/cubits/auth_states.dart';
import 'package:flutter_firebase_bloc_template/features/auth/presentation/screens/auth_screen.dart';
import 'package:flutter_firebase_bloc_template/features/auth/presentation/screens/sign_in_screen.dart';
import 'package:flutter_firebase_bloc_template/features/home/presentation/home_screen.dart';
import 'package:flutter_firebase_bloc_template/themes/light_mode.dart';

import 'firebase_options.dart';
import 'features/auth/data/data_sources/auth_local_data_source.dart';
import 'features/auth/data/data_sources/auth_remote_data_source.dart';
import 'features/auth/data/data_sources/auth_remote_data_source_firebase.dart';
import 'features/auth/data/repositories/auth_repository_impl.dart';
import 'features/auth/domain/entities/auth_user.dart';
import 'features/auth/domain/repositories/auth_repository.dart';

typedef AppBuilder = Future<Widget> Function();

Future<void> bootstrap(AppBuilder builder) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(await builder());
}

void main() {
  bootstrap(
    () async {
      AuthLocalDataSource authLocalDataSource = AuthLocalDataSource();
      AuthRemoteDataSource authRemoteDataSource = AuthRemoteDataSourceFirebase();

      AuthRepository authRepository = AuthRepositoryImpl(
        localDataSource: authLocalDataSource,
        remoteDataSource: authRemoteDataSource,
      );

      return App(
        authRepository: authRepository,
        authUser: await authRepository.authUser.first,
      );
    },
  );
}

class App extends StatelessWidget {
  const App({
    super.key,
    required this.authRepository,
    this.authUser,
  });

  final AuthRepository authRepository;
  final AuthUser? authUser;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(authRepository: authRepository)..checkAuth(),
      child: MaterialApp(
        title: 'Clean Architecture',
        theme: lightMode,
        home: BlocConsumer<AuthCubit, AuthState>(
          // Listen for errors
          listener: (context, state) {
            if (state is AuthError) {
              print(state.message);
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(
                    content: Text('Login Error: ${state.message}'),
                  ),
                );
            }
          },
          builder: (context, state) {
            if (state is AuthUnauthenticated || state is AuthError) {
              return const AuthScreen();
            }
            if (state is AuthAuthenticated) {
              return const HomeScreen();
            }
            return const Scaffold(body: Center(child: CircularProgressIndicator()));
          },
        ),
      ),
    );
  }
}

// class HomeScreen extends StatelessWidget {
//   const HomeScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Clean Architecture')),
//       body: const Column(children: []),
//     );
//   }
// }
