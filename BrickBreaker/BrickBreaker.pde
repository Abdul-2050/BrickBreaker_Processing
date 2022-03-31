// Main Applet


// library for timer
import com.dhchoi.*;

// lib for Sound
import processing.sound.*;

// reference for genrating brick and Intersection
BrickGenrator brick;
Intersection check;

// ball and padel directions
int padelX, padelY;
int ballX, ballY, ballXDir, ballYDir;
int ballW, ballH, padelW, padelH;

// controls
boolean right, left;

// color
int[][] tint;

// score
int score = 0;

// rows and col width
int rows = 5;
int col = 10;
int bw ;

// total bricks
int  totalBricks =( rows * col)- 8;
//int totalBricks = 2;


// runtime
boolean play= false;

// gift
boolean gift= false;
boolean free = false;
Gift gift2;

// Timer
CountdownTimer timer1;
CountdownTimer timer2;
CountdownTimer timer3;
// currentTime
long time1;
long time2;
long time3;

// Sounds
SoundFile hitS;
SoundFile backS;


//Fonts
PFont scoreF;


// construcktor for Initializaltion
void setup() {
  size(800, 400);
  surface.setResizable(true);
  surface.setTitle("Brick Breaker ");
  brick = new BrickGenrator(rows, col, bw, 150);

  padelX= (width-125)/2;
  padelY= 450;
  ballX = width /2;
  ballY= height /2;
  ballXDir = 3;
  ballYDir = 8;
  ballW= 20;
  ballH= 20;
  padelW= 125;
  padelH= 20;

  bw=  width- width/2-100;


  tint= new int[rows][ col];
  for (int a=0; a< tint.length; a++) {
    for (int b=0; b< tint.length; b++) {
      tint[a][b] =(int) random(255);
    }
  }

  gift2 = new Gift(200, 100, 40, 40);

  timer1 =  CountdownTimerService.getNewCountdownTimer(this).configure(1000, 4000);
  timer2 =  CountdownTimerService.getNewCountdownTimer(this).configure(1000, 11000);
  timer3 =  CountdownTimerService.getNewCountdownTimer(this).configure(1000, 4000);

  background(0);

  hitS= new SoundFile(this, "hit.mp3");
  backS = new SoundFile(this, "back.mp3");
  backS.play();

  String[] fontList = PFont.list();
  printArray(fontList);

  scoreF = createFont("Arial Bold", 50);
}

void draw() {

  //  background(0);
  background(45, 152, 218);

  // to show bricks
  brick.show();
  bw= width- width/2-100;
  brick.setW(bw);
  brick.showText();

  // padel
  padelY = height- 50;
  fill(235, 59, 90);
  stroke(0);
  strokeWeight(4);
  //padelX= mouseX;
  rect(padelX, padelY, padelW, padelH, 10);
  movePadel();

  // ball
  fill(235, 59, 90);
  stroke(0);
  ellipse(ballX, ballY, ballW, ballH);
  moveBall();
  // Intersection
  check = new Intersection(ballX, ballY, padelX, padelY);
  check.ballIntersectsBoundries();
  check.ballIntersectsPadel();

  // Method for checking if ball intersects the Bricks
  ballIntersectsBrick();

  // score
  textFont(scoreF);
  fill(0);
  textSize(25);
  text("" + score, width- 60, 40);

  // win or lose state
  win();
  lose();


  // Conditions for making gift
  if (gift == true) {

    gift2.makeGift();
    gift2.move(1);
    gift2.intersects();

    // CountdownTimerService.getCountdownTimerForId(1).start();

    if (free) {
      textSize(15);
      text("Gift Time " + time2, 80, 20);
    } else {
      CountdownTimerService.getCountdownTimerForId(1).
        reset(CountdownTimer
        .StopBehavior.STOP_AFTER_INTERVAL);
    }


    if (time2 <= 0) {
      free = false;
      padelW= 125;
      gift= false;
    }
  }


  // Timers
  CountdownTimerService.getCountdownTimerForId(0).start();
  long t1= CountdownTimerService.getCountdownTimerForId(0).getTimeLeftUntilFinish()/1000;
  time1= t1;
  CountdownTimerService.getCountdownTimerForId(1).start();
  long t2= CountdownTimerService.getCountdownTimerForId(1).getTimeLeftUntilFinish()/1000;
  time2= t2;
  CountdownTimerService.getCountdownTimerForId(2).start();
  long t3= CountdownTimerService.getCountdownTimerForId(2).getTimeLeftUntilFinish()/1000;
  time3= t3;


  // music
  if (!backS.isPlaying()) {
    backS.play();
  }
}

