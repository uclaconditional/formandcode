/**
 * Repeat: Embedded Iteration from Form+Code in Design, Art, and Architecture 
 * implemented in OpenFrameworks by Anthony Stellato <http://rabbitattack.com/> 
 * 
 * Requires OpenFrameworks available at http://openframeworks.cc/
 *
 * For more information about Form+Code visit http://formandcode.com
 */

#ifndef _TEST_APP
#define _TEST_APP


#include "ofMain.h"

class Repeat_Embedded : public ofBaseApp{

	public:
		void setup();
		void update();
		void draw();
		void arc(float x, float y, float width, float height, float start, float stop);
		void mousePressed(int x, int y, int button);

		
		int option, width, height;
};

#endif
