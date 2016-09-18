import gifAnimation.*;
import java.awt.Rectangle;

Bird bird;

int MONTE = 3, DESCENTE = 2, NONE = 0;
int lEcran=480, LEcran=800, blockWidth=50,soilHeight = 46;
int vitesseBg = 8, bgx = 0, tx = 0, score = 0, fontSize  = 20, distance = 0, second = 0, nitrosec =0, lastvbg = 4, relX=0, relY=0; 
int highScore = 0, bestDist = 0;

boolean start = false, gameOver = false, replaceHighScore = false, replaceBestDist = false;

//Desclare images
PImage background, terre, star, panel, reload, instructions;
ArrayList<PImage> lcstars = new ArrayList<PImage>();
Gif lamiBird, lamiBirdD, lamiBirdM;
Gif birdGiff, helicoGif, birdFalling, birdOnEarth;
Gif tap, warning;

//Desclare arrays
ArrayList<Obstacle> obstacles;
ArrayList<Star> stars;
ArrayList<helicopter> helicos;

//Declare font
PFont font;

void setup() {
  size(480,800);
  
  //Load game's scores
  String[] sc = readHighScore();
  highScore = Integer.valueOf(sc[0]);
  bestDist = Integer.valueOf(sc[1]);
  
  //Load bird
  bird = new Bird();
  bird.x = 200;
  bird.y = 200;
  bird.hauteur = 20;
  bird.longueur = 43;
  bird.soilHeight = soilHeight;
 
  //Load images + gifs + font
  background = loadImage("background.png");
  panel = loadImage("panel.png");
  reload = loadImage("reload.png");
  instructions = loadImage("instructions.png");
  lcstars.add(loadImage("0stars.png"));
  lcstars.add(loadImage("1stars.png"));
  lcstars.add(loadImage("2stars.png"));
  lcstars.add(loadImage("3stars.png"));
  terre = loadImage("terre.png");
  star = loadImage("star.png");
  tap = new Gif(this, "tap.gif");
  warning = new Gif(this, "warning.gif");
  helicoGif = new Gif(this, "helico.gif");
  birdFalling = new Gif(this, "birdfalling.gif");
  birdOnEarth = new Gif(this, "birdone.gif");
  birdGiff = new Gif(this, "bird.gif");
  lamiBird = new Gif(this, "lamibird.gif");
  lamiBirdD = new Gif(this, "lamibirdbottom.gif");
  lamiBirdM = new Gif(this, "lamibirdtop.gif");
  birdGiff.play();
  birdFalling.play();
  lamiBird.play();
  tap.play();
  helicoGif.play();
  lamiBirdD.play();
  lamiBirdM.play();
  font = loadFont("PipeDream-48.vlw");
  
  //Load obstacle
  obstacles = new ArrayList<Obstacle>();
  helicos = new ArrayList<helicopter>();
  stars = new ArrayList<Star>();
  
  String[] obst = readObstacles();
  String[] sts = readStars();
  int obstacleCount = (int)random(300,500);
  
  int x = LEcran;
  for(int i=0; i<obstacleCount; i++){
    if(i%5 == 0 && i>5){
      helicos.add(new helicopter(x, (int)random(10,lEcran-120-soilHeight-100),115,80));
      x += 300;
  } else if(i%4 == 0){
      ArrayList<Star> stas = readStar(x, sts[(int)random(0,sts.length-1)]);      
      for(int a=0; a<stas.size();a++){
         stars.add(stas.get(a));
       }
       x += getStarWidth(stas)+200;
    }
    else{
       ArrayList<Obstacle> obsts = readObstacle(x, obst[(int)random(0,obst.length-1)]);
       for(int a=0; a<obsts.size();a++){
         obstacles.add(obsts.get(a));
       }
       x += getObstacleWidth(obsts)+200;
    }
    
  }

}

boolean clickIn(int x, int y, int w, int h){
  if(mouseX> x && mouseX<x+w && mouseY>y && mouseY<y+h) return true;
  else return false;
}

