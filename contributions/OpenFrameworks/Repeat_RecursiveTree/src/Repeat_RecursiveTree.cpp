/**
 * Repeat: Recursive Tree from Form+Code in Design, Art, and Architecture 
 * implemented in OpenFrameworks by Anthony Stellato <http://rabbitattack.com/> 
 * 
 * Requires OpenFrameworks available at http://openframeworks.cc/
 *
 * For more information about Form+Code visit http://formandcode.com
 */

#include "Repeat_RecursiveTree.h"

//--------------------------------------------------------------
void Repeat_RecursiveTree::setup(){
	ofSetFrameRate(1);
	ofBackground(255, 255, 255);
	ofEnableSmoothing();
	
	dotSize = 9.0f;
	angleOffsetA = ofDegToRad(1.5);
	angleOffsetB = ofDegToRad(50);
}

//--------------------------------------------------------------
void Repeat_RecursiveTree::update(){

}

//--------------------------------------------------------------
void Repeat_RecursiveTree::draw(){
	ofBackground(255, 255, 255);
	ofSetColor(0, 0, 0);
	ofTranslate(ofGetWidth()/2, ofGetHeight(), 0);
	seed1(dotSize, ofDegToRad(270), 0, 0);

}

//--------------------------------------------------------------
void Repeat_RecursiveTree::seed1(float dotSize, float angle, float x, float y){
	if(dotSize > 1.0f){
		float r = ofRandomuf();
		
		if(r > 0.02f){
			ofCircle(x, y, dotSize);
			float newx = x + cos(angle) * dotSize;
			float newy = y + sin(angle) * dotSize;
			seed1(dotSize * 0.99f, angle - angleOffsetA, newx, newy);
		}
		else {
			ofCircle(x, y, dotSize);
			float newx = x + cos(angle);
			float newy = y + sin(angle);
			seed2(dotSize * 0.99f, angle + angleOffsetA, newx, newy);
			seed1(dotSize * 0.6f, angle + angleOffsetB, newx, newy);
			seed2(dotSize * 0.5f, angle - angleOffsetB, newx, newy);
		}
	}
}

//--------------------------------------------------------------
void Repeat_RecursiveTree::seed2(float dotSize, float angle, float x, float y){
	if(dotSize > 1.0f){
		float r = ofRandomuf();
		
		if(r > 0.05f){
			ofCircle(x, y, dotSize);
			float newx = x + cos(angle) * dotSize;
			float newy = y + sin(angle) * dotSize;
			seed2(dotSize * 0.99f, angle + angleOffsetA, newx, newy);
		}
		else {
			ofCircle(x, y, dotSize);
			float newx = x + cos(angle);
			float newy = y + sin(angle);
			seed1(dotSize * 0.99f, angle + angleOffsetA, newx, newy);
			seed2(dotSize * 0.6f, angle + angleOffsetB, newx, newy);
			seed1(dotSize * 0.5f, angle - angleOffsetB, newx, newy);
		}
	}
}

//--------------------------------------------------------------
void Repeat_RecursiveTree::keyPressed(int key){

}

//--------------------------------------------------------------
void Repeat_RecursiveTree::keyReleased(int key){

}

//--------------------------------------------------------------
void Repeat_RecursiveTree::mouseMoved(int x, int y ){

}

//--------------------------------------------------------------
void Repeat_RecursiveTree::mouseDragged(int x, int y, int button){

}

//--------------------------------------------------------------
void Repeat_RecursiveTree::mousePressed(int x, int y, int button){

}

//--------------------------------------------------------------
void Repeat_RecursiveTree::mouseReleased(int x, int y, int button){

}

//--------------------------------------------------------------
void Repeat_RecursiveTree::windowResized(int w, int h){

}

