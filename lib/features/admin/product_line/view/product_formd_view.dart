import 'package:e_commerce/presentation/widgets/inputs/custom_multi_select_autocomplete.dart';
import 'package:e_commerce/presentation/widgets/inputs/custom_text_form_field.dart';
import 'package:flutter/material.dart';

class ProductFormView extends StatefulWidget {
  const ProductFormView({super.key});

  @override
  State<ProductFormView> createState() => _ProductFormViewState();
}

class _ProductFormViewState extends State<ProductFormView> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Nuevo Producto"),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).colorScheme.onSurface,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: SafeArea(
          child: Stepper(
            currentStep: _index,
            onStepCancel: () {
              setState(() {
                if (_index > 0) _index -= 1;
              });
            },
            onStepContinue: () {
              setState(() {
                if (_index < 2) _index += 1;
              });
            },
            onStepTapped: (int index) {
              setState(() {
                _index = index;
              });
            },
            elevation: 20,
            steps: [
              Step(
                title: const Text("Información del Producto"),
                content: Column(
                  children: [
                    CustomTextFormField(
                      label: "Nombre del producto",
                      hint: "EJ: iPhone 15 Pro Max",
                    ),
                    const SizedBox(height: 12),
                    CustomTextFormField(label: "Precio", hint: "EJ: 999.99"),
                    const SizedBox(height: 12),
                    CustomMultiSelectAutocomplete(
                      options: [
                        "options",
                        "options12",
                        "options13",
                        "options14",
                      ],
                      label: "Categorias",
                      onChanged: (value) {},
                    ),
                  ],
                ),
                isActive: _index == 0,
                state: _index == 0 ? StepState.editing : StepState.complete,
              ),
              Step(
                title: const Text('Step 1 title'),
                content: Container(
                  alignment: Alignment.centerLeft,
                  child: const Text('Content for Step 1'),
                ),
                isActive: _index == 1,
                state: _index == 1 ? StepState.editing : StepState.disabled,
              ),
              Step(
                title: Text('Step 2 title'),
                content: Text('Content for Step 2'),
                isActive: _index == 2,
                state: _index == 2 ? StepState.editing : StepState.disabled,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
