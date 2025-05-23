import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/features/home/manager/cubit/user_cubit/user_cubit.dart';
import 'package:todoapp/features/home/manager/cubit/user_cubit/user_state.dart';

class HomeTaskContentScreen extends StatelessWidget {
  const HomeTaskContentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Tasks'),
          ),
          body: const Center(
            child: Text('Task Content Screen'),
          ),
        );
      },
    );
  }
} 