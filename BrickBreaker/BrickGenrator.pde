

// class for genrating Bricks

public class BrickGenrator {


  int[][] brick ;

  int bw;
  int bh;
  int row;
  int col;

  BrickGenrator(int row, int col, int w, int h) {
    brick = new int[row][col];

    for (int a=0; a< brick.length; a++) {
      for (int b=0; b< brick[a].length; b++) {
        brick[a][b] = 1;
      }
    }

    this.bw= w/col;
    this.bh= h/col;
    this.row= row;
    this.col = col;
  }

  void setW(int w) {
    this.bw= w/5;
  }

  public void show() {

    for (int a=0; a< brick.length; a++) {
      for ( int b=0; b< brick[a].length; b++) {
        if ( brick[a][b] > 0) {
          
        //  brick[(int) random(2)][(int)random(5)] = 2;
          
          if ( brick[a][b] ==2) {
            fill(255, 0, 0);
          }else{
          
          try{
          fill( tint[a][b], tint[a][b], 100);
          }catch(Exception ex){}
          }
           
          stroke(247, 183, 49);
          strokeWeight(4);
          rect( b*bw +((width - bw*col)/2), a*bh+ 50, bw, bh, 5);
        }
      }
    }
  }

  void setBrickValue(int row, int col, int val) {
    brick[row] [col] = val;
  }

  void fillColor(int[] r, int[] g, int[] b ) {
    int rr = r[2];
    fill(r[1]);
  }
}
