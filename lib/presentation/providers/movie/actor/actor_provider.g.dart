// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'actor_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$actorHash() => r'2aaf55b8fd448b6b1b21a4505485b011b5b3f4f9';

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

/// See also [actor].
@ProviderFor(actor)
const actorProvider = ActorFamily();

/// See also [actor].
class ActorFamily extends Family<AsyncValue<List<Actor>>> {
  /// See also [actor].
  const ActorFamily();

  /// See also [actor].
  ActorProvider call({
    required int movieId,
  }) {
    return ActorProvider(
      movieId: movieId,
    );
  }

  @override
  ActorProvider getProviderOverride(
    covariant ActorProvider provider,
  ) {
    return call(
      movieId: provider.movieId,
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
  String? get name => r'actorProvider';
}

/// See also [actor].
class ActorProvider extends AutoDisposeFutureProvider<List<Actor>> {
  /// See also [actor].
  ActorProvider({
    required int movieId,
  }) : this._internal(
          (ref) => actor(
            ref as ActorRef,
            movieId: movieId,
          ),
          from: actorProvider,
          name: r'actorProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$actorHash,
          dependencies: ActorFamily._dependencies,
          allTransitiveDependencies: ActorFamily._allTransitiveDependencies,
          movieId: movieId,
        );

  ActorProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.movieId,
  }) : super.internal();

  final int movieId;

  @override
  Override overrideWith(
    FutureOr<List<Actor>> Function(ActorRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ActorProvider._internal(
        (ref) => create(ref as ActorRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        movieId: movieId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<Actor>> createElement() {
    return _ActorProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ActorProvider && other.movieId == movieId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, movieId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin ActorRef on AutoDisposeFutureProviderRef<List<Actor>> {
  /// The parameter `movieId` of this provider.
  int get movieId;
}

class _ActorProviderElement
    extends AutoDisposeFutureProviderElement<List<Actor>> with ActorRef {
  _ActorProviderElement(super.provider);

  @override
  int get movieId => (origin as ActorProvider).movieId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
