// Copyright (c) 2016, Devon Carew. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:async';

class Debounce<T> implements StreamTransformer<T, T> {
  final Duration duration;

  Debounce(this.duration);

  Stream<T> bind(Stream<T> stream) {
    StreamController<T> controller = new StreamController();

    Timer timer;
    StreamSubscription<T> sub;

    sub = stream.listen((T data) {
      timer?.cancel();
      timer = new Timer(duration, () => controller.add(data));
    }, onDone: () => sub.cancel());

    return controller.stream;
  }
}
