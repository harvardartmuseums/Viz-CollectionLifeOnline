void mousePressed() {
  paused = !paused;
}

void keyPressed() {
  if (keyCode == KeyEvent.VK_R) {
    //Restart the whole thing
    i = 0;
  } else if (keyCode == KeyEvent.VK_RIGHT) {
    //go forward in time
    //need to pause everything to make this work
  } else if (keyCode == KeyEvent.VK_LEFT) {
    //go backward in time
    //need to pause everything to make this work
  }
}
