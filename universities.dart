import '../models/journey.dart';

// ===========================================================================
// INSTITUTIONS
//
// Only places charging 2,000 euro a year or less for third-country students
// appear in the main list. Anything dearer sits in the warning list at the
// bottom, so nobody applies somewhere they cannot afford without knowing.
//
// feeVerified: false means the figure came from a secondary source. Check it
// against the institution's own fee page before relying on it.
// ===========================================================================

/// The federal rate for third-country students, per semester.
/// Individual universities publish 726.72; the OeAD portal lists 751.92.
/// Worth confirming which applies before quoting it as final.
const double kPublicSemesterFee = 726.72;

const List<University> universities = [
  // -------------------------------------------------------------------------
  // PUBLIC UNIVERSITIES
  // Same federal fee everywhere: about 1,453 euro a year.
  // -------------------------------------------------------------------------

  University(
    id: 'univie',
    name: 'University of Vienna',
    city: 'Vienna',
    type: InstitutionType.publicUniversity,
    tuitionPerSemesterEur: kPublicSemesterFee,
    englishMasters: ['Cognitive Science', 'Data Science', 'Business Analytics', 'Economics'],
    website: 'https://www.univie.ac.at',
    admissionsUrl: 'https://studieren.univie.ac.at/en/admission/',
    feeVerified: true,
    note: 'The oldest and largest in the country. Bachelor programmes are '
        'almost all in German.',
  ),

  University(
    id: 'tuwien',
    name: 'TU Wien',
    city: 'Vienna',
    type: InstitutionType.publicUniversity,
    tuitionPerSemesterEur: kPublicSemesterFee,
    englishMasters: ['Computer Science', 'Engineering programmes'],
    website: 'https://www.tuwien.at',
    admissionsUrl: 'https://www.tuwien.at/en/studies/admission',
    feeVerified: true,
    note: 'Entrance exams apply to the limited-place programmes such as '
        'Computer Science and Architecture.',
  ),

  University(
    id: 'wu',
    name: 'WU Vienna, Economics and Business',
    city: 'Vienna',
    type: InstitutionType.publicUniversity,
    tuitionPerSemesterEur: kPublicSemesterFee,
    englishMasters: [
      'International Management (CEMS)',
      'Strategy, Innovation and Management Control',
      'Marketing',
      'Quantitative Finance',
      'Socio-Ecological Economics and Policy',
    ],
    website: 'https://www.wu.ac.at',
    admissionsUrl: 'https://www.wu.ac.at/en/programs/application-and-admission/',
    feeVerified: true,
    note: 'Competitive. Several programmes ask for GMAT or GRE plus an '
        'interview.',
  ),

  University(
    id: 'leoben',
    name: 'Montanuniversit\u00E4t Leoben',
    city: 'Leoben',
    type: InstitutionType.publicUniversity,
    tuitionPerSemesterEur: kPublicSemesterFee,
    englishBachelors: [
      'Circular Engineering',
      'Geoenergy Engineering',
      'Responsible Consumption and Production',
      'Applied Geosciences',
      'Mineral Resources Engineering',
      'Petroleum Engineering',
    ],
    englishMasters: [
      'Digital and AI',
      'Energy Transition',
      'Circular Economy',
      'Materials for Future',
      'Sustainable Technologies',
      'Raw Material Safety',
    ],
    website: 'https://www.unileoben.ac.at',
    admissionsUrl: 'https://ssc.unileoben.ac.at/en/',
    feeVerified: true,
    note: 'One of the very few public universities teaching Bachelor degrees '
        'in English. Circular Engineering, Geoenergy Engineering and '
        'Responsible Consumption and Production each require a qualification '
        'examination.',
  ),

  University(
    id: 'klagenfurt',
    name: 'University of Klagenfurt',
    city: 'Klagenfurt',
    type: InstitutionType.publicUniversity,
    tuitionPerSemesterEur: kPublicSemesterFee,
    englishBachelors: [
      'International Business and Economics',
      'Robotics and Artificial Intelligence',
      'Worlds of English',
      'Digital Media, Culture and Communication',
    ],
    englishMasters: [
      'Artificial Intelligence and Cybersecurity',
      'Cross-Border Studies',
      'Game Studies and Engineering',
      'Mathematics',
    ],
    website: 'https://www.aau.at',
    feeVerified: true,
    note: 'Unusually strong English Bachelor offering for a public university.',
  ),

  University(
    id: 'tugraz',
    name: 'TU Graz',
    city: 'Graz',
    type: InstitutionType.publicUniversity,
    tuitionPerSemesterEur: kPublicSemesterFee,
    englishMasters: ['Computer Science', 'Chemical Engineering', 'Advanced Materials'],
    website: 'https://www.tugraz.at',
    feeVerified: true,
  ),

  University(
    id: 'unigraz',
    name: 'University of Graz',
    city: 'Graz',
    type: InstitutionType.publicUniversity,
    tuitionPerSemesterEur: kPublicSemesterFee,
    website: 'https://www.uni-graz.at',
    admissionsUrl: 'https://studienabteilung.uni-graz.at/en/tuition-fee/',
    feeVerified: true,
    note: 'Teaching is mostly in German and C1 is generally expected.',
  ),

  University(
    id: 'uibk',
    name: 'University of Innsbruck',
    city: 'Innsbruck',
    type: InstitutionType.publicUniversity,
    tuitionPerSemesterEur: kPublicSemesterFee,
    englishMasters: ['Strategic Management', 'Physics'],
    website: 'https://www.uibk.ac.at',
    admissionsUrl: 'https://www.uibk.ac.at/en/admission-department/',
    feeVerified: true,
    note: 'Around half the student body is international.',
  ),

  University(
    id: 'jku',
    name: 'Johannes Kepler University Linz',
    city: 'Linz',
    type: InstitutionType.publicUniversity,
    tuitionPerSemesterEur: kPublicSemesterFee,
    englishMasters: ['Business and technical programmes'],
    website: 'https://www.jku.at',
    admissionsUrl: 'https://www.jku.at/en/degree-programs/international-students/',
    feeVerified: true,
    note: 'Single campus, and offers a number of dual-language programmes.',
  ),

  University(
    id: 'boku',
    name: 'BOKU University',
    city: 'Vienna',
    type: InstitutionType.publicUniversity,
    tuitionPerSemesterEur: kPublicSemesterFee,
    englishMasters: [
      'Biotechnology',
      'Mountain Forestry',
      'Green Chemistry',
      'Environmental Sciences',
    ],
    website: 'https://boku.ac.at',
    admissionsUrl: 'https://boku.ac.at/en/studienservices/',
    feeVerified: true,
    note: 'Natural resources and life sciences. All Bachelor programmes are '
        'German-taught; the English options are at Master level.',
  ),

  University(
    id: 'salzburg',
    name: 'University of Salzburg',
    city: 'Salzburg',
    type: InstitutionType.publicUniversity,
    tuitionPerSemesterEur: kPublicSemesterFee,
    englishMasters: ['Selected programmes, check the current catalogue'],
    website: 'https://www.plus.ac.at',
    feeVerified: true,
    note: 'Roughly a third of students come from outside Austria.',
  ),

  University(
    id: 'meduni-wien',
    name: 'Medical University of Vienna',
    city: 'Vienna',
    type: InstitutionType.publicUniversity,
    tuitionPerSemesterEur: kPublicSemesterFee,
    website: 'https://www.meduniwien.ac.at',
    feeVerified: true,
    note: 'Medicine has its own entrance examination and a separate '
        'application route.',
  ),

  University(
    id: 'meduni-graz',
    name: 'Medical University of Graz',
    city: 'Graz',
    type: InstitutionType.publicUniversity,
    tuitionPerSemesterEur: kPublicSemesterFee,
    website: 'https://www.medunigraz.at',
    feeVerified: true,
  ),

  University(
    id: 'meduni-innsbruck',
    name: 'Medical University of Innsbruck',
    city: 'Innsbruck',
    type: InstitutionType.publicUniversity,
    tuitionPerSemesterEur: kPublicSemesterFee,
    website: 'https://www.i-med.ac.at',
    feeVerified: true,
  ),

  University(
    id: 'vetmed',
    name: 'University of Veterinary Medicine Vienna',
    city: 'Vienna',
    type: InstitutionType.publicUniversity,
    tuitionPerSemesterEur: kPublicSemesterFee,
    website: 'https://www.vetmeduni.ac.at',
    feeVerified: true,
    note: 'Teaching is primarily in German.',
  ),

  University(
    id: 'akbild',
    name: 'Academy of Fine Arts Vienna',
    city: 'Vienna',
    type: InstitutionType.publicUniversity,
    tuitionPerSemesterEur: kPublicSemesterFee,
    website: 'https://www.akbild.ac.at',
    feeVerified: true,
    note: 'Portfolio and entrance examination required.',
  ),

  University(
    id: 'dieangewandte',
    name: 'University of Applied Arts Vienna',
    city: 'Vienna',
    type: InstitutionType.publicUniversity,
    tuitionPerSemesterEur: kPublicSemesterFee,
    website: 'https://www.dieangewandte.at',
    feeVerified: true,
    note: 'Portfolio required.',
  ),

  University(
    id: 'mdw',
    name: 'University of Music and Performing Arts Vienna',
    city: 'Vienna',
    type: InstitutionType.publicUniversity,
    tuitionPerSemesterEur: kPublicSemesterFee,
    website: 'https://www.mdw.ac.at',
    admissionsUrl: 'https://www.mdw.ac.at/studiencenter/studienbeitrag/',
    feeVerified: true,
    note: 'Auditions required. One of the most respected music schools in the '
        'world.',
  ),

  University(
    id: 'kug',
    name: 'University of Music and Performing Arts Graz',
    city: 'Graz',
    type: InstitutionType.publicUniversity,
    tuitionPerSemesterEur: kPublicSemesterFee,
    website: 'https://www.kug.ac.at',
    feeVerified: true,
    note: 'Auditions required.',
  ),

  University(
    id: 'moz',
    name: 'Mozarteum University Salzburg',
    city: 'Salzburg',
    type: InstitutionType.publicUniversity,
    tuitionPerSemesterEur: kPublicSemesterFee,
    website: 'https://www.moz.ac.at',
    feeVerified: true,
    note: 'Auditions required.',
  ),

  University(
    id: 'ufg',
    name: 'University of Art and Design Linz',
    city: 'Linz',
    type: InstitutionType.publicUniversity,
    tuitionPerSemesterEur: kPublicSemesterFee,
    website: 'https://www.ufg.at',
    feeVerified: true,
  ),

  University(
    id: 'donau-uni',
    name: 'University for Continuing Education Krems',
    city: 'Krems',
    type: InstitutionType.publicUniversity,
    website: 'https://www.donau-uni.ac.at',
    feeVerified: false,
    note: 'Continuing education, so fees are set per programme rather than '
        'federally. Check the individual programme before applying.',
  ),

  // -------------------------------------------------------------------------
  // UNIVERSITIES OF APPLIED SCIENCES
  // Practical and industry-focused, often an easier entry route.
  // Fees vary between institutions, so check each one.
  // -------------------------------------------------------------------------

  University(
    id: 'fh-kufstein',
    name: 'FH Kufstein Tirol',
    city: 'Kufstein',
    type: InstitutionType.appliedSciences,
    tuitionPerSemesterEur: 363.36,
    applicationFeeEur: 726.72,
    applicationFeeNote:
        'Deposit paid with the online application and credited against your '
        'first year.',
    englishBachelors: ['Business (BA)', 'Engineering (BSc)'],
    englishMasters: ['Several English-taught Master programmes'],
    website: 'https://www.fh-kufstein.ac.at',
    admissionsUrl: 'https://www.fh-kufstein.ac.at/en/admissions/tuition-fees',
    feeVerified: true,
    note: 'The cheapest option in this list at roughly 727 euro for a full '
        'year, and it runs a dedicated English-taught track.',
  ),

  University(
    id: 'campus02',
    name: 'FH CAMPUS 02',
    city: 'Graz',
    type: InstitutionType.appliedSciences,
    tuitionPerSemesterEur: 726.72,
    englishBachelors: ['Selected business and technology programmes'],
    englishMasters: ['International Marketing and Sales', 'Innovation Management'],
    website: 'https://www.campus02.at',
    admissionsUrl:
        'https://www.campus02.at/en/service-fuer-studieninteressierte/bewerbung-aufnahme/studienbeitraege-gebuehren/',
    feeVerified: false,
    note: 'Business and technology with a strong practical focus, built around '
        'working alongside industry. Rooms in Graz run 300 to 650 euro a '
        'month, and their partner WIFI offers German courses at a student '
        'discount. Start looking for housing two to three months before you '
        'move; Graz is tight.',
  ),

  University(
    id: 'fh-joanneum',
    name: 'FH JOANNEUM',
    city: 'Graz, Kapfenberg and Bad Radkersburg',
    type: InstitutionType.appliedSciences,
    tuitionPerSemesterEur: 726.72,
    applicationFeeEur: 260,
    applicationFeeNote:
        'A 250 euro deposit plus a 10 euro processing fee, payable before you '
        'apply. The processing fee is not refundable.',
    englishMasters: [
      'Electronic Engineering',
      'Global Strategic Management',
      'Automotive Engineering',
      'Aviation',
      'IT and Mobile Security',
      'Energy and Transport Management',
    ],
    website: 'https://www.fh-joanneum.at',
    admissionsUrl:
        'https://www.fh-joanneum.at/en/international/international-degree-seeking-students/admissions/',
    feeVerified: true,
    note: 'Your first two semesters are payable in advance once you accept. '
        'Note that fees are being introduced for new starters from winter '
        '2026/27, so check the current position.',
  ),

  University(
    id: 'fh-ooe',
    name: 'FH Upper Austria',
    city: 'Hagenberg, Wels, Steyr and Linz',
    type: InstitutionType.appliedSciences,
    tuitionPerSemesterEur: 726.72,
    englishMasters: [
      'Interactive Media, Hagenberg',
      'Energy Informatics, Hagenberg',
      'Innovation and Product Management, Wels',
      'Global Sales and Marketing, Steyr',
    ],
    website: 'https://fh-ooe.at',
    admissionsUrl: 'https://fh-ooe.at/en/study-information/financial-matters',
    feeVerified: true,
    note: 'Hagenberg is the country\u2019s software campus. The fee can drop to '
        '363.36 a semester if you can show close ties to Austria.',
  ),

  University(
    id: 'fh-campus-wien',
    name: 'Hochschule Campus Wien',
    city: 'Vienna',
    type: InstitutionType.appliedSciences,
    tuitionPerSemesterEur: 726.72,
    englishMasters: ['Selected technology and health programmes'],
    website: 'https://www.fh-campuswien.ac.at',
    feeVerified: false,
    note: 'The largest university of applied sciences in Austria, with a broad '
        'spread of subjects.',
  ),

  University(
    id: 'fh-salzburg',
    name: 'FH Salzburg',
    city: 'Salzburg',
    type: InstitutionType.appliedSciences,
    tuitionPerSemesterEur: 726.72,
    englishBachelors: ['See their English programmes page'],
    englishMasters: ['Applied Image and Signal Processing', 'Business Management'],
    website: 'https://www.fh-salzburg.ac.at',
    admissionsUrl:
        'https://www.fh-salzburg.ac.at/en/study/bachelors-and-masters-degree-programmes-in-english',
    feeVerified: false,
  ),

  University(
    id: 'fh-kaernten',
    name: 'FH K\u00E4rnten',
    city: 'Villach, Klagenfurt, Spittal and Feldkirchen',
    type: InstitutionType.appliedSciences,
    tuitionPerSemesterEur: 726.72,
    englishBachelors: ['Selected engineering programmes'],
    englishMasters: ['Systems Design', 'Health Care IT', 'Spatial Mobility'],
    website: 'https://www.fh-kaernten.at',
    feeVerified: false,
    note: 'Four campuses across Carinthia.',
  ),

  University(
    id: 'fh-burgenland',
    name: 'Hochschule Burgenland',
    city: 'Eisenstadt and Pinkafeld',
    type: InstitutionType.appliedSciences,
    applicationFeeEur: 350,
    applicationFeeNote:
        'A 350 euro deposit on admission, refunded after your first semester.',
    englishMasters: ['International Business', 'Energy and Environmental Management'],
    website: 'https://www.hochschule-burgenland.at',
    feeVerified: false,
    note: 'Has historically charged no tuition, though the deposit still '
        'applies. Confirm the current position for third-country students.',
  ),

  University(
    id: 'fhv',
    name: 'FH Vorarlberg',
    city: 'Dornbirn',
    type: InstitutionType.appliedSciences,
    englishMasters: ['Computer Science', 'International Management'],
    website: 'https://www.fhv.at',
    feeVerified: false,
    note: 'Has historically charged no tuition, though it reserves the right '
        'to introduce fees. Worth checking directly.',
  ),

  University(
    id: 'fhwien-wkw',
    name: 'FHWien der WKW',
    city: 'Vienna',
    type: InstitutionType.appliedSciences,
    tuitionPerSemesterEur: 726.72,
    englishMasters: ['Executive Management', 'Marketing and Sales Management'],
    website: 'https://www.fh-wien.ac.at',
    feeVerified: false,
    note: 'Management and communications, closely tied to the Vienna Chamber '
        'of Commerce.',
  ),

  University(
    id: 'fh-bfi-wien',
    name: 'FH BFI Vienna',
    city: 'Vienna',
    type: InstitutionType.appliedSciences,
    tuitionPerSemesterEur: 726.72,
    englishBachelors: ['International Business Administration'],
    englishMasters: ['Strategic Finance and Business Analytics'],
    website: 'https://www.fh-vie.ac.at',
    feeVerified: false,
    note: 'Business and finance.',
  ),

  University(
    id: 'lauder',
    name: 'Lauder Business School',
    city: 'Vienna',
    type: InstitutionType.appliedSciences,
    tuitionPerSemesterEur: 726.72,
    englishBachelors: ['International Business Administration'],
    englishMasters: [
      'International Management and Leadership',
      'Strategic Finance and Business Analytics',
    ],
    website: 'https://www.lbs.ac.at',
    feeVerified: false,
    note: 'Everything is taught in English, and it is a government-funded '
        'institution rather than a private one. Confirm the third-country fee '
        'directly.',
  ),

  University(
    id: 'fh-gesundheit-tirol',
    name: 'FH Gesundheit Tirol',
    city: 'Innsbruck',
    type: InstitutionType.appliedSciences,
    tuitionPerSemesterEur: 726.72,
    website: 'https://www.fhg-tirol.ac.at',
    feeVerified: false,
    note: 'Health professions, taught in German.',
  ),

  University(
    id: 'fh-gesundheit-ooe',
    name: 'FH Health Professions Upper Austria',
    city: 'Linz',
    type: InstitutionType.appliedSciences,
    tuitionPerSemesterEur: 726.72,
    website: 'https://www.fh-gesundheitsberufe.at',
    feeVerified: false,
    note: 'Health professions, taught in German.',
  ),

  University(
    id: 'fernfh',
    name: 'Ferdinand Porsche FernFH',
    city: 'Wiener Neustadt, distance learning',
    type: InstitutionType.appliedSciences,
    tuitionPerSemesterEur: 726.72,
    website: 'https://www.fernfh.ac.at',
    feeVerified: false,
    note: 'Distance learning. Worth knowing that a fully remote programme may '
        'not satisfy the residence permit requirements, so check before '
        'applying.',
  ),
];

