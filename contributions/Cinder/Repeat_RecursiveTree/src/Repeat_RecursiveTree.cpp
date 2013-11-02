/**
 * Repeat: Recursive Tree from Form+Code in Art, Design, and Architecture
 * implemented in C++ by Patrick Tierney (patrick.l.tierney@gmail.com || http://ptierney.com)
 *
 * Requires Cinder 0.8.2 available at http://libcinder.org
 *
 * Project files are located at https://github.com/hlp/form-and-code
 *
 * For more information about Form+Code visit http://formandcode.com
 */

#include "cinder/app/AppBasic.h"
#include "cinder/CinderMath.h"
#include "cinder/Rand.h"

class Repeat_RecursiveTree : public ci::app::AppBasic {
public:
    void prepareSettings(Settings* settings);
    void setup();
    void draw();
    void seed1(float dotSize, float angle, float x, float y);
    void seed2(float dotSize, float angle, float x, float y);

private:
    float dotSize;
    float angleOffsetA;
    float angleOffsetB;
    ci::Rand rand;
};

void Repeat_RecursiveTree::prepareSettings(Settings* settings) {
    dotSize = 9;
    settings->setWindowSize(900, 600);
    settings->setFrameRate(1.0f);  // Redraw the tree once a second
}

void Repeat_RecursiveTree::setup() {
    ci::gl::color(ci::Color::black());
    glEnable(GL_SMOOTH);

    angleOffsetA = ci::toRadians(1.5f);
    angleOffsetB = ci::toRadians(50.0f);

    rand.randomize();
}

void Repeat_RecursiveTree::draw() {
    ci::gl::setMatricesWindow(getWindowSize());
    ci::gl::clear(ci::Color::white()); // White background
    ci::gl::translate(ci::Vec2f(getWindowWidth()/2, getWindowHeight())); // Move to the center, bottom of the screen
    seed1(dotSize, ci::toRadians(270.0f), 0, 0); // Start the tree
}

void Repeat_RecursiveTree::seed1(float dotSize, float angle, float x, float y) {

    if (dotSize > 1.0) {

        // Create a random numbers between 0 and 1
        float r = rand.randFloat(0, 1.0f);  

        // 02% chance this will happen
        if (r > 0.02) {
            ci::gl::drawSolidCircle(ci::Vec2f(x, y), dotSize/2);
            float newx = x + ci::math<float>::cos(angle) * dotSize;
            float newy = y + ci::math<float>::sin(angle) * dotSize;
            seed1(dotSize * 0.99, angle - angleOffsetA, newx, newy);   
        }
        // 98% chance this will happen
        else {  
            ci::gl::drawSolidCircle(ci::Vec2f(x, y), dotSize/2);
            float newx = x + ci::math<float>::cos(angle);
            float newy = y + ci::math<float>::sin(angle);
            seed2(dotSize * 0.99, angle + angleOffsetA, newx, newy);
            seed1(dotSize * 0.60, angle + angleOffsetB, newx, newy);
            seed2(dotSize * 0.50, angle - angleOffsetB, newx, newy);
        } 
    }
}

void Repeat_RecursiveTree::seed2(float dotSize, float angle, float x, float y) {

    if (dotSize > 1.0) {

        // Create a random numbers between 0 and 1
        float r = rand.randFloat(0, 1.0);

        // 5% chance this will happen
        if (r > 0.05) {
            ci::gl::drawSolidCircle(ci::Vec2f(x, y), dotSize/2);
            float newx = x + ci::math<float>::cos(angle) * dotSize;
            float newy = y + ci::math<float>::sin(angle) * dotSize;
            seed2(dotSize * 0.99, angle + angleOffsetA, newx, newy);
        } 
        // 95% chance this will happen
        else {
            ci::gl::drawSolidCircle(ci::Vec2f(x, y), dotSize/2);
            float newx = x + ci::math<float>::cos(angle);
            float newy = y + ci::math<float>::sin(angle);
            seed1(dotSize * 0.99, angle + angleOffsetA, newx, newy);  
            seed2(dotSize * 0.60, angle + angleOffsetB, newx, newy);
            seed1(dotSize * 0.50, angle - angleOffsetB, newx, newy);
        }
    }
}

CINDER_APP_BASIC(Repeat_RecursiveTree, ci::app::RendererGl)
