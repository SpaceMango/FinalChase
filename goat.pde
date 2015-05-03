public class Goat extends Animal {  
  private final float goatSeperation = 50, renderCircles = 10;
  private final static float maxTurn = 0.1, maxSpeed = 0.4, size = 3, FOV = 200, safeRadius = 80;
  
  Goat(PVector startPosition, Arena arena) {
    super(startPosition, maxTurn, maxSpeed, size, FOV, safeRadius, arena);
    this.arena = arena;
  }
  
  public void update(ArrayList<Wolf> wolves, ArrayList<Goat> goats, ArrayList<Animal> allAnimals) {
    updatePosition(wolves, goats, allAnimals);
  }
  
  //Gets the desired position in relation to other animals (to be chasing goats and staying away from wolves)
  private void updatePosition(ArrayList<Wolf> wolves, ArrayList<Goat> goats, ArrayList<Animal> allAnimals) {
    PVector desired = getDesiredMovement(wolves, goats);
    super.moveTowards(desired, allAnimals);
  }
  
  private PVector getDesiredMovement(ArrayList<Wolf> wolves, ArrayList<Goat> goats) {
    PVector desiredMovement = new PVector(0, 0);
    PVector desiredWithinArena = super.getDesiredWithinArena();
    desiredMovement.add(desiredWithinArena);
    PVector desiredGoatSeperation = super.getDesiredSeperationFrom(goats, goatSeperation);
    desiredMovement.add(desiredGoatSeperation);
    PVector desiredWolfSeperation = super.getDesiredSeperationFrom(wolves, FOV);
    desiredMovement.add(desiredWolfSeperation);
    if (desiredMovement.mag() == 0) {
      desiredMovement = super.getRandomDesired();
    }
    return desiredMovement;
  }
  
  public void render() {
    float centre = 240;
    float colourDiff = 80/renderCircles;
    for (float i = renderCircles; i > 0; i--) {
      float radius = size * i;
      fill(centre - (i*colourDiff));
      ellipse(position.x, position.y, radius, radius);
      noStroke();
    }
  }
  
}
