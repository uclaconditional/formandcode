/**
 * Parameterize: Wave
 * from Form+Code in Design, Art, and Architecture 
 * by Casey Reas, Chandler McWilliams, and LUST
 * Princeton Architectural Press, 2010
 * ISBN 9781568989372
 * 
 * This code was written for Processing 2+
 * Get Processing at http://www.processing.org/download
 */

int brickWidth = 40;
int brickHeight = 15;
int cols = 20;
int rows = 24;
int columnOffset = 60;
int rowOffset = 30;
float rotationIncrement = 0.15;

void setup() {
  size(1200, 768);
  background(0);
  noStroke();
  fill(255);
  noLoop();
}

void draw() {
  translate(30, 30);
  for (int i=0; i<cols; i++) {
    pushMatrix();
    translate(i * columnOffset, 0);
    float r = random(-QUARTER_PI, QUARTER_PI);
    int dir = 1;
    for (int j=0; j<rows; j++) {
      pushMatrix();
      translate(0, rowOffset * j);
      rotate(r);
      rect(-brickWidth/2, -brickHeight/2, brickWidth, brickHeight);
      popMatrix();
      r += dir * rotationIncrement;
      if (r > QUARTER_PI || r < -QUARTER_PI) dir *= -1;
    }
    popMatrix();
  }
}
