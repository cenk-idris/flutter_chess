
# Flutter Chess

Flutter Chess is a Flutter application that allows users to create or join chess rooms and play chess in real-time. The app uses Firebase Realtime Database as the backend to manage users, rooms, and game states. The project leverages the BLoC pattern for state management and real-time updates.

## Features

- User Registration
- Create and Join Chess Rooms
- Real-time Chess Gameplay
- Pawn Promotion and Castling
- End Game Detection (Checkmate and Draw)
- Room and Game State Management with Firebase and BLoC
- Responsive UI

## Screenshots

| User Registration                                             | Questionscreen                                            | Scorescreen                                         |
|---------------------------------------------------------------|-----------------------------------------------------------|-----------------------------------------------------|
| ![userRegistration](/assets/screenshots/userRegistration.png) | ![Question screen of QuizApp](/assets/questionscreen.jpg) | ![Score screen of QuizApp](/assets/scorescreen.jpg) |


## Technologies Used

- [Flutter](https://flutter.dev/)
- [Firebase Realtime Database](https://firebase.google.com/docs/database/flutter/start)
- [Bloc](https://bloclibrary.dev/#/)
- [Simple Chess Board (Dart Package)](https://pub.dev/packages/simple_chess_board)
- [Chess Engine (Dart Package)](https://pub.dev/packages/chess)

## Project Structure

```
lib
├── blocs
│   ├── lounge_cubit
│   │   └── lounge_cubit.dart
│   ├── room_cubit
│   │   ├── room_cubit.dart
│   │   └── room_state.dart
│   └── user_cubit
│       ├── user_cubit.dart
│       └── user_state.dart
├── models
│   ├── game_model.dart
│   ├── invite_model.dart
│   ├── room_model.dart
│   └── user_model.dart
├── screens
│   ├── create_game_screen.dart
│   ├── game_screen.dart
│   ├── invites_screen.dart
│   ├── lounge_screen.dart
│   ├── main_screen.dart
│   ├── registration_screen.dart
│   └── room_detail_screen.dart
├── services
│   └── firebase_RTDB_service.dart
├── app.dart
├── firebase_options.dart
└── main.dart
```


## Getting Started
Below getting started instructions assumes you are using macOS,

### Prerequisites

- Xcode (iOS)
- Latest iOS SDK for running iOS Simulator on macOS
- [Flutter Version Manager](https://fvm.app/documentation/getting-started)
- Your own Firebase project with Realtime Database created

### Running the App

Follow these steps to run the Flutter Chess app:

1. Clone the repository:

    ```bash
    git clone git@github.com:cenk-idris/flutter_chess.git
    ```

2. Navigate to the project directory:

    ```bash
    cd flutter_chess
    ```

3. Add Firebase to the project. Follow the instructions [here](https://firebase.google.com/docs/flutter/setup?platform=ios) to set up Firebase for iOS.

4. Use the correct Flutter version:

    ```bash
    fvm use
    ```

5. Clean the project:

    ```bash
    fvm flutter clean
    ```

6. Get the project dependencies:

    ```bash
    fvm flutter pub get
    ```

7. Launch the iOS simulator:

    ```bash
    fvm flutter emulators --launch apple_ios_simulator
    ```

8. Run the app in debug mode:

    ```bash
    fvm flutter run --debug
    ```

9. You will be prompted to choose the available target device. Pick the Simulator's iOS instance you just launched.

10. Cross your fingers :)

## Usage

### Registration and Login

- Users can register with a username.

### Creating & Joining a Room

- After registration, users can create a new chess room or join to available rooms listed in the lounge.
- The user who creates the room becomes the host and the one joins becomes guest.
- The guest user will see the host’s details and wait for the host to start the game.

### Playing Chess

- Once the host starts the game, both players can make moves in real-time.
- The game board updates for both players as they make moves.
- Pawn promotion is handled, and players can promote their pawns.
- Castling is available, allowing players to perform both kingside and queenside castling.
- The game detects checkmate and draw conditions, and the game ends accordingly.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

## Acknowledgements

- [Flutter](https://flutter.dev/)
- [Firebase](https://firebase.google.com/)
- [Bloc](https://bloclibrary.dev/#/)
- [Simple Chess Board (Dart Package)](https://pub.dev/packages/simple_chess_board)
- [Chess Engine (Dart Package)](https://pub.dev/packages/chess)
