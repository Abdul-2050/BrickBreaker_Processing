




BrickGenrator brick;
Intersection check;

// ball and padel directions
int padelX, padelY;
int ballX, ballY, ballXDir, ballYDir;

// controls
boolean right, left;

// color
int[][] tint;

// score
int score = 0;

// rows and col width
int rows = 5;
int col = 10;
int bw = width- width/2-100;

// total bricks
int  totalBricks = rows * col;
//int totalBricks = 2;


// runtime
boolean play= false;

void setup() {
  size(800, 500);
  surface.setResizable(true);

  brick = new BrickGenrator(rows, col, bw, 150);

  padelX= (width-125)/2;
  padelY= 450;
  ballX = width /2;
  ballY= height /2;
  ballXDir = 3;
  ballYDir = 6;


  tint= new int[rows][ col];
  for (int a=0; a< tint.length; a++) {
    for (int b=0; b< tint.length; b++) {
      tint[a][b] =(int) random(255);
      println(""+ tint[a] [b]);
    }
  }
}


void draw() {

  background(45, 152, 218);


  // to show bricks
  brick.show();
  bw= width- width/2-100;
  brick.setW(bw);


  // padel
  padelY = height- 50;
  fill(235, 59, 90);
  stroke(0);
  rect(padelX, padelY, 125, 20, 10);
  movePadel();

  // ball
  fill(250, 130, 49);
  stroke(75, 101, 132);
  ellipse(ballX, ballY, 20, 20);
  moveBall();
  check = new Intersection(ballX, ballY, padelX, padelY);
  check.ballIntersectsBoundries();
  check.ballIntersectsPadel();

  // brick
  ballIntersectsBrick();

  // score
  textSize(40);
  text("" + score, width- 60, 40);

  // win or lose state
  win();
  lose();
}

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
          brick.setBrickValue(a, b, 0);
          score+= 5;
          totalBricks --;
          if (ballX +19 <= rect1.x || ballX+1 >= rect1.x + rect1.width) {
            ballXDir = -ballXDir;
          } else {
            ballYDir =  -ballYDir;
          }

          break A;
        }
      }
    }
  }
}

void win() {
  if (totalBricks<= 0 ) {
    textAlign(CENTER, CENTER);
    text("You Win", width/2, height/2);
    text("Enter 'r' to replay", width/2+ 20, height/2+ 40);
    play = false;
    ballX = width /2;
    ballY= height /2;
  }
}

void lose() {
  if (ballY >= height-10 ) {
    textAlign(CENTER, CENTER);
    text("You lose", width/2, height/2);
    text("Enter 'r' to replay", width/2+ 20, height/2+ 40);
    play = false;
    ballX = width /2;
    // ballY= height /2;
  }
}

void moveBall() {
  if (play) {
    ballX += ballXDir;
    ballY += ballYDir;
  }
}

void moveRight() {
  padelX= padelX +10;
}
void moveLeft() {
  padelX = padelX -10;
}
void movePadel() {
  if (right) {
    moveRight();
  }

  if (left) {
    moveLeft();
  }

  if (padelX > width-125 ) {
    padelX = width-125;
  }

  if (padelX <= 0 ) {
    padelX = 0;
  }
}

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
  if ( totalBricks <= 0) {
    if (keyCode == 'r' ||keyCode == 'R') {
      rows = rows +2;
      brick = new BrickGenrator(rows, col, 300, 150);
      play = true;
      totalBricks =  rows * col;
      score =0 ;
      ballXDir =  4;
      ballYDir = 8;
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
