import '../models/journey.dart';

// ===========================================================================
// THE CONTENT FILE
//
// This is where the words live. Change anything inside 'single quotes'.
// Leave the commas, brackets and braces alone and nothing will break.
//
// To add a step: copy an existing block, give it a new id and order number.
// ===========================================================================

/// Named spans of time, so people know where they are rather than just which
/// numbered step they're on.
const List<JourneyBlock> journeyBlocks = [
  JourneyBlock(
    id: 'block-1',
    phase: Phase.homeCountry,
    title: 'Getting your papers ready',
    duration: 'About 6 months',
    description:
        'Book your VFS date first, then work through the ministries while you '
        'wait for it. These run at the same time. That is the part most people '
        'get wrong.',
  ),
  JourneyBlock(
    id: 'block-2',
    phase: Phase.homeCountry,
    title: 'Submission and the long wait',
    duration: '2 to 4 months',
    description:
        'You hand everything in, then you wait for the embassy to verify it. '
        'Nothing you do speeds this up.',
  ),
  JourneyBlock(
    id: 'block-3',
    phase: Phase.homeCountry,
    title: 'Admission and residence permit',
    duration: '3 to 6 months',
    description:
        'Legalised documents in hand, you apply to universities, then to the '
        'authorities for your residence permit.',
  ),
  JourneyBlock(
    id: 'block-4',
    phase: Phase.homeCountry,
    title: 'Visa and departure',
    duration: '4 to 8 weeks',
    description:
        'Only after your residence permit is approved does the D visa happen. '
        'Then you fly.',
  ),
  JourneyBlock(
    id: 'block-5',
    phase: Phase.postArrival,
    title: 'Your first weeks in Austria',
    duration: '2 to 4 weeks',
    description:
        'Registration, bank, insurance, transport, and finally the card '
        'itself.',
  ),
];

