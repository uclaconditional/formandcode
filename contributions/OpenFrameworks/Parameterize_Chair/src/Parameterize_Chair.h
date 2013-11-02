/**
 * Parameterize: Chair from Form+Code in Design, Art, and Architecture 
 * implemented in OpenFrameworks by Anthony Stellato <http://rabbitattack.com/> 
 * 
 * Requires OpenFrameworks available at http://openframeworks.cc/
 *
 * For more information about Form+Code visit http://formandcode.com
 */

#ifndef _TEST_APP
#define _TEST_APP


#include "ofMain.h"

class Parameterize_Chair : public ofBaseApp{

	public:
		void setup();
		void draw();
	void drawBox(int size);
	void drawBox(int w, int h, int d);
	void scrambleChair();
	void drawChair();
		void mousePressed(int x, int y, int button);

};

#endif