// Overriden Methods (must be there!)
void onTickEvent(CountdownTimer t, long timeLeftUntilFinish) {
}
void onFinishEvent(CountdownTimer t) {
}

// method for Intersection with Bricks
void ballIntersectsBrick() {

A:
  for (int a=0; a< brick.brick.length; a++) {
    for (int b=0; b<brick.brick[0].length; b++) {

      if (brick.brick[a][b ] > 0) {
        int brickX= b * brick.bw + ((width - brick.bw*brick.col)/2);
        int brickY= a * brick.bh +50;
        int brickW= brick.bw;
        int brickH= brick.bh;

        Rectangle rect1= new Rectangle(brickX, brickY, brickW, brickH);
        Rectangle rect2= new Rectangle(ballX, ballY, 20, 20);



        if (rect1.intersects(rect2)) {
          if (brick.brick[a][b] == 8 ) {
            gift=true;
          }
          brick.setBrickValue(a, b, 1);
          if (brick.brick[a][b] ==0) {
            score+= 5;
            totalBricks --;
          }

          if (free == false) {
            if (ballX +19 <= rect1.x || ballX+1 >= rect1.x + rect1.width) {
              ballXDir = -ballXDir;
            } else {
              ballYDir =  -ballYDir;
              hitS.play();
            }
          }

          break A;
        }
      }
    }
  }
}
// Win state
void win() {
  if (totalBricks<= 0 ) {
    play = false;
    ballX = width /2;
    ballY= height /2;

    textSize(25);
    textAlign(CENTER, CENTER);
    text("Next Level In  "+ time3, width/2, height/2);

    if (time3 <= 0) {
      gift= false;
      rows = rows +2;
      brick = new BrickGenrator(rows, col, 300, 150);
      totalBricks = ( rows * col)-8;
      score =0 ;
      ballXDir =  4;
      ballYDir = 8;
      giftY= 0;
    }
  } else {
    timer3.reset(CountdownTimer.StopBehavior.STOP_AFTER_INTERVAL);
  }
}

// Lose State
void lose() {
  if (ballY >= height- ballH ) {
    textAlign(CENTER, CENTER);
    play = false;
    ballX = width /2;
    text("Play in: " + time1, width/2, height/2);
    if (time1 <= 0) {
      ballY = height/2;
      play = true;
    }
  } else {
    timer1.reset(CountdownTimer.StopBehavior.STOP_AFTER_INTERVAL);
  }
}

// Method for movong ball
void moveBall() {
  if (play) {
    ballX += ballXDir;
    ballY += ballYDir;
  }
}

int steps = 10;

// Methods for moving Padel
void moveRight() {
  padelX= padelX +steps;
}
void moveLeft() {
  padelX = padelX -steps;
}

void movePadel() {
  if (right) {
    moveRight();
  }

  if (left) {
    moveLeft();
  }

  if (padelX > width-padelW ) {
    padelX = width-padelW;
  }

  if (padelX <= 0 ) {
    padelX = 0;
  }
}

// And the KeyListeneres
void keyPressed() {
  if ( keyCode == RIGHT) {
    right= true;
  } else {
    right= false;
  }

  if ( keyCode == LEFT) {
    left = true;
  } else {
    left = false;
  }

  if (key == ENTER ) {
    play = true;
  }

  // depricated
  if ( totalBricks <= 0) {
    if (keyCode == 'r' ||keyCode == 'R') {
      play = true;
    }
  }
  if ( ballY >= height- 20) {
    if (keyCode == 'r' ||keyCode == 'R') {
      ballY= height /2;
    }
  }
}

void keyReleased() {
  if ( keyCode == RIGHT) {
    right= false;
  }
  if ( keyCode == LEFT) {
    left = false;
  }
}
