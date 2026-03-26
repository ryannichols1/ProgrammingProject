class SearchBox{float x, y, w, h;
    String text = "";
    boolean active = false;
    
    SearchBox(float x, float y, float w, float h){
        this.x = x;
        this.y = y;
        this.w = w;
        this.h = h;
    }
    
    void display(){
        fill(255);
        rect(x, y, w, h);
        fill(0);
        text(text, x + 5, y + h / 2 + 5);
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
    