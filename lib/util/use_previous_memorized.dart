import 'package:flutter_hooks/flutter_hooks.dart';

(T, T) usePreviousMemorized<T>(
  T Function() valueBuilder,
  T init, [
  List<Object?> keys = const <Object>[],
]) {
  final internal = useRef(init);
  final res = useMemoized(valueBuilder, keys);
  final prev = useState(init);

  useEffect(() {
    prev.value = internal.value;
    internal.value = res;
    return null;
  }, [res]);

  return (res, prev.value);
}
