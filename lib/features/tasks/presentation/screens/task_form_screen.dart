import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '/features/tasks/data/data.dart';
import '/features/tasks/domain/domain.dart';
import '/features/tasks/presentation/providers/providers.dart';

class TaskFormScreen extends ConsumerStatefulWidget {
  final TaskEntitie? initialTask;

  const TaskFormScreen({super.key, this.initialTask});

  @override
  ConsumerState<TaskFormScreen> createState() => _TaskFormScreenState();
}

class _TaskFormScreenState extends ConsumerState<TaskFormScreen> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _titleController;
  late final TextEditingController _descriptionController;
  late TaskPriority _priority;

  bool get _isEditMode => widget.initialTask != null;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();

    _titleController = TextEditingController(
      text: widget.initialTask?.title ?? '',
    );
    _descriptionController = TextEditingController(
      text: widget.initialTask?.description ?? '',
    );
    _priority = widget.initialTask?.priority ?? TaskPriority.medium;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      return; // Validación falló
    }

    setState(() {
      _isSaving = true;
    });

    bool success = false;

    try {
      if (_isEditMode) {
        // --- MODO EDITAR ---
        final updatedTask = widget.initialTask!.copyWith(
          title: _titleController.text,
          description: _descriptionController.text,
          priority: _priority,
          updatedAt: DateTime.now(), // Actualizar fecha
        );

        success = await ref
            .read(updateTaskControllerProvider.notifier)
            .updateTask(updatedTask);
      } else {
        // --- MODO CREAR ---
        success = await ref
            .read(createTaskControllerProvider.notifier)
            .createTask(
              title: _titleController.text,
              description: _descriptionController.text,
              priority: _priority,
            );
      }

      if (mounted && success) {
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            SnackBar(content: Text('Tarea guardada exitosamente')),
          );
        context.pop();
      } else if (mounted) {
        // El error se muestra desde el listener
      }
    } finally {
      if (mounted) {
        setState(() {
          _isSaving = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // Escuchar errores de los controladores
    ref.listen<AsyncValue<void>>(createTaskControllerProvider, (prev, next) {
      if (next.hasError) {
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            SnackBar(
              content: Text('Error al crear: ${next.error}'),
              backgroundColor: Colors.red,
            ),
          );
      }
    });
    ref.listen<AsyncValue<void>>(updateTaskControllerProvider, (prev, next) {
      if (next.hasError) {
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            SnackBar(
              content: Text('Error al actualizar: ${next.error}'),
              backgroundColor: Colors.red,
            ),
          );
      }
    });

    return Scaffold(
      appBar: AppBar(title: Text(_isEditMode ? 'Editar Tarea' : 'Nueva Tarea')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // --- Título ---
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Título',
                  border: OutlineInputBorder(),
                  counterText: '', // Ocultar contador
                ),
                maxLength: 50,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'El título es requerido';
                  }
                  if (value.length > 50) {
                    return 'Máximo 50 caracteres';
                  }
                  return null;
                },
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 16),

              // --- Descripción ---
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Descripción (Opcional)',
                  border: OutlineInputBorder(),
                  counterText: '',
                ),
                maxLines: 5,
                maxLength: 250,
                validator: (value) {
                  if (value != null && value.length > 250) {
                    return 'Máximo 250 caracteres';
                  }
                  return null;
                },
                textInputAction: TextInputAction.done,
              ),
              const SizedBox(height: 16),

              // --- Prioridad ---
              DropdownButtonFormField<TaskPriority>(
                value: _priority,
                decoration: const InputDecoration(
                  labelText: 'Prioridad',
                  border: OutlineInputBorder(),
                ),
                items: TaskPriority.values.map((priority) {
                  return DropdownMenuItem(
                    value: priority,
                    child: Text(
                      priority == TaskPriority.high
                          ? 'Alta'
                          : priority == TaskPriority.medium
                          ? 'Media'
                          : 'Baja',
                    ),
                  );
                }).toList(),
                onChanged: _isSaving
                    ? null
                    : (value) {
                        if (value != null) {
                          setState(() {
                            _priority = value;
                          });
                        }
                      },
              ),
              const SizedBox(height: 32),

              // --- Botón Guardar ---
              ElevatedButton(
                onPressed: _isSaving ? null : _submit,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: _isSaving
                    ? const SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : const Text('Guardar'),
              ),

              // --- Botón Cancelar ---
              TextButton(
                onPressed: _isSaving ? null : () => context.pop(),
                child: const Text('Cancelar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
