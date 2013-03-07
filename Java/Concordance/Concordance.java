import java.util.Scanner;
import java.util.TreeMap;
import java.util.ArrayList;

/**
 * This object represents a concordance, which is an alphabetical list of all word occurrences, labeled with 
 * word frequencies and the sentence numbers they occur in.  this concordance is created from strings or 
 * files as detailed by the includeSentence, includeSentenceBlock, and includeFile methods.  Sentence numbering
 * will occur in the order sentences are inputed into the Concordance object. Word delimeters are determined by
 * the regex pattern: [^\w\.]+; Sentence delimeters are determined by the regex pattern: \.(\s(?=[A-Z])|\Z).
 * Concordances are most efficiently backed by either HashMap or TreeMap structures. This specific concordance
 * utilizes the TreeMap because of a concordance's inherent need for sorting.
 */
public class Concordance
{
    private TreeMap<String, WordLocale> concMap;
    private int sentCount;
    
    public Concordance()
    {
        concMap = new TreeMap<String, WordLocale>();
        sentCount=0;
    }
    /**
     * Adds all words in the given sentence to the concordance. Words are defined as an unbroken string of word
     * characters (letters, digits, or dots).  This allows all standard words, abbreviations, shortened words, and 
     * decimal numbers to be accepted. Inputs containing dots in any form other than a whole word should be fed 
     * instead to includeSentenceBlock(String).
     * 
     * @param sentence a string of words seperated by whitespace and non-period punctuation marks.
     */
    public void includeSentence(String sentence)
    {
        sentence = sentence.toLowerCase();
        sentCount++;
        
        //Splits the sentence into an array of individual words
        String words[] = sentence.split("[^\\w\\.]+");
        //Iterates through all the words in the given sentence
        for (String word: words)
        {
            if(concMap.containsKey(word))
            {
                WordLocale locs = concMap.get(word);
                locs.addLocale(sentCount);
            }
            else
            {
                WordLocale locs = new WordLocale(word);
                locs.addLocale(sentCount);
                concMap.put(word, locs);
            }
        }
    }
    /**
     * Adds all words in a given block of sentences to the concordance. Sentences are 
     * seperated by a (period+whitespace+uppercase letter) pattern (regex: \.(\s(?=[A-Z])|\Z)) ). 
     * Individual sentences are processed and added to the concordence as defined by includeSentence(String).
     * 
     * @param block a string of sentences.
     */
    public void includeSentenceBlock(String block)
    {
        Scanner s = new Scanner(block);
        s.useDelimiter("\\.(\\s(?=[A-Z])|\\Z)");
        while (s.hasNext())
        {
            this.includeSentence(s.next());
        }
    }
    /**
     * Adds all words in the given file to the concordance. A file is parsed into sentences seperated 
     * by a (period+whitespace+uppercase letter) pattern (regex: \.(\s(?=[A-Z])|\Z)) ). Individual 
     * sentences are processed and added to the concordence as defined by includeSentence(String).
     * 
     * @param path a string representation of the filepath to be included in the concordance
     */
    public void includeFile(String path)
    {
        try {
            
            Scanner s = new Scanner(new java.io.File(path));
            s.useDelimiter("\\.(\\s(?=[A-Z])|\\Z)");
            while (s.hasNext())
            {
                this.includeSentence(s.next());
            }
        }
        catch (java.io.FileNotFoundException e) {
            System.err.println("Error: "+e.toString());
            System.exit(1);
        }
    }
    /**
     * Returns an ArrayList<WordLocale> containing all words and which sentences they are located in.
     * The returned ArrayList is sorted in alpabetical order.
     */
    public ArrayList<WordLocale> getAllWords()
    {
        return new ArrayList<WordLocale> (concMap.values());
    }
    /**
     * Prints the given Concordance object as a list of words, labeled with their frequency and the 
     * sentence numbers which they occur in.
     */
    public static void printConcordance(Concordance c)
    {
        for (WordLocale l: c.getAllWords())
        {
            System.out.println(l);
        }
    }
    
    /**
     * WordLocale is a helper class to Concordance.  WordLocale stores an individual word, along with 
     * all of its locations. 
     */
    private class WordLocale implements Comparable<WordLocale>
    {
        private ArrayList<Integer> locs;
        private String word;
        
        public WordLocale(String word)
        {
            this.word=word;
            this.locs=new ArrayList<Integer>();
        }
        public void addLocale(Integer loc)
        {
            locs.add(loc);
        }
        public ArrayList<Integer> getLocales()
        {
            return locs;
        }
        public String getWord()
        {
            return word;
        }
        /**
         * Compares two WordLocale objects based on the difference between their representative
         * words. Value returned is defined as in String.compareTo(String)
         * 
         * @param o another WordLocale object to compare this one too
         * @return the integer difference between the word represented by this WordLocale object
         * and the given WordLocale object
         */
        public int compareTo(WordLocale o)
        {
            return word.compareTo(o.getWord());
        }
        /**
         * Returns a String representation of this WordLocale object.  Resultant string includes the
         * original word, its frequency, and its locations
         * 
         * @return a String representation of this WordLocale object
         */
        public String toString()
        {
            String str = word+"\t{"+locs.size()+": ";
            boolean first=true;
            for (Integer i: locs)
            {
                if (!first) {
                    str+=","+i;
                }
                else {
                    first=false;
                    str+=i;
                }
            }
            return str+"}\n";
        }
    }
}
