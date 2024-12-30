import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_task_bloc_project/app/bloc/post_bloc/post_bloc.dart';
import 'package:social_media_task_bloc_project/app/bloc/post_bloc/post_state.dart';
import 'package:social_media_task_bloc_project/app/custom_widgets/custom_snackbar.dart';
import '../bloc/post_bloc/post_event.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.userId});

  final String userId;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late TextEditingController messageController;

  @override
  void initState() {
    super.initState();
    messageController = TextEditingController();
  }

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          PostBloc(FirebaseFirestore.instance)..add(LoadPosts()),
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Welcome to Social Post',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),
              ),
              IconButton(
                onPressed: () {
                  // Add logout functionality here if needed
                },
                icon: const Icon(Icons.logout_sharp),
              ),
            ],
          ),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: messageController,
                      decoration: const InputDecoration(
                        hintText: 'Enter your message...',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () {
                      if (messageController.text.isNotEmpty) {
                        context.read<PostBloc>().add(
                            AddPost(messageController.text, widget.userId));

                        messageController.clear();
                      } else {
                        customSnackbar(context, "Please enter a message.");
                      }
                    },
                    child: const Text('Post'),
                  ),
                ],
              ),
            ),
            Expanded(
              child: BlocBuilder<PostBloc, PostState>(
                builder: (context, state) {
                  if (state is PostLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is PostLoaded) {
                    return ListView.builder(
                      itemCount: state.posts.length,
                      itemBuilder: (context, index) {
                        final post = state.posts[index];
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.pink[100],
                            radius: 25,
                            child: const Icon(Icons.person),
                          ),
                          title: Text(post['username']),
                          subtitle: Text(post['message']),
                        );
                      },
                    );
                  } else if (state is PostError) {
                    return Center(child: Text('Error: ${state.error}'));
                  }
                  return const Center(child: Text('No posts yet!'));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
