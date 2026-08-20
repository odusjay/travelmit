import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Tracks which steps are complete and which documents are ticked off.
/// Persisted locally so progress survives app restarts.
class ProgressService extends ChangeNotifier {
  static const _stepsKey = 'completed_steps';
  static const _docsKey = 'completed_documents';

  SharedPreferences? _prefs;
  Set<String> _completedSteps = {};
  Set<String> _completedDocuments = {};

  Set<String> get completedSteps => _completedSteps;
  Set<String> get completedDocuments => _completedDocuments;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
    _completedSteps = (_prefs?.getStringList(_stepsKey) ?? []).toSet();
    _completedDocuments = (_prefs?.getStringList(_docsKey) ?? []).toSet();
    notifyListeners();
  }

  bool isStepComplete(String stepId) => _completedSteps.contains(stepId);
  bool isDocumentComplete(String docId) => _completedDocuments.contains(docId);

  Future<void> toggleStep(String stepId) async {
    _completedSteps.contains(stepId)
        ? _completedSteps.remove(stepId)
        : _completedSteps.add(stepId);
    await _prefs?.setStringList(_stepsKey, _completedSteps.toList());
    notifyListeners();
  }

  Future<void> toggleDocument(String docId) async {
    _completedDocuments.contains(docId)
        ? _completedDocuments.remove(docId)
        : _completedDocuments.add(docId);
    await _prefs?.setStringList(_docsKey, _completedDocuments.toList());
    notifyListeners();
  }

  /// Fraction complete across the given step ids, 0.0–1.0.
  double progressFor(List<String> stepIds) {
    if (stepIds.isEmpty) return 0;
    final done = stepIds.where(_completedSteps.contains).length;
    return done / stepIds.length;
  }

  Future<void> reset() async {
    _completedSteps.clear();
    _completedDocuments.clear();
    await _prefs?.remove(_stepsKey);
    await _prefs?.remove(_docsKey);
    notifyListeners();
  }
}
