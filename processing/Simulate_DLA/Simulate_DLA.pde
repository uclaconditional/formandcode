/**
 * Simulate: Diffusion-Limited Aggregation
 * from Form+Code in Design, Art, and Architecture 
 * by Casey Reas, Chandler McWilliams, and LUST
 * Princeton Architectural Press, 2010
 * ISBN 9781568989372
 * 
 * Get Processing at http://www.processing.org/download
 */

// This number might need to be smaller for some computers
int particleCount = 20000;
Particle[] particles = new Particle[particleCount];
boolean[] field;

void setup() {
  size(1024, 700, P2D);
  
  // Create an array that stores the position of our particles
  field = new boolean[width * height];

  // Add seed in the center
  int fcenterX = width / 2;
  int fcenterY = height / 2;
  field[fcenterX + fcenterY * width] = true;
  
  // Make particles
  for(int i=0; i<particleCount; i++) {
    particles[i] = new Particle();
  }
}


void draw() {
  background(0);

  loadPixels();
  for(int i=0; i<particleCount; i++) {
    particles[i].update();
    if (particles[i].stuck) {
      pixels[particles[i].y * width + particles[i].x] = color(255);
    }
  }
  updatePixels();
}