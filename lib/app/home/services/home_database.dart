import 'package:pillie_app/app/home/services/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HomeDatabase {
  final SupabaseQueryBuilder database = Supabase.instance.client.from('users');

  final stream = Supabase.instance.client.from('users').stream(
    primaryKey: ["id"],
  ).map((data) => data.map((userMap) => UserModel.fromMap(userMap)).toList());
}
