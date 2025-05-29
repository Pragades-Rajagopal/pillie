import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pillie_app/app/auth/services/auth_service.dart';
import 'package:pillie_app/app/user_inventory/services/user_database.dart';
import 'package:pillie_app/components/text_button.dart';
import 'package:pillie_app/components/text_form_field.dart';
import 'package:pillie_app/models/user_model.dart';
import 'package:pillie_app/utils/dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class EditUser extends StatefulWidget {
  final UserModel userInfo;
  const EditUser({
    super.key,
    required this.userInfo,
  });

  @override
  State<EditUser> createState() => _EditUserState();
}

class _EditUserState extends State<EditUser> {
  final db = UserDatabase();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _dobController = TextEditingController();
  final _bloodGroupController = TextEditingController();
  final _heightController = TextEditingController();
  final _weightController = TextEditingController();
  final _medicationController = TextEditingController();
  final _medicalNotesController = TextEditingController();
  final _organDonorController = TextEditingController();
  File? _imgFile;

  @override
  void initState() {
    super.initState();
    setState(() {
      _nameController.text = widget.userInfo.name ?? '';
      _dobController.text = widget.userInfo.dob ?? '';
      _bloodGroupController.text = widget.userInfo.bloodGroup ?? '';
      _heightController.text = widget.userInfo.height != null
          ? widget.userInfo.height.toString()
          : '';
      _weightController.text = widget.userInfo.weight != null
          ? widget.userInfo.weight.toString()
          : '';
      _medicationController.text = widget.userInfo.medications ?? '';
      _medicalNotesController.text = widget.userInfo.medicalNotes ?? '';
      _organDonorController.text = widget.userInfo.organDonor ?? '';
    });
  }

  // File

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

  dynamic sanitizeInput(TextEditingController controller) =>
      controller.text.isEmpty ? null : controller.text;

  void editUser() async {
    try {
      final user = AuthService().getCurrentUser();
      // Check if text fields are not null
      // if (_formKey.currentState!.validate()) {
      //   final imageUrl = await uploadImage();
      //   await db.editUser(UserModel(
      //     name: _nameController.text,
      //     img: imageUrl,
      //     dob: sanitizeInput(_dobController),
      //     height: _heightController.text.isNotEmpty
      //         ? int.tryParse(sanitizeInput(_heightController).toString())
      //         : null,
      //     weight: _weightController.text.isNotEmpty
      //         ? int.tryParse(sanitizeInput(_weightController).toString())
      //         : null,
      //     bloodGroup: sanitizeInput(_bloodGroupController),
      //     medicalNotes: sanitizeInput(_medicalNotesController),
      //     medications: sanitizeInput(_medicationController),
      //     organDonor: sanitizeInput(_organDonorController),
      //     parentUserId: user!["uid"],
      //   ));
      //   if (mounted) Navigator.pop(context);
      // }
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
                "Edit User",
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
                    if (widget.userInfo.img != null &&
                        widget.userInfo.img!.isNotEmpty) ...{
                      CircleAvatar(
                        radius: 160,
                        backgroundImage: NetworkImage('${widget.userInfo.img}'),
                      ),
                    },
                    const SizedBox(height: 16),
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
                      labelText: 'DOB (DD/MM/YYYY)',
                      textController: _dobController,
                      validator: (value) {
                        if (value!.isNotEmpty && value.length != 10) {
                          return "Enter in DD/MM/YYYY format";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    AppTextFormField(
                      labelText: 'Blood Group',
                      textController: _bloodGroupController,
                      validator: (value) {
                        if (value!.isNotEmpty && value.length <= 1) {
                          return "Enter the appropriate blood group";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: AppTextFormField(
                            labelText: 'Height (cms)',
                            textController: _heightController,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                          ),
                        ),
                        const SizedBox(width: 6),
                        Expanded(
                          child: AppTextFormField(
                            labelText: 'Weight (kg)',
                            textController: _weightController,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    AppTextFormField(
                      labelText: 'Medications',
                      textController: _medicationController,
                    ),
                    const SizedBox(height: 16),
                    AppTextFormField(
                      labelText: 'Medical Notes',
                      textController: _medicalNotesController,
                    ),
                    const SizedBox(height: 16),
                    AppTextFormField(
                      labelText: 'Organ Donor',
                      textController: _organDonorController,
                    ),
                    const SizedBox(height: 16),
                    AppTextButton(
                      buttonText: 'Upload New Profile Picture',
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
                    AppTextButton(buttonText: 'Edit', onTap: editUser),
                    const SizedBox(height: 24),
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
