import 'package:rxdart/rxdart.dart';

const String defaultKey = "NaqshSoft";

class Bus {
  PublishSubject _subjects = PublishSubject();

  String _tag = "";

  PublishSubject get subject => _subjects;

  String get tag => _tag;

  Bus(String tag) {
    _tag = tag;
    _subjects = PublishSubject();
  }

  Bus.create() {
    _subjects = PublishSubject();
    _tag = defaultKey;
  }

  dispose() {
    _subjects.close();
  }
}

class RxBus {
  static final RxBus _singleton = RxBus._internal();

  factory RxBus() {
    return _singleton;
  }

  RxBus._internal();

  static final List<Bus> _list = <Bus>[];

  static RxBus get singleton => _singleton;

  static Stream<T> register<T>({required String tag}) {
    Bus eventBus;
    if (_list.isNotEmpty) {
      // ignore: avoid_function_literals_in_foreach_calls
      _list.forEach((bus) {
        if (bus.tag == tag) {
          eventBus = bus;
          return;
        }
      });
      eventBus = Bus(tag);
      _list.add(eventBus);
    } else {
      eventBus = Bus(tag);
      _list.add(eventBus);
    }
    return eventBus.subject.stream.where((event) => event is T).cast<T>();
  }

  static void post(event, {tag}) {
    for (var rxBus in _list) {
      if (tag != null && tag != defaultKey && rxBus.tag == tag) {
        rxBus.subject.sink.add(event);
      } else if ((tag == null || tag == defaultKey) &&
          rxBus.tag == defaultKey) {
        rxBus.subject.sink.add(event);
      }
    }
  }

  static void destroy({tag}) {
    var toRemove = [];
    for (var rxBus in _list) {
      if (tag != null && tag != defaultKey && rxBus.tag == tag) {
        rxBus.subject.close();
        toRemove.add(rxBus);
      } else if ((tag == null || tag == defaultKey) &&
          rxBus.tag == defaultKey) {
        rxBus.subject.close();
        toRemove.add(rxBus);
      }
    }
    for (var rxBus in toRemove) {
      _list.remove(rxBus);
    }
  }
}
