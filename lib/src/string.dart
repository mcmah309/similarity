import 'package:similarity/similarity.dart';

// Notes:
// The Damerau–Levenshtein distance (DL) and the Optimal String Alignment distance (OSA) are different in that the OSA
// does not allow multiple edits on the same substring, while the DL does. For example, the DL distance between
// “CA” and “ABC” is 2, because you can transpose “CA” to “AC” and then insert “B” in between. However, the OSA
// distance between “CA” and “ABC” is 3, because you cannot use the transposition operation after editing the same
// substring1. Therefore, the OSA distance is always greater than or equal to the DL distance

/// Similarity using Damerau-Levenshtein Distance
double dLStringSimilarity(String a, String b, {int sigma = 256}) {
  return dLSimilarity(a.codeUnits, b.codeUnits, sigma: sigma);
}

/// The Damerau-Levenshtein Distance calculates the Damerau-Levenshtein distance between two strings.
/// Used for similarity see [dLSimilarity]. Considers substitution, insertion, deletion, and transposition. Slower than
/// The Levenshtein distance algorithm but more accurate, since it considers transposition. See the OSA implementation
/// for a faster, but slightly less accurate version.
/// https://en.wikipedia.org/wiki/Damerau%E2%80%93Levenshtein_distance
/// sigma is the maximum different characters in the character set, 256 assumes ascii
int dLStringDistance(String stringA, String stringB, {int sigma = 256}) {
  return dLDistance(stringA.codeUnits, stringB.codeUnits, sigma: sigma);
}

//************************************************************************//

/// Levenshtein distance is a string metric for measuring the difference between two sequences.
/// Informally, the Levenshtein distance between two words is the minimum number of single-character edits
/// (insertions, deletions or substitutions) required to change one word into the other
double osaStringSimilarity(String a, String b) {
  int distance = osaDistance(a.codeUnits, b.codeUnits);
  int maxLength = a.length > b.length ? a.length : b.length;
  double similarity = 1 - (distance / maxLength);
  return similarity;
}

/// Levenshtein distance is a string metric for measuring the difference between two sequences.
/// Informally, the Levenshtein distance between two words is the minimum number of single-character edits
/// (insertions, deletions or substitutions) required to change one word into the other
int osaStringDistance(String a, String b) {
  return osaDistance(a.codeUnits, b.codeUnits);
}
