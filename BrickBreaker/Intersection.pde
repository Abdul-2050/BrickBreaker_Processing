

// class for to check the Intersections with the borders and with the bricks

import java.awt.Rectangle;

public class Intersection {
  
  
  Rectangle ball;
  Rectangle padel;

  Intersection(int ballX, int ballY, int padelX, int padelY) {
    ball= new Rectangle(ballX, ballY, 20, 20);
    padel= new Rectangle(padelX, padelY, 125, 20);
  }


  void ballIntersectsBoundries() {
    if (ballX <=0) {
      ballXDir = -ballXDir;
    }
    if (ballX >= width-10) {
      ballXDir = -ballXDir;
    }

    if (ballY <=0 ) {
      ballYDir = -ballYDir;
    }

    if (ballY >=height-10 ) {
      ballYDir = -ballYDir;
    }
  }

  void ballIntersectsPadel() {
    if ( ball.intersects(padel)) {
      ballYDir = -ballYDir;
    }
  }
  
}
