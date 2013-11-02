/**
 * Simulate: Particles from Form+Code in Art, Design, and Architecture
 * implemented in C++ by Patrick Tierney (patrick.l.tierney@gmail.com || http://ptierney.com)
 *
 * Requires Cinder 0.8.2 available at http://libcinder.org
 *
 * Project files are located at https://github.com/hlp/form-and-code
 *
 * For more information about Form+Code visit http://formandcode.com
 */

#include <boost/date_time.hpp>

#include "cinder/app/AppBasic.h"
#include "cinder/Rand.h"
#include "cinder/CinderMath.h"

class Particle;

class Simulate_Particles : public ci::app::AppBasic {
public:
    void prepareSettings(Settings* settings);
    void setup();
    void draw();

private:
    std::vector<Particle> particles;
    bool saving;
};

class Particle {
public:
    Particle(ci::Vec2f l) {
        counter = 0;

        float randmin = -M_PI / 2.0f;
        float randmax = 0;

        float r = ci::Rand::randFloat(0, M_PI * 2.0f);
        float x = ci::math<float>::cos(r);
        float y = ci::math<float>::sin(r);
        acc = ci::Vec2f(x / 250.0f, y / 250.0f);

        float q = ci::Rand::randFloat(0, 1);
        r = ci::Rand::randFloat(randmin, randmax);
        x = ci::math<float>::cos(r) * q;
        y = ci::math<float>::sin(r) * q;
        vel = ci::Vec2f(x, y);
        loc = l;

        counter = 0;
        hist.resize(1000);
    }

    void update() {
        vel += acc;
        loc += vel;
        // save location every 10 frames
        if (ci::app::getElapsedFrames() % 10 == 0) {
            hist[counter] = (loc);  
            counter++;
        }
    }

    void drawArrowHead(ci::Vec2f v, ci::Vec2f loc, float scale) {
        ci::gl::pushMatrices();
        float arrowsize = 4;
        // Translate to location to render vector
        ci::gl::translate(ci::Vec2f(loc.x, loc.y));

        // Rotate to the vector heading
        ci::Quatf q(0.0f, 0.0f, ci::math<float>::atan2(v.normalized().y, v.normalized().x));
        ci::gl::rotate(q);

        // Calculate length of vector & scale it to be bigger or smaller if necessary
        float len = v.length()*scale;
        arrowsize = ci::lmap<float>(len, 0, 10, 0, 1) * arrowsize;

        // Draw point
        glColor4f(0.0f, 0.0f, 0.0f, 100.0f/255.0f);
        ci::gl::drawLine(ci::Vec2f(0,0),ci::Vec2f(len-arrowsize,0));
        glBegin(GL_TRIANGLES);
        glVertex2f(len,0);
        glVertex2f(len-arrowsize,+arrowsize/2);
        glVertex2f(len-arrowsize,-arrowsize/2);
        glEnd();

        ci::gl::popMatrices();
    }

    void draw() {
        float c = 100.0f/255.0f;
        glColor4f(c, c, c, 50.0f/255.0f);

        drawArrowHead(vel,loc,10);

        // draw history path
        glColor4f(0.0f, 0.0f, 0.0f, 100.0f/255.0f);
        glBegin(GL_LINE_STRIP);
        for (int i = 0; i < counter; i++) {
            glVertex2f(hist[i].x, hist[i].y);
        }

        if (!hist.empty()) glVertex2f(loc.x, loc.y);
        
        glEnd();
    }

private:
    ci::Vec2f loc;
    ci::Vec2f vel;
    ci::Vec2f acc;

    std::vector<ci::Vec2f> hist;
    int counter;
};

void Simulate_Particles::prepareSettings(Settings* settings) {
    settings->setWindowSize(1024, 768);
}

void Simulate_Particles::setup() {
    glEnable(GL_LINE_SMOOTH);
    ci::gl::enableAlphaBlending();

    for (int i = 0; i < 1000; i++) {
        particles.push_back(Particle(ci::Vec2f(100, getWindowHeight()-100)));
    }
}

void Simulate_Particles::draw() {
    ci::gl::setMatricesWindow(getWindowSize());
    ci::gl::clear(ci::Color::white());

    for (std::vector<Particle>::iterator it = particles.begin(); 
        it != particles.end(); ++it) {
        it->update();
        it->draw();
    }
}


CINDER_APP_BASIC(Simulate_Particles, ci::app::RendererGl)