// ---------------------------------------------------------------------------
// The ones to avoid on a tight budget.
// Listed deliberately: better you know the price before you apply than after
// you have been accepted.
// ---------------------------------------------------------------------------

const List<ExpensiveInstitution> expensiveInstitutions = [
  ExpensiveInstitution(
    name: 'FH St. P\u00F6lten',
    city: 'St. P\u00F6lten',
    yearlyCost: '\u20AC3,000 a year',
    warning:
        'Charges \u20AC1,500 per semester to third-country students, well '
        'above the usual applied sciences rate.',
  ),
  ExpensiveInstitution(
    name: 'MCI Innsbruck',
    city: 'Innsbruck',
    yearlyCost: 'About \u20AC16,500 a year',
    warning:
        'Roughly eleven times what FH Kufstein charges for the same level of '
        'study. The full first year is due within two weeks of acceptance.',
  ),
  ExpensiveInstitution(
    name: 'FH Technikum Wien',
    city: 'Vienna',
    yearlyCost: 'About \u20AC6,000 a year',
    warning:
        'Charges 3,000 euro per semester to third-country students, well above '
        'the usual applied sciences rate. A 250 euro deposit is due on '
        'conditional admission.',
  ),
  ExpensiveInstitution(
    name: 'Webster Vienna',
    city: 'Vienna',
    yearlyCost: '\u20AC17,000 to \u20AC20,000 a year',
    warning:
        'Private, taught entirely in English, and wants a 1,000 euro deposit '
        'before it will even issue the acceptance letter you need for '
        'immigration.',
  ),
  ExpensiveInstitution(
    name: 'Modul University Vienna',
    city: 'Vienna',
    yearlyCost: 'About \u20AC12,000 a year',
    warning: 'Private institution, business and tourism focused.',
  ),
  ExpensiveInstitution(
    name: 'IMC Krems',
    city: 'Krems',
    yearlyCost: 'Around \u20AC7,000 a year, unconfirmed',
    warning:
        'Charges third-country students noticeably above the standard rate. '
        'Confirm the exact figure with them before applying.',
  ),
  ExpensiveInstitution(
    name: 'Other private universities',
    city: 'Various',
    yearlyCost: '\u20AC3,000 to \u20AC35,000 a year',
    warning:
        'Danube Private University, Sigmund Freud, Karl Landsteiner and '
        'others. Entry is often easier, but the cost is many times what a '
        'public university charges.',
  ),
];

List<University> universitiesOfType(InstitutionType type) =>
    universities.where((u) => u.type == type).toList();

List<University> withEnglishBachelors() =>
    universities.where((u) => u.hasEnglishBachelor).toList();

List<University> withEnglishMasters() =>
    universities.where((u) => u.hasEnglishMaster).toList();
