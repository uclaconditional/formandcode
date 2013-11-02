/**
 * Transform: SlitScan from Form+Code in Design, Art, and Architecture 
 * implemented in OpenFrameworks by Anthony Stellato <http://rabbitattack.com/> 
 * 
 * Requires OpenFrameworks available at http://openframeworks.cc/
 *
 * For more information about Form+Code visit http://formandcode.com
 */

#ifndef _TEST_APP
#define _TEST_APP


#include "ofMain.h"

class Transform_SlitScan : public ofBaseApp{

	public:
		void setup();
		void update();
		void draw();
		void setPixel(int horizontal,int vertical,unsigned char R,
					  unsigned char G,unsigned char B,int w, unsigned char pixels[]);
		void getPixel(int horizontal,int vertical,unsigned char* R,
					  unsigned char* G,unsigned char* B,int w, unsigned char pixels[]);
	
		ofVideoPlayer player;
		ofTexture texture;
		unsigned char * texpixels, * vidpixels;
};

#endif
