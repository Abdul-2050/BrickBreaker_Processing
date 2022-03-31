
// class for making Gift
int giftY=100;
public class Gift {
  int x, w, h;

  Gift(int x, int y, int w, int h ) {
    this.x= x;
    //this.y= y;
    this.w= w;
    this.h= h;
  }

  void makeGift() {
    fill(46, 204, 113);
    rect(x-10, giftY-20, w+20, 15, 5);
    fill(52, 73, 94);
    rect(x, giftY, w, h, 5);
    textSize(12);
    fill(255);
    textAlign(CENTER, CENTER);
    text("GIFT", x+20, giftY+20);
  }

  void move(int steps) {
    giftY += steps;
    if (giftY >= height)  giftY= height+100;
  }

  boolean intersects() {

    // depricated code
    
    //if (x >= padelX && x<= padelX+ padelW) {
    //  if (giftY+ h >= padelY && giftY+ h <= padelY) {
    //    free= true;
    //    padelW = 150;
    //    giftY= height+100;
    //  }
    //}

    Rectangle rect1= new Rectangle(x, giftY, w, h);
    Rectangle rect2= new Rectangle(padelX, padelY, padelW, padelH);

    if (rect1.intersects(rect2)) {
      free= true;
      padelW = 150;
      giftY= height+100;
    }

    return false;
  }
}
