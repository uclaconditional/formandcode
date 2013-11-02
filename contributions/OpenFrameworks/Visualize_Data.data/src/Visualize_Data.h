/**
 * Visualize: Superformula from Form+Code in Design, Art, and Architecture 
 * implemented in OpenFrameworks by Anthony Stellato <http://rabbitattack.com/> 
 * 
 * Requires OpenFrameworks available at http://openframeworks.cc/
 *
 * For more information about Form+Code visit http://formandcode.com
 */

#ifndef _TEST_APP
#define _TEST_APP


#include "ofMain.h"
#include <fstream>
#include <sstream>
#include <cctype>
#include <string>

class Word {
public:
	string ww;
	int count;
	int wordCount;
	
	Word(){};
	Word(string txt);
	int compareTo(Word o);
};

class Visualize_Data : public ofBaseApp{

	public:
		void setup();
		void update();
		void draw();
		void countAndOrderWords( string textFile, vector<Word> *wordList);
		vector<string> tokenizeString(string & str,string & delims);
		string removePunctuation(string& my_input);
	
		vector<Word> frankList, dracuList;
		ofTrueTypeFont liberation;
};

#endif
