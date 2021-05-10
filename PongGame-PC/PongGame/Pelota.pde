class Pelota{
  private static final int R = 50;
  private float speedX = 5, speedY = 5;
  private float x = width/2, y = height/2;
  
  public Pelota()
  {
    if(Math.random()*1>0.5)
    {
      speedX *= -1;
    }
    if(Math.random()*1>0.5)
    {
      speedY *= -1;
    }
  }
  
  public void dibujar()
  {
    if(empezar)
    {
      fill(255, 255, 255);
      x += speedX;
      if(x > width || x < 0)
      {
        speedX *= -1;
      }
  
      y += speedY;
      if(y > height || y < 0)
      {
        speedY *= -1;
      }
      circle(x, y, R);
      fill(0, 0, 255);
    }
  }
  
  public float getY()
  {
    return y;
  }
  
  public float getX()
  {
    return x;
  }
  
  public float getRadio()
  {
    return R;
  }
  
  public void setUbicacion(float x, float y)
  {
    this.x = x;
    this.y = y;
  }
}
