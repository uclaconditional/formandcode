/**
 * Visualize: Superformula from Form+Code in Art, Design, and Architecture
 * implemented in C++ by David Wicks http://sansumbrella.com/
 *
 * Requires Cinder 0.8.2 available at http://libcinder.org
 *
 * For more information about Form+Code visit http://formandcode.com
 */

#include "cinder/app/AppBasic.h"
#include "cinder/CinderMath.h"
#include "cinder/gl/gl.h"

using namespace ci;
using namespace ci::app;
using namespace std;

class Visualize_Superformula : public AppBasic {
public:
	void prepareSettings( Settings* settings );
	void setup();
	void draw();
	void calculateShape();
	vector<Vec2f> superformula( float m, float n1, float n2, float n3 );
	Vec2f superformulaPoint( float m, float n1, float n2, float n3, float phi );
private:
	Shape2d	mSuperShape;
	float	scaler;
	int		m;
	float	n1, n2, n3;
};

void Visualize_Superformula::prepareSettings( Settings* settings )
{
	settings->setWindowSize( 700, 700 );
}

void Visualize_Superformula::setup()
{
	scaler = 200;
	m = 2;
	n1 = 18;
	n2 = 1;
	n3 = 1;
	
	calculateShape();
}

void Visualize_Superformula::draw()
{
	gl::clear( Color::black() ); 
	
	gl::pushMatrices();
	gl::translate( getWindowCenter() );
	
	gl::color( Color( CM_HSV, 0.9583f, 0.38f, 0.97f ) );
	gl::draw( mSuperShape );
	
	gl::popMatrices();
}

void Visualize_Superformula::calculateShape()
{
	float newscaler = scaler;
	
	for ( int s = 16; s > 0; s-- )
	{
		float mm = m + s;
		float nn1 = n1 + s;
		float nn2 = n2 + s;
		float nn3 = n3 + s;
		newscaler = newscaler * 0.98f;
		float sscaler = newscaler;
		
		vector<Vec2f> points = superformula( mm, nn1, nn2, nn3 );
		mSuperShape.moveTo( points[0] * sscaler );
		for( int i = 1; i < points.size(); i++ )
		{
			mSuperShape.quadTo( points[i-1] * sscaler, points[i] * sscaler );
		}
		
		mSuperShape.close();
	}
}

vector<Vec2f> Visualize_Superformula::superformula( float m, float n1, float n2, float n3 )
{
	int numPoints = 360;
	float phi = (M_PI * 2.0f) / numPoints;
	
	vector<Vec2f> points;
	for( int i = 0; i < numPoints; i++ )
	{
		points.push_back( superformulaPoint( m, n1, n2, n3, phi * i ) );
	}
	
	return points;
}

Vec2f Visualize_Superformula::superformulaPoint( float m, float n1, float n2, float n3, float phi )
{
	float r;
	float t1,t2;
	float a=1,b=1;
	float x = 0;
	float y = 0;
	
	t1 = cos(m * phi / 4) / a;
	t1 = abs(t1);
	t1 = pow(t1,n2);
	
	t2 = sin(m * phi / 4) / b;
	t2 = abs(t2);
	t2 = pow(t2,n3);
	
	r = pow(t1+t2,1/n1);
	if (abs(r) == 0)
	{
		x = 0;
		y = 0;
	} else 
	{
		r = 1.0f / r;
		x = r * cos(phi);
		y = r * sin(phi);
	}
	
	return Vec2f(x, y);
}


CINDER_APP_BASIC( Visualize_Superformula, RendererGl )