/**
 * Transform: Landscape from Form+Code in Design, Art, and Architecture 
 * implemented in OpenFrameworks by Anthony Stellato <http://rabbitattack.com/> 
 * 
 * Requires OpenFrameworks available at http://openframeworks.cc/
 *
 * For more information about Form+Code visit http://formandcode.com
 */

#include "Transform_Landscape.h"

#define WIDTH 348
#define HEIGHT 600

int values[WIDTH][HEIGHT];

//--------------------------------------------------------------
void Transform_Landscape::setup(){
	ofSetFrameRate(60);
	ofEnableAlphaBlending();
	ofNoFill();
	angle = 0.0f;
	
	img.loadImage("nasa-iceberg.jpg");
	unsigned char * pixels = img.getPixels();
	for(int i = 0; i < HEIGHT; i++){
		for(int j = 0; j < WIDTH; j++){
			values[j][i] = pixels[(int)(i*WIDTH+j)];
		}
	}
}

//--------------------------------------------------------------
void Transform_Landscape::draw(){
	ofBackground(0, 0, 0);
	ofTranslate(ofGetWidth()/2, ofGetHeight()/2, 0);
	ofRotate(ofRadToDeg(angle), 0, 1, 0);
	ofScale(2, 2, 2);
	
	angle += 0.005f;
	
	glBegin(GL_LINES);
	for(int i = 0; i < HEIGHT; i += 3){
		for(int j = 0; j < WIDTH; j += 3){
			float val = (float)values[j][i];
			ofSetColor(val, val, val, 153);
			float x1 = j-WIDTH/2;
			float y1 = i-HEIGHT/2;
			float z1 = -val/2;
			float x2 = j-WIDTH/2;
			float y2 = i-HEIGHT/2;
			float z2 = -val/2-4;

			glVertex3f(x1, y1, z1);
			glVertex3f(x2, y2, z2);
		}
	}
	glEnd();
}

