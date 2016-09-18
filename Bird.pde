class Bird {
  int MONTE = 2, DESCENTE = 1, NONE = 0;
  public int state = NONE;
  public int x,y,hauteur,longueur,soilHeight;
  private double vitesse = 0, acceleration = 0.5, force = 0, forcex = 0;
  public boolean crashed = false, saute = true, nitro = false;
  
  public void update(){
    if(y+hauteur<480-soilHeight && y >= 0){
        if(force>0 || force - acceleration >0){
          vitesse -= force;
          force -= acceleration;
        } else force = 0;
          if(vitesse + acceleration < 10) vitesse += acceleration;
          else vitesse = 10;
          y += vitesse;
          if(x<=200 && x+forcex<200)x += forcex;
          else x=200;
          if(forcex>0) forcex--;
          else if(forcex<0) forcex++;
          if(vitesse<0) state = MONTE;
          else if(vitesse>=0) state = DESCENTE;
      }
    else if(y <= 0){
      y = 1;  
      force = 0;
      vitesse = 0;
    }
    else{
      state = DESCENTE;
      y = 480-soilHeight-hauteur/2;
      crashed = true;
    }
    if(x+longueur/2<0){
     slow();
   }
  }
  
  public void saute(){
    if(force == 0 && vitesse > -force && saute){
      force = 2.5;
      vitesse = 0;
    }  
  }
  
  public void slow(){
    forcex -= 5;
  }
  
  public void goForward(){
    if(200-x>0) forcex += 5;
  }
}
