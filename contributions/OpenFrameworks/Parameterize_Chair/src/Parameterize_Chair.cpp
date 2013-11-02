/**
 * Parameterize: Chair from Form+Code in Design, Art, and Architecture 
 * implemented in OpenFrameworks by Anthony Stellato <http://rabbitattack.com/> 
 * 
 * Requires OpenFrameworks available at http://openframeworks.cc/
 *
 * For more information about Form+Code visit http://formandcode.com
 */

#include "Parameterize_Chair.h"

int chairSeatHeight      = 100;
int chairWidth           = 50;
int chairDepth           = 50;
int chairBackHeight      = 100;
int chairFrameThickness  = 10;

//--------------------------------------------------------------
void Parameterize_Chair::setup(){
	ofSetFrameRate(60);
	ofEnableSmoothing();
}


//--------------------------------------------------------------
void Parameterize_Chair::draw(){
	ofBackground(255, 255, 255);
	ofSetColor(0, 0, 0);
	ofPushMatrix();
	ofTranslate(ofGetWidth()/2, ofGetHeight()/2, 0);
	ofRotate(ofRadToDeg(-PI/9), 1, 0, 0);
	ofRotate(ofRadToDeg(PI/8), 0, 1, 0);
	drawChair();
	ofPopMatrix();
}

void Parameterize_Chair::drawChair(){
	//back
	ofPushMatrix();
	ofTranslate(chairWidth/2, chairBackHeight/2, 0);
	drawBox(chairWidth, chairBackHeight, chairFrameThickness);
	ofPopMatrix();
	
	//seat
	ofPushMatrix();
	ofTranslate(chairWidth/2, chairBackHeight + chairFrameThickness/2,
				chairDepth/2 - chairFrameThickness/2);
	drawBox(chairWidth, chairFrameThickness, chairDepth);
	ofPopMatrix();
	
	//legs
	ofPushMatrix();
	ofTranslate(chairFrameThickness/2, chairBackHeight + chairSeatHeight/2 + chairFrameThickness, 0);
	drawBox(chairFrameThickness, chairSeatHeight, chairFrameThickness);
	ofPopMatrix();
	
	ofPushMatrix();
	ofTranslate(chairWidth - chairFrameThickness/2,
				chairBackHeight + chairSeatHeight/2 + chairFrameThickness, 0);
	drawBox(chairFrameThickness, chairSeatHeight, chairFrameThickness);
	ofPopMatrix();
	
	ofPushMatrix();
	ofTranslate(chairWidth - chairFrameThickness/2,
				chairBackHeight + chairSeatHeight/2 + chairFrameThickness, chairDepth - chairFrameThickness);
	drawBox(chairFrameThickness, chairSeatHeight, chairFrameThickness);
	ofPopMatrix();
	
	ofPushMatrix();
	ofTranslate(chairFrameThickness/2, chairBackHeight + chairSeatHeight/2 + chairFrameThickness,
				chairDepth - chairFrameThickness);
	drawBox(chairFrameThickness, chairSeatHeight, chairFrameThickness);
	ofPopMatrix();
}

void Parameterize_Chair::scrambleChair(){
	chairSeatHeight = floor(ofRandom(10, 200));
	chairWidth = floor(ofRandom(10, 200));
	chairDepth = floor(ofRandom(10, 200));
	chairBackHeight = floor(ofRandom(10, 200));
}

void Parameterize_Chair::drawBox(int size){
	drawBox(size, size, size);
}

void Parameterize_Chair::drawBox(int w, int h, int d){
	float x1 = -w/2.f; float x2 = w/2.f;
	float y1 = -h/2.f; float y2 = h/2.f;
	float z1 = -d/2.f; float z2 = d/2.f;
	
	glBegin(GL_QUADS);
	
	// front
	glNormal3d(0, 0, 1);

    glVertex3f(x1, y1, z1);
    glVertex3f(x2, y1, z1);
    glVertex3f(x2, y2, z1);
    glVertex3f(x1, y2, z1);
	
    // right
    glNormal3d(1, 0, 0);
    glVertex3f(x2, y1, z1);
    glVertex3f(x2, y1, z2);
    glVertex3f(x2, y2, z2);
    glVertex3f(x2, y2, z1);
	
    // back
    glNormal3d(0, 0, -1);
    glVertex3f(x2, y1, z2);
    glVertex3f(x1, y1, z2);
    glVertex3f(x1, y2, z2);
    glVertex3f(x2, y2, z2);
	
    // left
    glNormal3d(-1, 0, 0);
    glVertex3f(x1, y1, z2);
    glVertex3f(x1, y1, z1);
    glVertex3f(x1, y2, z1);
    glVertex3f(x1, y2, z2);
	
    // top
    glNormal3d(0, 1, 0);
    glVertex3f(x1, y1, z2);
    glVertex3f(x2, y1, z2);
    glVertex3f(x2, y1, z1);
    glVertex3f(x1, y1, z1);
	
    // bottom
    glNormal3d(0, -1, 0);
    glVertex3f(x1, y2, z1);
    glVertex3f(x2, y2, z1);
    glVertex3f(x2, y2, z2);
    glVertex3f(x1, y2, z2);
	
	glEnd();
}

//--------------------------------------------------------------
void Parameterize_Chair::mousePressed(int x, int y, int button){
	scrambleChair();
}
