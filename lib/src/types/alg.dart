enum IdTokenSignAlgorithm {
  // ignore: constant_identifier_names
  PS256,
  // ignore: constant_identifier_names
  RS256;

  String get value {
    switch (this) {
      case IdTokenSignAlgorithm.PS256:
        return 'PS256';
      case IdTokenSignAlgorithm.RS256:
        return 'RS256';
    }
  }
}
