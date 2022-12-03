import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.Arrays;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.util.stream.Collectors;

public class day3 {

    public static void main(String[] args) throws IOException {
        System.out.println("hello old java!");
        // ReadFile
        Path file = new File("input.txt").toPath();
        List<String> stringList = Files.readAllLines(file);
        String[] inputArr = stringList.toArray(new String[] {});

        // part1
        System.out.println(
                Arrays.stream(inputArr).collect(Collectors.toList()).stream().mapToInt(a -> getValue(find(a))).sum());

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
