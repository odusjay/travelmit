// ===========================================================================
// REFERRAL CODES
//
// Give each friend a short code. Anyone who enters it at checkout gets 20%
// off, and the code is attached to that purchase in your RevenueCat
// dashboard, so you can see who to credit.
//
// To add a friend: add a line below. Codes are matched without case
// sensitivity, so 'John10' and 'JOHN10' both work.
// To remove one: delete the line.
// ===========================================================================

const Map<String, String> referralCodes = {
  'JOHN10': 'John',
  // 'MARY10': 'Mary',
};

/// Percentage taken off when a valid code is applied.
const double referralDiscountPercent = 20;
