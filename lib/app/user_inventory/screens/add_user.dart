import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pillie_app/app/user_inventory/services/user_database.dart';
import 'package:pillie_app/components/text_button.dart';
import 'package:pillie_app/components/text_form_field.dart';
import 'package:pillie_app/models/user_model.dart';
import 'package:pillie_app/utils/dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AddUser extends StatefulWidget {
  const AddUser({super.key});

  @override
  State<AddUser> createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  final db = UserDatabase();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _daysToRefillController = TextEditingController();
  final _attentionController = TextEditingController();

  // File
  File? _imgFile;

  Future pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() => _imgFile = File(image.path));
    }
  }

  Future<String?> uploadImage() async {
    final env = await parseDotEnv();
    if (_imgFile == null) return null;
    final fileName = DateTime.now().millisecondsSinceEpoch.toString();
    final path = 'uploads/$fileName';
    final imgPath = await Supabase.instance.client.storage
        .from('user-profile-picture')
        .upload(path, _imgFile!);
    final imageUrl = '${env["SUPABASE_URL"]}/storage/v1/object/public/$imgPath';
    return imageUrl;
    // TODO: add snack bar for max file size
  }

  void addUser() async {
    try {
      // Check if text fields are not null
      if (_formKey.currentState!.validate()) {
        final imageUrl = await uploadImage();
        await db.addUser(UserModel(
          name: _nameController.text,
          img: imageUrl,
          daysToRefill: int.parse(_daysToRefillController.text),
          itemsAttention: int.parse(_attentionController.text),
        ));
        _nameController.clear();
        _attentionController.clear();
        _daysToRefillController.clear();
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
                  color: Colors.black,
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
            padding: const EdgeInsets.symmetric(
              vertical: 18.0,
              horizontal: 14.0,
            ),
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
                    const SizedBox(height: 16),
                    AppTextButton(
                      buttonText: 'Upload Profile Picture',
                      onTap: pickImage,
                      buttonColor: Theme.of(context).colorScheme.primary,
                    ),
                    if (_imgFile != null) ...{
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Image Preview',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                          ),
                          CircleAvatar(
                            backgroundImage: FileImage(_imgFile!),
                            radius: 30.0,
                          ),
                        ],
                      ),
                    },
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