void draw(){
  background(color(255,255,255));
  fill(color(0,0,150));
  
   if (mousePressed && (mouseButton == LEFT)) {
      if(!gameOver){
        start = true;
        bird.saute();
      }
      else if(gameOver){
        if(score>highScore && !replaceHighScore){
          highScore = score;
          String[] filetext = {String.valueOf(highScore), String.valueOf(bestDist)};
          saveStrings("data.txt", filetext);
          replaceHighScore = true;
        }
        if(distance>bestDist && !replaceBestDist){
          bestDist = distance;
          String[] filetext = {String.valueOf(highScore), String.valueOf(bestDist)};
          saveStrings("data.txt", filetext);
          replaceBestDist = true;
        }
        if(clickIn(relX, relY, 44, 45)){
          start = false;
          
          //Load game's scores
          String[] sc = readHighScore();
          highScore = Integer.valueOf(sc[0]);
          bestDist = Integer.valueOf(sc[1]);
          //Load bird
          bird = new Bird();
          bird.x = 200;
          bird.y = 200;
          bird.hauteur = 20;
          bird.longueur = 43;
          bird.soilHeight = soilHeight;
          gameOver = false;
          vitesseBg = 4;
          bgx = 0;
          tx = 0;
          score = 0;
          distance = 0; 
          second = 0; 
          nitrosec =0; 
          lastvbg = 4;  
          //Load obstacle
          obstacles = new ArrayList<Obstacle>();
          helicos = new ArrayList<helicopter>();
          stars = new ArrayList<Star>();
          
          String[] obst = readObstacles();
          String[] sts = readStars();
          int obstacleCount = (int)random(300,500);
          
          int x = LEcran;
          for(int i=0; i<obstacleCount; i++){
            if(i%5 == 0 && i>5){
              helicos.add(new helicopter(x, (int)random(10,lEcran-120-soilHeight-100),115,80));
              x += 300;
          } else if(i%4 == 0){
              ArrayList<Star> stas = readStar(x, sts[(int)random(0,sts.length-1)]);      
              for(int a=0; a<stas.size();a++){
                 stars.add(stas.get(a));
               }
               x += getStarWidth(stas)+200;
            }
            else{
               ArrayList<Obstacle> obsts = readObstacle(x, obst[(int)random(0,obst.length-1)]);
               for(int a=0; a<obsts.size();a++){
                 obstacles.add(obsts.get(a));
               }
               x += getObstacleWidth(obsts)+200;
            }
            
          }
        }
      }
    }
    if (keyPressed == true && key == ' ' && !gameOver && score>=5 && !bird.nitro) {
      bird.goForward();
      bird.nitro = true;
      nitrosec = 0;
      lastvbg = vitesseBg;
      if(vitesseBg<=6) vitesseBg = 10;
      else vitesseBg *= 1.5;
      score -= 5;
    }
    
 if(start && !bird.crashed){
   updateGameStarted();
  } 
  else if(bird.crashed){
    gameOver = true;
  }
  else if(gameOver){
    updateGameOver();
  }  
  
  image(background, bgx,0);
  image(background, bgx+LEcran,0);
  image(terre, tx,lEcran-soilHeight);
  image(terre, tx+LEcran,lEcran-soilHeight);
  
  if(bird.state == MONTE) image(lamiBirdM,bird.x-8,bird.y-20);
  else if(bird.state == DESCENTE) image(lamiBirdD,bird.x-8,bird.y-20);
  else image(lamiBird,bird.x-8,bird.y-20);
  
  if(!start && !gameOver){
    image(tap,bird.x+50,bird.y+20);
    image(instructions, LEcran-170, lEcran-soilHeight-100);
  }
  for(int i=0;i<obstacles.size();i++){
    Obstacle o = obstacles.get(i);
    if(o.x<=LEcran){
      if(!o.collided) image(birdGiff, o.x-5, o.y-3);
      else if(o.collided && o.y<429) image(birdFalling, o.x-5, o.y-3);
      else image(birdOnEarth, o.x-5, o.y-3);
    }
  } 
  for(int i=0;i<stars.size();i++){
    Star s = stars.get(i);
    
    if(s.x<=LEcran){
      rect(s.x,s.y,s.w,s.h);
      image(star,s.x-6,s.y-7);
    } 
  } 
  for(int i=0; i<helicos.size(); i++){
    helicopter h = helicos.get(i);
    if(h.x>LEcran && h.x<LEcran+150*vitesseBg) image(warning,LEcran-40,h.y+h.height/2);
    if(h.x<=LEcran) image(helicoGif,h.x-20,h.y-20);
  }
    
  if(!gameOver){
    fill(255, 255, 255);
    textFont(font, 20);
    if(score>highScore) text("Score: "+String.valueOf(score)+" (High score)", 10, fontSize+10);
    else text("Score: "+String.valueOf(score), 10, fontSize+10);
    if(distance>bestDist) text("Distance: "+String.valueOf(distance)+"m (Best distance)", 10, (fontSize*2+10));
    else text("Distance: "+String.valueOf(distance)+"m", 10, (fontSize*2+10));
    
    if(start){
      textFont(font, 35);
    }
  } else{
    int Xbox = (800-305)/2, Ybox = (480-304)/2;
    image(panel, Xbox, Ybox);
    textFont(font, 35);
    fill(color(196,72,72));
    if(score/highScore > 0.9) image(lcstars.get(3), Xbox+102,Ybox+75);
    else if(score/highScore > 0.6) image(lcstars.get(2), Xbox+102,Ybox+75);
    else if(score/highScore > 0.2) image(lcstars.get(1), Xbox+102,Ybox+75);
    else image(lcstars.get(0), Xbox+102,Ybox+75);
    text("Game Over", Xbox+63, Ybox+50); 
  
    fill(0);
    textFont(font, 30);
    text("Score: "+score, Xbox+85, Ybox+ 150);
    textFont(font, 20);
    fill(color(59,29,91));
    text("Distance: "+distance+ "m", Xbox+50, Ybox+ 200);
    text("High score: "+highScore, Xbox+50, Ybox+ 230);
    text("Best distance: "+bestDist+"m", Xbox+50, Ybox+ 260);
    image(reload, Xbox+200,Ybox+275);
    relX = Xbox+200;
    relY = Ybox+275;
  }
}

