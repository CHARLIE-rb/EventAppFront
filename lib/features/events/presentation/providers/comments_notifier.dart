import 'package:flutter/material.dart';
import 'package:flutterv1/shared/domain/entities/user.dart';
import 'package:flutterv1/features/events/domain/entities/event.dart';
import 'package:flutterv1/shared/domain/usecases/session/get_current_user.dart';

/// Supone que tu EventRepositoryImpl ya actualiza
/// Event.employeeFeedbacks y Event.companyFeedback
/// al guardar el feedback en el backend o en un mock local.
/// Si no, crea casos de uso AddEmployeeFeedback, AddCompanyFeedback, UpdateEmployeeFeedback.

class CommentsNotifier extends ChangeNotifier {
  final Event _event;
  final GetCurrentUser _getCurrentUser;

  User? _currentUser;
  List<FeedBack> employeeComments = [];
  FeedBack? companyComment;
  bool isLoading = false;

  CommentsNotifier(this._event, this._getCurrentUser) {
    _init();
  }

  Future<void> _init() async {
    isLoading = true;
    notifyListeners();

    // 1) Obtenemos el usuario actual mediante el caso de uso
    _currentUser = await _getCurrentUser();

    // 2) Copiamos los comentarios desde la entidad Event
    employeeComments = List.from(_event.employeeFeedbacks);
    companyComment = _event.companyFeedback;

    isLoading = false;
    notifyListeners();
  }

  /// Getters para rol y estado del evento
  bool get isManager => _currentUser?.role == Role.manager;
  bool get isEmployee =>
      _currentUser != null &&
      _currentUser!.role != Role.manager &&
      _currentUser!.role != Role.company;
  bool get isCompany => _currentUser?.role == Role.company;
  bool get isPastEvent => DateUtils.dateOnly(
    DateTime.now(),
  ).isAfter(DateUtils.dateOnly(_event.endDateTime));
  bool get within48h =>
      DateTime.now().isAfter(_event.endDateTime) &&
      DateTime.now().isBefore(
        _event.endDateTime.add(const Duration(hours: 48)),
      );

  /// Devuelve el feedback del usuario actual (ya sea empleado o empresa)
  FeedBack? get myFeedback {
    if (_currentUser == null) return null;
    if (isCompany) return companyComment;

    final matches = employeeComments.where((fb) => fb.id == _currentUser!.id);
    return matches.isNotEmpty ? matches.first : null;
  }

  /// Añade o actualiza el feedback del usuario actual
  Future<void> submitFeedback({required int rating, String? comment}) async {
    if (_currentUser == null) return;

    isLoading = true;
    notifyListeners();

    final now = DateTime.now();
    final fb = FeedBack(
      id: _currentUser!.id,
      rating: rating,
      comment: comment ?? '',
      timestamp: now,
    );

    if (isCompany) {
      // Si el rol es empresa, guardamos en companyComment
      companyComment = fb;
      // TODO: llamar al caso de uso AddCompanyFeedback(_event.id, fb);
    } else {
      // Si es empleado, buscamos si ya existe feedback previo
      final idx = employeeComments.indexWhere((e) => e.id == _currentUser!.id);
      if (idx >= 0) {
        employeeComments[idx] = fb;
        // TODO: llamar a UpdateEmployeeFeedback(_event.id, fb);
      } else {
        employeeComments.add(fb);
        // TODO: llamar a AddEmployeeFeedback(_event.id, fb);
      }
    }

    isLoading = false;
    notifyListeners();
  }
}
