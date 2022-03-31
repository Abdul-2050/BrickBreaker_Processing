

// class for genrating Bricks
public class BrickGenrator {
  int[][] brick ;

  int bw;
  int bh;
  int row;
  int col;
  int brickVal= 1;

  BrickGenrator(int row, int col, int w, int h) {
    brick = new int[row][col];

    for (int a=0; a< brick.length; a++) {
      for (int b=0; b< brick[a].length; b++) {
        brick[a][b] = brickVal;
        brick[0] [b]= 5;
        brick[1][b]= 4;
        brick[2][b]= 3;
        brick[3][b]= 2;
        brick[0][8]= 8;
      }
    }

    for (int a=0; a< brick.length; a++) {
      for (int b=1; b< brick[a].length-1; b++) {
        brick[brick.length-1] [b]= 0;
      }
    }

    this.bw= w/rows;
    this.bh= h/6;
    this.row= row;
    this.col = col;
  }

  void setW(int w) {
    this.bw= w/5;
  }

  public void show() {

    for (int a=0; a< brick.length; a++) {
      for ( int b=0; b< brick[a].length; b++) {
        if ( brick[a][b] > 0 ) {

          switch(brick[a] [b]) {
          case 8:
            {
              fill(random(255));
              break;
            }
          case  5:
            {
              fill(52, 73, 94);
              break;
            }
          case 4:
            {
              fill(142, 68, 173);
              break;
            }
          case 3:
            {
              fill(52, 152, 219);
              break;
            }
          case 2:
            {
              fill(250, 130, 49);
              break;
            }
          default :
            {
              try {
                fill(46, 204, 113);
                // fill( tint[a][b], tint[a][b], 100);
              }
              catch(Exception ex) {
              }
            }
          }

          stroke(0);
          strokeWeight(4);
          rect( b*bw +((width - bw*col)/2), a*bh+ 50, bw, bh, 5);
        }
      }
    }
  }

  void showText() {
    for (int a=0; a< brick.length; a++) {
      for (int b=0; b< brick[a].length; b++) {
        int brickX= b * bw + ((width - bw*col)/2);
        int brickY= a * bh +50;
        int brickW= bw;
        int brickH= bh;
        if (brick[a][b] > 0 && brick[a][b]<=5) {
          textSize(12);
          textAlign(CENTER, CENTER);
          fill(255);
          text("Hit " + brick[a][b], brickX+ brickW/2, brickY+ brickH/2);
        }

        if (brick[a][b] ==8 ) {
          textSize(12);
          textAlign(CENTER, CENTER);
          fill(255, 0, 0);
          text("GIFT ", brickX+ brickW/2, brickY+ brickH/2);
        }
      }
    }
  }

  void setBrickValue(int row, int col, int val) {
    brick[row] [col] =   brick[row] [col]-val;
    //brick[row] [col] =   0;
  }

  int getBrickValue() {
    for (int a=0; a< brick.length; a++) {
      for (int b=0; b< brick[a].length; b++) {
        return brick[a] [b];
      }
    }

    return 1;
  }

  void fillColor(int[] r, int[] g, int[] b ) {
    int rr = r[2];
    fill(r[1]);
  }
}
