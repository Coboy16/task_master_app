import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '/features/auth/presentation/widgets/widgets.dart';
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
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSaving = true);

    bool success = false;

    try {
      if (_isEditMode) {
        final updatedTask = widget.initialTask!.copyWith(
          title: _titleController.text.trim(),
          description: _descriptionController.text.trim(),
          priority: _priority,
          updatedAt: DateTime.now(),
        );

        success = await ref
            .read(updateTaskControllerProvider.notifier)
            .updateTask(updatedTask);

        if (success && mounted) {
          await ref.read(tasksProvider.notifier).refreshTasks();
          ref.invalidate(taskDetailProvider(widget.initialTask!.id));
        }
      } else {
        success = await ref
            .read(createTaskControllerProvider.notifier)
            .createTask(
              title: _titleController.text.trim(),
              description: _descriptionController.text.trim(),
              priority: _priority,
            );
      }

      if (mounted && success) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              _isEditMode ? 'Tarea actualizada' : 'Tarea creada',
              style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            backgroundColor: const Color(0xFF10b981),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            margin: const EdgeInsets.all(16),
          ),
        );
        context.pop();
      }
    } finally {
      if (mounted) {
        setState(() => _isSaving = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue<void>>(createTaskControllerProvider, (prev, next) {
      if (next.hasError) {
        _showErrorSnackBar('Error al crear: ${next.error}');
      }
    });

    ref.listen<AsyncValue<void>>(updateTaskControllerProvider, (prev, next) {
      if (next.hasError) {
        _showErrorSnackBar('Error al actualizar: ${next.error}');
      }
    });

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(LucideIcons.arrowLeft, color: Color(0xFF1a1a1a)),
          onPressed: () => context.pop(),
        ),
        title: Text(
          _isEditMode ? 'Editar Tarea' : 'Nueva Tarea',
          style: GoogleFonts.inter(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF1a1a1a),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Título',
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF1a1a1a),
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(
                  hintText: 'Nombre de la tarea',
                  hintStyle: GoogleFonts.inter(
                    color: const Color(0xFFd1d5db),
                    fontSize: 15,
                  ),
                  prefixIcon: const Icon(
                    LucideIcons.fileText,
                    size: 20,
                    color: Color(0xFF6b7280),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(
                      color: Color(0xFFe5e7eb),
                      width: 1,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(
                      color: Color(0xFFe5e7eb),
                      width: 1,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(
                      color: Color(0xFF2800C8),
                      width: 2,
                    ),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(
                      color: Color(0xFFef4444),
                      width: 1,
                    ),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(
                      color: Color(0xFFef4444),
                      width: 2,
                    ),
                  ),
                  filled: true,
                  fillColor: const Color(0xFFfafafa),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 16,
                  ),
                  counterText: '',
                ),
                style: GoogleFonts.inter(
                  fontSize: 15,
                  color: const Color(0xFF1a1a1a),
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
              const SizedBox(height: 20),
              Text(
                'Descripción (Opcional)',
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF1a1a1a),
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(
                  hintText: 'Agrega más detalles...',
                  hintStyle: GoogleFonts.inter(
                    color: const Color(0xFFd1d5db),
                    fontSize: 15,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(
                      color: Color(0xFFe5e7eb),
                      width: 1,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(
                      color: Color(0xFFe5e7eb),
                      width: 1,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(
                      color: Color(0xFF2800C8),
                      width: 2,
                    ),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(
                      color: Color(0xFFef4444),
                      width: 1,
                    ),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(
                      color: Color(0xFFef4444),
                      width: 2,
                    ),
                  ),
                  filled: true,
                  fillColor: const Color(0xFFfafafa),
                  contentPadding: const EdgeInsets.all(16),
                  counterText: '',
                ),
                style: GoogleFonts.inter(
                  fontSize: 15,
                  color: const Color(0xFF1a1a1a),
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
              const SizedBox(height: 20),
              Text(
                'Prioridad',
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF1a1a1a),
                ),
              ),
              const SizedBox(height: 8),
              DropdownButtonFormField<TaskPriority>(
                value: _priority,
                decoration: InputDecoration(
                  prefixIcon: const Icon(
                    LucideIcons.flag,
                    size: 20,
                    color: Color(0xFF6b7280),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(
                      color: Color(0xFFe5e7eb),
                      width: 1,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(
                      color: Color(0xFFe5e7eb),
                      width: 1,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(
                      color: Color(0xFF2800C8),
                      width: 2,
                    ),
                  ),
                  filled: true,
                  fillColor: const Color(0xFFfafafa),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 16,
                  ),
                ),
                style: GoogleFonts.inter(
                  fontSize: 15,
                  color: const Color(0xFF1a1a1a),
                ),
                items: TaskPriority.values.map((priority) {
                  String label;
                  Color color;

                  switch (priority) {
                    case TaskPriority.high:
                      label = 'Alta';
                      color = const Color(0xFFef4444);
                      break;
                    case TaskPriority.medium:
                      label = 'Media';
                      color = const Color(0xFFf59e0b);
                      break;
                    case TaskPriority.low:
                      label = 'Baja';
                      color = const Color(0xFF10b981);
                      break;
                  }

                  return DropdownMenuItem(
                    value: priority,
                    child: Row(
                      children: [
                        Container(
                          width: 12,
                          height: 12,
                          decoration: BoxDecoration(
                            color: color,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Text(label),
                      ],
                    ),
                  );
                }).toList(),
                onChanged: _isSaving
                    ? null
                    : (value) {
                        if (value != null) {
                          setState(() => _priority = value);
                        }
                      },
              ),
              const SizedBox(height: 40),
              CustomButton(
                text: _isEditMode ? 'Actualizar Tarea' : 'Crear Tarea',
                onPressed: _submit,
                isLoading: _isSaving,
                height: 52,
              ),
              const SizedBox(height: 12),
              Center(
                child: CustomButton(
                  text: 'Cancelar',
                  type: ButtonType.text,
                  onPressed: _isSaving ? null : () => context.pop(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w500),
        ),
        backgroundColor: const Color(0xFFef4444),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.all(16),
      ),
    );
  }
}
