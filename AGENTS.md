# AGENTS.md - Developer Guide

This document provides guidelines for agents working on this Flutter desktop application.

## Project Overview

- **Framework**: Flutter (desktop, web, mobile)
- **State Management**: flutter_bloc (BLoC pattern)
- **HTTP Client**: dio
- **Routing**: go_router
- **DI**: get_it
- **Form Validation**: formz
- **Local Storage**: hive
- **Architecture**: Feature-based with BLoC pattern

## Build / Lint / Test Commands

### Running the App
```bash
# Run on desktop (default)
flutter run

# Run on specific platform
flutter run -d windows
flutter run -d macos
flutter run -d linux
```

### Linting & Analysis
```bash
# Run static analysis (lint + type checking)
flutter analyze

# Run with fix suggestions
flutter analyze --fix
```

### Testing
```bash
# Run all tests
flutter test

# Run a single test file
flutter test test/widget_test.dart

# Run tests with coverage
flutter test --coverage

# Run specific test by name
flutter test --name "test_name"
```

### Building
```bash
# Build for current platform
flutter build

# Build for specific platforms
flutter build windows
flutter build macos
flutter build linux
flutter build web

# Build with specific build name/number
flutter build windows --build-name="1.0.0" --build-number="1"
```

### Dependency Management
```bash
# Get dependencies
flutter pub get

# Upgrade dependencies
flutter pub upgrade

# Run dependency runner (e.g., build_runner)
flutter pub run build_runner build
```

## Code Style Guidelines

### Imports
- Use package imports: `import 'package:backsystem_desktop_app/features/authentication/authentication.dart';`
- Group imports: dart core → external packages → relative imports
- Use barrel exports (`login.dart`, `authentication.dart`) for feature modules

### Formatting
- 2-space indentation (Flutter default)
- Maximum line length: 80 characters (soft limit)
- Use trailing commas for better formatting
- Run `flutter format .` before committing

### Naming Conventions

| Element | Convention | Example |
|---------|------------|---------|
| Files | snake_case | `login_bloc.dart`, `user_repository.dart` |
| Classes | PascalCase | `LoginBloc`, `AuthenticationRepository` |
| Methods/Functions | camelCase | `getSetting()`, `copyWith()` |
| Private members | _camelCase | `_authenticationRepository` |
| Constants | camelCase | `initialStatus` |
| Enums | PascalCase | `AuthenticationStatus` |

### BLoC Pattern Structure

Each feature follows this structure:
```
features/
  feature_name/
    bloc/
      feature_bloc.dart      # Main bloc file
      feature_event.dart     # Events (part of)
      feature_state.dart     # States (part of)
    repository/
      feature_repository.dart
    models/
      model.dart
    view/
      feature_page.dart
    feature.dart            # Barrel export
```

### State Classes
- Use `final class` with `Equatable`
- Use `copyWith()` pattern for immutable updates
- Use `const` constructors when possible
```dart
final class LoginState extends Equatable {
  const LoginState({this.status = FormzSubmissionStatus.initial, ...});

  LoginState copyWith({FormzSubmissionStatus? status, ...}) {
    return LoginState(status: status ?? this.status, ...);
  }
}
```

### Event Classes
- Use `sealed class` for base events
- Use `final class` for concrete events
```dart
sealed class LoginEvent extends Equatable {
  const LoginEvent();
}

final class LoginSubmitted extends LoginEvent {
  const LoginSubmitted();
}
```

### Model Classes
- Use `FormzInput` for form validation models
- Implement validation with enums for error types
```dart
enum UsernameValidationError { empty }

class Username extends FormzInput<String, UsernameValidationError> {
  const Username.pure() : super.pure('');
  const Username.dirty([super.value = '']) : super.dirty();

  @override
  UsernameValidationError? validator(String value) {
    return value.isEmpty ? UsernameValidationError.empty : null;
  }
}
```

### Error Handling
- Use try-catch in async operations
- Emit failure states in BLoCs
- Handle Dio errors appropriately
```dart
try {
  await _authenticationRepository.logIn(...);
  emit(state.copyWith(status: FormzSubmissionStatus.success));
} catch (err) {
  emit(state.copyWith(status: FormzSubmissionStatus.failure));
}
```

### UI Components
- Use `const` constructors for stateless widgets
- Prefer `StatelessWidget` over `StatefulWidget` when no state is needed
- Use `WidgetTester` for widget testing

### Dependency Injection
- Register singletons in `main.dart` using GetIt
- Use constructor injection in BLoCs and Repositories

## Directory Structure

```
lib/
  core/
    config/        # App configuration, environment
    constants/    # App constants
    router/       # GoRouter configuration
    utils/         # Utility functions (http, auth, sign)
  features/
    authentication/
    login/
    user/
    home/
    splash/
    ticket_unissued/
  app.dart        # Root app widget
  main.dart       # Entry point
test/
  widget_test.dart
```

## Environment Files

Environment-specific configs are stored as `.env` files:
- `.env` - Default
- `.env.dev` - Development
- `.env.staging` - Staging
- `.env.prod` - Production
- `.env.test` - Testing

## Testing Conventions

- Place tests in `test/` directory
- Use `flutter_test` package
- Follow naming: `{feature}_test.dart` or `widget_test.dart`
- Use `WidgetTester` for widget interaction tests
