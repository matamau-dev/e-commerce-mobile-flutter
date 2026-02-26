import 'package:flutter/material.dart';

class DeleteBrandsDialog extends StatelessWidget {
  final String itemName;
  const DeleteBrandsDialog({super.key, required this.itemName});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: const Text("Eliminar Marca"),
      content: Text("¿Estás seguro de eliminar la marca $itemName?"),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Cancelar"),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            elevation: 0,
          ),
          onPressed: () {
            Navigator.pop(context, true);
          },
          child: const Text("Eliminar"),
        ),
      ],
    );
  }
}
