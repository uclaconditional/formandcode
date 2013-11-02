/**
 * Simulate: Diffusion-Limited Aggregation from Form+Code in Art, Design, and Architecture
 * implemented in C++ by Patrick Tierney (patrick.l.tierney@gmail.com || http://ptierney.com)
 *
 * Requires Cinder 0.8.2 available at http://libcinder.org
 *
 * Project files are located at https://github.com/hlp/form-and-code
 *
 * For more information about Form+Code visit http://formandcode.com
 */

#include <vector>

#include <boost/shared_ptr.hpp>
#include <boost/date_time.hpp>

#include "cinder/gl/gl.h"
#include "cinder/gl/Texture.h"
#include "cinder/app/AppBasic.h"
#include "cinder/Rand.h"
#include "cinder/CinderMath.h"

class Particle;

// soon to be std::shared_ptr
typedef boost::shared_ptr<Particle> ParticlePtr;

class Simulate_DLA : public ci::app::AppBasic {
public:
    void prepareSettings(Settings* settings);
    void setup();
    void update();
    void draw();
    void shutdown();

    std::vector<bool> field;

private:
    int particleCount;
    std::vector<ParticlePtr> particles;
    GLubyte* data;
    int dataSize;
};

class Particle {
public:
    Particle(Simulate_DLA& diffusionApp) : field(diffusionApp.field) {
        stuck = false;
        width = diffusionApp.getWindowWidth();
        height = diffusionApp.getWindowHeight();

        reset();
    }

    void reset() {
        // keep choosing random spots until an empty one is found
        do {
            x = ci::Rand::randInt(width);
            y = ci::Rand::randInt(height);
        } while (field[y * width + x]);
    }

    void update() {
        // move around
        if (!stuck) {
            // get random int [-1, 1] (hence 2)
            x += ci::Rand::randInt(-1, 2);
            y += ci::Rand::randInt(-1, 2);
      
            if (x < 0 || y < 0 || x >= width || y >= height) {
                reset();
                return; 
            }

            // test if something is next to us
            if (!alone()) {
                stuck = true;
                field[y * width + x] = true;        
            }
        }
    }

    // returns true if no neighboring pixels
    bool alone() {
        int cx = x;
        int cy = y;

        // get positions
        int lx = cx-1;
        int rx = cx+1;
        int ty = cy-1;
        int by = cy+1;

        if (cx <= 0 || cx >= width || 
            lx <= 0 || lx >= width || 
            rx <= 0 || rx >= width || 
            cy <= 0 || cy >= height || 
            ty <= 0 || ty >= height || 
            by <= 0 || by >= height) return true;

        // pre multiply the ys
        cy *= width;
        by *= width;
        ty *= width;
    
        // N, W, E, S
        if (field[cx + ty] || 
            field[lx + cy] ||
            field[rx + cy] ||
            field[cx + by]) return false;
    
        // NW, NE, SW, SE
        if (field[lx + ty] || 
            field[lx + by] ||
            field[rx + ty] ||
            field[rx + by]) return false;
    
        return true;
    } 

    bool stuck;
    int x, y;

private:
    int width, height;
    std::vector<bool>& field;
};


void Simulate_DLA::prepareSettings(Settings* settings) {
    settings->setWindowSize(1024, 700);
}

void Simulate_DLA::setup() {
    // this number might need to be smaller for some computers
    particleCount = 20000;
    particles.resize(particleCount);

    // create an array that stores the position of our particles and set them to false
    field.resize(getWindowWidth() * getWindowHeight());

    for (std::vector<bool>::iterator it = field.begin(); it != field.end(); ++it) {
        *it = false;
    }

    // add seed in the center
    int fcenterX = getWindowWidth() / 2;
    int fcenterY = getWindowHeight() / 2;
    field[fcenterX + fcenterY * getWindowWidth()] = true;

    // make particles
    for (int i = 0; i < particles.size(); ++i) {
        particles[i] = ParticlePtr(new Particle(*this));
    }

    // create pixel buffer
    dataSize = getWindowWidth() * getWindowHeight() * 3;
    data = new GLubyte[dataSize];

    // set all pixels to white
    for (int i = 0; i < dataSize; i++) {
        data[i] = (GLubyte) 255;
    }
}

void Simulate_DLA::update() {
    for(int i = 0; i < particleCount; i++) {
        particles[i]->update();
        if (particles[i]->stuck) {
            data[particles[i]->y * getWindowWidth() * 3 + particles[i]->x * 3] = (GLubyte) 0;
            data[particles[i]->y * getWindowWidth() * 3 + particles[i]->x * 3 + 1] = (GLubyte) 0;
            data[particles[i]->y * getWindowWidth() * 3 + particles[i]->x * 3 + 2] = (GLubyte) 0;
        }
    }
}

void Simulate_DLA::draw() {
    glDrawPixels(getWindowWidth(), getWindowHeight(), GL_RGB, GL_UNSIGNED_BYTE, data);  
}

void Simulate_DLA::shutdown() {
    delete [] data;
}

CINDER_APP_BASIC(Simulate_DLA, ci::app::RendererGl)
