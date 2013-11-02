/**
 * Visualize: Superformula from Form+Code in Design, Art, and Architecture 
 * implemented in OpenFrameworks by Anthony Stellato <http://rabbitattack.com/> 
 * 
 * Requires OpenFrameworks available at http://openframeworks.cc/
 *
 * For more information about Form+Code visit http://formandcode.com
 */

#include "Visualize_Superformula.h"

float scaler = 200;
int m = 2;
float n1 = 18;
float n2 = 1;
float n3 = 1;
static int POINTNUM = 360;

//--------------------------------------------------------------
void Visualize_Superformula::setup(){
	ofEnableSmoothing();
	ofNoFill();
	ofSetColor(255, 255, 255);
	
}

//--------------------------------------------------------------
ofPoint Visualize_Superformula::superformulaPoint(float m, float n1, float n2, float n3, float phi)
{
	float r;
	float t1,t2;
	float a=1,b=1;
	float x = 0;
	float y = 0;
	
	t1 = cos(m * phi / 4) / a;
	t1 = fabs(t1);
	t1 = pow(t1,n2);
	
	t2 = sin(m * phi / 4) / b;
	t2 = fabs(t2);
	t2 = pow(t2,n3);
	
	r = pow(t1+t2,1/n1);
	if (fabs(r) == 0) {
		x = 0;
		y = 0;
	}  
	else {
		r = 1 / r;
		x = r * cos(phi);
		y = r * sin(phi);
	}
	return ofPoint(x, y);
}

//--------------------------------------------------------------
ofPoint* Visualize_Superformula::superformula(float m, float n1, float n2, float n3)
{
	int numPoints = POINTNUM;
	float phi = TWO_PI / numPoints;
	ofPoint* retPoints = new ofPoint[numPoints+1];
	for(int i = 0; i <= numPoints; i++){
		retPoints[i] = superformulaPoint(m, n1, n2, n3, phi * i);
	}
	return retPoints;
}

//--------------------------------------------------------------
void Visualize_Superformula::draw(){
	ofBackground(0, 0, 0);
	ofPushMatrix();
	ofTranslate(ofGetWidth()/2, ofGetHeight()/2, 0);
	
	float newscaler = scaler;
	for(int s = 16; s > 0; s--){
		ofBeginShape();
		
		float mm = m + s;
		float nn1 = n1 + s;
		float nn2 = n2 + s;
		float nn3 = n3 + s;
		newscaler = newscaler * 0.98;
		float sscaler = newscaler;
		
		ofPoint* points = superformula(mm, nn1, nn2, nn3);
		ofCurveVertex(points[POINTNUM-1].x * sscaler, points[POINTNUM-1].y * sscaler);
		for(int j = 0; j < POINTNUM; j++){
			ofCurveVertex(points[j].x * sscaler, points[j].y * sscaler);
		}
		ofCurveVertex(points[0].x * sscaler, points[0].y * sscaler);
		ofEndShape(true);
	}
	ofPopMatrix();
}

