Steps to configure Firebase to work with Flutter app:

1. Create a project in Firebase.
2. Enable any Sign-in method.
3. Install the Firebase CLI (https://firebase.google.com/docs/flutter/setup?platform=android)
4. Run 'firebase login' in the terminal.
5. Run 'flutter pub global activate flutterfire_cli'
6. run 'flutterfire configure'
7. Choose your project
8. Add your app name


# Flutter Clean Architecture with Firebase

This project demonstrates the use of advanced topics such as Clean Architecture, Firebase integration, Bloc pattern for state management, and Hive for local storage.

## Structure

The application follows the principles of Clean Architecture and is structured into three primary layers:

- **Data Layer**: This layer includes the models, data sources (remote and local), and the repositories. It interacts with Firebase for remote data and Hive for local data.

- **Domain Layer**: This layer contains the core business logic (use cases) and entity definitions.

- **Presentation Layer**: This is where the UI-related logic resides. It uses Bloc for state management.

The application has three main features/modules:

- **Auth**: Deals with user authentication, both locally and remotely through Firebase.

- **Feed** (not included in the preview): Handles the creation, fetching, and management of user posts.

- **Chat** (not included in the preview): Manages real-time chat functionality between users.

All modules follow the above-mentioned architectural layers and are organized accordingly within their respective directories.

## Usage

- **User Authentication**: User can register, login and logout.

- **Feed Posting**: Users can view posts. Coming soon: add and delete posts. 

- **Chat**: Users can chat with other users in real-time.

Please note that the code is written in a way to be easily read, extended, and maintained. This is in line with the principles of Clean Architecture, which aims to separate concerns and make the codebase more understandable and flexible.

## Customization

Feel free to customize the code to suit your needs. The codebase is modular and flexible, making it easy to add, remove, or modify features.

## Dependencies

The application is built using various dependencies that aid in implementing its features:

- Firebase Core, Firestore, and Auth for backend operations.
- Hive for local database operations.
- Bloc for state management.
- Equatable, UUID, Built Value for data handling.
- Google Fonts and Flex Color Scheme for UI styling.
- Functional error handling with fpdart (not included in the preview)
- And several other for testing and mocking.