public void updateGameOver(){
  bird.update();
}

public void updateGameStarted(){
   bird.update();
   
   //Obstacles terminés
   if(obstacles.size() == 0){
         //Load obstacle
          obstacles = new ArrayList<Obstacle>();
          helicos = new ArrayList<helicopter>();
          stars = new ArrayList<Star>();
          
          String[] obst = readObstacles();
          String[] sts = readStars();
          int obstacleCount = (int)random(300,500);
          
          int x = LEcran;
          for(int i=0; i<obstacleCount; i++){
            if(i%5 == 0 && i>5){
              helicos.add(new helicopter(x, (int)random(10,lEcran-120-soilHeight-100),115,80));
              x += 300;
          } else if(i%4 == 0){
              ArrayList<Star> stas = readStar(x, sts[(int)random(0,sts.length-1)]);      
              for(int a=0; a<stas.size();a++){
                 stars.add(stas.get(a));
               }
               x += getStarWidth(stas)+200;
            }
            else{
               ArrayList<Obstacle> obsts = readObstacle(x, obst[(int)random(0,obst.length-1)]);
               for(int a=0; a<obsts.size();a++){
                 obstacles.add(obsts.get(a));
               }
               x += getObstacleWidth(obsts)+200;
            }
            
          }
   }
   
   if(bird.x+bird.longueur<0){
     gameOver = true;
     start = false;
   }
   //Gestion du nitro
   if(bird.nitro){
     if(nitrosec == 80){
       nitrosec = 0;
       vitesseBg = lastvbg;
       bird.nitro = false;
     }
     else nitrosec++;
   }
   
   //Gestion de l'arrière plan
   if(second == 15-Math.abs(vitesseBg)){
     if(distance%(50*vitesseBg) == 0 && vitesseBg <= 10) vitesseBg++;
     distance++;
     second = 0;
   } 
   else if(second>=0 && second <15-Math.abs(vitesseBg)) second++;
   else second = 0;
     if(bgx-vitesseBg/3 <= -LEcran) bgx=0;
    else bgx -= vitesseBg/3;
     if(tx-vitesseBg <= -LEcran) tx=0;
    else tx -= vitesseBg;
    
    //Gestion des obstacles
    for(int i=0;i<obstacles.size();i++){
     Obstacle o = obstacles.get(i);
     if(o.x<LEcran){
       if(o.collided) o.update(vitesseBg);
       else o.update((int)(vitesseBg*0.6));
     }
     else if(o.x+o.width+50<0) obstacles.remove(i);
     else o.update((int)(vitesseBg*0.7));
     if(checkCollision(bird, o) && !o.collided && !bird.nitro){
       bird.slow();
       o.collided = true;
     }
    }
    
    //Gestion des helicos
    for(int i=0; i<helicos.size(); i++){
      helicopter h = helicos.get(i);
      if(checkCollision(bird, h) && !bird.nitro){
        bird.saute = false;
      }
      if(h.x < LEcran) h.update((int)(vitesseBg *4));
      else h.update((int)(vitesseBg));
      
      if(h.x > LEcran+50 && bird.y<lEcran-soilHeight-h.height-10) h.y = bird.y;
    }
    
    //Gestion des étoiles
    for(int i=0;i<stars.size();i++){
      Star s = stars.get(i);
      if(checkCollision(bird, s)){
        score++;
        stars.remove(i);
      }
      s.update((int)(vitesseBg*0.7));
    }
}


