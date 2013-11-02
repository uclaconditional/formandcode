/**
 * Simulate: Particles
 * from Form+Code in Design, Art, and Architecture 
 * by Casey Reas, Chandler McWilliams, and LUST
 * Princeton Architectural Press, 2010
 * ISBN 9781568989372
 * 
 * This code was written for Processing 2+
 * Get Processing at http://www.processing.org/download
 */

Particle[] particles = new Particle[250];
boolean saving = false;

void setup() {
  size(1024, 768, P2D);
  smooth();
  
  // Create particles
  for (int i = 0; i < particles.length; i++) {
    particles[i] = new Particle(new PVector(100, height-100));
  }
}

void draw() {
  background(0);
  // Draw the particles
  for (int i = 0; i < particles.length; i++) {
    particles[i].update();
    particles[i].draw();
  }
}
