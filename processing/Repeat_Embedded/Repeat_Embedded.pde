/**
 * Repeat: Embedded Iteration 
 * from Form+Code in Design, Art, and Architecture 
 * by Casey Reas, Chandler McWilliams, and LUST
 * Princeton Architectural Press, 2010
 * ISBN 9781568989372
 * 
 * Get Processing at http://www.processing.org/download
 */

int option = 1;
void setup() {
  size(400, 300);
  smooth();
  stroke(255);
  noFill();
}

void draw() {
  background(0);

  if (option == 1) {
    // Option 1: Stitches
    for (int x = 50; x <= width-50; x += 20) {
      for (int y = 50; y <= height-50; y+=20) {
        line(x-5, y-5, x+5, y+5);
        line(x+5, y-5, x-5, y+5);
      }
    }
  } 
  else if (option == 2) {
    // Option 2: Perspective
    for (int x = 50; x <= width-50; x += 20) {
      for (int y = 50; y <= height-50; y+=20) {
        line(x, y, width/2, height/2);
      }
    }
  } 
  else if (option == 3) {
    // Option 3: Overlapping circles
    for (int x = 50; x <= width-50; x += 20) {
      for (int y = 50; y <= height-50; y+=20) {
        ellipse(x, y, 40, 40);
      }
    }
  } 
  else if (option == 4) {
    // Option 4: Rotating arcs
    int count = 120;
    for (int x = 50; x <= width-50; x += 20) {
      for (int y = 50; y <= height-50; y+=20) {
        float s = map(count, 120, 0, 0, TWO_PI*2);
        arc(x, y, 14, 14, s, s + PI);
        count--;
      }
    }
  } 
  else if (option == 5) {
    // Option 5: Groups of five
    for (int x = 50; x < width-50; x += 20) {
      for (int y = 50; y < height-50; y+=20) {
        for (int i = 0; i < 16; i+=4) {
          line(x + i, y, x + i, y + 12);
        }
        line(x, y, x + 12, y + 12);
      }
    }
  }
}

void mousePressed() {
  option++;
  if (option > 5) {
    option = 1;
  }
}