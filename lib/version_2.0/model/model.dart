typedef JsonDecode<T> = T Function(Map<String, dynamic>);

List<S> jsonToModelList<S>(dynamic json, JsonDecode<S> decode) {
  try {
    List<dynamic> list = json as List<dynamic>;
    List<S> result = [];
    for (var v in list) {
      try {
        result.add(decode(v as Map<String, dynamic>));
      } catch (e) {
        print(e);
        continue;
      }
    }
    return result;
  } catch (e) {
    print(e);
    return [];
  }
}
