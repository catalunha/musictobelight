# create
flutter create --project-name=musictobeligth --org br.com.musictobelight --platforms android,web,linux ./musictobelight


# pubspec.yaml
Configure o pubspec.yaml executando as linhas a seguir no terminal

## state manager
```
flutter pub add flutter_riverpod
flutter pub add riverpod_annotation
flutter pub add freezed_annotation
flutter pub add json_annotation

flutter pub add dev:riverpod_generator
flutter pub add dev:build_runner
flutter pub add dev:custom_lint
flutter pub add dev:riverpod_lint
flutter pub add dev:freezed
flutter pub add dev:json_serializable
```
## others
```
flutter pub add audioplayers
flutter pub add audio_session
flutter pub add just_audio
```

## analysis_options.yaml
Copia as linhas a seguir no final do arquivo analysis_options.yaml
```
# Riverpod
analyzer:
  plugins:
    - custom_lint
  exclude:
    - "**/*.g.dart"
    - "**/*.freezed.dart"
    - "docs"
  errors:
    invalid_annotation_target: ignore
```
