/**
 * Parameterize: Waves from Form+Code in Art, Design, and Architecture
 * implemented in C++ by Sven Steinbauer (svenito@gmail.com || http://www.unlogic.co.uk/)
 *
 * Requires Cinder 0.8.2 available at http://libcinder.org
 * And the SimpleGUI Cinder block available at https://github.com/vorg/MowaLibs
 *
 * Project files are located at https://github.com/Svenito/parameterize-waves
 *
 * For more information about Form+Code visit http://formandcode.com
 */

#include "cinder/app/AppBasic.h"
#include "cinder/CinderMath.h"
#include "cinder/Rand.h"
#include "cinder/Rect.h"
using namespace ci;
using namespace ci::app;

#include <list>
using namespace std;

#include "SimpleGUI.h"
using namespace mowa::sgui;

static float QUARTER_PI = M_PI/4.0f;

#define WINDOW_WIDTH 700.0
#define WINDOW_HEIGHT 600.0

class Parameterize_Waves : public ci::app::AppBasic {
public:
    void prepareSettings(Settings* settings);
    void setup();
    void draw();
    void seed1(float dotSize, float angle, float x, float y);
    void seed2(float dotSize, float angle, float x, float y);
    void mouseDown( MouseEvent event );
    
private:
    SimpleGUI *gui;
    Rand rand;
    
    int brickWidth;
    int brickHeight;
    int cols;
    int rows;
    int columnOffset;
    int rowOffset;
    float rotationIncrement;
    float r;
    int _dir;
};

void Parameterize_Waves::prepareSettings(Settings* settings) {
    settings->setWindowSize(WINDOW_WIDTH, WINDOW_HEIGHT);
    settings->setFrameRate(24.0f);
}

void Parameterize_Waves::setup() {
    brickWidth = 20;
    brickHeight = 15;
    cols = 17;
    rows = 14;
    columnOffset = 40;
    rowOffset = 40;
    _dir = 1;
    rand.randomize();
    r = rand.randFloat(-1.0f * QUARTER_PI, QUARTER_PI);
    
    gui = new SimpleGUI(this);
    gui->addParam("Rot Increment", &rotationIncrement, 0.0f, 1.0f, 0.1f);
}

void Parameterize_Waves::draw() {
    gl::setMatricesWindow(getWindowSize());
    gl::clear(Color::black());
    gl::color(ColorA(0.6, 0.2, 0.2, 1));
    
    gl::translate(Vec3f(30.0f, 30.0f, 0.0f));
    float tmp_rot = r;
    for(int i = 0; i < cols; i++) {
        gl::pushMatrices();
        gl::translate(Vec3f(i * columnOffset, 0.0f, 0.0f));
        int dir = 1;
        for(int j = 0; j < rows; j++){
            gl::pushMatrices();
            gl::translate(Vec3f(0.0f, rowOffset * j, 0.0f));
            gl::rotate(Vec3f(0.0f, 0.0f, toDegrees(tmp_rot)));
            RectT<float> rec = RectT<float>(-brickWidth/2, -brickHeight/2, brickWidth, brickHeight);
            gl::drawSolidRect(rec, false);

            gl::popMatrices();
            tmp_rot += dir * rotationIncrement;
            if(tmp_rot > QUARTER_PI || tmp_rot < (-1 * QUARTER_PI))
                dir *= -1;
        }
        gl::popMatrices();
    }
    gui->draw();
}

void Parameterize_Waves::mouseDown( MouseEvent event ) {
    r = rand.randFloat(-1 * QUARTER_PI, QUARTER_PI);
}

CINDER_APP_BASIC( Parameterize_Waves, RendererGl )