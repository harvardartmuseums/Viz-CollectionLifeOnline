public Artwork[] loadArtworkData() {
  Artwork artworks[];

  //String lines[] = loadStrings("data.csv");
  String lines[] = loadStrings("data-orderedby-firstviewed.csv");
  
  println("Loaded " + lines.length + " bits of data");
  
  //Length-1 because we are skipping the first row with column names
  artworks = new Artwork[lines.length-1];
  
  //Skip the first row because it contains column names
  for(int i=1; i<lines.length; i++) {
    artworks[i-1] = new Artwork(lines[i]);
  }
  
  println("Done stepping through the data");
  return artworks;
}

public HashMap<Integer, DataGroup> loadDataGroups() {
  HashMap<Integer, DataGroup> dataGroups = new HashMap();

  dataGroups.put(16, new DataGroup(16, "Division of Asian and Mediterranean Art"));
  dataGroups.put(17, new DataGroup(17, "Division of European and American Art"));
  dataGroups.put(18, new DataGroup(18, "Division of Modern and Contemporary Art"));  

  return dataGroups;
}

/*
public Events[] loadEventsData() {
}
*/


