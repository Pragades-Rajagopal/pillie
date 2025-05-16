import 'package:flutter/material.dart';
import 'package:pillie_app/app/user_inventory/services/user_database.dart';
import 'package:pillie_app/components/text_button.dart';
import 'package:pillie_app/components/text_form_field.dart';
import 'package:pillie_app/models/user_model.dart';

class AddUser extends StatefulWidget {
  const AddUser({super.key});

  @override
  State<AddUser> createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  final db = UserDatabase();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _imgController = TextEditingController();
  final _daysToRefillController = TextEditingController();
  final _attentionController = TextEditingController();

  void addUser() async {
    try {
      // Check if text fields are not null
      if (_formKey.currentState!.validate()) {
        await db.addUser(UserModel(
          name: _nameController.text,
          img: _imgController.text,
          daysToRefill: int.parse(_daysToRefillController.text),
          itemsAttention: int.parse(_attentionController.text),
        ));
        _nameController.clear();
        _attentionController.clear();
        _daysToRefillController.clear();
        _imgController.clear();
        if (mounted) Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Something went wrong'),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            snap: false,
            pinned: false,
            floating: false,
            flexibleSpace: FlexibleSpaceBar(
              // titlePadding: const EdgeInsets.all(18),
              title: const Text(
                "Add User",
                style: TextStyle(
                  fontSize: 22.0,
                ),
              ),
              background: Container(
                color: Colors.lightGreen[200],
              ),
              stretchModes: const [StretchMode.fadeTitle],
            ),
            // expandedHeight: 120,
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(vertical: 18.0),
            sliver: SliverToBoxAdapter(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AppTextFormField(
                      labelText: 'Name',
                      textController: _nameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Name is mandatory";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    AppTextFormField(
                      labelText: 'Image Url',
                      textController: _imgController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Image Url is mandatory";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    AppTextFormField(
                      labelText: 'Days to refill',
                      textController: _daysToRefillController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Mandatory";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    AppTextFormField(
                      labelText: 'Items need attention',
                      textController: _attentionController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Mandatory";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 14),
                    AppTextButton(buttonText: 'Add', onTap: addUser),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
