/**
 * Transform: Landscape from Form+Code in Design, Art, and Architecture 
 * implemented in OpenFrameworks by Anthony Stellato <http://rabbitattack.com/> 
 * 
 * Requires OpenFrameworks available at http://openframeworks.cc/
 *
 * For more information about Form+Code visit http://formandcode.com
 */

#ifndef _TEST_APP
#define _TEST_APP


#include "ofMain.h"

class Transform_Landscape : public ofBaseApp{

	public:
		void setup();
		void draw();
	
		ofImage img;
		float angle;
};

#endif
