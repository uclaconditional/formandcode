/**
 * Transform: Slit-Scan
 * from Form+Code in Design, Art, and Architecture 
 * by Casey Reas, Chandler McWilliams, and LUST
 * Princeton Architectural Press, 2010
 * ISBN 9781568989372
 * 
 * This code was written for Processing 2+
 * Get Processing at http://www.processing.org/download
 */


import processing.video.*;

Movie myVideo;

int video_width     = 640;
int video_height    = 360;
int video_slice_x   = video_width/2;
int window_width    = 1000;
int window_height   = video_height;
int draw_position_x = 0; 
boolean newFrame  = false;

void setup() {
  size(window_width, window_height, P2D);
  myVideo = new Movie(this, "transit.mov");
  background(0);
  myVideo.loop();
}

void draw() {
  if (myVideo.available() == true) {
    myVideo.read();
    loadPixels();
    myVideo.loadPixels();
    for (int y = 0; y < window_height; y++){
      int setPixelIndex = y*window_width + draw_position_x;
      int getPixelIndex = y*video_width  + video_slice_x;
      pixels[setPixelIndex] = myVideo.pixels[getPixelIndex];
    }
    updatePixels();
    
    draw_position_x++;
    if (draw_position_x >= window_width) {
      draw_position_x = 0;
    }
  }
}
