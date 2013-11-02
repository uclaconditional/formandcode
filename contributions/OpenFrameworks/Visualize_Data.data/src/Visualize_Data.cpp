/**
 * Visualize: Data from Form+Code in Design, Art, and Architecture 
 * implemented in OpenFrameworks by Anthony Stellato <http://rabbitattack.com/> 
 * 
 * Requires OpenFrameworks available at http://openframeworks.cc/
 *
 * For more information about Form+Code visit http://formandcode.com
 */

#include "Visualize_Data.h"

bool compareWords(const Word &one, const Word &two){
	return one.count > two.count;
}

int numWords = 175;
int maximumSize = 85;
int wordHeight = 30;
float y = maximumSize * 0.75;
int x = 0;
float maxHeight = 0;
float ascent = 0;
float descent = 0;
float exponent = 0.60;

//--------------------------------------------------------------
void Visualize_Data::setup(){
	ofSetFrameRate(1);
	
	float time = ofGetElapsedTimef();
	countAndOrderWords("84.txt", &frankList);
	cout<<"frankList done.\n";
	float dur = ofGetElapsedTimef() - time;
	cout<<"took "<<dur<<" seconds.\n";
	time = ofGetElapsedTimef();
	countAndOrderWords("345.txt", &dracuList);
	cout<<"dracuList done.\n";
	dur = ofGetElapsedTimef() - time;
	cout<<"took "<<dur<<" seconds.\n";
	
	liberation.loadFont("LiberationMono-Regular.ttf", 24);
}

//--------------------------------------------------------------
void Visualize_Data::countAndOrderWords(string textFile, vector<Word> *wordList){

	bool started = false;
	size_t foundBegin, foundEnd;
	ifstream fin;
	fin.open( ofToDataPath(textFile).c_str() );
	while(fin!=NULL)
	{
		string line;
		getline(fin, line, '\n');
		foundBegin = line.find("*** START OF");
		foundEnd = line.find("*** END");
		if(foundBegin!=string::npos){
			started = true;
		} else if(foundEnd!=string::npos){
			started = false;
		} else if(started){
			string punct = " ,;:.!?()\"-";
			vector<string> words = tokenizeString(line, punct);
			for(vector<string>::iterator iter = words.begin(); iter != words.end(); ++iter){
				string word = removePunctuation(*iter);
				if(word.length() == 0){
					break;
				}else{
					transform(word.begin(), word.end(), word.begin(), ::tolower);
					bool newWord = true;
					for(vector<Word>::iterator w = wordList->begin(); w != wordList->end(); ++w){
						if(w->ww.compare(word) == 0){
							newWord = false;
							w->count++;
							break;
						}
					}

					if(newWord == true){
						Word next = Word(word);
						next.wordCount = word.length();
						wordList->push_back(next);
					}
				}
			}
		}
	}
	
	sort(wordList->begin(), wordList->end(), compareWords);
}

//--------------------------------------------------------------
// based on code from rosettacode.org
vector<string> Visualize_Data::tokenizeString(string & str,string & delims)
{
	string::size_type lastPos = str.find_first_not_of(delims, 0);
	string::size_type pos     = str.find_first_of(delims, lastPos);
	
	vector<string> tokens;
	
	while (string::npos != pos || string::npos != lastPos)
    {
		tokens.push_back(str.substr(lastPos, pos - lastPos));
		lastPos = str.find_first_not_of(delims, pos);
		pos     = str.find_first_of(delims, lastPos);
    }
	
	return tokens;
}

//--------------------------------------------------------------
string Visualize_Data::removePunctuation(string& my_input)
{
	for(int i=0; i < my_input.length(); i++)
	{
		if(!isalpha(my_input.at(i))){
			my_input.erase(i, 1);
		}
	}
	return my_input;
}

//--------------------------------------------------------------
void Visualize_Data::update(){

}

//--------------------------------------------------------------
void Visualize_Data::draw(){
	ofBackground(0, 0, 0);
	ofSetColor(255, 255, 255);
	
	float nextHeight = maximumSize;
	x = 0;
	y = maximumSize;
	
	liberation.loadFont("LiberationMono-Regular.ttf", nextHeight);
	
	for( int i = 0; i < numWords; i++){
		if( x == 0 ){
			liberation.drawString(dracuList[i].ww, x, y);
			x += liberation.stringWidth(dracuList[i].ww);
		} else {
			liberation.drawString(dracuList[i].ww, x, y);
			x += liberation.stringWidth(dracuList[i].ww);
		}
		nextHeight = dracuList[i+1].count / float(dracuList[0].count);
		nextHeight = pow(nextHeight, exponent);
		nextHeight = nextHeight * maximumSize;
		liberation.loadFont("LiberationMono-Regular.ttf", nextHeight);
		x += liberation.stringWidth("l") * .75f;
		
		if( (x + liberation.stringWidth(dracuList[i+1].ww + "l") ) > ofGetWidth()){
			x = 0;
			y += liberation.stringHeight("!llpyzzm_") * .75f;
		}
	}
	
	float ratio = dracuList[0].count / float(frankList[0].count);
	
	x = 0;
	y = ofGetHeight()/2 + maximumSize;
	
	nextHeight = maximumSize;
	liberation.loadFont("LiberationMono-Regular.ttf", nextHeight);
	
	for( int i = 0; i < numWords; i++){
		if( x == 0 ){
			liberation.drawString(frankList[i].ww, x, y);
			x += liberation.stringWidth(frankList[i].ww);
		} else {
			liberation.drawString(frankList[i].ww, x, y);
			x += liberation.stringWidth(frankList[i].ww);
		}
		nextHeight = frankList[i+1].count / float(frankList[0].count);
		nextHeight = pow(nextHeight, exponent);
		nextHeight = nextHeight * maximumSize;
		liberation.loadFont("LiberationMono-Regular.ttf", nextHeight);
		x += liberation.stringWidth("l") * .75f;
		
		if( (x + liberation.stringWidth(frankList[i+1].ww + "l") ) > ofGetWidth()){
			x = 0;
			y += liberation.stringHeight("!llpyzzm_") * .75f;
		}
	}
}

Word::Word(string txt){
	ww = txt;
	count = 1;
	wordCount = 0;
}

int Word::compareTo(Word o){
	if(o.count > this->count ){
		return 1;
	}
	if(o.count == this->count ){
		return 0;
	} else {
		return -1;
	}
}

