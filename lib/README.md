# lib

The main repository for the application’s code.

The main app file which includes initializing and debugging the app as well as the main app state handler.

Implementations of the packages directory (The UI).

Uses cubits to interact with the data.

```
lib/
  ├── app/                       # Main app logic
  ├── features/                  # Implemented features of the app
  ├── theme/                     # Theme cubit
  ├── l10n/                      # Handles app localizations
  └── main.dart                  # Entry point for the app
```

## Handling Data and State: 💾

This app uses cubits to handle state along side the work done in the backend.

`UI <--> Cubit <--> Repository`

UI -> the end point for the user

Cubit -> emits and handles state changes

Repositories -> handle requests and responses to the API's
