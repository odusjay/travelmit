# TravelMit

A guide for Nigerians studying in Austria. Free preview, then a one-off payment
unlocks everything.

## Running it

```bash
flutter create . --project-name travelmit
flutter pub get
flutter run
```

The `flutter create .` step generates the android and ios folders around the
existing `lib/` code. Run it once, inside this directory.

## Where the words live

Content is kept apart from layout, so you never have to touch UI code to change
what the app says.

| To change | Open |
|---|---|
| Steps, documents, warnings, timings | `lib/data/journey_content.dart` |
| Schools, fees, programmes, links | `lib/data/universities.dart` |
| The Austria page and reviews | `lib/data/discover_content.dart` |
| Abuja service wording and email | `lib/data/support_content.dart` |
| Colours | `lib/theme.dart` |

Anything inside 'single quotes' is safe to edit. Leave the commas and brackets
where they are. If your text has an apostrophe in it, put a backslash first:
`'Nigeria\'s ministry'`.

## Still needs your input

- **RevenueCat keys** in `lib/services/purchase_service.dart`
- **Store ids** in `lib/services/review_service.dart`, once you have registered
- **VFS booking URL** in `journey_content.dart`, replace the placeholder
- **Sanlam policy link** in `journey_content.dart`
- **Accommodation links** for the house contract document
- **Real testimonials** in `discover_content.dart`, currently an empty list

## Reviews

The testimonials list ships empty on purpose. The section stays hidden until
you add something to it. Apple and Google both ban invented reviews and do
check, particularly on new apps.

You have already helped real people through this. Ask a few of them for a
sentence and their permission to use it.

## RevenueCat

1. Create a project.
2. App Store Connect: a **Non-Consumable** product.
3. Play Console: a **one-time (managed)** product.
4. Add both to an Offering.
5. Create an Entitlement with the identifier `fullAccess`.
6. Paste the public SDK keys into `purchase_service.dart`.

The restore button is already wired. Both stores reject apps without one.

## Referral codes

Anyone can type a code on the paywall to get 20% off. Add or remove your
friends' codes in `lib/data/referral_codes.dart` — no other file needs
touching for that part.

The discount itself needs one more product, because app stores fix the
price per product ID; the app can't apply a percentage off at runtime.

1. Create a second product in App Store Connect and Play Console, priced
   20% below the full price.
2. Add it to the same Offering in RevenueCat, and set its **package
   identifier** to `referral_discount` (this exact string is already wired
   into the app — see `referralPackageId` in `purchase_service.dart`).
3. Attach this second product to the same `fullAccess` entitlement as the
   full-price one, so either purchase unlocks the app.

Until that second product exists, a valid code still gets tagged on the
purchase for tracking, but the price shown won't actually change — so set
this up before you tell anyone a code gives a discount.

**Seeing who a code was used by:** every time someone applies a valid code,
it's attached to their RevenueCat customer record as `referral_code` and
`referred_by`. Open a customer's page in the RevenueCat dashboard to see it
against their purchase — no separate spreadsheet needed.

## Before submitting

- [ ] Confirm the fees marked unverified against each institution's own page
- [ ] Settle the €726.72 versus €751.92 public university question
- [ ] Privacy policy URL, required by both stores
- [ ] Test purchase and restore in sandbox
- [ ] Have a few people who do not know the process try it and watch where they
      get stuck

## One structural thing

All content compiles into the app, so fixing a wrong fee means shipping an
update and waiting for review. Austrian fees move every January and programmes
change yearly.

Once you have paying users, moving content to Firebase Firestore would let you
correct a figure from your phone and have everyone see it immediately. Not
needed for launch, but worth planning for. Stale numbers in a paid immigration
app cost trust quickly.
