import java.io.File

fun main() {
    // part1
    println(find(File("input.txt").readLines()[0], 0, 4, 4))
    // part2
    println(find(File("input.txt").readLines()[0], 0, 14, 14))
}

fun find(el: String, rangeStart: Int, rangeEnd: Int, range: Int): Int {
    if (noDuplicates(el.substring(rangeStart, rangeEnd), range)) return rangeEnd
    else return find(el, rangeStart + 1, rangeEnd + 1, range)
}

fun noDuplicates(el: String, range: Int): Boolean {

    return el.toList().distinct().size == range
}
