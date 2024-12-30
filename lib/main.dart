import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_task_bloc_project/app/bloc/auth_bloc/auth_bloc.dart';
import 'package:social_media_task_bloc_project/app/bloc/post_bloc/post_event.dart';

import 'app/bloc/post_bloc/post_bloc.dart';

import 'app/screens/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthBloc(FirebaseAuth.instance),
        ),
        BlocProvider(
          create: (context) =>
              PostBloc(FirebaseFirestore.instance)..add(LoadPosts()),
        ),
      ],
      child: MaterialApp(
          title: 'Social Post',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: LoginScreen()),
    );
  }
}
