# similarity

Similarity algorithms for Dart.

## Features
- **Damerau-Levenshtein Distance**: Calculates the similarity between sequences by considering substitution, insertion, deletion, and transposition operations. It is particularly useful for applications that require a high degree of accuracy in similarity measurement.
- **Optimal String Alignment (OSA) Distance**: A faster, though slightly less precise, alternative to the Damerau-Levenshtein Distance. It does not allow multiple edits on the same substring, making it suitable for scenarios where performance is critical.