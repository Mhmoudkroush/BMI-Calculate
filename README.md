# BMI Calculator

A clean, responsive Flutter application that calculates Body Mass Index (BMI) across two screens, built with the **BLoC (Cubit)** state management pattern.

---

## Table of Contents

- [Overview](#overview)
- [Features](#features)
- [Tech Stack](#tech-stack)
- [Getting Started](#getting-started)
- [Project Structure](#project-structure)
- [Architecture](#architecture)
- [State Management](#state-management)
- [Responsive Design](#responsive-design)
- [BMI Calculation](#bmi-calculation)
- [Design Decisions](#design-decisions)
- [Known Limitations](#known-limitations)

---

## Overview

The app lets a user enter their gender, height, weight, and age on a home screen, then calculates and displays their BMI with a category and a short, friendly description on a result screen.

The project started as a `setState`-based app that passed values between screens through constructors. It was rebuilt so that:

1. All state lives in **Cubits**, with states and cubits kept in a dedicated `cubit/` folder.
2. The UI adapts to **any screen size**, from small phones to tablets and desktop windows.
3. Duplicated UI code (app bar, card container, action button) was extracted into **reusable shared widgets**.

---

## Features

- Gender selection (Male / Female)
- Height selection with a slider (100–200 cm)
- Weight and age selection with increment / decrement controls
- BMI calculation with four categories: Underweight, Normal, Overweight, Obese
- Input validation in the result cubit (a failure state for invalid values)
- Responsive layout: scales with screen width, scrolls on short screens, and switches to a two-column layout on wide screens

---

## Tech Stack

| Area | Choice |
| --- | --- |
| Framework | Flutter (Dart 3) |
| State management | [`flutter_bloc`](https://pub.dev/packages/flutter_bloc) (Cubit) |
| Value equality | [`equatable`](https://pub.dev/packages/equatable) |
| UI | Material |

**Requirements:** Flutter 3.10 or newer (Dart 3). The code uses sealed classes, pattern matching, and switch expressions.

---

## Getting Started

The Dart package name is `task_7`, so all imports use `package:task_7/...`.

```bash
# 1. Add the dependencies
flutter pub add flutter_bloc equatable

# 2. Fetch packages
flutter pub get

# 3. Run the app
flutter run
```

---

## Project Structure

```
lib/
├── main.dart
├── core/
│   ├── color_manager.dart          # App color palette
│   ├── style_manager.dart          # Shared text styles
│   ├── responsive.dart             # Responsive helpers (context.r, context.isWide)
│   └── widget/
│       ├── app_card.dart           # Rounded card container used across screens
│       ├── bmi_app_bar.dart        # Shared app bar
│       └── button.dart             # Primary action button
├── cubit/
│   ├── home_state.dart             # HomeState: HomeInitial, HomeUpdated, Gender enum
│   ├── home_cubit.dart             # Input logic (gender, height, weight, age)
│   ├── result_state.dart           # ResultState: ResultInitial, ResultSuccess, ResultFailure, BmiCategory enum
│   └── result_cubit.dart           # BMI calculation and categorization
└── features/
    ├── home/
    │   ├── home_screen.dart        # Input screen (single class)
    │   └── widgets/
    │       ├── gender_card.dart    # Selectable gender card
    │       └── age_and_weight.dart # Counter card for age and weight
    └── result/
        └── result_screen.dart      # Result screen (single class)
```

---

## Architecture

The app separates **UI**, **state**, and **shared building blocks**:

- **`cubit/`** holds all business logic and state. Cubits expose methods; screens only call them and render the current state.
- **`features/`** holds the screens and the widgets specific to them.
- **`core/`** holds reusable pieces: colors, styles, the responsive helper, and shared widgets.

### Data flow

```
HomeScreen ──watch/read──▶ HomeCubit ──emits──▶ HomeState
    │
    │  "Calculate" → Navigator.push
    │  BlocProvider(create: ResultCubit()..calculate(height, weight))
    ▼
ResultScreen ──watch──▶ ResultCubit ──emits──▶ ResultState
    │
    └─ "Re - Calculate" → Navigator.pop (inputs are preserved in HomeCubit)
```

- `HomeCubit` is provided once in `main.dart`, so the user's inputs survive navigating to the result screen and back.
- `ResultCubit` is created per navigation, scoped to the result route, and calculates immediately on creation.

---

## State Management

### Home

`HomeState` is a sealed class carrying the current inputs.

| State | Meaning |
| --- | --- |
| `HomeInitial` | Default values when the screen first opens (100 cm, 80 kg, age 22, no gender selected) |
| `HomeUpdated` | Emitted after any input changes |

`HomeCubit` methods:

| Method | Purpose |
| --- | --- |
| `selectGender(Gender)` | Select Male or Female |
| `setHeight(double)` | Update height, clamped to 100–200 cm |
| `incrementWeight()` / `decrementWeight()` | Adjust weight, clamped to 10–300 kg |
| `incrementAge()` / `decrementAge()` | Adjust age, clamped to 1–120 |

### Result

`ResultState` is a sealed class describing the calculation outcome.

| State | Meaning |
| --- | --- |
| `ResultInitial` | Before any calculation |
| `ResultSuccess` | Holds the computed `bmi` and its `BmiCategory` |
| `ResultFailure` | Holds an error message when height or weight is not greater than zero |

`ResultCubit.calculate({height, weight})` computes the BMI and emits either `ResultSuccess` or `ResultFailure`.

All states extend `Equatable`, so identical states do not trigger needless rebuilds.

---

## Responsive Design

Responsiveness is handled by `core/responsive.dart`, a single extension on `BuildContext`:

| Helper | Behavior |
| --- | --- |
| `context.r(size)` | Scales a size relative to a 400 px design width, clamped between 0.8× and 1.2× |
| `context.isWide` | `true` when the screen width is 800 px or more |
| `context.maxContentWidth` | 600 px on narrow screens, 900 px on wide screens |

How it is applied:

- **Scaling:** fonts, paddings, icons, and button sizes all use `context.r(...)`.
- **Constrained width:** content is centered with a maximum width, so it never stretches awkwardly on tablets or desktops.
- **Scrolling:** the home screen's inputs sit in a scroll view while the action button stays pinned at the bottom, so nothing overflows on small or landscape screens.
- **Two-column layout:** on wide screens the home screen places gender and height on the left, and weight and age on the right.
- **Overflow safety:** large numbers and button labels use `FittedBox`, so they shrink instead of overflowing.
- **Safe areas:** screens are wrapped in `SafeArea`.

---

## BMI Calculation

```
BMI = weight (kg) / height (m)²
```

| BMI | Category | Result color |
| --- | --- | --- |
| Below 18.5 | Underweight | Orange |
| 18.5 to below 25 | Normal | Green |
| 25 to below 30 | Overweight | Pink / red |
| 30 and above | Obese | Pink / red |

The result is displayed rounded to one decimal place.

---

## Design Decisions

- **Cubit over full Bloc.** The interactions are simple method calls with no event streams, so Cubit keeps the code short without losing testability.
- **Sealed states.** Sealed classes make `switch` expressions exhaustive: adding a new state produces a compile-time error wherever it is not handled.
- **Stateless counter widget.** `AgeAndWeightCard` no longer keeps its own copy of the value. The cubit owns it, which prevents the widget and the screen from drifting out of sync.
- **Shared components.** The app bar, card container, and action button were duplicated across screens in the original code and are now reusable widgets in `core/widget/`.
- **Single-class screens.** `HomeScreen` and `ResultScreen` each build everything inside `build()`, with no private widget classes or helper methods.
- **Input limits.** Weight (10–300) and age (1–120) are bounded so the controls cannot produce nonsensical values.

---

## Known Limitations

- **Gender and age are not used in the calculation.** They are stored in `HomeState` for possible future use, but standard BMI depends only on height and weight.
- **BMI is a screening estimate.** It does not account for muscle mass, age, or body composition, and is not a medical diagnosis.
- **Metric units only.** Height is in centimeters and weight in kilograms.
- **No automated tests are included yet.** The cubits are pure Dart logic and are good candidates for unit tests with `bloc_test`.
