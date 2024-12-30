import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:social_media_task_bloc_project/app/bloc/post_bloc/post_event.dart';
import 'package:social_media_task_bloc_project/app/bloc/post_bloc/post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final FirebaseFirestore firestore;
  final postCollection = FirebaseFirestore.instance.collection('posts');
  PostBloc(this.firestore) : super(PostInitial()) {
    on<LoadPosts>(
      (event, emit) async {
        emit(
          PostLoading(),
        );
        await Future.delayed(Duration(seconds: 1));
        try {
          print(".........................inside try ");
          await firestore.collection('posts').get().then(
            (snapshot) {
              print(".........................inside try  ?");
              final posts = snapshot.docs.map(
                (doc) {
                  return {
                    "message": doc['message'] ?? '',
                    "username": doc['username'] ?? 'Anonymous',
                  };
                },
              ).toList();
              print(posts.toList());
              emit(PostLoaded(posts));
            },
          );
        } catch (e) {
          emit(
            PostError(
              e.toString(),
            ),
          );
        }
      },
    );

    on<AddPost>((event, emit) async {
      emit(
        PostLoading(),
      );
      try {
        await firestore.collection('posts').add({
          "message": event.message,
          "username": event.userID, // Replace with actual username from auth.
          "timestamp": FieldValue.serverTimestamp(),
        });

        // emit(PostInitial());
        add(LoadPosts());
      } catch (e) {
        emit(PostError(e.toString()));
      }
    });
  }
}
