# EasyTV Android 64-bit – Claude Code Anleitung

## Sprache
Antworte immer auf **Deutsch**, egal wie ich frage.

---

## Projekt-Übersicht

Dieses Repository ist ein **EasyTV Android 64-bit Fork** auf Basis von **Kodi Omega (21)**.

EasyTV ist ein stark angepasster Kodi-Fork. Die Windows-Version existiert separat.
Dieses Repo hier ist ausschließlich für den **Android-Build (ARM64, 64-bit)**.

- Native Lib: `libeasytv.so`
- Ziel-Plattform: **Android 16 (API 36)**, abwärtskompatibel wenn möglich
- **16KB Page Size** (`-C,-z,max-page-size=16384`)
- Package: `app.easytv.org`
- Alter Fork (Referenz, nicht bearbeiten): `/home/sven/easytv`

---

## Build-Umgebung

Die Build-Umgebung auf diesem Ubuntu-System muss **komplett neu eingerichtet** werden.
Folgende Tools werden benötigt und müssen ggf. neu heruntergeladen werden:

- **Android NDK** (empfohlen: r28c oder aktueller)
- **Android SDK** mit Build-Tools für API 36
- **CMake** (Kodi-kompatible Version)
- **Gradle / Android Studio** für den APK-Build
- **Python 3.x** für Kodi-Buildsystem-Scripts
- **ccache** für schnellere Rebuilds

Wenn Tools fehlen, weise mich darauf hin und hilf mir beim Einrichten.

---

## Projektstruktur (Orientierung)

```
easytv-64/              ← dieses Repository (Kodi Omega Basis)
├── cmake/              ← Kodi Build-System
├── xbmc/               ← Kodi Core (C++)
├── tools/
│   └── buildsteps/
│       └── android/    ← Android-spezifische Build-Scripts
├── project/
│   └── android/        ← Android Studio Projekt, build.gradle, Java-Dateien
└── CLAUDE.md           ← diese Datei
```

---

## Wichtige Regeln

- **Immer ARM64-only** – niemals armeabi-v7a hinzufügen
- **16KB Page Size** muss in allen nativen Libs berücksichtigt sein
- Wenn du dir bei einer Änderung nicht sicher bist, **frag zuerst**
- Bevor du große Refactorings machst, zeig mir den Plan
- Fehlermeldungen immer **vollständig** ausgeben, nicht kürzen

---

## Hilfreiche Befehle (werden ergänzt)

```bash
# Wird befüllt sobald Build-Umgebung steht
```
