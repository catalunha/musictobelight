// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'controllers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$audioControllerHash() => r'5109700a48990e6c492b53a436f176b1b80130e6';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

abstract class _$AudioController
    extends BuildlessAutoDisposeAsyncNotifier<AudioState> {
  late final String url;

  FutureOr<AudioState> build(
    String url,
  );
}

/// See also [AudioController].
@ProviderFor(AudioController)
const audioControllerProvider = AudioControllerFamily();

/// See also [AudioController].
class AudioControllerFamily extends Family<AsyncValue<AudioState>> {
  /// See also [AudioController].
  const AudioControllerFamily();

  /// See also [AudioController].
  AudioControllerProvider call(
    String url,
  ) {
    return AudioControllerProvider(
      url,
    );
  }

  @override
  AudioControllerProvider getProviderOverride(
    covariant AudioControllerProvider provider,
  ) {
    return call(
      provider.url,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'audioControllerProvider';
}

/// See also [AudioController].
class AudioControllerProvider
    extends AutoDisposeAsyncNotifierProviderImpl<AudioController, AudioState> {
  /// See also [AudioController].
  AudioControllerProvider(
    String url,
  ) : this._internal(
          () => AudioController()..url = url,
          from: audioControllerProvider,
          name: r'audioControllerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$audioControllerHash,
          dependencies: AudioControllerFamily._dependencies,
          allTransitiveDependencies:
              AudioControllerFamily._allTransitiveDependencies,
          url: url,
        );

  AudioControllerProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.url,
  }) : super.internal();

  final String url;

  @override
  FutureOr<AudioState> runNotifierBuild(
    covariant AudioController notifier,
  ) {
    return notifier.build(
      url,
    );
  }

  @override
  Override overrideWith(AudioController Function() create) {
    return ProviderOverride(
      origin: this,
      override: AudioControllerProvider._internal(
        () => create()..url = url,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        url: url,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<AudioController, AudioState>
      createElement() {
    return _AudioControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is AudioControllerProvider && other.url == url;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, url.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin AudioControllerRef on AutoDisposeAsyncNotifierProviderRef<AudioState> {
  /// The parameter `url` of this provider.
  String get url;
}

class _AudioControllerProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<AudioController, AudioState>
    with AudioControllerRef {
  _AudioControllerProviderElement(super.provider);

  @override
  String get url => (origin as AudioControllerProvider).url;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
