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

class Visualize_Superformula : public ofBaseApp{

	public:
		void setup();
		void draw();

		ofPoint* superformula(float m, float n1, float n2, float n3);
		ofPoint superformulaPoint(float m, float n1, float n2, float n3, float phi);
};

#endif
