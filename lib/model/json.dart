typedef ValueToModel<T, E> = T Function(E value);

typedef MapToModel<T> = ValueToModel<T, Map<String, dynamic>>;

typedef ListToModel<T> = ValueToModel<T, List<dynamic>>;