boolean checkCollision(Bird bird, Obstacle obstacle){
 Rectangle b = new Rectangle(bird.x,bird.y,bird.longueur,bird.hauteur);
 Rectangle o = new Rectangle(obstacle.x,obstacle.y,obstacle.width,obstacle.height);
 if (b.intersects(o)) return true;
 else return false;
}


boolean checkCollision(Bird bird, Star star){
 Rectangle b = new Rectangle(bird.x,bird.y,bird.longueur,bird.hauteur);
 Rectangle o = new Rectangle(star.x,star.y,star.w,star.h);
 if (b.intersects(o)) return true;
 else return false;
}

boolean checkCollision(Bird bird, helicopter helico){
 Rectangle b = new Rectangle(bird.x,bird.y,bird.longueur,bird.hauteur);
 Rectangle o = new Rectangle(helico.x,helico.y,helico.width,helico.height);
 if (b.intersects(o)) return true;
 else return false;
}

String[] readHighScore(){
  String[] lines = loadStrings("data.txt");
  return lines;
}

 ArrayList<Star> readStar(int x, String obstacle){
  String[] map = obstacle.split("-");
  ArrayList<Star> obsts = new ArrayList<Star>();
  int lastY = (int) random(10,480-map.length*21-soilHeight-50);
  
  for(int i=0; i<map.length; i++){
    String[] chars = map[i].split("");
    int lastX = x;
    
    for(int a=0;a<chars.length;a++){
      if(chars[a].equals("1")){
          Star s = new Star();
          s.x = lastX;
          s.y = lastY;
          s.h = 10;
          s.w = 10;
          obsts.add(s);
          lastX +=25;
        }
        else if(chars[a].equals("0")){
          lastX +=25;
        }
    }
    lastY += 25;
  }
  return obsts;
}

ArrayList<Obstacle> readObstacle(int x, String obstacle){
  String[] map = obstacle.split("-");
  ArrayList<Obstacle> obsts = new ArrayList<Obstacle>();
  int lastY = (int) random(5,480-map.length*35-soilHeight-5);
  
  for(int i=0; i<map.length; i++){
    String[] chars = map[i].split("");
    int lastX = x;
    
    for(int a=0;a<chars.length;a++){
       if(chars[a].equals("1")){
          Obstacle o = new Obstacle(lastX, lastY, 43, 19);
          o.gif = birdGiff;
          obsts.add(o);
          lastX += 50;
        }
        else if(chars[a].equals("0")){
          lastX += 50;
        }
    }
    
    lastY += 30;
  }
  return obsts;
}

String[] readStars(){
  String[] lines = loadStrings("stars.txt");
  String ob = new String();
  for(int i=0; i<lines.length; i++){
    ob += lines[i];
  }
  //Split the text
  String[] obstacles = ob.split("\\|");
  return obstacles;
}

String[] readObstacles(){
  String[] lines = loadStrings("obstacles.txt");
  String ob = new String();
  for(int i=0; i<lines.length; i++){
    ob += lines[i];
  }
  //Split the text
  String[] obstacles = ob.split("\\|");
  return obstacles;
}

int getObstacleWidth(ArrayList<Obstacle> obsts){
  int lastX = 0;
  int firstX = 0;
  for(int i=0; i<obsts.size(); i++){
    if(obsts.get(i).x<firstX || firstX == 0) firstX = obsts.get(i).x;
    if(obsts.get(i).x+obsts.get(i).width>lastX) lastX = obsts.get(i).x+obsts.get(i).width;
  }
  return lastX-firstX;
}
int getStarWidth(ArrayList<Star> obsts){
  int lastX = 0;
  int firstX = 0;
  for(int i=0; i<obsts.size(); i++){
    if(obsts.get(i).x<firstX || firstX == 0) firstX = obsts.get(i).x;
    if(obsts.get(i).x+obsts.get(i).w>lastX) lastX = obsts.get(i).x+obsts.get(i).w;
  }
  return lastX-firstX;
}