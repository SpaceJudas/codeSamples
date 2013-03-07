import java.io.Console;
import java.io.File;
import java.util.Scanner;

/**
 * Driver for input in the form of a plaintext file (e.g. 
 */
public class Driver
{
    public static void main(String[] args)
    {
        Console console = System.console();
        if (console == null) {
            System.err.println("Error: console not active.");
            System.exit(1);
        }
        String file = console.readLine("%nEnter the path of the plaintext file to be read: ");
        Concordance c = new Concordance();
        c.includeFile(file);
        Concordance.printConcordance(c);
    }
}