public class Artwork {
 
  public int objectID;
  int imageCount;
  int division;
  int classification;
  int totalPageViews;
  int totalUniquePageViews;
  int totalEdits;
  int imagePermission;
  int orderNumber;
  LocalDate dateFirstViewed;
  LocalDate dateLastViewed;
  boolean onView;
  boolean isFeatured;
  
  PVector location; 
   
  private color c;
  private float colorAlive = 255.0;
  private float colorDead = 48.0;
  private float colorNow = colorAlive;
  private boolean isAlive = false;
  private float decayRate = 0.0;
  private int sizeMultiplier = 1;
  private int daysAlive = 0;
   
  public Artwork(String _data) {
    String bits[];    
    
    bits = split(_data, ",");
    
    objectID = int(bits[0]);
    totalPageViews = int(bits[1]);
    totalUniquePageViews = int(bits[2]);
    totalEdits = int(bits[3]);
    classification = int(bits[4]);
    imagePermission = int(bits[5]);
    imageCount = int(bits[6]);
    division = int(bits[7]);
    onView = boolean(bits[8]);
    isFeatured = boolean(bits[9]);
    if (bits[10].equals("NULL") == false) dateFirstViewed = new LocalDate(bits[10]);
    if (bits[11].equals("NULL") == false) dateLastViewed = new LocalDate(bits[11]); 
    orderNumber = int(bits[12]);   
    
    //Calculate the life of this artwork
    if ((dateFirstViewed != null) && (dateLastViewed != null)) {
      float days = Days.daysBetween(dateFirstViewed, dateLastViewed).getDays();
      if (days == 0) {
        decayRate = colorAlive - colorDead;
      } else if (days > 0) {
        decayRate = (colorAlive - colorDead)/days;
      }
    }
  }
  
  public void render() {
    if (isAlive == false) {
      isAlive = true;
      c = color(255, 204, 0);
      sizeMultiplier = 3;
    } else {
      c = color(colorNow, 0, 0);
      if (colorNow > colorDead) {
        colorNow-=decayRate;
      }
      sizeMultiplier = 1;
    }
      
    noStroke();
    fill(c);
    pushMatrix();
    translate(location.x, location.y);
    rect(0, 0, ARTWORK_SIZE * sizeMultiplier, ARTWORK_SIZE * sizeMultiplier);
    popMatrix();
    
    daysAlive+=1;
  }
  
  public void setLocation(PVector _l) {
    location = _l;
  }
}
