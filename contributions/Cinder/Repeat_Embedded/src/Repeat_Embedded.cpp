/**
 * Repeat: Embedded Iteration from Form+Code in Art, Design, and Architecture
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

class Repeat_Embedded : public ci::app::AppBasic {
public:
    void prepareSettings(Settings* settings);
    void setup();
    void draw();

    void mouseDown(ci::app::MouseEvent);

private:
    void arc(const ci::Vec2f& center, float radius, float start, float stop);

    int option;
};

void Repeat_Embedded::prepareSettings(Settings* settings) {
    settings->setWindowSize(400, 300);
}

void Repeat_Embedded::setup() {
    option = 1;
    glEnable(GL_SMOOTH);
    ci::gl::enableAlphaBlending();
    
    glLineWidth(1.2f);
    ci::gl::color(ci::Color::black());
}

void Repeat_Embedded::draw() {
    ci::gl::setMatricesWindow(getWindowSize());
    ci::gl::clear(ci::Color::white());

    if (option == 1) {
        // Option 1: Stitches
        for (int x = 50; x <= getWindowWidth()-50; x += 20) {
            for (int y = 50; y <= getWindowHeight()-50; y+=20) {
                ci::gl::drawLine(ci::Vec2f(x-5, y-5), ci::Vec2f(x+5, y+5));
                ci::gl::drawLine(ci::Vec2f(x+5, y-5), ci::Vec2f(x-5, y+5));
            }
        }
    }
    else if (option == 2) {
        // Option 2: Perspective
        for (int x = 50; x <= getWindowWidth()-50; x += 20) {
            for (int y = 50; y <= getWindowHeight()-50; y+=20) {
                ci::gl::drawLine(ci::Vec2f(x, y), ci::Vec2f(getWindowWidth()/2, getWindowHeight()/2));
            }
        }
    }
    else if (option == 3) {
        // Option 3: Overlapping circles
        for (int x = 50; x <= getWindowWidth()-50; x += 20) {
            for (int y = 50; y <= getWindowHeight()-50; y+=20) {
                ci::gl::drawStrokedCircle(ci::Vec2f(x, y), 40/2);
            }
        }
    }
    else if (option == 4) {
        // Option 4: Rotating arcs
        int count = 120;
        for (int x = 50; x <= getWindowWidth()-50; x += 20) {
            for (int y = 50; y <= getWindowHeight()-50; y +=20) {
                float s = ci::lmap<float>(count, 120, 0, 0, M_PI*2*2);
                arc(ci::Vec2f(x, y), 14/2, s, s + M_PI);
                count--;
            }
        }
    }
    else if (option == 5) {
        // Option 5: Groups of five
        for (int x = 50; x < getWindowWidth()-50; x += 20) {
            for (int y = 50; y < getWindowHeight()-50; y+=20) {
                //rect(x-10, y-10, 22, 22);
                for (int i = 0; i < 16; i+=4) {
                    ci::gl::drawLine(ci::Vec2f(x + i, y), ci::Vec2f(x + i, y + 12));
                }
                ci::gl::drawLine(ci::Vec2f(x, y), ci::Vec2f(x + 12, y + 12));
            }
        }
    }
}

void Repeat_Embedded::mouseDown(ci::app::MouseEvent /*event*/) {
    option++;
    if (option > 5) option = 1;
}

void Repeat_Embedded::arc(const ci::Vec2f& center, float radius, float start, float stop) {
    // automatically determine the number of segments from the circumference
    int numSegments = (int) ci::math<double>::floor(radius * M_PI * 2);
    int startSegments = (int) ci::math<double>::floor(radius * start);
    int endSegments = (int) ci::math<double>::floor(radius * stop);

    if (numSegments < 2) numSegments = 2;
    int numVerts = (endSegments-startSegments)*2;
    if (numVerts < 2) numVerts = 2;
    GLfloat* verts = new float[numVerts];

    int i = 0;
    for(int s = startSegments; s < endSegments; s++) {
        float t = s / (float)numSegments * 2.0f * 3.14159f;
        verts[i*2+0] = center.x + ci::math<float>::cos(t) * radius;
        verts[i*2+1] = center.y + ci::math<float>::sin(t) * radius;
        i++;
    }

    glEnableClientState(GL_VERTEX_ARRAY);
    glVertexPointer(2, GL_FLOAT, 0, verts);
    glDrawArrays(GL_LINE_STRIP, 0, numVerts / 2);
    glDisableClientState(GL_VERTEX_ARRAY);

    delete [] verts;
}

CINDER_APP_BASIC(Repeat_Embedded, ci::app::RendererGl)
