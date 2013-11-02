/**
 * Transform: SlitScan from Form+Code in Design, Art, and Architecture 
 * implemented in OpenFrameworks by Anthony Stellato <http://rabbitattack.com/> 
 * 
 * Requires OpenFrameworks available at http://openframeworks.cc/
 *
 * For more information about Form+Code visit http://formandcode.com
 */

#include "Transform_SlitScan.h"

int video_width     = 160;
int video_height    = 120;
int video_slice_x   = video_width/2;
int window_width    = 1000;
int window_height   = video_height;
int draw_position_x = 0;
bool newFrame  = false;

//--------------------------------------------------------------
void Transform_SlitScan::setup(){
	player.loadMovie("station.mov");
	player.setLoopState(1);
	player.play();
	
	texture.allocate(window_width, window_height, GL_RGB);
	texpixels = new unsigned char [window_width * window_height * 3];
}

//--------------------------------------------------------------
void Transform_SlitScan::update(){
	player.idleMovie();
	newFrame = player.isFrameNew();
	if(newFrame){
		vidpixels = player.getPixels();
		for (int y=0; y<window_height; y++){
			unsigned char r, g, b;
			getPixel(video_slice_x, y, &r, &g, &b, video_width, vidpixels);
			setPixel(draw_position_x, y, r, g, b, window_width, texpixels);
		}
		texture.loadData(texpixels, window_width, window_height, GL_RGB);
		
		draw_position_x++;
		if (draw_position_x >= window_width) {
			OF_EXIT_APP(0);
		}
		newFrame = false;
	}
}

//--------------------------------------------------------------
void Transform_SlitScan::draw(){
	ofBackground(0, 0, 0);
	texture.draw(0, 0);
}

// The following code is from the Pixel by Pixel Openframeworks Course
// and is very useful if I do say myself.
//--------------------------------------------------------------
void Transform_SlitScan::setPixel(int horizontal,int vertical,unsigned char R,unsigned char G,
					   unsigned char B,int w, unsigned char pixels[]){
	int thisPixel;
	thisPixel = 3*(w * vertical +horizontal);
	pixels[thisPixel]=R;
	pixels[thisPixel+1]=G;
	pixels[thisPixel+2]=B;
}

//--------------------------------------------------------------
void Transform_SlitScan::getPixel(int horizontal,int vertical,unsigned char* R,unsigned char* G,
					   unsigned char* B,int w, unsigned char pixels[]){
	int thisPixel;
	thisPixel = 3*(w * vertical +horizontal);
	*R= pixels[thisPixel];
	*G= pixels[thisPixel+1];
	*B= pixels[thisPixel+2];
}
