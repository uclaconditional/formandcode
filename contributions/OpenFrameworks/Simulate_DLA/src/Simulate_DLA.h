/**
 * Simulate: DLA from Form+Code in Design, Art, and Architecture 
 * implemented in OpenFrameworks by Anthony Stellato <http://rabbitattack.com/> 
 * 
 * Requires the OpenFrameworks available at http://openframeworks.cc/
 *
 * For more information about Form+Code visit http://formandcode.com
 */

#ifndef _TEST_APP
#define _TEST_APP


#include "ofMain.h"

class aggParticle {
	
	public:

		void setup(bool *_field, int _w, int _h);
		void reset();
		void update();
		bool alone();
	
		int round(float _in);
	
		int x, y, w, h;
		bool stuck;
		bool *field;
	
};

class Simulate_DLA : public ofBaseApp{

	public:
		void setup();
		void update();
		void draw();

		ofTexture texture;
		unsigned char * pixels;
		int width, height;
	
		uint particleCount;
		aggParticle *mParticles;
		bool *field;
};

#endif
