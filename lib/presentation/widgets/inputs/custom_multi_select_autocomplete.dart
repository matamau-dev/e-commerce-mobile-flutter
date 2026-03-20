import 'package:flutter/material.dart';

class CustomMultiSelectAutocomplete extends StatefulWidget {
  final List<String> options;
  final String label;
  final String hint;
  final List<String> initialSelected;
  final Function(List<String>) onChanged;

  const CustomMultiSelectAutocomplete({
    super.key,
    required this.options,
    required this.label,
    this.hint = "Escribe para buscar...",
    this.initialSelected = const [],
    required this.onChanged,
  });

  @override
  State<CustomMultiSelectAutocomplete> createState() =>
      _CustomMultiSelectAutocompleteState();
}

class _CustomMultiSelectAutocompleteState
    extends State<CustomMultiSelectAutocomplete> {
  late List<String> _selectedItems;
  late TextEditingController _fieldController;

  bool get _allSelected => _selectedItems.length == widget.options.length;

  @override
  void initState() {
    super.initState();
    _selectedItems = List.from(widget.initialSelected);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: theme.textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),

        Autocomplete<String>(
          optionsBuilder: (TextEditingValue textEditingValue) {
            if (_allSelected) {
              return const Iterable<String>.empty();
            }

            if (textEditingValue.text.isEmpty) {
              return widget.options.where(
                (option) => !_selectedItems.contains(option),
              );
            }

            return widget.options.where((option) {
              final isMatch = option.toLowerCase().contains(
                textEditingValue.text.toLowerCase(),
              );
              final isNotSelected = !_selectedItems.contains(option);
              return isMatch && isNotSelected;
            });
          },

          onSelected: (String selection) {
            setState(() {
              _selectedItems.add(selection);
              _fieldController.clear(); // 👈 limpia input correctamente
            });

            widget.onChanged(_selectedItems);
          },

          fieldViewBuilder:
              (context, fieldController, focusNode, onFieldSubmitted) {
                _fieldController = fieldController;

                return TextField(
                  controller: fieldController,
                  focusNode: focusNode,
                  enabled: !_allSelected, // 👈 deshabilita si todo seleccionado
                  decoration: InputDecoration(
                    hintText: _allSelected
                        ? "Todas las opciones seleccionadas"
                        : widget.hint,

                    prefixIcon: const Icon(Icons.search, size: 20),

                    suffixIcon: fieldController.text.isEmpty
                        ? IconButton(
                            onPressed: () {
                              if (!focusNode.hasFocus) {
                                focusNode.requestFocus();
                              } else {
                                fieldController.clear();
                              }
                            },
                            icon: const Icon(Icons.arrow_drop_down, size: 20),
                          )
                        : IconButton(
                            icon: const Icon(Icons.clear, size: 20),
                            onPressed: () {
                              setState(() {
                                fieldController.clear();
                              });
                            },
                          ),

                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),

                    filled: true,

                    fillColor: _allSelected
                        ? theme.colorScheme.surfaceContainerHighest.withValues(
                            alpha: 0.1,
                          )
                        : theme.colorScheme.surfaceContainerHighest.withValues(
                            alpha: 0.3,
                          ),
                  ),
                );
              },
        ),

        const SizedBox(height: 8),

        Wrap(
          spacing: 8,
          runSpacing: 0,
          children: _selectedItems.map((item) {
            return InputChip(
              label: Text(item, style: const TextStyle(fontSize: 12)),

              onDeleted: () {
                setState(() {
                  _selectedItems.remove(item);
                });

                widget.onChanged(_selectedItems);
              },

              deleteIcon: const Icon(Icons.close, size: 14),

              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),

              backgroundColor: theme.colorScheme.primaryContainer.withValues(
                alpha: 0.5,
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
