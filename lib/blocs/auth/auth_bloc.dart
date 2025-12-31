// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:notes_app/blocs/auth/auth_event.dart';
// import 'package:notes_app/blocs/auth/auth_state.dart';
// import 'package:notes_app/services/auth/auth_provider.dart';

// class AuthBloc extends Bloc<AuthEvent, AuthState> {
//   AuthBloc(AuthProvider provider) : super(const AuthStateUninitialized(isLoading: true)) {
//     on<AuthEventInitialize>((event, emit) async {
//       await provider.initialize();
//       final user = provider.currentUser;
//       if(user == null) {
//         emit(
//           const AuthStateLoggedOut(
//             exception: null, 
//             isLoading: false,
//           ),
//         );
//       } else if (!user.isEmailVerified) {
//         emit(const Auth);
//       }
//     },);
//   }
// }