import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> init() async {
  await Supabase.initialize(
    anonKey: "",
    url: "",
  );
}
