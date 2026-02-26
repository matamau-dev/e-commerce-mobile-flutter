import 'package:e_commerce/presentation/widgets/app_bars/custom_app_bar.dart';
import 'package:flutter/material.dart';

class LegalView extends StatelessWidget {
  final String title;
  final String type; // 'terms' or 'privacy'

  const LegalView({super.key, required this.title, required this.type});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: title),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _getTypeTitle(type),
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "Última actualización: 01 de Enero, 2024",
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(color: Colors.grey),
            ),
            const SizedBox(height: 24),
            Text(
              _getContent(type),
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                height: 1.6,
                color: Colors.grey[800],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getTypeTitle(String type) {
    return type == 'privacy'
        ? 'Política de Privacidad'
        : 'Términos y Condiciones';
  }

  String _getContent(String type) {
    if (type == 'privacy') {
      return """
1. Recopilación de Información
Recopilamos información personal que nos proporcionas directamente, como tu nombre, dirección de correo electrónico y dirección de envío cuando te registras o realizas una compra.

2. Uso de la Información
Utilizamos la información recopilada para procesar tus pedidos, comunicarnos contigo sobre el estado de tu compra y enviarte actualizaciones y promociones si así lo has aceptado.

3. Protección de Datos
Tomamos medidas razonables para proteger tu información personal contra pérdida, robo y uso no autorizado. Utilizamos tecnología de encriptación para asegurar tus datos durante la transmisión.

4. Compartir Información
No vendemos ni alquilamos tu información personal a terceros. Podemos compartir información con proveedores de servicios que nos ayudan a operar nuestra plataforma, como empresas de envío y procesamiento de pagos.
      """;
    } else {
      return """
1. Aceptación de los Términos
Al acceder y utilizar nuestra aplicación, aceptas estar sujeto a estos Términos y Condiciones. Si no estás de acuerdo con alguna parte de estos términos, no debes utilizar nuestros servicios.

2. Uso del Servicio
Te comprometes a utilizar nuestra aplicación solo para fines legales y de una manera que no infrinja los derechos de otros ni restrinja o inhiba su uso y disfrute de la aplicación.

3. Cuentas de Usuario
Eres responsable de mantener la confidencialidad de tu cuenta y contraseña. Aceptas notificarnos inmediatamente sobre cualquier uso no autorizado de tu cuenta.

4. Propiedad Intelectual
Todo el contenido incluido en esta aplicación, como texto, gráficos, logotipos e imágenes, es propiedad nuestra o de nuestros licenciantes y está protegido por las leyes de derechos de autor.

5. Modificaciones
Nos reservamos el derecho de modificar estos términos en cualquier momento. Te notificaremos sobre cualquier cambio importante publicando los nuevos términos en esta página.
      """;
    }
  }
}
