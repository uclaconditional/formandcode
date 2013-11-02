/**
 * Simulate: DLA from Form+Code in Design, Art, and Architecture 
 * implemented in OpenFrameworks by Anthony Stellato <http://rabbitattack.com/> 
 * 
 * Requires the OpenFrameworks available at http://openframeworks.cc/
 *
 * For more information about Form+Code visit http://formandcode.com
 */

#include "Simulate_DLA.h"

#define WIDTH 1024
#define HEIGHT 768

//--------------------------------------------------------------
void Simulate_DLA::setup(){
	
	//initialize field
	field = new bool[WIDTH*HEIGHT];
	
	for(int i = 0; i < WIDTH*HEIGHT; i++){
		field[i] = false;
	}
	
	//setup texture
	width = WIDTH;
	height = HEIGHT;
	
	pixels = new unsigned char [width * height];
	
	texture.allocate(width, height, GL_LUMINANCE);
	
	for (int i = 0; i < width * height; i++){
		pixels[i] = 255;
	}

	texture.loadData(pixels, width, height, GL_LUMINANCE);
	
	//seed center
	int fcenterX = width/2;
	int fcenterY = height/2;
	field[fcenterX + fcenterY * width] = true;
	
	//initialize particle array
	particleCount = 200000;
	mParticles = new aggParticle[particleCount];
	
	for(int i = 0; i < particleCount; i++){
		aggParticle temp;
		temp.setup(field, WIDTH, HEIGHT);
		mParticles[i] = temp;
	}

}

//--------------------------------------------------------------
void Simulate_DLA::update(){
	for(int i = 0; i < particleCount; i++){
		mParticles[i].update();
		if(mParticles[i].stuck){
			pixels[mParticles[i].y * width + mParticles[i].x] = 0;
		}
	}
	texture.loadData(pixels, width, height, GL_LUMINANCE);
}

//--------------------------------------------------------------
void Simulate_DLA::draw(){
	texture.draw(0, 0);
}

//--------------------------------------------------------------
void aggParticle::setup(bool *_field, int _w, int _h){
	field = _field;
	w = _w;
	h = _h;
	stuck = false;
	reset();
}

//--------------------------------------------------------------
void aggParticle::reset(){
	do {
		x = ofRandom(0, ofGetWidth());
		y = ofRandom(0, ofGetHeight());
	} while (field[y * ofGetWidth() + x]);
}

//--------------------------------------------------------------
void aggParticle::update(){
	if(!stuck){
		
		x += round(ofRandomf());
		y += round(ofRandomf());
		
		if(x < 0 || y < 0 || x > w || y > h){
			this->reset();
			return;
		}
		
		if(!alone()){
			stuck = true;
			field[y * w + x] = true;
		}
	}
}

//--------------------------------------------------------------
int aggParticle::round(float _in){
	if(_in > 0.0f)
		return ceil(_in);
	else if(_in < 0.0f)
		return floor(_in);
	else
		return 0;
}

//--------------------------------------------------------------
bool aggParticle::alone(){
	int cx = x;
	int cy = y;
	
	int lx = cx - 1;
	int rx = cx + 1;
	int ty = cy - 1;
	int by = cy + 1;
	
	if(cx <= 0 || cx >= w || lx <= 0 || lx >= w || rx <= 0 || rx >= w ||
	   cy <= 0 || cy >= h || ty <= 0 || ty >= h || by <= 0 || by >= h){
		return true;
	}
	
	cy *= w;
	by *= w;
	ty *= w;
	
	if(field[cx + ty] || field[lx + cy] || field[rx + cy] || field[cx + by]){
		return false;
	}
	
	if(field[lx + ty] || field[lx + by] || field[rx + ty] || field[rx + by]){
		return false;
	}
	
	return true;
}
