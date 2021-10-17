/** ******************** 
 Class: CISC 1600 TR2, FALL 2020
 INTRODUCTION TO MULTIMEDIA COMPUTING
 Your Name:MOHAMMED FADEL
 Note: Fill in the appropriate ******************** */

/** ********************
 Variables:
 Variables provide a way to save information within your sketch and are used to control the size, position, shape, etc. of what you are drawing.
 ******************** */
int mode;//1: start screen, 2: game, 3: game over screen
PImage bg;//background for start and end screen
PImage bg2;//background for when game is being played
PFont h1;//largest font
PFont h2;//second largest font
PFont h3;//second smalled font
PFont h4;//smallest font
int score=0;//will calculate the user's score
float sizeW=100;//the paddles' width which will become smaller during the game
float sizeO=50;//the ball's
float minus=0.9995;//the rate in which the ball and paddles will shrink by
Ball gameBall;//the ball
Paddle1 paddle1;// the top paddle
Paddle2 paddle2;// the buttom paddle
/** ********************
 
 setup():
 Use setup() to specify things that need to
 ******************** */
void setup() {
  frameRate(35);
  size(450, 450);
  bg = loadImage("BackgroundBg.jpg");
  bg2 = loadImage("BackgroundBg2.jpg");
  background(bg);
  gameBall= new Ball();// ball
  paddle1= new Paddle1();// top paddle
  paddle2= new Paddle2();//buttom paddle
  rectMode(CENTER);//center all rectangles, such as the paddles
  ellipseMode(CENTER);// centers the ball
  mode = 1;//start screen
  h1 = createFont("Times-Bolditalic", 75);//title font
  h2 = createFont(".SFNSText", 60);// game over font
  h3 = createFont("Verdana", 50);//buttons font
  h4 = createFont("Verdana", 12);// instructions font
}
/** ********************
 Use draw() to specify things that you want
 repeatedly. NOTE: draw() must be present in your program, even if it is left empty.
 ******************** */
void draw() {
  if (mode == 1) {
    introScreen();
  } else if (mode == 2) {
    theGame();
    hitPad();
  } else if (mode == 3) {
    gameOverScreen();
  } else {
    background(255, 0, 0);
    println("MODE ERROR");
  }
}
/** ********************
 Event Listeners:
 Use event-listeners like keyPressed() to allow users of your program to cause things to happen.
 ******************** */
/** ********************
 Custom Functions:
 Functions are sections of code that you create and name.
 ******************** */
/**
 *********************/
