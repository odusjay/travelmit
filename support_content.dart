// ===========================================================================
// ABUJA SUPPORT
//
// The ministries and the embassy are all in Abuja. Most applicants are not.
// This is the service that closes that gap.
// ===========================================================================

const String supportEmail = 'odusjay@gmail.com';
const String supportTeamName = 'Abuja Support Team';

const String supportHeadline = 'You do not have to be in Abuja';

const String supportIntro =
    'The Ministry of Education, the Ministry of Foreign Affairs and the '
    'embassy are all in Abuja. If you live in Lagos, Port Harcourt, Kano or '
    'anywhere else, that means flights, hotels and days off work, repeated '
    'across several trips.\n\n'
    'You can send your documents instead. Our team in Abuja handles the '
    'stamping on your behalf and sends everything back to you.';

/// How the service actually works, step by step.
const List<({String title, String detail})> supportSteps = [
  (
    title: 'Get your documents together',
    detail:
        'Gather the originals you need for the stage you are on. Check the '
        'document list for that step so nothing is missing.',
  ),
  (
    title: 'Photograph everything first',
    detail:
        'Before anything leaves your hands, photograph every page. If a parcel '
        'goes astray, those photos are your proof of what was sent. Takes five '
        'minutes and settles any question later.',
  ),
  (
    title: 'Send through a registered transport company',
    detail:
        'Use a proper courier, not an informal arrangement. God is Good Motors '
        'is the one we use most often from Lagos, and they are reliable with '
        'documents. You get a tracking reference, which matters.',
  ),
  (
    title: 'We confirm arrival',
    detail:
        'Our Abuja team confirms receipt and checks the documents against what '
        'the stage requires, before anything is submitted.',
  ),
  (
    title: 'You get a price before anything is paid',
    detail:
        'The cost depends on how many documents you have sent and which '
        'stamps they need. You are told the figure first and pay only when you '
        'have agreed it.',
  ),
  (
    title: 'Processing and return',
    detail:
        'The documents go through the ministry or embassy, then come back to '
        'you through the same registered transport company.',
  ),
];

const String supportNote =
    'This covers Ministry of Education authentication, Ministry of Foreign '
    'Affairs authentication, and legalisation at the embassy. Email the team '
    'with which stage you are on and how many documents you have, and they '
    'will tell you what it costs.';

/// Shown on the Discover page before purchase, without the contact details.
const String supportTeaser =
    'Ninety percent of the people we work with do not live in Abuja. Sending '
    'documents beats flying there. Full details, and direct contact with our '
    'Abuja team, come with the guide.';
