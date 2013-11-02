/**
 * Simulate: Diffusion-Limited Aggregation
 * from Form+Code in Design, Art, and Architecture 
 * by Casey Reas, Chandler McWilliams, and LUST
 * Princeton Architectural Press, 2010
 * ISBN 9781568989372
 * 
 * This code was written for Processing 2+
 * Get Processing at http://www.processing.org/download
 */

// ---------------
// Particle.pde
// ---------------
class Particle
{
  int x, y;
  boolean stuck = false;

  Particle() {
    reset();
  }

  void reset() {
    // Keep choosing random spots until an empty one is found
    do {
      x = floor(random(width));
      y = floor(random(height));
    } while (field[y * width + x]);
  }

  void update() {
    // Move around
    if (!stuck) {
      x += round(random(-1, 1));
      y += round(random(-1, 1));
      
      if (x < 0 || y < 0 || x >= width || y >= height) {
         reset();
         return; 
      }

      // Test if something is next to us
      if (!alone()) {
        stuck = true;
        field[y * width + x] = true;        
      }
    }
  }

  // Returns true if no neighboring pixels
  boolean alone() {
    int cx = x;
    int cy = y;

    // Get positions
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

    // Pre multiply the ys
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
}