const List<JourneyStep> journeySteps = [
  // -------------------------------------------------------------------------
  // BLOCK 1 — roughly the first six months
  // -------------------------------------------------------------------------

  JourneyStep(
    id: 'international-passport',
    order: 1,
    phase: Phase.homeCountry,
    blockId: 'block-1',
    title: 'Get your international passport ready',
    summary: 'Nothing else in this process can start without one.',
    detail:
        'Before anything else, you need a valid Nigerian international '
        'passport. Every document, every VFS appointment, every '
        'application from here on assumes you already have one.\n\n'
        'If you do not have one yet, apply for it now, before you do '
        'anything else in this guide. The application, payment and your '
        'biometrics appointment all happen on the Nigeria Immigration '
        'Service\u2019s own portal. The direct link is included with the '
        'full guide, so you do not have to search for the right site '
        'yourself.\n\n'
        'If you already have one, check the expiry date. It needs enough '
        'validity left to comfortably cover your studies in Austria, not '
        'just the application process itself.',
    links: [
      StepLink(
        label: 'Nigeria Immigration Service \u2013 passport portal',
        url: 'https://passport.immigration.gov.ng/',
        premiumOnly: true,
      ),
    ],
    criticalNote:
        'Do this first. Every step after this one assumes you already hold '
        'a valid international passport.',
    isFreePreview: true,
  ),

  JourneyStep(
    id: 'consultation',
    order: 2,
    phase: Phase.homeCountry,
    blockId: 'block-1',
    title: 'Work out where you actually stand',
    summary: 'Your education level decides everything that follows.',
    detail:
        'Before you book anything or pay anyone, establish what you are '
        'working with. Did you stop after secondary school? Do you have an '
        'OND, an HND, a degree?\n\n'
        'This is not a formality. It decides which programmes will accept '
        'you, which documents you have to authenticate, how many of them '
        'there are, and therefore what this whole thing costs you. Someone '
        'with an HND authenticates more documents than someone with O\u2019Level '
        'alone, and pays more at every stage because of it.\n\n'
        'Get this clear now and the rest of the process has a shape. Guess at '
        'it and you will find out the expensive way.',
    criticalNote:
        'Everything downstream depends on this answer. Do not estimate it.',
    isFreePreview: true,
  ),

  JourneyStep(
    id: 'vfs-booking',
    order: 3,
    phase: Phase.homeCountry,
    blockId: 'block-1',
    timing: StepTiming.startsClock,
    title: 'Book your VFS appointment straight away',
    summary: 'Do this before your documents are ready, not after.',
    detail:
        'This is the single thing people get backwards, and it costs them '
        'months.\n\n'
        'Getting a VFS slot takes time. Then the date you are given is '
        'further out again. So you book first and let that clock run while '
        'you deal with everything else. If you wait until your documents are '
        'authenticated before booking, you will sit idle for weeks waiting '
        'for a date you could have secured already.\n\n'
        'Book it. Then start on the ministries.\n\n'
        'Before you can book anything, you first create an account on the '
        'VFS site with your email address. VFS sends a confirmation link to '
        'that email, and you have to open it and confirm before the account '
        'is active. Use an email you check often, since every update about '
        'your appointment and your documents comes through it, and check '
        'your spam folder if the confirmation does not arrive within a few '
        'minutes.',
    links: [
      StepLink(
        label: 'VFS Nigeria \u2013 book your Austria appointment',
        url: 'https://visa.vfsglobal.com/nga/en/avs/book-an-appointment',
      ),
    ],
    criticalNote:
        'Book now, authenticate afterwards. The waiting time for a slot is '
        'usually longer than the authentication itself.',
  ),

  JourneyStep(
    id: 'vfs-questionnaire',
    order: 4,
    phase: Phase.homeCountry,
    blockId: 'block-1',
    timing: StepTiming.parallel,
    runsDuring: 'while you wait for your VFS date',
    title: 'Fill out the verification questionnaire',
    summary: 'Get it from the VFS page, fill it in block letters.',
    detail:
        'Alongside your documents, you need a completed questionnaire on '
        'submission day. Open the link below, the same VFS page where you '
        'booked your appointment, and look for the download link on that '
        'page rather than saving a copy now. That way, if VFS updates the '
        'questionnaire later, you are always looking at whichever version '
        'is current.\n\n'
        'When you open the link, you will see a numbered, step by step '
        'process on the page. The download link for the questionnaire sits '
        'inside Step 2, \u201cBegin your verification process\u201d, not right '
        'at the top of the page. Tap on Step 2 to open it, and the link to '
        'download the questionnaire is in the text there.\n\n'
        'Fill it in during the waiting period, not the night before your '
        'appointment, so there is time to fix a mistake if you make one.\n\n'
        'Write everything in block letters. Handwriting that cannot be read '
        'clearly gets applications turned back at the counter, and you would '
        'have to book another appointment and start that wait again.\n\n'
        'Answer every question rather than leaving anything blank, and sign '
        'it yourself. For a minor, a parent or legal guardian signs instead.',
    links: [
      StepLink(
        label: 'VFS page \u2013 find the questionnaire there',
        url: 'https://visa.vfsglobal.com/nga/en/avs/apply-verification',
      ),
    ],
    criticalNote:
        'Block letters, every field answered, signed by the applicant.',
  ),

  JourneyStep(
    id: 'moe-authentication',
    order: 5,
    phase: Phase.homeCountry,
    blockId: 'block-1',
    timing: StepTiming.parallel,
    runsDuring: 'while you wait for your VFS date',
    needsAbuja: true,
    title: 'Ministry of Education authentication',
    summary: 'Educational documents first. This one comes before Foreign Affairs.',
    detail:
        'Every educational document goes to the Federal Ministry of Education '
        'in Abuja to be authenticated.\n\n'
        'The order matters and cannot be swapped. Education first, then '
        'Foreign Affairs. Documents that arrive at Foreign Affairs without the '
        'Education stamp get turned away, and you start that leg again.',
    documents: [
      RequiredDocument(id: 'waec', title: 'WAEC or NECO result'),
      RequiredDocument(
        id: 'ss-transcript',
        title: 'SS1 to SS3 secondary school transcript',
        explanation:
            'Obtained from the secondary school you actually attended. Start '
            'asking early, schools are slow with these.',
      ),
      RequiredDocument(
        id: 'higher-ed',
        title: 'OND, HND or BSc certificate and transcript',
        explanation:
            'Only if it applies to you. HND builds on OND, so HND holders '
            'carry both sets of papers: OND certificate and transcript, plus '
            'HND certificate and official transcript.',
      ),
    ],
    criticalNote:
        'Education before Foreign Affairs. There is no way round this order.',
  ),

  JourneyStep(
    id: 'mfa-authentication',
    order: 6,
    phase: Phase.homeCountry,
    blockId: 'block-1',
    timing: StepTiming.parallel,
    runsDuring: 'while you wait for your VFS date',
    needsAbuja: true,
    title: 'Ministry of Foreign Affairs authentication',
    summary: 'Educational and personal documents together this time.',
    detail:
        'Once Education has stamped your academic papers, everything goes to '
        'the Ministry of Foreign Affairs in Abuja. This round includes your '
        'personal documents alongside the educational ones.\n\n'
        'Note what you need for identity. If you are eighteen or over you '
        'cannot use a birth certificate. You need an attestation of birth '
        'certificate. This catches people out constantly.',
    documents: [
      RequiredDocument(
        id: 'mfa-educational',
        title: 'All educational documents, already stamped by Education',
      ),
      RequiredDocument(
        id: 'attestation',
        title: 'Attestation of birth certificate',
        explanation:
            'For anyone eighteen or over. A birth certificate will not be '
            'accepted at this age.',
        warning:
            'Adults cannot substitute a birth certificate here. If you are 18 '
            'or older you need the attestation.',
      ),
      RequiredDocument(
        id: 'child-birth-cert',
        title: 'Birth certificate, for children under 18',
        explanation: 'Children use the birth certificate itself.',
      ),
      RequiredDocument(
        id: 'declaration-age',
        title: 'Declaration of age',
        explanation:
            'Sworn by a guardian at least five years older than you. Mother, '
            'father, uncle or brother all work, provided the five year gap '
            'holds.',
      ),
      RequiredDocument(
        id: 'marriage-cert',
        title: 'Marriage certificate',
        explanation:
            'Needed if you are applying as a couple. Also worth legalising '
            'now even if your partner is joining you later, so you are not '
            'doing it from Austria.',
      ),
      RequiredDocument(
        id: 'bachelorhood',
        title: 'Bachelorhood certificate',
        explanation:
            'Not required for the application. But if you might marry in '
            'Austria one day, legalise it now while you are already paying '
            'for the process.',
      ),
    ],
    criticalNote:
        'If you are 18 or over, it is the attestation of birth certificate, '
        'not the birth certificate.',
  ),

  JourneyStep(
    id: 'english-test',
    order: 7,
    phase: Phase.homeCountry,
    blockId: 'block-1',
    timing: StepTiming.parallel,
    runsDuring: 'while you wait for your VFS date',
    title: 'Sit IELTS or Duolingo',
    summary: 'IELTS 6.0 or Duolingo 110, minimum.',
    detail:
        'You need proof of English. IELTS at 6.0 or above, or Duolingo at 110 '
        'points or above.\n\n'
        'These are international exams, so they skip the whole authentication '
        'and legalisation chain. Nothing to take to Abuja, nothing to pay per '
        'page. Book it while you are waiting on everything else.\n\n'
        'Only the person studying needs this. Your partner does not.',
    criticalNote:
        'No legalisation needed for these. They do not add to your document '
        'count or your legalisation bill.',
  ),

  // -------------------------------------------------------------------------
  // BLOCK 2 — submission and waiting
  // -------------------------------------------------------------------------

  JourneyStep(
    id: 'vfs-submission',
    order: 8,
    phase: Phase.homeCountry,
    blockId: 'block-2',
    title: 'Submit at VFS on your appointment date',
    summary: 'Two separate payments happen here. Budget for both.',
    detail:
        'Your appointment arrives and you hand in the complete set. Turn up '
        'with anything missing and you lose the slot, then queue again for '
        'another.\n\n'
        'Two payments are due at the counter on the day. The lawyer fee is set '
        'by the embassy: four hundred euro for a single applicant, five '
        'hundred for a family. On top of that VFS charges a processing fee per '
        'document, so the more documents you carry the more this comes to.',
    costs: [
      CostItem(
        label: 'Lawyer fee, single applicant',
        amount: 400,
        currency: Currency.eur,
      ),
      CostItem(
        label: 'Lawyer fee, family',
        amount: 500,
        currency: Currency.eur,
      ),
      CostItem(
        label: 'VFS processing',
        amount: 15,
        currency: Currency.eur,
        unit: 'per document',
        note: 'Ranges from 10 to 15 euro depending on the document',
      ),
    ],
    criticalNote:
        'Both payments are made over the counter at VFS on the day. Come with '
        'the money ready.',
  ),

  JourneyStep(
    id: 'verification-wait',
    order: 9,
    phase: Phase.homeCountry,
    blockId: 'block-2',
    timeline: 'Two to four months',
    title: 'The verification wait',
    summary: 'Two to four months of silence. This is normal.',
    detail:
        'VFS and the embassy now verify what you submitted. How long depends '
        'on your documents. Two months for some, four for others. An email '
        'tells you the outcome.\n\n'
        'You will hear nothing for weeks at a time. That is how it works, not '
        'a sign that something has gone wrong.\n\n'
        'Nobody can shorten this. If someone offers to, for a fee, they are '
        'lying to you.',
    criticalNote:
        'No agent, no contact, no payment speeds this up. Ignore anyone who '
        'claims otherwise.',
  ),

  // -------------------------------------------------------------------------
  // BLOCK 3 — legalisation, admission, residence permit
  // -------------------------------------------------------------------------

  JourneyStep(
    id: 'legalisation',
    order: 10,
    phase: Phase.homeCountry,
    blockId: 'block-3',
    needsAbuja: true,
    title: 'Legalisation at the embassy',
    summary: 'Eighty euro per document, at the embassy in Abuja.',
    detail:
        'With verification confirmed, your documents get legalised at the '
        'embassy. Eighty euro each.\n\n'
        'This is charged per document, which is why the number of documents '
        'you carry matters so much to your total. It is also why it is worth '
        'thinking now about the optional ones, such as a marriage or '
        'bachelorhood certificate. Doing them later, from Austria, is far '
        'harder than adding them to this batch.',
    costs: [
      CostItem(
        label: 'Embassy legalisation',
        amount: 80,
        currency: Currency.eur,
        unit: 'per document',
      ),
    ],
  ),

  JourneyStep(
    id: 'university-application',
    order: 11,
    phase: Phase.homeCountry,
    blockId: 'block-3',
    title: 'Apply for admission',
    summary: 'Compare fees carefully before you commit to anywhere.',
    detail:
        'Now you apply. Use the Universities tab to compare what each place '
        'actually charges someone from Nigeria, which is often not the figure '
        'advertised on the front page of their website.\n\n'
        'Watch for deposits. Several institutions want money at application, '
        'sometimes before they will even issue the acceptance letter you need '
        'for immigration. A few of those deposits are non-refundable.',
    criticalNote:
        'Check the third-country fee, not the EU one. And check whether a '
        'deposit is due at application.',
  ),

  JourneyStep(
    id: 'permit-appointment',
    order: 12,
    phase: Phase.homeCountry,
    blockId: 'block-3',
    timeline: 'Reply in 3 to 4 working days',
    title: 'Request your residence permit appointment',
    summary: 'An email to the embassy. They answer within a few working days.',
    detail:
        'Once you hold an admission, email the embassy to request an '
        'appointment for your residence permit. They usually come back within '
        'three or four working days.',
  ),

  JourneyStep(
    id: 'residence-permit',
    order: 13,
    phase: Phase.homeCountry,
    blockId: 'block-3',
    title: 'Residence permit application',
    summary: 'The heaviest stage. One document here expires while you wait.',
    detail:
        'This is where people come unstuck. Every item below has its own '
        'process, and the police clearance certificate has a validity window, '
        'so it cannot be sorted early and set aside.\n\n'
        'Pay the fee, submit, then wait for approval to arrive by post.',
    documents: [
      RequiredDocument(
        id: 'house-contract',
        title: 'House contract',
        explanation:
            'Proof of somewhere to live in Austria. It has to be a real '
            'contract.',
      ),
      RequiredDocument(
        id: 'health-insurance',
        title: 'Travel health insurance',
        explanation:
            'Not the same thing as \u00D6GK. \u00D6GK only comes into play '
            'once you have landed. For this application you need travel health '
            'insurance.',
        linkLabel: 'Sanlam',
      ),
      RequiredDocument(
        id: 'proof-of-funds',
        title: 'Proof of account and source of funds',
        explanation:
            'Twelve months of funds shown in advance, and proof of where the '
            'money came from. A healthy balance on its own is not enough. '
            'Money that appears without explanation is one of the most common '
            'reasons applications fail.',
      ),
      RequiredDocument(
        id: 'police-clearance',
        title: 'Police clearance certificate',
        explanation:
            'Required for every adult applicant, not for children. This one '
            'is not an educational document, so it goes to the Ministry of '
            'Foreign Affairs for authentication on its own, not bundled with '
            'your educational papers.',
        warning:
            'It expires three months after it is issued, so time it '
            'carefully. Start this around two weeks before your residence '
            'permit appointment date \u2014 enough room to get it '
            'authenticated at Foreign Affairs and back in hand. On the day '
            'of your residence permit appointment, take the authenticated '
            'certificate to the embassy and pay a separate \u20AC80 '
            'legalisation fee there, on top of the residence permit '
            'application fee. Arrive without it legalised and the '
            'application will not be approved.',
      ),
      RequiredDocument(
        id: 'permit-form',
        title: 'Completed residence permit application form',
      ),
      RequiredDocument(
        id: 'eu-photo',
        title: 'EU standard passport photograph',
        explanation:
            'EU specification. A standard Nigerian passport photo is often '
            'rejected.',
      ),
    ],
    costs: [
      CostItem(
        label: 'Residence permit application',
        amount: 218,
        currency: Currency.eur,
        note: 'Confirm the current rate before you pay',
      ),
      CostItem(
        label: 'Police clearance certificate legalisation',
        amount: 80,
        currency: Currency.eur,
        note: 'Paid at the embassy the same day, separate from the '
            'application fee',
      ),
      CostItem(
        label: 'Travel health insurance, Sanlam',
        amount: 30000,
        currency: Currency.ngn,
      ),
    ],
    criticalNote:
        'The police clearance certificate is the trap in this stage. Start '
        'it about two weeks before your appointment, not earlier, since it '
        'expires after three months. Take it to the embassy with you and '
        'legalise it there for \u20AC80 \u2014 without it, the application '
        'is not approved.',
  ),

  // -------------------------------------------------------------------------
  // BLOCK 4 — visa and departure
  // -------------------------------------------------------------------------

  JourneyStep(
    id: 'd-visa',
    order: 14,
    phase: Phase.homeCountry,
    blockId: 'block-4',
    title: 'D visa application',
    summary: 'Permit first, visa second. Austria works the opposite way round.',
    detail:
        'Austria does not hand you a student visa the way other countries do. '
        'Your residence permit has to be approved first. Only then can you '
        'apply for the D visa.\n\n'
        'People assume it runs the other way and lose months finding out. Once '
        'the permit is approved, your D visa appointment date comes through '
        'automatically.',
    documents: [
      RequiredDocument(id: 'dvisa-statement', title: 'Updated statement of account'),
      RequiredDocument(id: 'dvisa-insurance', title: 'The same health insurance'),
      RequiredDocument(id: 'dvisa-ticket', title: 'One way ticket to Austria'),
      RequiredDocument(id: 'dvisa-form', title: 'D visa application form'),
      RequiredDocument(id: 'dvisa-photo', title: 'Passport photograph'),
    ],
    costs: [
      CostItem(
        label: 'D visa',
        amount: 150,
        currency: Currency.eur,
        note: 'Confirm the current rate',
      ),
    ],
    criticalNote:
        'Residence permit approval comes before the visa application, never '
        'the other way round.',
  ),

  JourneyStep(
    id: 'travel',
    order: 15,
    phase: Phase.homeCountry,
    blockId: 'block-4',
    title: 'Visa approved, time to fly',
    summary: 'The last step you take from home.',
    detail:
        'D visa in your passport. Everything from here happens on Austrian '
        'ground.',
  ),

  // -------------------------------------------------------------------------
  // BLOCK 5 — after arrival
  // -------------------------------------------------------------------------

  JourneyStep(
    id: 'apartment-form',
    order: 16,
    phase: Phase.postArrival,
    blockId: 'block-5',
    title: 'Get the registration form from your landlord',
    summary: 'A small piece of paper that everything else depends on.',
    detail:
        'Ask your landlord for the apartment registration form. Without it you '
        'cannot register your address, and without a registered address you '
        'cannot collect your residence permit card.',
  ),

  JourneyStep(
    id: 'address-registration',
    order: 17,
    phase: Phase.postArrival,
    blockId: 'block-5',
    title: 'Register your address',
    summary: 'Take the form to the registration office. Do it early.',
    detail:
        'Bring the form to the registration office and register formally. This '
        'is a legal requirement with a short deadline after arrival, and it '
        'blocks everything else until it is done.',
  ),

  JourneyStep(
    id: 'bank-account',
    order: 18,
    phase: Phase.postArrival,
    blockId: 'block-5',
    title: 'Open a bank account',
    summary: 'Austria runs on transfers, not cash.',
    detail:
        'Rent, insurance, phone bills. Almost everything here moves by bank '
        'transfer rather than cash, so you need an Austrian account early.',
  ),

  JourneyStep(
    id: 'insurance-card',
    order: 19,
    phase: Phase.postArrival,
    blockId: 'block-5',
    title: 'Sort your insurance card',
    summary: 'This is where \u00D6GK finally applies.',
    detail:
        'Now you are here, \u00D6GK is the relevant insurance, not the travel '
        'policy you used for the permit application. Get enrolled and get your '
        'card.',
  ),

  JourneyStep(
    id: 'transport',
    order: 20,
    phase: Phase.postArrival,
    blockId: 'block-5',
    title: 'Get your transport ticket',
    summary: 'Cheap, reliable, and you will use it every day.',
    detail:
        'Sort your public transport pass. If you are under 26 the annual youth '
        'pass covers the whole of Vienna for the year and works out at roughly '
        'twenty five euro a month.',
  ),

  JourneyStep(
    id: 'residence-card',
    order: 21,
    phase: Phase.postArrival,
    blockId: 'block-5',
    title: 'Collect your residence permit card',
    summary: 'The magistrate office. This is the finish line.',
    detail:
        'Take everything you have gathered along the way to the magistrate '
        'office and collect the card.\n\n'
        'That card makes you a legal resident student in Austria. Schengen '
        'travel, the right to work alongside your studies, and a path to stay '
        'once you graduate.',
    criticalNote: 'You made it. That was not an easy thing to do.',
  ),
];

List<JourneyStep> stepsForBlock(String blockId) =>
    journeySteps.where((s) => s.blockId == blockId).toList()
      ..sort((a, b) => a.order.compareTo(b.order));

List<JourneyBlock> blocksForPhase(Phase phase) =>
    journeyBlocks.where((b) => b.phase == phase).toList();
