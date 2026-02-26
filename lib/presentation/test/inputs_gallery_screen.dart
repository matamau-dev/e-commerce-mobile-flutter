import 'package:e_commerce/presentation/widgets/buttons/custom_button.dart';
import 'package:e_commerce/presentation/widgets/buttons/button_type.dart';
import 'package:e_commerce/presentation/widgets/inputs/custom_switch.dart';
import 'package:e_commerce/presentation/widgets/inputs/custom_checkbox.dart';
import 'package:e_commerce/presentation/widgets/inputs/custom_radio_group.dart';
import 'package:e_commerce/presentation/widgets/inputs/custom_segmented_toggle.dart';
import 'package:e_commerce/presentation/widgets/inputs/custom_text_form_field.dart';
import 'package:e_commerce/presentation/widgets/inputs/password_input.dart';
import 'package:flutter/material.dart';

class InputsGalleryScreen extends StatefulWidget {
  const InputsGalleryScreen({super.key});

  @override
  State<InputsGalleryScreen> createState() => _InputsGalleryScreenState();
}

class _InputsGalleryScreenState extends State<InputsGalleryScreen> {
  final _formKey = GlobalKey<FormState>();


  bool _switchValue = false;
  bool _checkboxValue = false;
  String? _radioValue = 'option1';
  Set<String> _segmentedValue = {'S'};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Inputs Gallery')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Text Inputs',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),

              CustomTextFormField(
                label: 'Email',
                hint: 'hola@ejemplo.com',
                prefixIcon: Icons.email_outlined,
                validator: (v) => v == null || v.isEmpty ? 'Requerido' : null,
              ),
              const SizedBox(height: 16),

              const PasswordInput(
                validator: null,
              ),
              const SizedBox(height: 32),

              const Text(
                'Toggles & Selectors',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),

              CustomSwitch(
                label: 'Notificaciones Push',
                value: _switchValue,
                onChanged: (v) => setState(() => _switchValue = v),
              ),
              const SizedBox(height: 16),

              CustomCheckbox(
                label: 'Acepto términos y condiciones',
                value: _checkboxValue,
                onChanged: (v) => setState(() => _checkboxValue = v),
              ),
              const SizedBox(height: 16),

              CustomRadioGroup<String>(
                label: 'Método de envío',
                groupValue: _radioValue,
                onChanged: (v) => setState(() => _radioValue = v),
                options: const {
                  'option1': 'Estándar (3-5 días)',
                  'option2': 'Express (24h)',
                  'option3': 'Recoger en tienda',
                },
              ),
              const SizedBox(height: 16),

              CustomSegmentedToggle<String>(
                label: 'Talla',
                selected: _segmentedValue,
                onSelectionChanged: (v) => setState(() => _segmentedValue = v),
                segments: const {
                  'S': Text('S'),
                  'M': Text('M'),
                  'L': Text('L'),
                  'XL': Text('XL'),
                },
              ),
              const SizedBox(height: 32),

              CustomButton(
                text: 'Validar Formulario',
                buttonType: ButtonType.filledButton,
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('¡Formulario Válido!')),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
