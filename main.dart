import 'dart:io' show File;
import 'dart:math' show min, max;

typedef Point = (num x, num y);
final List<Point> galaxies = [];
final Map<num, num> rowGaps = {}, colGaps = {};
num part1 = 0, part2 = 0, x = 1, y = 1;

num distance(Point a, Point b, { num gapSize = 2 }) {
  num result = 0,
      col = min(a.$1, b.$1),
      colTo = max(a.$1, b.$1),
      row = min(a.$2, b.$2),
      rowTo = max(a.$2, b.$2);
  do {
    if (col + 1 <= colTo) {
      col++;
      result += colGaps.containsKey(col) ? gapSize : 1;
    } else if (row + 1 <= rowTo) {
      row++;
      result += rowGaps.containsKey(row) ? gapSize : 1;
    }
  } while ((col, row) != (colTo, rowTo));
  return result;
}

void main() async {
  for (String line
      in (await new File('input.txt').readAsString()).split('\n')) {
    x = 1;
    int emptyCount = 0;
    for (String column in line.split('')) {
      column == '#' ? galaxies.add((x, y)) : emptyCount++;
      x++;
    }
    emptyCount == line.length ? rowGaps.putIfAbsent(y, () => y) : null;
    y++;
  }
  do {
    x--;
    galaxies.firstWhere((element) => element.$1 == x, orElse: () => (0, 0)) ==
            (0, 0)
        ? colGaps.putIfAbsent(x, () => x)
        : null;
  } while (x > 1);

  for (int i = 0; i <= galaxies.length - 2; i++) {
    for (int j = i + 1; j <= galaxies.length - 1; j++) {
      part1 += distance(galaxies[i], galaxies[j]);
      part2 += distance(galaxies[i], galaxies[j], gapSize: 1000000);
    }
  }
  print(''' $part1, $part2 ''');
}
