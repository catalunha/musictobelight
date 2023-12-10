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

## API
```
flutter pub add dio
flutter pub add retrofit
flutter pub add dev:retrofit_generator

flutter pub add shared_preferences
```

## others
```
flutter pub add audioplayers
flutter pub add validatorless
flutter pub add intl
flutter pub add url_launcher
flutter pub add image_picker
flutter pub add file_picker
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