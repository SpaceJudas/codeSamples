PROJECT TITLE: DateTransformer
OBJECTIVE: Edits text files replacing all of their dates in number format with dates in text format

---------------------------------------------------------------------------------
To run this project, start it from the console with 'java TransformDates'. The 
console tool will ask the user to enter the path of the file to perform the 
transform on.  Type the path in and hit the return key.  When the method is 
finished, the all numerical dates in the file at the given path will be changed
into textual dates.

Right now, TransformDates supports transforms from "MM/dd/yy" and "MM/dd" style dates in the original file, however additional numerical date formats can be added my modifying the main method in a simple way, as described in the inline documentation.  In its current state, the transformDates method does not support transforming from textual date formats to other formats (textual is defined here as containing whitespace within the pattern itself).  This is because transformDates uses a scanner to parse tokens delimited by whitespace.  An alternative approach to the transformDates method could fix this problem by adopting an approach which uses the ParsePosition class to parse lines character by character, instead of by whitespace-delimited tokens.
---------------------------------------------------------------------------------
