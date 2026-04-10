//Authorship Connor Nel, Vlad Manea, Ryan Nichols,  Callum Hughes 

class SearchBox {
  float x, y, w, h;
  String text = "";  // what the user has typed 
  boolean active = false; // wether the box is being used or not
  boolean cursorVisible = true; // if cursor is blinking or not 
  int lastBlink = 0;
  int blinkInterval = 500; // blinks every 500ms

  SearchBox(float x, float y, float w, float h) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
  }

  void display() {
    fill(255);
    rect(x, y, w, h);
    textAlign(LEFT, CENTER);
    textSize(12.10);
    if (active) {
      //enables flash of cursor every 500ms 
      if (millis() - lastBlink > blinkInterval) {
        cursorVisible = !cursorVisible;
        lastBlink = millis();
      }
      // shows typed text and the flashing cursor at end of text 
      fill(0);
      String shown = text + (cursorVisible ? "|" : " ");
      text(shown, x + 5, y + h / 2);
    } else if (text.equals("")) {
      // only show example of search text when the searchbox is not active and no text has been typed into it
      fill(180);
      text("e.g. AA or ATL or 2019-01-15", x + 5, y + h / 2);
    } else {
      fill(0);
      text(text, x + 5, y + h / 2);
    }
  }

  // activate if clicked inside the box, deactivate if clicked outside the box 
  void mousePressed() {
    if (mouseX > x && mouseX < x + w && mouseY > y && mouseY < y + h) {
      active = true;
      cursorVisible = true;
      lastBlink = millis();
    } else {
      active = false;
    }
  }

  void keyPressed() {
    if (active) {
      if (keyCode == BACKSPACE) { // handles tetx being deleted 
        if (text.length() > 0) {
          text = text.substring(0, text.length() - 1);
        }
      } else if (keyCode == ENTER) {
        // handled in homepage keyPressed
      } else {
        text += key;
      }
    }
  }
}
