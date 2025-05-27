import 'package:pillie_app/models/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HomeDatabase {
  String userId;

  HomeDatabase(this.userId);

  final SupabaseQueryBuilder database = Supabase.instance.client.from('users');

  Stream<List<UserModel>> get stream => Supabase.instance.client
      .from('users')
      .stream(
        primaryKey: ["id"],
      )
      .eq("parent_user_id", userId)
      .map(
          (data) => data.map((userMap) => UserModel.fromMap(userMap)).toList());
}
