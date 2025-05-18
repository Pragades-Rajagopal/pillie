import 'package:pillie_app/models/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UserDatabase {
  final SupabaseQueryBuilder database = Supabase.instance.client.from('users');

  Future addUser(UserModel user) async {
    try {
      await database.insert(user.toMap());
    } catch (e, stackTrace) {
      throw Error.throwWithStackTrace(e, stackTrace);
    }
  }
}
