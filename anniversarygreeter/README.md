# Anniversary Greeter 💛

A small, playful Flutter app that hides a personal anniversary message behind a
"secret question" gate. Only someone who knows the right wedding date and venue
can unlock the message — and when they do, they're rewarded with a shower of
confetti.

The app title shown to the user is *"What Does that Button Do..?"* — the mystery
is the whole point.

## How It Works

1. The home screen shows a single button:
   **"Click Here to See if you are the Chosen One"**.
2. Tapping it opens a dialog asking two questions:
   - **The date you got married** (chosen with a date picker)
   - **The building in which you got married** (free text)
3. If the answers match the expected values, the secret message is unlocked and
   confetti starts falling.
4. Once unlocked, the button toggles the confetti animation on and off.

If the answers are wrong, nothing happens — the dialog simply won't close, so
the message stays locked.

## Project Structure (`lib/`)

| File | Responsibility |
|------|----------------|
| `main.dart` | App entry point and UI. Defines `MyApp` (root `MaterialApp`) and `MyHomePage`, a stateful widget that manages the unlock state, the confetti controller, and the button that drives the whole experience. |
| `questions.dart` | The `questions(BuildContext)` function. Shows the `AlertDialog` with the date and location inputs, validates the answers, and returns a `Future<bool>` indicating whether the message was unlocked. |
| `secret_message.dart` | The `secretMessage(bool)` function. Returns the widget containing the hidden anniversary note revealed on success. |

### Flow between files

```
main.dart  ──(button pressed)──▶  questions.dart
   │                                    │
   │        Future<bool> success ◀──────┘
   ▼
if unlocked ──▶ secret_message.dart  +  confetti animation
```

## Key Implementation Details

- **State management** — `_MyHomePageState` tracks three flags:
  `messageUnlocked` (has the gate been passed), `confettiDropping` (is confetti
  currently playing), and a `ConfettiController` that drives the animation.
- **Confetti** — provided by the [`confetti`](https://pub.dev/packages/confetti)
  package. A `ConfettiWidget` is layered over the whole screen in a `Stack`,
  set to loop and explode in all directions.
- **The answer check** lives in `questions.dart`: the submission succeeds only
  when the picked date equals `DateTime(2018, 11, 20)` **and** the location text
  contains `"grace"` (case-insensitive). Change these values to personalize the
  app for a different couple.
- **The message itself** is hard-coded in `secret_message.dart` and can be
  edited freely.

## Dependencies

- `flutter` (SDK)
- [`confetti`](https://pub.dev/packages/confetti) `^0.6.0` — celebration animation
- `cupertino_icons` `^1.0.6`

Requires the Dart SDK `>=3.4.1 <4.0.0`.

## Running the App

```bash
flutter pub get
flutter run
```

## Personalizing It

To adapt this app for your own anniversary:

1. Edit the correct answers in `lib/questions.dart` (the `pickedDate` and
   location checks).
2. Edit the message and recipient's name in `lib/secret_message.dart`.
3. Optionally change the app/button text in `lib/main.dart`.

---

*A little Flutter love letter. 💕*