void introScreen() {//The intro screen

  background(bg);

  textFont(h1);//title of the game 
  textAlign(CENTER);
  fill(#000000);
  text("Live Ball", 225, 100);

  textFont(h4);//instructions of the game 
  textAlign(CENTER);
  fill(#ffffff);
  text("1. Use mouse to move the paddles sideways", 225, 150);
  text("2. Keep the ball alive or within borders", 225, 175);
  text("3. Score is based on how long the ball is kept alive", 225, 200);
  text("4. Press play to start", 225, 225);

  stroke(0); //Play button
  strokeWeight(1);
  fill(#ff00ff);
  rect(225, 337, 120, 60);
  textFont(h3);
  textAlign(CENTER);
  fill(#000000);
  text("Play", 225, 350); 
  if (mousePressed == true) {//making the Play button be able to be clicked on with the mouse
    if (mouseX <=285 && mouseX >= 165 && mouseY <=367 && mouseY >= 307) {
      score=0;
      mode=2;
    }
  }
}
void theGame() {
  background(bg2);//background

  stroke(#f0f00f);//score display section
  strokeWeight(1);
  fill(#0fff00);
  rect(409, 439, 80, 20);
  textFont(h4);
  textAlign(CENTER);
  fill(#000000);
  text(score, 410, 445);

  gameBall.show();//shows ball
  gameBall.act();//animates the ball
  paddle1.show();//shows top paddle
  paddle1.act();//animates top paddle
  paddle2.show();//show buttom paddle
  paddle2.act();//animates buttom paddle
}
void gameOverScreen() {  //end of game screen
  background(bg);

  textFont(h2);//the "Game Over" text
  textAlign(CENTER);
  fill(#000000);
  text("Game Over", 225, 100); 

  stroke(#f0f00f); //score display section
  strokeWeight(1); 
  fill(#0fff00);         
  rect(225, 225, 80, 20);
  textFont(h4);
  textAlign(CENTER);
  fill(0);
  text(score, 225, 230);
  fill(#ffffff);
  text("Score:", 160, 230);

  stroke(0); //Replay button
  strokeWeight(1); 
  fill(#ff00ff);
  rect(225, 337, 170, 60);
  textFont(h3);
  textAlign(CENTER);
  fill(#000000);
  text("Replay", 225, 350); 
  if (mousePressed == true) {//making the Replay button be able to be clicked on with the mouse
    if (mouseX <=310 && mouseX >= 140 && mouseY <=367 && mouseY >= 307) {
      reset();//resets settings so the game will restart the way it first started
    }
  }
}
void reset() {//resets settings to be able to replay the game they way you first play it
  score=0;//reseting the score to 0
  sizeW=100;//reseting the size of the paddles
  sizeO=50;//reseting the size of the ball
  minus=0.9995;//reseting the rate of size change
  mode=2;//goes back to game screen
  gameBall.x=width/2;//resets ball's location
  gameBall.y=height/2;//resets ball's location
  gameBall.vx=3;//resets ball's speed
  gameBall.vy=4;//resets ball's speed
}
class Ball { //creates the ball
  float x, y, vx, vy;
  Ball() {
    x = width/2;//balls start x coordinate
    y= height/2;//balls start y coordinate
    vx = 4;// x velocity
    vy = 4;// y velocity
  }
  void show() {//design of the ball
    fill(#0000ff);
    stroke(#000000);
    ellipse(x, y, sizeO, sizeO);
  }
  void act() {//animation of the ball
    score+=1;//increases user's score
    x+= vx;//changing ball x coordinate
    y+= vy;//changing ball y coordinate
    if (x<sizeO) {//bounces ball from left wall
      vx = -vx+.3;//changes ball velocity while increasing
      score+=1;//increase user's score
    }
    if (x > width-sizeO) {//bounces ball from right wall
      vx = -vx-.3;//changes ball velocity while increasing
      score+=1;//increases user's score
    }
    if (y<-sizeO || y > 450+sizeO) {//ends game when ball goes passes the ceiling or the floor
      mode=3;
    }
    if (minus<1.01) {//changes ball size
      ellipse(x, y, sizeO, sizeO);
      sizeO*=minus;
      if (sizeW<20) {//changes ball size st a different rate
        minus=1;
        score+=1;//increases user's score
      }
    }
  }
}

void hitPad() {//making paddles a solid object
  int w = int(sizeO + sizeW)/2; //w is the width between paddle and ball when incontact
  int h = int(sizeO + 10)/2;  //w is the width between paddle and ball when incontact
  //Minkowski sum when the ball hits the top paddle 
  if ((gameBall.y >= paddle1.y - h) && (gameBall.y <= paddle1.y + h) && (paddle1.x >= gameBall.x - w) && (paddle1.x <= gameBall.x + w)) { 
    if (gameBall.y <= paddle1.y) {
      gameBall.y += abs(gameBall.y - paddle1.y) - h;//side hits, will determine if ball goes up or down
    } else { 
      gameBall.y -= abs(gameBall.y - paddle1.y) - h;//side hits, will determine if ball goes up or down
    } 
    if (sizeW>20)//changes balls velocity when ball shrinks
      gameBall.vy *= -1-0.05;//changes balls y velocity
    else //changes balls velocity when ball stops shrinking
    gameBall.vy *= -1-0.005;//changes balls y velocity
    if (abs(gameBall.x - paddle1.x) < (w/2) ) //when ball hit the center of the paddle
    {
      if (abs(gameBall.vx)>1)
        gameBall.vx*=.9;// when x velocity > 1 it gets multiplies by .9
      else
        gameBall.vx=1;// keeps the x-velocity at 1
    } else if (  (gameBall.vx < 0 && gameBall.x < paddle2.x) || (gameBall.vx > 0 && gameBall.x > paddle2.x) )
    {//when ball hit the left or right part of the paddle
      gameBall.vx *=1.8;//increases x velocity
    } else {
      gameBall.vx *=-1.8;//reflects x-velocity
    }
  }
  //Minkowski sum when the ball hits the buttom paddle 
  if ((gameBall.y >= paddle2.y - h) && (gameBall.y <= paddle2.y + h) && (paddle2.x >= gameBall.x - w) && (paddle2.x <= gameBall.x + w)) {
    if (gameBall.y <= paddle2.y) {
      gameBall.y += abs(gameBall.y - paddle2.y) - h;//side hits, will determine if ball goes up or down
    } else { 
      gameBall.y -= abs(gameBall.y - paddle2.y) - h;////side hits, will determine if ball goes up or down
    } 
    if (sizeW>20)//changes balls velocity when ball shrinks
      gameBall.vy *= -1-0.05;//changes balls y velocity
    else//changes balls velocity when ball stops shrinking
      gameBall.vy *= -1-0.005;//changes balls y velocity
    if (abs(gameBall.x - paddle2.x) < (w/2) ) {//when ball hit the center of the paddle
      if (abs(gameBall.vx)>1)
        gameBall.vx*=.9;// when x velocity > 1 it gets multiplies by .9
      else
        gameBall.vx=1;// keeps the x-velocity at 1
    } else if (  (gameBall.vx < 0 && gameBall.x < paddle2.x) || (gameBall.vx > 0 && gameBall.x > paddle2.x) ) 
    {//when ball hit the left or right part of the paddle
      gameBall.vx *=1.8;//increases x velocity
    } else {
      gameBall.vx *=-1.8;//increases x velocity
    }
  }
}
class Paddle1 {//creates top paddle
  float x, y;

  Paddle1() {
    x=width/2;//paddles x coordinate
    y=30;//paddles y coordinate
  }
  void show() {
    rect(x, y, sizeW, 10);//paddle design
  }
  void act() {//paddle animation
    x= mouseX;//mouse moves paddle sideways
    if (minus<1.01) {//shrinks paddle
      rect(x, y, sizeW, 10);
      sizeW*=minus;
      if (sizeW<20) {
        {//stops shrinkin
          minus=1;
          score+=1;
        }
      }
    }
  }
}
class Paddle2 {
  float x, y;

  Paddle2() {//paddle animation
    x=width/2;//paddles x coordinate
    y=420;//paddles y coordinate
  }
  void show() {
    rect(x, y, sizeW, 10);//paddle design
  }
  void act() {
    x= mouseX;//mouse moves paddle sideways
    if (minus<1.01) {//shrinks paddle
      rect(x, y, sizeW, 10);
      sizeW*=minus;
      if (sizeW<20) {//stops shrinkin
        minus=1;
        score+=1;//increases user's score
      }
    }
  }
}
