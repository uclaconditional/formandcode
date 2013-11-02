/**
 * Simulate: Particles from Form+Code in Design, Art, and Architecture 
 * implemented in OpenFrameworks by Anthony Stellato <http://rabbitattack.com/> 
 * 
 * Requires OpenFrameworks available at http://openframeworks.cc/
 *
 * For more information about Form+Code visit http://formandcode.com
 */

#include "Simulate_Particles.h"

Particle *particles;
bool saving = false;

float mag(ofPoint in){
	float retf = sqrt(in.x * in.x + in.y * in.y);
	return retf;
}

//--------------------------------------------------------------
void Simulate_Particles::setup(){
	ofSetFrameRate(60);
	ofEnableSmoothing();
	ofEnableAlphaBlending();
	
	particles = new Particle[1000];
	for(int i = 0; i < 1000; i++){
		particles[i] = Particle(ofPoint(100, ofGetHeight()-100));
	}
}

//--------------------------------------------------------------
void Simulate_Particles::update(){

}

//--------------------------------------------------------------
void Simulate_Particles::draw(){
	ofBackground(255, 255, 255);
	ofSetColor(0, 0, 0);
	for(int i = 0; i < 1000; i++){
		particles[i].update();
		particles[i].draw();
	}
}

//--------------------------------------------------------------
void Simulate_Particles::keyPressed(int key){

}

//--------------------------------------------------------------
void Simulate_Particles::keyReleased(int key){

}

//--------------------------------------------------------------
void Simulate_Particles::mouseMoved(int x, int y ){

}

//--------------------------------------------------------------
void Simulate_Particles::mouseDragged(int x, int y, int button){

}

//--------------------------------------------------------------
void Simulate_Particles::mousePressed(int x, int y, int button){

}

//--------------------------------------------------------------
void Simulate_Particles::mouseReleased(int x, int y, int button){

}

//--------------------------------------------------------------
void Simulate_Particles::windowResized(int w, int h){

}

Particle::Particle(ofPoint l){
	counter = 0;
	float randmin = -HALF_PI;
	float randmax = 0;
	
	float r = ofRandom(0, TWO_PI);
	float x = cos(r);
	float y = sin(r);
	acc = ofPoint(x / 250, y / 250);
	
	float q = ofRandom(0, 1);
	r = ofRandom(randmin, randmax);
	x = cos(r) * q;
	y = sin(r) * q;
	vel = ofPoint(x, y);
	loc = l;
	hist = new ofPoint[1000];
}

void Particle::update(){
	vel += acc;
	loc += vel;
	if(ofGetFrameNum() % 10 == 0 && counter < 1000){
		hist[counter].x = loc.x;
		hist[counter].y = loc.y;
		counter++;
	}
}

void Particle::draw(){
	ofFill();
	ofSetColor(100, 100, 100, 100);
	drawArrowHead(vel, loc, 10);
	ofNoFill();
	ofSetColor(0, 0, 0, 100);
	ofBeginShape();
	for(int i = 0; i < counter; i++){
		ofVertex(hist[i].x, hist[i].y);
	}
	if(counter > 0) ofVertex(loc.x, loc.y);
	ofEndShape(false);
}

void Particle::drawArrowHead(ofPoint v, ofPoint loc, float scale){
	ofPushMatrix();
	float arrowsize = 5.0f;
	ofTranslate(loc.x, loc.y, 0);
	float rotate = atan2(v.y, v.x);
	ofRotate(ofRadToDeg(rotate), 0, 0, 1);
	
	float len = mag(v) * scale;
	arrowsize = ofMap(len, 0.f, 10.f, 0.f, 1.f, false) * arrowsize;
	
	ofLine(0, 0, len-arrowsize, 0);

	ofBeginShape();
	ofVertex(len, 0);
	ofVertex(len-arrowsize, arrowsize/2);
	ofVertex(len-arrowsize, -arrowsize/2);
	ofEndShape(true);

	ofPopMatrix();
}