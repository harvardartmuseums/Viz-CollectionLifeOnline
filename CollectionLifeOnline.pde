//Info on creating date ranges: http://stackoverflow.com/questions/2689379/how-to-get-a-list-of-dates-between-two-dates-in-java

final static int ARTWORK_SIZE = 1;
final static int ARTWORK_SPACING = 1;

PFont fontA;
List<LocalDate> dates = new ArrayList<LocalDate>();
Artwork artworks[];
int i = 0;
boolean paused = false;
boolean recording = false;

void setup() {
  size(1280, 720);

  //Load data about the artworks
  artworks = loadArtworkData();

  //arrangeArtworks();
  arrangeArtworksByDivision();

  //Create a list of dates for the time series
  LocalDate startDate = new LocalDate("2009-05-01");
  LocalDate endDate = new LocalDate("2013-02-20");

  int days = Days.daysBetween(startDate, endDate).getDays();
  for (int i=0; i < days; i++) {
      LocalDate d = startDate.withFieldAdded(DurationFieldType.days(), i);
      dates.add(d);
  }

  //Prepare the remaining odds and ends
  fontA = loadFont("CourierNew36.vlw");
  textFont(fontA, 15);
}

void draw() {
  if (paused) {
    //do nothing
  } else {
    background(0);
    
    int countOfObjectsViewed = 0;
    
    LocalDate currentDate = dates.get(i);
    
    //Render the old and decaying artworks first
    for (int i=0; i < artworks.length; i++) {
      Artwork a = artworks[i];
      
      if (a.dateFirstViewed != null) {
        if (a.dateFirstViewed.isBefore(currentDate)) {
          a.render();          
          countOfObjectsViewed+=1;
        }      
      }
    }    
    
    //Render the new artworks second so they display on top of the old artworks
    for (int i=0; i < artworks.length; i++) {
      Artwork a = artworks[i];
      
      if (a.dateFirstViewed != null) {
        if (a.dateFirstViewed.isEqual(currentDate)) {
          a.render();          
          countOfObjectsViewed+=1;
        }      
      }
    }    
    
    //Render the data group info
    fill(128);
    //[DO SOMETHING HERE WITH THE HASHMAP]
    text("Asian and Mediterranean Art", 8, 16);
    text("European and American Art", 8, 186);
    text("Modern and Contemporary Art", 8, 423);
    
    //Render the information panel
    fill(255);
    text(dates.get(i).toString("yyyy-MM-dd") + ", " + countOfObjectsViewed + " of " + artworks.length + " objects viewed at least once", 8, height-6);    
    
    //Save the frames for output to a video file
    if (recording) {
      saveFrame("output/frames####.png");  
    }
        
    i++;
    if (i >= dates.size()) exit();
  }

}

void arrangeArtworks() {
  //Arrange the artworks
  int y = 0;
  int x = 0;
  for (int i=0; i < artworks.length; i++) {
    Artwork a = artworks[i];
    a.setLocation(new PVector(x, y));
    
    x = x + ARTWORK_SIZE + ARTWORK_SPACING;
    if (x >= width) {
      x = 0;
      y = y + ARTWORK_SIZE + ARTWORK_SPACING;
    }
  }
}


void arrangeArtworksByDivision() {
  //calculate the x,y position of each division block
  int countByDivision[] = {0, 0, 0};
  
  HashMap<Integer, DataGroup> dataGroups = loadDataGroups();
    
  for (int i=0; i < artworks.length; i++) {
    if (artworks[i].division > 0) {
      dataGroups.get(artworks[i].division).numOfArtworks+=1;
    }
    
    if (artworks[i].division == 16) countByDivision[0]+=1;
    if (artworks[i].division == 17) countByDivision[1]+=1;
    if (artworks[i].division == 18) countByDivision[2]+=1;    
  }
  
  int artworksPerRow = width / (ARTWORK_SIZE + ARTWORK_SPACING);
  int rowsByDivision[] = {0, 0, 0};
  rowsByDivision[0] = countByDivision[0] / artworksPerRow;
  rowsByDivision[1] = countByDivision[1] / artworksPerRow;  
  rowsByDivision[2] = countByDivision[2] / artworksPerRow;

  for (DataGroup d: dataGroups.values()) {
    d.numOfRows = d.numOfArtworks / artworksPerRow;
    d.heightOfGroup = d.numOfRows * (ARTWORK_SIZE + ARTWORK_SPACING) + 25; //The 25 is added to make room for the group label above the artwork pixels

    println("Division " + d.id + ": " + d.numOfArtworks + " Rows: " + d.numOfRows + " Height: " + d.heightOfGroup + " Name: " + d.name);    
  }
  
  int blockHeightByDivision[] = new int[3];
  blockHeightByDivision[0] = rowsByDivision[0] * (ARTWORK_SIZE + ARTWORK_SPACING);
  blockHeightByDivision[1] = rowsByDivision[1] * (ARTWORK_SIZE + ARTWORK_SPACING);
  blockHeightByDivision[2] = rowsByDivision[2] * (ARTWORK_SIZE + ARTWORK_SPACING);  

  println("Division 16: " + countByDivision[0] + " Rows: " + rowsByDivision[0] + " Height: " + blockHeightByDivision[0]);
  println("Division 17: " + countByDivision[1] + " Rows: " + rowsByDivision[1] + " Height: " + blockHeightByDivision[1]);
  println("Division 18: " + countByDivision[2] + " Rows: " + rowsByDivision[2] + " Height: " + blockHeightByDivision[2]);  


  int x[] = {0, 0, 0};
  int y[] = {25, 25 + blockHeightByDivision[0] + 25, 25 + blockHeightByDivision[0] + 25 + blockHeightByDivision[1] + 25};
  println(y[0] + ", " + y[1] + ", " + y[2]);
  for (int i=0; i < artworks.length; i++) {
    /*
    if (artworks[i].division > 0) {
      Artwork a = artworks[i];
      DataGroup d = dataGroups.get(a.division);
      d.location.x
      a.setLocation(dataGroups.get(a.division).getNextArtworkLocation());      
    } */   
    
    int positionIndex = 0;
    Artwork a = artworks[i];
    if (a.division == 16) positionIndex = 0;
    if (a.division == 17) positionIndex = 1;
    if (a.division == 18) positionIndex = 2;
    
    a.setLocation(new PVector(x[positionIndex], y[positionIndex]));
    
    
    x[positionIndex] = x[positionIndex] + ARTWORK_SIZE + ARTWORK_SPACING;
    if (x[positionIndex] >= width) {
      x[positionIndex] = 0;
      y[positionIndex] = y[positionIndex] + ARTWORK_SIZE + ARTWORK_SPACING;
    }       
  }
}
