// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_filter_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(TaskFilter)
const taskFilterProvider = TaskFilterProvider._();

final class TaskFilterProvider
    extends $NotifierProvider<TaskFilter, TaskFilterState> {
  const TaskFilterProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'taskFilterProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$taskFilterHash();

  @$internal
  @override
  TaskFilter create() => TaskFilter();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(TaskFilterState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<TaskFilterState>(value),
    );
  }
}

String _$taskFilterHash() => r'b36200c03c4d62622d8b53fac8c3ad6ecd77b1bf';

abstract class _$TaskFilter extends $Notifier<TaskFilterState> {
  TaskFilterState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<TaskFilterState, TaskFilterState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<TaskFilterState, TaskFilterState>,
              TaskFilterState,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
