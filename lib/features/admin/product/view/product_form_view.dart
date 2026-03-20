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
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
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
                  if (_index < 3) _index += 1;
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
                  title: const Text("Tipo de producto"),
                  subtitle: const Text("Selecciona el tipo de producto"),
                  content: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Column(
                      children: [
                        CustomMultiSelectAutocomplete(
                          options: ["Electrónica", "Ropa", "Hogar", "Deportes"],
                          label: "Producto a agregar",
                          onChanged: (value) {
                            debugPrint("Selected categories: $value");
                          },
                        ),
                      ],
                    ),
                  ),
                  isActive: _index == 0,
                  state: _index == 0 ? StepState.editing : StepState.complete,
                ),
                Step(
                  title: const Text("Información del Producto"),
                  subtitle: const Text(
                    "Agrega la información básica del producto",
                  ),
                  isActive: _index == 1,
                  state: _index == 1 ? StepState.editing : StepState.complete,
                  content: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Column(
                      children: [
                        CustomTextFormField(
                          label: "Nombre del producto",
                          hint: "EJ: iPhone 15 Pro Max",
                        ),
                        const SizedBox(height: 12),
                        CustomTextFormField(
                          label: "Precio",
                          hint: "EJ: 999.99",
                        ),
                        const SizedBox(height: 12),
                        CustomMultiSelectAutocomplete(
                          options: [
                            "Electrónica",
                            "Ropa",
                            "Hogar",
                            "Deportes",
                            "Libros",
                          ],
                          label: "Categorias",
                          onChanged: (value) {
                            debugPrint("Selected categories: $value");
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                Step(
                  title: const Text('Agregar Marcas y Modelos'),
                  subtitle: const Text(
                    'Selecciona las marcas disponibles para este producto',
                  ),
                  isActive: _index == 2,
                  state: _index == 2 ? StepState.editing : StepState.disabled,
                  content: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Column(
                      children: [
                        CustomMultiSelectAutocomplete(
                          options: ["Apple", "Samsung", "Nike", "Adidas"],
                          label: "Marcas",
                          onChanged: (value) {
                            debugPrint("Selected marca: $value");
                          },
                        ),
                        const SizedBox(height: 12),
                        CustomMultiSelectAutocomplete(
                          options: ["Galaxy S", "Galaxy Z", "Demas"],
                          label: "Modelos",
                          onChanged: (value) {
                            debugPrint("Selected Model: $value");
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                Step(
                  title: Text('Agregar Variantes'),
                  subtitle: Text(
                    'Agrega las variantes disponibles para este producto',
                  ),
                  isActive: _index == 3,
                  state: _index == 3 ? StepState.editing : StepState.disabled,
                  content: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Column(
                      children: [
                        CustomTextFormField(
                          label: "Color",
                          hint: "EJ: Rojo, Azul, Verde",
                          onChanged: (value) {
                            debugPrint("Color: $value");
                          },
                        ),
                        const SizedBox(height: 12),
                        CustomTextFormField(
                          label: "Talla",
                          hint: "EJ: S, M, L, XL",
                          onChanged: (value) {
                            debugPrint("Talla: $value");
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
