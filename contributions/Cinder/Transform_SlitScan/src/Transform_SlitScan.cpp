/**
 * Transform: Slit-Scan from Form+Code in Art, Design, and Architecture
 * implemented in C++ by Patrick Tierney <http://ptierney.com>
 * 
 * A variation of this example by Forrest Oliphant <http://sembiki.com>
 * which takes advantage of cinder specific optimizations
 * can be found at https://gist.github.com/856451
 *
 * Requires Cinder 0.8.2 available at http://libcinder.org
 *
 * Project files are located at https://github.com/hlp/form-and-code
 *
 * For more information about Form+Code visit http://formandcode.com
 */

#include "cinder/app/AppBasic.h"
#include "cinder/Surface.h"
#include "cinder/Capture.h"

class Transform_SlitScan : public ci::app::AppBasic {
public:
    void prepareSettings(Settings* settings);
    void setup();
    void update();
    void draw();
    void shutdown();

private:
    ci::Capture capture;
    ci::Surface surface;

    int video_width;
    int video_height;
    int video_slice_x;
    int window_width;
    int window_height;
    int draw_position_x;
    bool newFrame;

    int data_size;
    GLubyte* data;
};

void Transform_SlitScan::prepareSettings(Settings* settings) {
    video_width = 320;
    video_height = 240;
    video_slice_x = video_width / 2;
    window_width = 1000;
    window_height = video_height;
    draw_position_x = 0;
    newFrame = false;
    data_size = window_width * window_height * 3;

    settings->setWindowSize(window_width, window_height);
}

void Transform_SlitScan::setup() {
    try {
        capture = ci::Capture(video_width, video_height);
        capture.start();
    } catch (...) {
        // if we threw in the start close the program 
        ci::app::console() << "Unable to open webcam." << std::endl;
        exit(1);
    }

    if (capture.getWidth() != video_width || capture.getHeight() != video_height) {
        ci::app::console() << "Unable to open webcam at desired size." << std::endl;
        exit(1);
    }

    // create new pixel buffer
    data = new GLubyte[data_size];

    // set all pixels to black
    for (int i = 0; i < data_size; ++i) {
        data[i] = (GLubyte) 0;
    }
}

void Transform_SlitScan::update() {
    newFrame = false;

    if (!capture || !capture.checkNewFrame()) 
        return;

    newFrame = true;

    surface = capture.getSurface();

    ci::Surface::Iter it = surface.getIter();

    int i = window_height - 1;
    while(it.line()) {
        int j = 0;
		while(it.pixel()) {
            if (j == video_slice_x) {
                data[i * window_width * 3 + draw_position_x * 3] = (GLubyte) it.r(); 
                data[i * window_width * 3 + draw_position_x * 3 + 1] = (GLubyte) it.g(); 
                data[i * window_width * 3 + draw_position_x * 3 + 2] = (GLubyte) it.b(); 
            }
            j++;
		}
        i--;
	}
}

void Transform_SlitScan::draw() {
    if (!newFrame)
        return;

    draw_position_x++;

    if (draw_position_x >= window_width)
        draw_position_x = 0;

    glDrawPixels(window_width, window_height, GL_RGB, GL_UNSIGNED_BYTE, data);
}

void Transform_SlitScan::shutdown() {
    delete [] data;
}


CINDER_APP_BASIC(Transform_SlitScan, ci::app::RendererGl)
