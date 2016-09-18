class Obstacle{
  
  public int x,y, width, height;
  public boolean collided = false;
  double gravity = 1, vitesse = 0;
  Gif gif;
  
  public Obstacle(int x,int y, int width, int height){
    this.x = x;
    this.y = y;
    this.width = width;
    this.height = height;
  }
  
  public void update(int vitesse){
    x -= vitesse;
    if(collided){
      if(vitesse<6) vitesse += gravity;
      if(y+vitesse>=429) y = 429;
      else y += vitesse;
    }
  }
  
}
