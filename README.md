# Adithya Vardhan Reddy — Portfolio

Premium portfolio built with **Flutter Web + GetX**, inspired by Linear, Vercel, Stripe, and Raycast.

## Run

```bash
flutter pub get
flutter run -d chrome
```

## Build for web

```bash
flutter build web --release
```

## Structure

```
lib/
├── app/                  # Theme, routes, constants
├── controllers/          # GetX controllers
├── data/                 # Static portfolio content
├── models/               # Plain data models
├── views/home/sections/  # Page sections (hero, about, etc.)
└── widgets/              # Reusable UI components
```

## Stack

- Flutter (Web) — UI
- GetX — state, routing, theming
- google_fonts — Inter & JetBrains Mono
- flutter_animate — entrance animations
- url_launcher — external links
