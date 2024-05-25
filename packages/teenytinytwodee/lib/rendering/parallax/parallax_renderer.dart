import 'package:teenytinytwodee/rendering/parallax/parallax_layer.dart';

class ParallaxRenderer {
  ParallaxRenderer(int totalLayers, List<double> layerSpeeds) {
    for (int i = 0; i < totalLayers; i++) {
      _layers.add([]);
    }

    _layerSpeed.addAll(layerSpeeds);
  }

  final List<double> _layerSpeed = [];
  final List<List<ParallaxLayer>> _layers = [];

  void addLayer(int layerNumber, ParallaxLayer layer) {
    _layers[layerNumber].add(layer);
  }

  void render(num x) {
    for (int i = 0; i < _layers.length; i++) {
      for (final layer in _layers[i]) {
        layer.render(_layerSpeed[i] * x);
      }
    }
  }
}
