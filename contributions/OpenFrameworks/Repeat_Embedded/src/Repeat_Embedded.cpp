/**
 * Repeat: Embedded Iteration from Form+Code in Design, Art, and Architecture 
 * implemented in OpenFrameworks by Anthony Stellato <http://rabbitattack.com/> 
 * 
 * Requires OpenFrameworks available at http://openframeworks.cc/
 *
 * For more information about Form+Code visit http://formandcode.com
 */

#include "Repeat_Embedded.h"

//--------------------------------------------------------------
void Repeat_Embedded::setup(){
	option = 1;
	width = ofGetWidth();
	height = ofGetHeight();
	ofNoFill();
}

//--------------------------------------------------------------
void Repeat_Embedded::update(){

}

//--------------------------------------------------------------
void Repeat_Embedded::draw(){
	ofBackground(0, 0, 0);
	ofSetColor(255, 255, 255);

	if(option == 1){
		// Option 1: Stitches
		for(int x = 50; x <= width-50; x += 20){
			for(int y = 50; y <= height-50; y += 20){
				ofLine(x-5, y-5, x+5, y+5);
				ofLine(x+5, y-5, x-5, y+5);
			}
		}
	}
	else if(option == 2){
		// Option 2: Perspective
		for(int x = 50; x <= width-50; x += 20){
			for(int y = 50; y <= height-50; y += 20){
				ofLine(x, y, width/2, height/2);
			}
		}
	}
	else if(option == 3){
		// Option 3: Overlapping circles
		for(int x = 50; x <= width-50; x += 20){
			for(int y = 50; y <= height-50; y += 20){
				ofEllipse(x, y, 40, 40);
			}
		}
	}
	else if(option == 4){
		// Option 3: Rotating arcs
		int count = 120;
		for(int x = 50; x <= width-50; x += 20){
			for(int y = 50; y <= height-50; y += 20){
				float s = ofMap(count, 0, 120, 0, TWO_PI*2, false);
				arc(x, y, 14, 14, s, s + PI);
				count--;
			}
		}
	}
	else if(option == 5){
		// Option 3: Groups of five
		for(int x = 50; x <= width-50; x += 20){
			for(int y = 50; y <= height-50; y += 20){
				for(int i = 0; i < 16; i += 4){
					ofLine(x + i, y, x + i, y+12);
				}
				ofLine(x, y, x + 12, y + 12);
			}
		}
	}
}

//--------------------------------------------------------------
void Repeat_Embedded::arc(float x, float y, float width, float height, float start, float stop){
	
	float hr = width / 2.0f;
    float vr = height / 2.0f;
	
    float centerX = x + hr;
    float centerY = y + vr;
	
	float startLUT = start;
	float stopLUT = stop;
	
	glBegin(GL_LINE_STRIP);
	float increment = 0.2f;
	for (float i = startLUT; i < stopLUT; i += increment) {
        glVertex2f(centerX + cos(i) * hr,
               centerY + sin(i)* vr);
	}
	
	glVertex2f(centerX + cos(stopLUT) * hr,
		   centerY + sin(stopLUT) * vr);
	glEnd();
}

//--------------------------------------------------------------
void Repeat_Embedded::mousePressed(int x, int y, int button){
	option++;
	if(option > 5)
		option = 1;
}

