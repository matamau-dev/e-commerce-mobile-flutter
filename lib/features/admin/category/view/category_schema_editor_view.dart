import 'package:e_commerce/features/admin/category/view/widgets/attribute_config_card.dart';
import 'package:e_commerce/features/admin/category/view_model/category_schema_editor_view_model.dart';
import 'package:e_commerce/presentation/widgets/inputs/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategorySchemaEditorView extends StatefulWidget {
  const CategorySchemaEditorView({super.key});

  @override
  State<CategorySchemaEditorView> createState() =>
      _CategorySchemaEditorViewState();
}

class _CategorySchemaEditorViewState extends State<CategorySchemaEditorView> {
  @override
  Widget build(BuildContext context) {
    final categorySchemaEditorViewModel = context
        .watch<CategorySchemaEditorViewModel>();
    final theme = Theme.of(context);
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () => FocusScope.of(context).unfocus(),
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Text("Editar Esquema de Categorías"),
            centerTitle: true,
            elevation: 0,
            backgroundColor: Colors.transparent,
            foregroundColor: Theme.of(context).colorScheme.onSurface,
            bottom: TabBar(
              tabs: [
                Tab(text: "Categorías"),
                Tab(text: "Sub Categorías"),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    const SizedBox(height: 16),
                    CustomTextFormField(
                      label: "Nombre de la categoría",
                      suffixIcon: Icon(Icons.category),
                      hint: "EJ: Ropa",
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Formulario para agregar productos a la categoría",
                      style: theme.textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),

                    Expanded(
                      child: categorySchemaEditorViewModel.attributes.isEmpty
                          ? Center(
                              child: Text(
                                "No hay atributos configurados.\nToca el botón '+' para agregar uno.",
                                textAlign: TextAlign.center,
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  color: Colors.grey,
                                ),
                              ),
                            )
                          : ListView.builder(
                              itemCount: categorySchemaEditorViewModel
                                  .attributes
                                  .length,
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              itemBuilder: (context, index) {
                                final attribute = categorySchemaEditorViewModel
                                    .attributes[index];
                                return AttributeConfigCard(
                                  attribute: attribute,
                                  onDelete: () => categorySchemaEditorViewModel
                                      .removeAttribute(index),
                                  onAttributeChanged: (updatedAttribute) {
                                    categorySchemaEditorViewModel
                                        .updateAttribute(
                                          updatedAttribute,
                                          index,
                                        );
                                  },
                                );
                              },
                            ),
                    ),
                  ],
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.construction, size: 64, color: Colors.grey),
                  const SizedBox(height: 16),
                  Text(
                    "Configuración de Sub Categorías\n(Próximamente)",
                    textAlign: TextAlign.center,
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () => categorySchemaEditorViewModel.addEmptyAttribute(),
            backgroundColor: Theme.of(context).colorScheme.primary,
            foregroundColor: Theme.of(context).colorScheme.onPrimary,
            elevation: 10,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            icon: const Icon(Icons.add, size: 28),
            label: const Text(
              'Agregar Atributo',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ),
    );
  }
}
