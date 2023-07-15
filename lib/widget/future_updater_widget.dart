import 'package:flutter/material.dart';
import 'dart:async';

typedef LoadingBuilder = Widget Function(BuildContext);
typedef DataBuilder<T> = Widget Function(BuildContext, T?);
typedef ErrorBuilder<T> = Widget Function(BuildContext, dynamic, T?);

class FutureUpdater<T> extends StatefulWidget {
  const FutureUpdater({
    super.key,
    this.loadingBuilder,
    required this.builder,
    this.errorBuilder,
    required this.future,
    this.initialData,
  });

  final LoadingBuilder? loadingBuilder;

  final DataBuilder<T> builder;
  final T? initialData;

  final ErrorBuilder<T>? errorBuilder;
  final Future<T>? future;

  @override
  State<FutureUpdater<T>> createState() => _FutureUpdaterState<T>();
}

class _FutureUpdaterState<T> extends State<FutureUpdater<T>> {
  Object? _activeCallbackIdentity;
  late AsyncSnapshot<T> _snapshot;

  // TODO: Поправить initialData

  T? _data;
  dynamic _error;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _getData();
    _snapshot = widget.initialData == null
        ? AsyncSnapshot<T>.nothing()
        : AsyncSnapshot<T>.withData(
            ConnectionState.none, widget.initialData as T);
    _subscribe();
  }

  @override
  void didUpdateWidget(covariant FutureUpdater<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    _getData();
    if (oldWidget.future != widget.future) {
      if (_activeCallbackIdentity != null) {
        _unsubscribe();
        _snapshot = _snapshot.inState(ConnectionState.none);
      }
      _subscribe();
    }
  }

  void _subscribe() {
    if (widget.future != null) {
      final Object callbackIdentity = Object();
      _activeCallbackIdentity = callbackIdentity;
      widget.future!.then<void>((T data) {
        if (_activeCallbackIdentity == callbackIdentity) {
          setState(() {
            _snapshot = AsyncSnapshot<T>.withData(ConnectionState.done, data);
          });
        }
      }, onError: (Object error, StackTrace stackTrace) {
        if (_activeCallbackIdentity == callbackIdentity) {
          setState(() {
            _snapshot = AsyncSnapshot<T>.withError(
                ConnectionState.done, error, stackTrace);
          });
        }
        assert(() {
          if (FutureBuilder.debugRethrowError) {
            Future<Object>.error(error, stackTrace);
          }
          return true;
        }());
      });
      if (_snapshot.connectionState != ConnectionState.done) {
        _snapshot = _snapshot.inState(ConnectionState.waiting);
      }
    }
  }

  void _unsubscribe() {
    _activeCallbackIdentity = null;
  }

  @override
  void dispose() {
    _unsubscribe();
    super.dispose();
  }

  Future<void> _getData() async {
    if (widget.future != null) {
      await widget.future!.then(
        (data) {
          setState(() {
            _data = data;
          });
        },
        onError: (e) {
          setState(() {
            _error = e;
          });
        },
      );
      _loading = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final errorBuilder = widget.errorBuilder;

    if (_error != null && errorBuilder != null) {
      return errorBuilder(context, _error, _data);
    }

    final loadingBuilder = widget.loadingBuilder;

    if (_data == null && loadingBuilder != null && _loading) {
      return loadingBuilder(context);
    }

    return widget.builder(context, _data);
  }
}
