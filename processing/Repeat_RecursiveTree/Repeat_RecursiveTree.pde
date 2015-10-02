/**
 * Repeat: Recursive Tree
 * from Form+Code in Design, Art, and Architecture 
 * by Casey Reas, Chandler McWilliams, and LUST
 * Princeton Architectural Press, 2010
 * ISBN 9781568989372
 *
 * This program is based on Context Free program 
 * "Foggy Tree by Chris Coyne:
 * http://www.contextfreeart.org/gallery/view.php?id=4 
 * 
 * Get Processing at http://www.processing.org/download
 */


float dotSize = 9;
float angleOffsetA;
float angleOffsetB;

void setup() {
  size(900, 600); 
  noStroke();
  fill(255);
  frameRate(1);  // Redraw the tree once a second
  
  angleOffsetA = radians(1.5); // Convert 1.5 degrees to radians
  angleOffsetB = radians(50);  // Convert 50 degrees to radians
}

void draw() {
  background(0);                     // White background
  translate(width/2, height);          // Move to the center, bottom of the screen
  seed1(dotSize, radians(270), 0, 0);  // Start the tree
}

void seed1(float dotSize, float angle, float x, float y) {
  
  if (dotSize > 1.0) {
    
    // Create a random numbers between 0 and 1
    float r = random(0, 1.0);  
    
    // 98% chance this will happen
    if (r > 0.02) {  
      ellipse(x, y, dotSize, dotSize);
      float newx = x + cos(angle) * dotSize;
      float newy = y + sin(angle) * dotSize;
      seed1(dotSize * 0.99, angle - angleOffsetA, newx, newy);   
    }
    // 2% chance this will happen
    else {  
      ellipse(x, y, dotSize, dotSize);
      float newx = x + cos(angle);
      float newy = y + sin(angle);
      seed2(dotSize * 0.99, angle + angleOffsetA, newx, newy);
      seed1(dotSize * 0.60, angle + angleOffsetB, newx, newy);
      seed2(dotSize * 0.50, angle - angleOffsetB, newx, newy);
    } 
  }
}


void seed2(float dotSize, float angle, float x, float y) {
  
  if (dotSize > 1.0) {
    
    // Create a random numbers between 0 and 1
    float r = random(0, 1.0);
    
    // 95% chance this will happen
    if (r > 0.05) {
      ellipse(x, y, dotSize, dotSize);
      float newx = x + cos(angle) * dotSize;
      float newy = y + sin(angle) * dotSize;
      seed2(dotSize * 0.99, angle + angleOffsetA, newx, newy);
    } 
    // 5% chance this will happen
    else {
      ellipse(x, y, dotSize, dotSize);
      float newx = x + cos(angle);
      float newy = y + sin(angle);
      seed1(dotSize * 0.99, angle + angleOffsetA, newx, newy);  
      seed2(dotSize * 0.60, angle + angleOffsetB, newx, newy);
      seed1(dotSize * 0.50, angle - angleOffsetB, newx, newy);
    }
  }
}