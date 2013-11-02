/**
 * Repeat: Recursive Tree from Form+Code in Design, Art, and Architecture 
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
	"rand"
	"math"
	"time"
	"os"
)

var (
	width  = 900
	height = 600
	canvas = svg.New(os.Stdout)
)

var  (
	angleOffsetA = radians(1.5) // Convert 1.5 degrees to radians
	angleOffsetB = radians(50)  // Convert 50 degrees to radians
)

func radians(angle float64) float64 {
	return (angle * math.Pi) / 180
}

func seed1(dotSize, angle, x, y float64) {

 if dotSize > 1.0 {

   // Create a random numbers between 0 and 1
    r := rand.Float64()  

   // 98% chance this will happen
   if (r > 0.02) {  
     dot(x, y, dotSize)
     newx := x + math.Cos(angle) * dotSize
     newy := y + math.Sin(angle) * dotSize
     seed1(dotSize * .99, angle - angleOffsetA, newx, newy)   
   }  else { // 02% chance this will happen  
     dot(x, y, dotSize)
     newx := x + math.Cos(angle)
     newy := y + math.Sin(angle)
     seed2(dotSize * .99, angle + angleOffsetA, newx, newy)
     seed1(dotSize * .60, angle + angleOffsetB, newx, newy)
     seed2(dotSize * .5, angle - angleOffsetB, newx, newy)
   } 
 }
}


func seed2(dotSize, angle, x, y float64) {

 if dotSize > 1.0 {
   // Create a random numbers between 0 and 1
   r := rand.Float64()
   // 95% chance this will happen
   if (r > 0.05) {
     dot(x, y, dotSize)
     newx := x + math.Cos(angle) * dotSize
     newy := y + math.Sin(angle) * dotSize
     seed2(dotSize * .99, angle + angleOffsetA, newx, newy)
   } else { // 05% chance this will happen
     dot(x, y, dotSize)
     newx := x + math.Cos(angle)
     newy := y + math.Sin(angle)
     seed1(dotSize * .99, angle + angleOffsetA, newx, newy)  
     seed2(dotSize * .60, angle + angleOffsetB, newx, newy)
     seed1(dotSize * .50, angle - angleOffsetB, newx, newy)
   }
 }
}

func dot(x, y, d float64) {
	canvas.Circle(int(x), int(y), round(d/2))
	//fmt.Fprintf(os.Stderr, "x=%.2f y=%.2f d=%.2f (%d)\n", x, y, r, round(r))
} 

func round(x float64) int {
		i := int(x)
		f := x - float64(i)
		if f > 0.5 {
			return i + 1
		}
		return i
}

func main() {
	rand.Seed(time.Nanoseconds() % 1e9)
	canvas.Start(width, height)
	canvas.Gstyle("fill:black;fill-opacity:0.5")
	canvas.Gtransform(fmt.Sprintf("translate(%d,%d)",width/2,height))
	seed1(12, radians(270), 0, 0)
	canvas.Gend()
	canvas.Gend()
	canvas.End()
}