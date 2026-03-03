import 'package:flutter/material.dart';

class DeleteConfirmDialog extends StatelessWidget {
  final String itemName;

  const DeleteConfirmDialog({super.key, required this.itemName});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: const Row(
        children: [
          Icon(Icons.warning_amber_rounded, color: Colors.red),
          SizedBox(width: 10),
          Text("¿Eliminar?"),
        ],
      ),
      content: Text(
        "¿Estás seguro de que quieres eliminar \"$itemName\"? Esta acción no se puede deshacer.",
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: const Text("Cancelar", style: TextStyle(color: Colors.grey)),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red[50],
            foregroundColor: Colors.red,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          onPressed: () => Navigator.pop(context, true), // Retornamos "true"
          child: const Text(
            "Eliminar",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
