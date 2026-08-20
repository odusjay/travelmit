import '../models/journey.dart';

// ===========================================================================
// THE FIRST PAGE
//
// This is what someone sees before they pay. Its job is to be honest enough
// that they trust it, and clear enough that they want the rest.
//
// Everything inside 'single quotes' is safe to edit.
// ===========================================================================

const String appName = 'TravelMit';

class DiscoverSection {
  final String icon;
  final String title;
  final String body;
  final List<String> facts;
  final String? insiderTip;

  const DiscoverSection({
    required this.icon,
    required this.title,
    required this.body,
    this.facts = const [],
    this.insiderTip,
  });
}

const List<({String value, String label})> heroStats = [
  (value: '\u20AC1,453', label: 'a year at a public university'),
  (value: '20 hrs', label: 'you can work each week'),
  (value: '12 months', label: 'to find work after graduating'),
];

const String heroTitle = 'Austria costs less\nthan you think.';

const String heroSubtitle =
    'A public university here charges about \u20AC726 a semester. Not a month. '
    'A semester. There are degrees taught in English, you can work while you '
    'study, and when you finish you are allowed to stay and look for a job.';

const List<DiscoverSection> discoverSections = [
  DiscoverSection(
    icon: '\u{1F393}',
    title: 'The fees are the same wherever you go',
    body:
        'Vienna, Graz, Innsbruck, Leoben. Every public university in Austria '
        'charges the same, around \u20AC726 a semester for someone coming from '
        'Nigeria. That works out at roughly \u20AC1,453 for the year.\n\n'
        'A single year in the UK or Canada costs more than an entire Austrian '
        'degree. And nobody has ever looked at an Austrian qualification and '
        'wondered why it was cheap.',
    facts: [
      'Identical fee at every public university',
      'Most public universities charge nothing to apply',
      'Recognised across the EU',
    ],
  ),

  DiscoverSection(
    icon: '\u{1F5E3}',
    title: 'You can do the whole thing in English',
    body:
        'People assume German is compulsory. It is not. There are full degree '
        'programmes taught in English across engineering, computing, business '
        'and more.\n\n'
        'If your programme is in English, you generally will not need to prove '
        'German for the residence permit either. That removes the barrier most '
        'people think is standing in their way before they have even looked.',
    facts: [
      'English Bachelor and Master programmes exist',
      'No German requirement for English-taught degrees',
      'Master level has far more choice',
    ],
    insiderTip:
        'English Bachelor programmes are a short list. Leoben and Klagenfurt '
        'are the main public options, plus a handful of applied sciences '
        'schools. Apply blind and you will waste months on programmes that '
        'were never in English.',
  ),

  DiscoverSection(
    icon: '\u{1F4C4}',
    title: 'What you will actually need',
    body:
        'This is the part nobody lays out properly, so here it is up front.\n\n'
        'Your educational papers: WAEC or NECO, a testimonial, and your SS1 to '
        'SS3 transcript from the school you attended. If you went further, add '
        'the certificate and transcript for your OND, HND or degree.\n\n'
        'Your personal papers: if you are eighteen or over, an attestation of '
        'birth certificate, not a birth certificate. Children under eighteen '
        'use the birth certificate itself. Everyone needs a declaration of age '
        'sworn by a guardian at least five years older than them.\n\n'
        'English: IELTS at 6.0 or Duolingo at 110. International exams, so '
        'they skip the authentication chain entirely.\n\n'
        'Later, for the residence permit: a house contract, travel health '
        'insurance, proof of funds with evidence of where the money came from, '
        'a police clearance certificate, the application form, and an EU '
        'standard passport photograph.',
    facts: [
      'Every document counts toward your costs',
      'Adults cannot use a birth certificate',
      'Only the student needs IELTS or Duolingo',
    ],
    insiderTip:
        'Each document is \u20AC80 to legalise, plus a VFS processing fee on '
        'top. So an HND holder pays noticeably more than someone with '
        'O\u2019Level alone. The calculator inside works out your number.',
  ),

  DiscoverSection(
    icon: '\u{1F3D9}',
    title: 'You can live well here on very little money',
    body:
        'Vienna has been named the most liveable city in the world five '
        'times and currently sits second. That means the ordinary things: '
        'you feel safe walking home, the hospitals work, the buses come on '
        'time.\n\n'
        'The tap water arrives from Alpine springs, so nobody buys bottled '
        'water. Parks and libraries are free. Museums cost very little with '
        'a student card. Daily life does not need to be expensive here, and '
        'that is not true of every country in Europe.',
    facts: [
      'Among the safest countries anywhere',
      'Drink the tap water, it is better than bottled',
      'Over half of Vienna is green space',
    ],
  ),

  DiscoverSection(
    icon: '\u{1F687}',
    title: 'You will never need a car',
    body:
        'Trams, buses and underground trains that arrive when the app says '
        'they will. At weekends the Vienna underground runs through the '
        'night.\n\n'
        'Under 26, the annual youth pass covers all of Vienna for \u20AC294 a '
        'year, which is about \u20AC25 a month for the whole city. If you want '
        'to see the rest of the country, the national KlimaTicket is \u20AC1,050 '
        'a year at that age.',
    facts: [
      '\u20AC294 a year for unlimited travel in Vienna',
      'Night services at weekends',
      'Shared bikes through the same system',
    ],
    insiderTip:
        'The \u20AC75 semester ticket everyone still writes about was scrapped '
        'in February 2026. If a guide quotes it, that guide has not been '
        'updated in a while.',
  ),

  DiscoverSection(
    icon: '\u{1F6D2}',
    title: 'Things that will catch you out in week one',
    body:
        'Shops close on Sundays. Nearly all of them, nearly everywhere. Forget '
        'to buy food on Saturday and you will be eating whatever is in the '
        'cupboard. Every newcomer learns this once.\n\n'
        'Hofer and Lidl are where your money goes furthest. Billa and Spar '
        'cost more for the same thing. Cooking at home rather than eating out '
        'changes your monthly budget more than any other single habit.\n\n'
        'Rubbish gets separated into several bins and people take it '
        'seriously. Rent usually wants a deposit of a few months up front. And '
        'almost everything, rent, insurance, phone, moves by bank transfer '
        'rather than cash.',
    facts: [
      'Hofer and Lidl for groceries',
      'Sundays: shops shut',
      'Bank transfer for nearly everything',
    ],
    insiderTip:
        'Supermarkets inside the big train stations are among the few places '
        'open on a Sunday. Find your nearest one before the weekend you need '
        'it.',
  ),

  DiscoverSection(
    icon: '\u{1F1E6}\u{1F1F9}',
    title: 'German is what turns this into a life',
    body:
        'You can study in English. But German is the difference between living '
        'in Austria and passing through it.\n\n'
        'It changes what work you can get, how easily you deal with landlords '
        'and offices, and whether you end up with Austrian friends or only '
        'international ones. Universities run cheap courses, and the '
        'Volkshochschule adult education centres run cheaper ones in every '
        'city.\n\n'
        'You will not need it to arrive. You will want it by your second year.',
    facts: [
      'Not needed for English-taught degrees',
      'Cheap classes at Volkshochschule',
      'Opens up part-time work',
    ],
    insiderTip:
        'Learn a little before you fly, even just greetings and numbers. The '
        'first weeks are all paperwork and apartment viewings, and a small '
        'amount of German makes them far less exhausting.',
  ),

  DiscoverSection(
    icon: '\u{1F91D}',
    title: 'You will not be the only Nigerian here',
    body:
        'University canteens do a full meal at student prices. Student tickets '
        'get you into museums, concerts and the opera for very little; in '
        'Vienna you can stand at the State Opera for about the price of a '
        'coffee.\n\n'
        'Every university has societies, international groups and buddy '
        'schemes that pair new arrivals with people already here. There are '
        'established Nigerian and West African communities in all the main '
        'cities, and they are easy to find once you arrive.\n\n'
        'You are also allowed to work twenty hours a week while you study.',
    facts: [
      'Cheap meals on campus',
      'Student rates at almost everything',
      'Established Nigerian communities',
      'Twenty hours a week of legal work',
    ],
  ),

  DiscoverSection(
    icon: '\u{1F30D}',
    title: 'Europe stops being far away',
    body:
        'With an Austrian residence permit you can move around the Schengen '
        'area, up to ninety days in any hundred and eighty. Germany, Italy, '
        'France, Spain, the Netherlands. No new visa each time.\n\n'
        'Austria sits in the middle of it all. Budapest, Prague, Munich and '
        'Venice are a few hours away by train or coach, and students go for '
        'weekends on the kind of money a night out costs.',
    facts: [
      'Ninety days in any hundred and eighty',
      'Prague, Budapest and Munich within hours',
      'Student fares on rail and coach',
    ],
  ),

  DiscoverSection(
    icon: '\u{1F3AF}',
    title: 'And you are allowed to stay',
    body:
        'This is the part that changes the whole calculation, and almost '
        'nobody knows it before they start.\n\n'
        'Finish a degree at an Austrian university and you can apply for a Job '
        'Seeker Visa. That is twelve months to find work in your field. When '
        'you find it, you move onto a Red-White-Red Card without the labour '
        'market test other applicants have to pass.\n\n'
        'Austria does not train you and then send you home.',
    facts: [
      'Twelve months to find work after graduating',
      'Red-White-Red Card route',
      'A path toward long-term residence',
    ],
    insiderTip:
        'Immigration rules do change. Confirm the current terms with the '
        'embassy before you build a plan around them.',
  ),
];

