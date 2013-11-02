/**
 * Parameterize: Waves from Form+Code in Design, Art, and Architecture 
 * implemented in Go by Anthony Starks 
 * 
 * Requires the go programming language available at http://golang.org
 * and the SVGo libraray available at http://github.com/ajstarks/svgo
 *
 * Create SVG file from command line with: make
 * 
 * For more information about Form+Code visit http://formandcode.com
 */
package main

import (
	"github.com/ajstarks/svgo"
	"os"
	"fmt"
	"rand"
	"time"
)

var (
	canvas = svg.New(os.Stdout)
	width = 1200
	height = 768
	brickWidth = 40
	brickHeight = 15
	cols = 20
	rows = 24
	columnOffset = 60
	rowOffset = 30
	rotationIncrement float64 = 8.55  // original was 0.15, for Pi/4, we use degrees
)

func wave() {
	var dir float64
	canvas.Gtransform("translate(30,30)")
	for i := 0; i < cols; i++ {
		canvas.Gtransform(fmt.Sprintf("translate(%d,0)", i*columnOffset))
		r := randrange(-45, 45) // degrees instead of radians
		dir = 1
		for j := 0; j < rows; j++ {
			canvas.Gtransform(fmt.Sprintf("translate(0 %d) rotate(%f)", rowOffset*j, r))
			canvas.Rect(-brickWidth/2, -brickHeight/2, brickWidth, brickHeight)
			canvas.Gend()
			r += dir * rotationIncrement
			if r > 45 || r < -45 {
				dir *= -1
			}
		}
		canvas.Gend()
	}
	canvas.Gend()
}

func randrange(min, max int) float64 {
	if max < min {
		min, max = max, min
	}
	length := max - min + 1
	return float64(rand.Intn(length) + min)
}

func main() {
	rand.Seed(time.Nanoseconds() % 1e9)
	canvas.Start(width,height)
	canvas.Rect(0,0,width,height,"fill:black")
	canvas.Gstyle("fill:none;stroke:pink")
	wave()
	canvas.Gend()
	canvas.End()
}
