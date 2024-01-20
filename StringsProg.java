class StringsProg {
    String str1;
    String str2;

    StringsProg(String str1, String str2) {
        this.str1 = str1;
        this.str2 = str2;
    }

    public String toString() {
        return this.str1 + " " + this.str2;
    }

    public static void main(String args[]) {

        // Using String literal
        String str1 = "str1 = Hello World!";
        System.out.println(str1);

        // Using new keyword
        String str2 = new String("str2 = Hello World!");
        System.out.println(str2);

        // Using char array
        char[] charArr = {'s', 't', 'r', '3', ' ', '=', ' ', 'H', 'e', 'l', 'l', 'o', ' ', 'W', 'o', 'r', 'l', 'd', '!'};
        String str3 = new String(charArr);
        System.out.println(str3);

        // StringBuilder
        StringBuilder str4 = new StringBuilder("str4 = Hello");
        System.out.println(str4);
        str4.append(" World!");
        System.out.println(str4);

        // Using string length() method
        System.out.println(str1.length());

        // Using string concatenation
        System.out.println("Hello " + 2 + " World!");

        // Using toString() method
        StringsProg str5 = new StringsProg("Hello", "World!");
        System.out.println(str5.toString());

        // Using getChars() method
        String sentence = new String("welcome to BMSCE");
        char[] targetCharArray = new char[5];
        sentence.getChars(11, 16, targetCharArray, 0);
        String str6 = new String(targetCharArray);
        System.out.println(str6);

        // Using comparing methods
        String a = "bmsce";
        String b = "BMSCE";
        String c = "college";
        System.out.println(a.equals(a));
        System.out.println(a.equals(b));
        System.out.println(a.equals(c));
        System.out.println(a.equalsIgnoreCase(b));

        // Using regionMatches() method
        String bigRegion = "Hello bmsce";
        String smallRegion = "BMSCE";
        System.out.println("region = " + bigRegion.regionMatches(6, smallRegion, 0, 5)); // Case-sensitive
        System.out.println("region = " + bigRegion.regionMatches(true, 6, smallRegion, 0, 5)); // Case-insensitive

        // Using startsWith() and endsWith()
        String startEnd = "Hello bmsce";
        System.out.println("start = " + startEnd.startsWith("Hello"));
        System.out.println("end = " + startEnd.endsWith("bmsce"));

        // Difference between equals() and ==
        String s1 = new String("nishu");
        String s2 = new String(s1);
        System.out.println("s1.equals(s2) = " + s1.equals(s2)); // Compare characters
        System.out.println("s1==s2 = " + (s1 == s2)); // Compare references
    }
}
