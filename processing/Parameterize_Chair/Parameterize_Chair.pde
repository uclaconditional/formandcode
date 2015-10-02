/**
 * Parameterize: Chair
 * from Form+Code in Design, Art, and Architecture 
 * by Casey Reas, Chandler McWilliams, and LUST
 * Princeton Architectural Press, 2010
 * ISBN 9781568989372
 * 
 * Get Processing at http://www.processing.org/download
 */

int chairSeatHeight      = 100;
int chairWidth           = 50;
int chairDepth           = 50;
int chairBackHeight      = 100;
int chairFrameThickness  = 10;

void setup() {
  size(1024, 768, P3D);
  fill(0);
  stroke(255);
  frameRate(1);  // Redraw the tree once a second
}

void draw() {
  background(0);
  ortho();

  pushMatrix();
  translate(400, 250);
  rotateX(-PI / 9);
  rotateY(PI / 8);
  scrambleChair();
  drawChair();
  popMatrix();
}

void scrambleChair() {
  chairSeatHeight = int(random(10, 200));
  chairWidth      = int(random(10, 200));
  chairDepth      = int(random(10, 200));
  chairBackHeight = int(random(10, 200));
}

void drawChair() {
  // Back
  pushMatrix();
  translate(chairWidth/2, chairBackHeight/2);
  box(chairWidth, chairBackHeight, chairFrameThickness);
  popMatrix();

  // Seat
  pushMatrix();
  translate(chairWidth/2, chairBackHeight + chairFrameThickness/2, chairDepth/2 - chairFrameThickness/2);
  box(chairWidth, chairFrameThickness, chairDepth);
  popMatrix();

  // Legs
  pushMatrix();
  translate(chairFrameThickness/2, chairBackHeight + chairSeatHeight/2 + chairFrameThickness, 0);
  box(chairFrameThickness, chairSeatHeight, chairFrameThickness);
  popMatrix();

  pushMatrix();
  translate(chairWidth - chairFrameThickness/2, chairBackHeight + chairSeatHeight/2 + chairFrameThickness, 0);
  box(chairFrameThickness, chairSeatHeight, chairFrameThickness);
  popMatrix();

  pushMatrix();
  translate(chairWidth - chairFrameThickness/2, chairBackHeight + chairSeatHeight/2 + chairFrameThickness, chairDepth - chairFrameThickness);
  box(chairFrameThickness, chairSeatHeight, chairFrameThickness);
  popMatrix();

  pushMatrix();
  translate(chairFrameThickness/2, chairBackHeight + chairSeatHeight/2 + chairFrameThickness, chairDepth - chairFrameThickness);
  box(chairFrameThickness, chairSeatHeight, chairFrameThickness);
  popMatrix();
}