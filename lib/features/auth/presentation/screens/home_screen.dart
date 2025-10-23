// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:go_router/go_router.dart';

// import '/core/core.dart';
// import '/features/auth/presentation/providers/providers.dart';

// class HomeScreen extends ConsumerWidget {
//   const HomeScreen({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final authState = ref.watch(authProvider).value;

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Home'),
//         actions: [
//           // Botón de logout temporal para pruebas
//           IconButton(
//             icon: const Icon(Icons.logout),
//             onPressed: () async {
//               await ref.read(authProvider.notifier).logout();
//             },
//           ),
//         ],
//       ),
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.all(24.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               const Text(
//                 'Bienvenido a Home!',
//                 style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//               ),
//               const SizedBox(height: 16),

//               // Mostrar información del usuario
//               if (authState != null)
//                 authState.maybeWhen(
//                   authenticated: (user) => Column(
//                     children: [
//                       Text('Usuario: ${user.name}'),
//                       const SizedBox(height: 8),
//                       if (user.email != null) Text('Email: ${user.email}'),
//                       const SizedBox(height: 8),
//                       Text(
//                         user.isGuest
//                             ? 'Modo: Invitado (Local)'
//                             : 'Modo: Autenticado (Firebase)',
//                         style: TextStyle(
//                           color: user.isGuest ? Colors.orange : Colors.green,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       const SizedBox(height: 32),

//                       // Mostrar botón de vincular solo si es usuario invitado
//                       if (user.isGuest) ...[
//                         Container(
//                           padding: const EdgeInsets.all(16),
//                           decoration: BoxDecoration(
//                             color: Colors.orange.shade50,
//                             borderRadius: BorderRadius.circular(12),
//                             border: Border.all(color: Colors.orange.shade200),
//                           ),
//                           child: Column(
//                             children: [
//                               Icon(
//                                 Icons.cloud_off,
//                                 size: 48,
//                                 color: Colors.orange.shade700,
//                               ),
//                               const SizedBox(height: 12),
//                               Text(
//                                 'Cuenta local',
//                                 style: TextStyle(
//                                   fontSize: 16,
//                                   fontWeight: FontWeight.bold,
//                                   color: Colors.orange.shade900,
//                                 ),
//                               ),
//                               const SizedBox(height: 8),
//                               Text(
//                                 'Tus datos solo están en este dispositivo',
//                                 style: TextStyle(
//                                   fontSize: 13,
//                                   color: Colors.orange.shade800,
//                                 ),
//                                 textAlign: TextAlign.center,
//                               ),
//                               const SizedBox(height: 16),
//                               ElevatedButton.icon(
//                                 onPressed: () {
//                                   // Navegar a LinkAccountScreen con los datos del usuario
//                                   context.push(
//                                     Uri(
//                                       path: RouteNames.linkAccount,
//                                       queryParameters: {
//                                         'guestUserId': user.id,
//                                         'guestUserName': user.name,
//                                       },
//                                     ).toString(),
//                                   );
//                                 },
//                                 icon: const Icon(Icons.cloud_upload),
//                                 label: const Text(
//                                   'Vincular cuenta con la nube',
//                                 ),
//                                 style: ElevatedButton.styleFrom(
//                                   padding: const EdgeInsets.symmetric(
//                                     horizontal: 24,
//                                     vertical: 12,
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ] else ...[
//                         // Usuario autenticado con Firebase
//                         Container(
//                           padding: const EdgeInsets.all(16),
//                           decoration: BoxDecoration(
//                             color: Colors.green.shade50,
//                             borderRadius: BorderRadius.circular(12),
//                             border: Border.all(color: Colors.green.shade200),
//                           ),
//                           child: Row(
//                             mainAxisSize: MainAxisSize.min,
//                             children: [
//                               Icon(
//                                 Icons.cloud_done,
//                                 color: Colors.green.shade700,
//                               ),
//                               const SizedBox(width: 12),
//                               Text(
//                                 'Cuenta sincronizada',
//                                 style: TextStyle(
//                                   color: Colors.green.shade900,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ],
//                   ),
//                   orElse: () => const SizedBox.shrink(),
//                 ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
