import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.util.stream.Collectors;
import java.util.stream.IntStream;

public class day3 {

    public static void main(String[] args) throws IOException {
        System.out.println("hello old java!");
        // ReadFile
        Path file = new File("input.txt").toPath();
        List<String> stringList = Files.readAllLines(file);
        String[] inputArr = stringList.toArray(new String[] {});

        var inputList = Arrays.stream(inputArr).collect(Collectors.toList());
        // part1
        System.out.println(
                inputList.stream().mapToInt(a -> getValue(find(a))).sum());

        // part2
        System.out.println(IntStream.range(0, (inputList.size() + 2) / 3)
                .mapToObj(i -> inputList.subList(i * 3, Math.min(3 * (i + 1),
                        inputList.size())))
                .collect(Collectors.toList()).stream().mapToInt(a -> findHelper(a)).sum());

    }

    public static int findHelper(List<String> lines) {
        return getValue(find2(lines.get(2), find2(lines.get(0), lines.get(1))));
    }

    public static String find2(String line1, String line2) {

        Pattern path = Pattern.compile("[" + line1 + "]");
        Matcher matcher = path.matcher(line2);

        StringBuilder temp = new StringBuilder();
        while (matcher.find()) {
            temp.append(matcher.group());

        }
        return temp.toString();

    }

    public static String find(String line) {

        Pattern path = Pattern.compile("[" + line.substring(0, line.length() / 2) + "]");
        Matcher matcher = path.matcher(line.substring(line.length() / 2));
        matcher.find();
        return matcher.group(0);

    }

    public static int getValue(String val) {

        return Character.isLowerCase(val.charAt(0)) ? (int) val.charAt(0) - 96 : (int) val.charAt(0) - 38;

    }
}
