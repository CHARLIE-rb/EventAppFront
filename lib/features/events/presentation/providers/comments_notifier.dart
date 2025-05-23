// lib/features/events/presentation/providers/comments_notifier.dart

import 'package:flutter/material.dart';
import 'package:flutterv1/features/auth/domain/entities/user.dart';
import 'package:flutterv1/features/events/domain/entities/event.dart';

/// Aquí suponemos que tu EventRepositoryImpl ya actualiza
/// los Event.employeeFeedbacks y Event.companyFeedback
/// al guardar el feedback en el backend o mock local.
/// Si no, crea casos de uso AddEmployeeFeedback, AddCompanyFeedback, UpdateEmployeeFeedback.

class CommentsNotifier extends ChangeNotifier {
  final Event _event;
  final User _currentUser;
  List<FeedBack> employeeComments = [];
  FeedBack? companyComment;
  bool isLoading = false;

  CommentsNotifier(this._event, this._currentUser) {
    _init();
  }

  void _init() {
    // Copiamos los comentarios del event (inmutables en la entidad)
    employeeComments = List.from(_event.employeeFeedbacks);
    companyComment = _event.companyFeedback;
  }

  bool get isManager => _currentUser.role == Role.manager;
  bool get isEmployee =>
      _currentUser.role != Role.manager && _currentUser.role != Role.company;
  bool get isCompany => _currentUser.role == Role.company;
  bool get isPastEvent => DateUtils.dateOnly(
    DateTime.now(),
  ).isAfter(DateUtils.dateOnly(_event.endDateTime));
  bool get within48h =>
      DateTime.now().isAfter(_event.endDateTime) &&
      DateTime.now().isBefore(
        _event.endDateTime.add(const Duration(hours: 48)),
      );

  FeedBack? get myFeedback {
    if (isCompany) return companyComment;
    final matches = employeeComments.where((fb) => fb.id == _currentUser.id);
    return matches.isNotEmpty ? matches.first : null;
  }

  /// Añade o actualiza tu feedback (empleado o empresa)
  Future<void> submitFeedback({required int rating, String? comment}) async {
    isLoading = true;
    notifyListeners();

    final now = DateTime.now();
    final fb = FeedBack(
      id: _currentUser.id,
      rating: rating,
      comment: comment ?? '',
      timestamp: now,
    );

    if (isCompany) {
      companyComment = fb;
      // Aquí llamarías al use case AddCompanyFeedback(_event.id, fb);
    } else {
      final idx = employeeComments.indexWhere((e) => e.id == _currentUser.id);
      if (idx >= 0) {
        employeeComments[idx] = fb;
        // Llamar a UpdateEmployeeFeedback(_event.id, fb);
      } else {
        employeeComments.add(fb);
        // Llamar a AddEmployeeFeedback(_event.id, fb);
      }
    }

    isLoading = false;
    notifyListeners();
  }
}
