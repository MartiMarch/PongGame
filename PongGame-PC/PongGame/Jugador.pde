class Jugador{
  private float posicionY = (height/2) - ((height/5)/2), posicionX, margen;
  private static final int N = 12;
  private float W = 20, H = height / 5;
  
  public Jugador(int posicionX, float radio)
  {
    this.posicionX = posicionX;
    margen += radio;
  }
  
  public void dibujar()
  {
    fill(255, 255, 255);
    stroke(0);
    rect(posicionX, posicionY, W, H);
  }
  
  public void setY(String movimiento)
  {
    if(movimiento.equals("UP"))
    {
      if(posicionY - N > -5)
      {
        posicionY -= N;
      }
    }
    else if (movimiento.equals("DOWN"))
    {
      if(posicionY + N < height - (height/5) + 5)
      {
        posicionY += N;
      }
    }
  }
  
  public float getW()
  {
    return W;
  }
  
  public boolean estaDentro(float x, float y)
  {
    boolean dentro = false;
    if(x >= posicionX - margen && x <= posicionX + margen + W && y  >= posicionY && y <= posicionY + H)
    {
      dentro = true;
    }
    return dentro;
  }
  
  public void setPosicion(int y)
  {
    posicionY = y;
  }
  
  public float getPosicion()
  {
    return posicionY;
  }
}
