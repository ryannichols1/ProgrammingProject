class SearchBox {
  float x, y, w, h;
  String text = "";
  boolean active = false;
  boolean cursorVisible = true;
  int lastBlink = 0;
  int blinkInterval = 500;

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
      if (millis() - lastBlink > blinkInterval) {
        cursorVisible = !cursorVisible;
        lastBlink = millis();
      }
      fill(0);
      String shown = text + (cursorVisible ? "|" : " ");
      text(shown, x + 5, y + h / 2);
    } else if (text.equals("")) {
      fill(180);
      text("e.g. AA or ATL or 2019-01-15", x + 5, y + h / 2);
    } else {
      fill(0);
      text(text, x + 5, y + h / 2);
    }
  }

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
      if (keyCode == BACKSPACE) {
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
