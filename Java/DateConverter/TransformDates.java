import java.io.File;
import java.io.FileNotFoundException;
import java.io.Console;

import java.util.Scanner;
import java.io.FileWriter;
import java.io.BufferedWriter;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.text.ParsePosition;
import java.text.FieldPosition;


public class TransformDates {

    public static void main(String[] args)
    {
        Console console = System.console();
        if (console == null) {
            System.err.println("Error: console not active.");
            System.exit(1);
        }
        String fName = console.readLine("%nEnter the path of the plaintext file to be read: ");
        
        File file = new File(fName);
        
        try {
            //SimpleDateFormat inDate = new SimpleDateFormat("MM/dd/yy");
            transformDates(file, "MM/dd/yy", "EEEE, MMMM dd, yyyy");
            transformDates(file, "MM/dd", "EEEE, MMMM dd, yyyy");
        }
        catch (Exception e)
        {
            e.printStackTrace();
            System.exit(0);
        }
        
        
        /*
        
        
        Scanner r = new Scanner(file);
        
        */
    }
    
    /**
    * Transforms dates in a file from one format to another.
    *
    * For example, "On 9/6/78, a really cool thing happened." and a destination
    * format of "EEEE, MMMM dd, yyyy". The expected output would be "On
    * Wednesday, September 06, 1978, a really cool thing happened."  This method
    * will only work with sourcePatterns that have no whitespace.  This could be improved
    * by using regex patterns that are explicitly defined from the {@link SimpleDateFormat}-compatible
    * sourcePattern.
    *
    * @param file The file whose dates will be transformed.
    * @param sourcePattern A {@link SimpleDateFormat}-compatible date format that
    * identifies the format of dates within the file to transform.
    * @param destinationPattern A {@link SimpleDateFormat}-compatible date format that
    * identifies the destination format of transformed dates.
    */
    public static void transformDates(final File file, String sourcePattern, String destinationPattern) throws FileNotFoundException
    {
        SimpleDateFormat inDate = new SimpleDateFormat(sourcePattern);
        SimpleDateFormat outDate = new SimpleDateFormat(destinationPattern);
        inDate.setLenient(false);
        Scanner fileScan; Scanner lineScan; BufferedWriter b; 
        try {
            fileScan = new Scanner(file);
            ParsePosition p = new ParsePosition(0); 
            FieldPosition f = new FieldPosition(-1);
            Date date; String token;
            StringBuffer s = new StringBuffer("");
            StringBuffer transformed = new StringBuffer("");
            
            //loop through each line in the file
            while (fileScan.hasNextLine()) {
                //create a scanner for the next line
                lineScan = new Scanner(fileScan.nextLine());
                //loop through each 'word' in the line
                while (lineScan.hasNext()) {
                    token = lineScan.next();
                    p.setIndex(0);
                    date = inDate.parse(token, new ParsePosition(0));
                    
                    if (date!=null) {
                        //remove the date, in its original form, from the parsing string
                        //and replace it with a placeholer character '-'
                        
                        token = token.replaceFirst("[0-9].+[0-9]","");
                        
                        //format date object into proper output format
                        s = outDate.format(date, new StringBuffer(""), new FieldPosition(-1));
                        transformed.append(s);
                        transformed.append(token+" ");
                    }
                    else {
                        transformed.append(token+" ");
                    }
                }
                transformed.append("\n");
                lineScan.close();
            }
            fileScan.close();
            
            String tstring = transformed.toString();
            b = new BufferedWriter(new FileWriter(file));
            b.write(tstring, 0, tstring.length());
            b.close();
        }
        catch (FileNotFoundException e) {
            throw e;
        }
        catch (java.io.IOException e){
            e.printStackTrace();
        }
    }
}
