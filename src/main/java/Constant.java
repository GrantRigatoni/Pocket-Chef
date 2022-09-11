import java.util.regex.Pattern;

public class Constant {
    //replace it with your DB credentials
    static public String DBUserName = "root";
    static public String DBPassword = "root";
    static public String DBUrl = "jdbc:mysql://localhost:3306/finalproject";

    static public Pattern namePattern = Pattern.compile("^[ A-Za-z]+$");
    static public Pattern emailPattern = Pattern.compile("^[a-zA-Z0-9_+&*-]+(?:\\."
            + "[a-zA-Z0-9_+&*-]+)*@"
            + "(?:[a-zA-Z0-9-]+\\.)+[a-z"
            + "A-Z]{2,7}$");

}
