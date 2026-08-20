/// Data shapes for the journey, documents, costs and institutions.
/// Content itself lives under lib/data/ — change it there.

enum Phase { homeCountry, postArrival }

/// Education level drives which documents an applicant needs, which in turn
/// drives what they pay for legalisation and VFS processing.
enum EducationLevel { oLevel, ond, hnd, bsc }

extension EducationLevelInfo on EducationLevel {
  String get label => switch (this) {
        EducationLevel.oLevel => 'O\u2019Level only',
        EducationLevel.ond => 'OND',
        EducationLevel.hnd => 'HND',
        EducationLevel.bsc => 'University graduate (BSc)',
      };

  /// Educational documents needing authentication and legalisation.
  /// A testimonial is not actually required, so it is not listed. HND
  /// builds on OND, so an HND applicant carries both sets of papers. A BSc
  /// supersedes the SS1-SS3 transcript, so it drops off at that level.
  List<String> get educationalDocuments => switch (this) {
        EducationLevel.oLevel => [
            'WAEC or NECO',
            'SS1\u2013SS3 secondary school transcript',
          ],
        EducationLevel.ond => [
            'WAEC or NECO',
            'SS1\u2013SS3 secondary school transcript',
            'OND certificate',
            'OND transcript',
          ],
        EducationLevel.hnd => [
            'WAEC or NECO',
            'SS1\u2013SS3 secondary school transcript',
            'OND certificate',
            'OND transcript',
            'HND certificate',
            'HND official transcript',
          ],
        EducationLevel.bsc => [
            'WAEC or NECO',
            'BSc certificate',
            'BSc transcript',
          ],
      };

  int get documentCount => educationalDocuments.length;
}

class RequiredDocument {
  final String id;
  final String title;
  final String? explanation;
  final String? link;
  final String? linkLabel;

  /// For documents with timing traps or hard constraints.
  final String? warning;

  const RequiredDocument({
    required this.id,
    required this.title,
    this.explanation,
    this.link,
    this.linkLabel,
    this.warning,
  });
}

enum Currency { eur, ngn }

class CostItem {
  final String label;
  final double amount;
  final Currency currency;

  /// e.g. 'per document', 'per semester'
  final String? unit;

  /// Set when a figure still needs confirming against a live source.
  final String? note;

  const CostItem({
    required this.label,
    required this.amount,
    required this.currency,
    this.unit,
    this.note,
  });

  String get formatted {
    final symbol = currency == Currency.eur ? '\u20AC' : '\u20A6';
    final value = amount == amount.roundToDouble()
        ? amount.toStringAsFixed(0)
        : amount.toStringAsFixed(2);
    final withSeparators = _thousands(value);
    return unit == null ? '$symbol$withSeparators' : '$symbol$withSeparators $unit';
  }

  static String _thousands(String number) {
    final parts = number.split('.');
    final intPart = parts[0];
    final buffer = StringBuffer();
    for (var i = 0; i < intPart.length; i++) {
      if (i > 0 && (intPart.length - i) % 3 == 0) buffer.write(',');
      buffer.write(intPart[i]);
    }
    return parts.length > 1 ? '${buffer.toString()}.${parts[1]}' : buffer.toString();
  }
}

class StepLink {
  final String label;
  final String url;

  /// True for a link that should stay locked behind the paywall even on a
  /// free-preview step. Use for high-value external links (like a direct
  /// government portal) where the surrounding guidance can be free but the
  /// shortcut itself is worth paying for.
  final bool premiumOnly;

  const StepLink({
    required this.label,
    required this.url,
    this.premiumOnly = false,
  });
}

/// Steps that run at the same time as another step rather than after it.
/// The VFS appointment wait is the obvious case: you book the date, then work
/// through the ministries while the clock runs.
enum StepTiming {
  /// Must finish before the next step starts.
  sequential,

  /// Happens during an earlier step's waiting period.
  parallel,

  /// Starts a waiting period that other steps run inside.
  startsClock,
}

class JourneyStep {
  final String id;
  final int order;
  final Phase phase;
  final String title;
  final String summary;
  final String detail;

  /// Which block of the journey this belongs to, e.g. 'Months 1\u20136'.
  final String blockId;

  final StepTiming timing;

  /// For parallel steps: what the applicant is waiting on meanwhile.
  final String? runsDuring;

  final String? timeline;
  final List<CostItem> costs;
  final List<RequiredDocument> documents;
  final List<StepLink> links;
  final String? criticalNote;

  /// Shows the Abuja support card. Set on the three steps that require
  /// physically being in Abuja.
  final bool needsAbuja;

  final bool isFreePreview;

  const JourneyStep({
    required this.id,
    required this.order,
    required this.phase,
    required this.title,
    required this.summary,
    required this.detail,
    required this.blockId,
    this.timing = StepTiming.sequential,
    this.runsDuring,
    this.timeline,
    this.costs = const [],
    this.documents = const [],
    this.links = const [],
    this.criticalNote,
    this.needsAbuja = false,
    this.isFreePreview = false,
  });
}

/// A named span of the journey, so people know roughly where they are in time.
class JourneyBlock {
  final String id;
  final String title;
  final String duration;
  final String description;
  final Phase phase;

  const JourneyBlock({
    required this.id,
    required this.title,
    required this.duration,
    required this.description,
    required this.phase,
  });
}

// ---------------------------------------------------------------------------
// Institutions
// ---------------------------------------------------------------------------

enum InstitutionType { publicUniversity, appliedSciences }

class University {
  final String id;
  final String name;
  final String city;
  final InstitutionType type;

  /// Per semester, for third-country (non-EU) students, in EUR.
  final double? tuitionPerSemesterEur;

  final double? applicationFeeEur;
  final String? applicationFeeNote;

  final List<String> englishBachelors;
  final List<String> englishMasters;

  final String? website;
  final String? admissionsUrl;

  /// False means the figure came from a secondary source and still needs
  /// checking against the institution's own page.
  final bool feeVerified;

  final String? note;

  const University({
    required this.id,
    required this.name,
    required this.city,
    required this.type,
    this.tuitionPerSemesterEur,
    this.applicationFeeEur,
    this.applicationFeeNote,
    this.englishBachelors = const [],
    this.englishMasters = const [],
    this.website,
    this.admissionsUrl,
    this.feeVerified = false,
    this.note,
  });

  bool get hasEnglishBachelor => englishBachelors.isNotEmpty;
  bool get hasEnglishMaster => englishMasters.isNotEmpty;

  double? get tuitionPerYearEur =>
      tuitionPerSemesterEur == null ? null : tuitionPerSemesterEur! * 2;

  String get typeLabel => switch (type) {
        InstitutionType.publicUniversity => 'Public University',
        InstitutionType.appliedSciences => 'University of Applied Sciences',
      };
}

/// Institutions priced beyond what this guide is aimed at. Listed as a warning
/// rather than hidden, so nobody applies without knowing the cost.
class ExpensiveInstitution {
  final String name;
  final String city;
  final String yearlyCost;
  final String warning;

  const ExpensiveInstitution({
    required this.name,
    required this.city,
    required this.yearlyCost,
    required this.warning,
  });
}

/// A quote from someone who has been through the process.
/// Only real, permitted quotes belong here.
class Testimonial {
  final String name;
  final String detail;
  final String quote;
  final int rating;

  const Testimonial({
    required this.name,
    required this.detail,
    required this.quote,
    this.rating = 5,
  });
}
