// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'controllers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$durationPlayerHash() => r'8d439e991b5fa1db36aed1dc361ba93c33f41af0';

/// See also [durationPlayer].
@ProviderFor(durationPlayer)
final durationPlayerProvider = AutoDisposeStreamProvider<Duration?>.internal(
  durationPlayer,
  name: r'durationPlayerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$durationPlayerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef DurationPlayerRef = AutoDisposeStreamProviderRef<Duration?>;
String _$positionPlayerHash() => r'7e15a37ca39ab0cf217730abb1d72283024f385b';

/// See also [positionPlayer].
@ProviderFor(positionPlayer)
final positionPlayerProvider = AutoDisposeStreamProvider<Duration>.internal(
  positionPlayer,
  name: r'positionPlayerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$positionPlayerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef PositionPlayerRef = AutoDisposeStreamProviderRef<Duration>;
String _$audioSourceHash() => r'bf00856be9d89a029d3a4aca2f0498ffe150263b';

/// See also [AudioSource].
@ProviderFor(AudioSource)
final audioSourceProvider =
    AutoDisposeNotifierProvider<AudioSource, String>.internal(
  AudioSource.new,
  name: r'audioSourceProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$audioSourceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$AudioSource = AutoDisposeNotifier<String>;
String _$audioControllerHash() => r'f13bcdcc622797eb9bac833bdbfc06c692d08569';

/// See also [AudioController].
@ProviderFor(AudioController)
final audioControllerProvider =
    AutoDisposeNotifierProvider<AudioController, AudioState>.internal(
  AudioController.new,
  name: r'audioControllerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$audioControllerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$AudioController = AutoDisposeNotifier<AudioState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
