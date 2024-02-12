import 'package:offset_list/offset_list.dart';

/// Similarity using Damerau-Levenshtein Distance
double dLSimilarity(List<int> a, List<int> b, {int sigma = 256}) {
  int distance = dLDistance(a, b, sigma: sigma);
  int maxLength = a.length > b.length ? a.length : b.length;
  double similarity = 1 - (distance / maxLength);
  return similarity;
}

/// The Damerau-Levenshtein Distance calculates the Damerau-Levenshtein distance between lists of integers, usual string code units.
/// See [string_functions.dart] for string based implementation.
/// Used for similarity see [dLSimilarity]. Considers substitution, insertion, deletion, and transposition. Slower than
/// The Levenshtein distance algorithm but more accurate, since it considers transposition. See the OSA implementation
/// for a faster, but slightly less accurate version.
/// https://en.wikipedia.org/wiki/Damerau%E2%80%93Levenshtein_distance
/// sigma is the maximum different characters in the character set, 256 assumes ascii
int dLDistance(List<int> listA, List<int> listB, {int sigma = 256}) {
  int lengthA = listA.length;
  int lengthB = listB.length;

  List<int> da = OffsetList.filled(len: sigma, offset: 1, val: 0); // Σ (sigma)

  int maxDist = lengthA + lengthB;
  OffsetList<OffsetList<int>> d = OffsetList<OffsetList<int>>(offset: -1);
  for (int i = 0; i < lengthA + 2; i++) {
    d.add(OffsetList.filled(len: lengthB + 2, offset: -1, val: 0));
  }

  for (int i = 0; i <= lengthA; i++) {
    d[i][-1] = maxDist;
    d[i][0] = i;
  }
  for (int j = 0; j <= lengthB; j++) {
    d[-1][j] = maxDist;
    d[0][j] = j;
  }

  OffsetList<int> a = OffsetList.fromList(offset: 1, list: listA);
  OffsetList<int> b = OffsetList.fromList(offset: 1, list: listB);
  for (int i = 1; i <= lengthA; i++) {
    int db = 0;
    for (int j = 1; j <= lengthB; j++) {
      int k = da[b[j]];
      int l = db;
      int cost;
      if (a[i] == b[j]) {
        cost = 0;
        db = j;
      } else {
        cost = 1;
      }
      d[i][j] = [
        d[i - 1][j - 1] + cost, // substitution
        d[i][j - 1] + 1, // insertion
        d[i - 1][j] + 1, // deletion
        d[k - 1][l - 1] + (i - k - 1) + 1 + (j - l - 1) // transposition
      ].reduce((value, element) => value < element ? value : element);

      da[a[i]] = i;
    }
  }

  return d[lengthA][lengthB];
}

//************************************************************************//

/// Similarity using Optimal string alignment (OSA) distance
double osaSimilarity(List<int> a, List<int> b) {
  int distance = osaDistance(a, b);
  int maxLength = a.length > b.length ? a.length : b.length;
  double similarity = 1 - (distance / maxLength);
  return similarity;
}

/// Optimal string alignment (OSA) algorithm computes the number of edit operations needed to make the strings
/// equal under the condition that no substring is edited more than once. Damerau–Levenshtein makes no such assumption.
/// Thus this algorithm is less precise but faster.
int osaDistance(List<int> listA, List<int> listB) {
  int lengthA = listA.length;
  int lengthB = listB.length;

  OffsetList<OffsetList<int>> d = OffsetList<OffsetList<int>>(offset: 0);
  for (int i = 0; i < lengthA + 1; i++) {
    d.add(OffsetList.filled(len: lengthB + 1, offset: 0, val: 0));
  }

  for (int i = 0; i <= lengthA; i++) {
    d[i][0] = i;
  }
  for (int j = 0; j <= lengthB; j++) {
    d[0][j] = j;
  }

  OffsetList<int> a = OffsetList.fromList(offset: 1, list: listA);
  OffsetList<int> b = OffsetList.fromList(offset: 1, list: listB);

  for (int i = 1; i <= lengthA; i++) {
    for (int j = 1; j <= lengthB; j++) {
      int cost = (a[i] == b[j]) ? 0 : 1;

      d[i][j] = [
        d[i - 1][j] + 1, // deletion
        d[i][j - 1] + 1, // insertion
        d[i - 1][j - 1] + cost // substitution
      ].reduce((value, element) => value < element ? value : element);

      if (i > 1 && j > 1 && a[i] == b[j - 1] && a[i - 1] == b[j]) {
        d[i][j] = [
          d[i][j],
          d[i - 2][j - 2] + 1 // transposition
        ].reduce((value, element) => value < element ? value : element);
      }
    }
  }

  return d[lengthA][lengthB];
}
