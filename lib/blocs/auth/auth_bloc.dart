
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/blocs/auth/auth_event.dart';
import 'package:notes_app/blocs/auth/auth_state.dart';
import 'package:notes_app/services/auth/auth_provider.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(AuthProvider provider) : super(const AuthStateUninitialized(isLoading: true)) {
    //Register
    on<AuthEventShouldRegister>(
      (event, emit) {
      emit(
        const AuthStateRegistering(
          exception: null, 
          isLoading:false,
        ));
      },
    );

    //Forgot password
    on<AuthEventForgotPassword>(
      (event, emit) async {
        final email = event.email;
        if (email == null) {
          emit(
            const AuthStateForgotPassword(
              exception: null, 
              hasSentEmail: false, 
              isLoading: false,
            ));
            return;
        }
        emit(const AuthStateForgotPassword(
          exception: null, 
          hasSentEmail: false, 
          isLoading: false,
        ));
        try {
          await provider.sendPasswordReset(toEmail: email);
          emit(
            const AuthStateForgotPassword(
              exception: null, 
              hasSentEmail: true, 
              isLoading: false,
            ));
        } on Exception catch (e) {
          emit(
             AuthStateForgotPassword(
              exception: e, 
              hasSentEmail: false, 
              isLoading: false,
            ));
        }
      }
    );

    //Send email verification
    on<AuthEventSendEmailVerification>((event, emit) async {
      await provider.sendEmailVerification();
      emit(state);
    },);
    //Register
    on<AuthEventRegister>((event, emit) async {
      try {
        final email = event.email;
        final password = event.password;
        await provider.createUser(
          email: email, 
          password: password,
        );
        emit(const AuthStateNeedsVerification(isLoading: false));
      } on Exception catch(e) {
        emit(AuthStateRegistering(
          exception: e, 
          isLoading: false,
        ));
      }
    },);

    //Initialize
    on<AuthEventInitialize>((event, emit) async {
      await provider.initialize();
      final user = provider.currentUser;
      if (user == null) {
        emit(
          const AuthStateLoggedOut(
            exception: null, 
            isLoading: false,
          ),
        );
      } else if (!user.isEmailVerified) {
        emit(const AuthStateNeedsVerification(isLoading: false));
      } else {
        emit(
          AuthStateLoggedIn(
            user: user, 
            isLoading: false,
          )
        );
      }
    });
    //Login
    on<AuthEventLogin>((event, emit) async {
      emit(const AuthStateLoggedOut(
        exception: null, 
        isLoading: true,
        loadingText: 'Please wait while we log you in..',
      ));
      final email = event.email;
      final password = event.password;
      try {
        final user = await provider.logIn(
          email: email, 
          password: password,
        );
        if (!user.isEmailVerified) {
          emit(const AuthStateLoggedOut(
            exception: null, 
            isLoading: false,
          ));
          emit(const AuthStateNeedsVerification(isLoading: false));
        } else {
          emit(
            const AuthStateLoggedOut(
              exception: null, 
              isLoading: false,
            ),
          );
          emit(AuthStateLoggedIn(
            user: user, 
            isLoading: false,
          ));
        }
      } on Exception catch(e) {
        emit(AuthStateLoggedOut(
          exception: e, 
          isLoading: false,
        ));
      }
    });
    //Logout
    on<AuthEventLogout>((event, emit) async {
      try {
        await provider.logOut();
        emit(
          const AuthStateLoggedOut(
            exception: null, 
            isLoading: false,
          ),
        );
      } on Exception catch(e) {
        emit(AuthStateLoggedOut(
          exception: e, 
          isLoading: false,
        ));
      }
    });
  }
}