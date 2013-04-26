public class DataGroup {
  int id;
  String name;
  int numOfArtworks;
  int numOfRows;
  int heightOfGroup;
  int widthOfGroup;
  PVector location;
  PVector lastUsedArtworkLocation;
  
  public DataGroup(int _id, String _name) {
    id = _id;
    name = _name;
    
    numOfArtworks = 0;
    numOfRows = 0;
    heightOfGroup = 0;
    widthOfGroup = width;
    
    location = new PVector(0, 0);
    
    if (name != null) {
      //There is a group heading so add some space for it before starting the artworks
      lastUsedArtworkLocation = new PVector(0, 25);
    } else {
      lastUsedArtworkLocation = new PVector(0, 0);      
    }
  }
  
  public PVector getNextArtworkLocation() {
    return null;
  }
  
  public void render() {
  }
}
