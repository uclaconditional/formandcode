/**
 * Visualize: Loading and Displaying Data
 * from Form+Code in Design, Art, and Architecture 
 * by Casey Reas, Chandler McWilliams, and LUST
 * Princeton Architectural Press, 2010
 * ISBN 9781568989372
 * 
 * This code was written for Processing 2+
 * Get Processing at http://www.processing.org/download
 */


IntDict frankList = new IntDict();
IntDict dracuList = new IntDict();

int numWords = 200;
int maxSize = 100;
int wordHeight = 30;
float nextHeight = maxSize;

float y = maxSize * 0.75;
int x = 0;
float maxHeight = 0;
float ascent = 0;
float descent = 0;

float exponent = 0.40;

PFont font;

void setup() {
  size(1024, 1024);
  background(0);

  // Load and create the font
  font = createFont("SourceCodePro-Regular.otf", wordHeight);
  textFont(font);
  textSize(nextHeight);
  
  // Load Frankenstein and chop it up
  String[] lines = loadStrings("84.txt");
  String allText = join(lines, " ").toLowerCase();
  String[] tokens = splitTokens(allText, " ,.?!:;[]-\'\"");

  // Calculate the frequency of each word in Frankenstein
  for (int i = 0; i < tokens.length; i++) {
    String s = tokens[i];
    frankList.increment(s);
  }
  frankList.sortValuesReverse();
  String[] frankWords = frankList.keyArray();

  // Load Dracula and chop it up
  lines = loadStrings("345.txt");
  allText = join(lines, " ").toLowerCase();
  tokens = splitTokens(allText, " ,.?!:;[]-\'\"");

  // Calculate the frequency of each word in Dracula
  for (int i = 0; i < tokens.length; i++) {
    String s = tokens[i];
    dracuList.increment(s);
  }
  dracuList.sortValuesReverse();
  String[] dracuWords = dracuList.keyArray();

  // Write the words from Frankenstein to the screen
  for (int i = 0; i < numWords; i++) {
    if (x == 0) {
      text(frankWords[i].toUpperCase(), x, y);
      x += textWidth(frankWords[i]);
    } 
    else {
      text(frankWords[i].toUpperCase(), x, y);
      x += textWidth(frankWords[i]);
    }

    nextHeight = frankList.get(frankWords[i+1]) / float(frankList.get(frankWords[0]));
    nextHeight = pow(nextHeight, exponent);
    nextHeight = nextHeight * maxSize;
    textSize(nextHeight);
    x += textWidth(" ") * 0.5; 

    if ((x + textWidth(frankWords[i+1] + " ")) > width) {
      x = 0; 
      ascent = textAscent();
      descent = textDescent();
      y += ascent + descent * .75;
    }
  }

  x = 0;
  y = height * 0.5;

  nextHeight = maxSize;
  textSize(nextHeight);

  // Write the words from Dracula to the screen
  for (int i = 0; i < numWords; i++) {
    if (x == 0) {
      text(dracuWords[i].toUpperCase(), x, y);
      x += textWidth(dracuWords[i]);
    } 
    else {
      text(dracuWords[i].toUpperCase(), x, y);
      x += textWidth(dracuWords[i]);
    }

    nextHeight = dracuList.get(dracuWords[i+1]) / float(dracuList.get(dracuWords[0]));
    nextHeight = pow(nextHeight, exponent);
    nextHeight = nextHeight * maxSize;
    textSize(nextHeight);
    x += textWidth(" ") * 0.5; 

    if ((x + textWidth(dracuWords[i+1] + " ")) > width) {
      x = 0; 
      ascent = textAscent();
      descent = textDescent();
      y += ascent + descent * .75;
    }
  }
}

