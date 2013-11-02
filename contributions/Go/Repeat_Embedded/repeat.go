/**
 * Repeat: Embedded Iteration from Form+Code in Design, Art, and Architecture 
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
	"fmt"
	"os"
)

var (
	width  = 400
	height = 300
	canvas = svg.New(os.Stdout)
)

func stitches() {
	for x := 50; x <= width-50; x += 20 {
		for y := 50; y <= height-50; y += 20 {
			canvas.Line(x-5, y-5, x+5, y+5)
			canvas.Line(x+5, y-5, x-5, y+5)
		}
	}
}
func perspective() {
	for x := 50; x <= width-50; x += 20 {
		for y := 50; y <= height-50; y += 20 {
			canvas.Line(x, y, width/2, height/2)
		}
	}
}
func ocircles() {
	for x := 50; x <= width-50; x += 20 {
		for y := 50; y <= height-50; y += 20 {
			canvas.Circle(x, y, 20)
		}
	}
}
func rarcs() {
	count := 120
	for x := 50; x <= width-50; x += 20 {
		for y := 50; y <= height-50; y += 20 {
			canvas.Gtransform(fmt.Sprintf("translate(%d,%d) rotate(%d)", x, y, imap(count, 120, 0, 0, 720)))
			canvas.Arc(-7, 0, 7, 7, 0, false, false, 7, 0)
			canvas.Gend()
			count--
		}
	}
}
func go5() {
	for x := 50; x <= width-50; x += 20 {
		for y := 50; y <= height-50; y += 20 {
			for i := 0; i < 16; i += 4 {
				canvas.Line(x+i, y, x+i, y+12)
			}
			canvas.Line(x, y, x+12, y+12)
		}
	}
}

func imap(value int, low1 int, high1 int, low2 int, high2 int) int {
	return low2 + (high2-low2)*(value-low1)/(high1-low1)
}

func main() {
	canvas.Start(width, height)
	canvas.Rect(0, 0, width, height, "fill:black")
	canvas.Gstyle("stroke:pink;fill:none;stroke-width:1px")
	if len(os.Args) > 1 {
		switch os.Args[1] {
		case "1":
			stitches()
		case "2":
			perspective()
		case "3":
			ocircles()
		case "4":
			rarcs()
		case "5":
			go5()
		}
	}
	canvas.Gend()
	canvas.End()
}