const String realityTitle = 'So why does anyone fail?';

const String realityBody =
    'Because the process punishes people who guess.\n\n'
    'Your documents go through two separate ministries, in an order that '
    'cannot be swapped. VFS appointments have to be booked months ahead, and '
    'the ministry work has to happen while you wait for that date, not after '
    'it. The police clearance certificate expires, so it has to be timed '
    'against the day you submit. And Austria approves your residence permit '
    'before you apply for the visa, which is the reverse of what almost '
    'everyone assumes.\n\n'
    'Any one of those, done in the wrong order, costs months. Agents charge a '
    'fortune and plenty of them know less than you will after reading this.\n\n'
    'I went through all of it myself, and I live in Austria now. This is the '
    'whole route written down. Every stage, every document, what it costs and '
    'when it is due.';

const String ctaLabel = 'Open the full guide';

// ---------------------------------------------------------------------------
// REVIEWS
//
// Only real quotes from real people, used with their permission.
// Apple and Google both ban invented testimonials and do check for them.
//
// This list ships empty. The section stays hidden until you add something.
// Format for each entry:
//
//   Testimonial(
//     name: 'First name and last initial',
//     detail: 'Something specific, e.g. Lagos to Graz, 2025',
//     quote: 'What they actually said.',
//     rating: 5,
//   ),
// ---------------------------------------------------------------------------

const List<Testimonial> testimonials = [];

const String reviewPrompt =
    'If this guide helped you get here, a review helps the next person find '
    'it.';
