import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firebase_bloc_template/features/auth/presentation/components/pf_button.dart';
import 'package:flutter_firebase_bloc_template/features/auth/presentation/cubits/auth_cubit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final authCubit = context.read<AuthCubit>();
    return Scaffold(
        appBar: AppBar(
          title: Text('Home'),
          actions: [
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () {
                authCubit.logout();
              },
            )
          ],
        ),
        body: Column(children: [
          Text(authCubit.getCurrentUser!.toJson().toString()),
        ]));
  }
}
