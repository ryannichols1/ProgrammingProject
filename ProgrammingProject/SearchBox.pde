class SearchBox{float x, y, w, h;
    String text = "";
    boolean active = false;
    
    SearchBox(float x, float y, float w, float h){
        this.x = x;
        this.y = y;
        this.w = w;
        this.h = h;
    }
    
    void display() {
  fill(255);
  rect(x, y - 120, w, h + 20);

  textAlign(LEFT, CENTER);
  textSize(12.10);

  if (text.equals("")) {
    fill(180);
    text("e.g. AA or ATL or 2019-01-15", x + 1, y - 120 + h / 2 + 10);
  } else {
    fill(0);
    text(text, x + 1, y - 120 + h / 2 + 10);
  }

  if (active) {
    fill(0);
    String cursor = text + "|";
    text(cursor, x + 1, y - 120 + h / 2 + 10);
  }
}
    
    void mousePressed(){
        if (mouseX > x && mouseX < x + w && mouseY > y && mouseY < y + h) {
        active = true;
        } else {
        active = false;
        }
    }
    
    void keyPressed(){
        if (active) {
        if (keyCode == BACKSPACE) {
            if (text.length() > 0) {
            text = text.substring(0, text.length() - 1);
            }
        } else if (keyCode == ENTER) {
            // Handle search action here
        } else {
            text += key;
        }
        }
    }
}
    