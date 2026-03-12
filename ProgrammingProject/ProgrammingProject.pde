void setup() {
    size(400,400);
    read_in_the_file();
    result = default_query();
    current_query = query3;// whatever type of query is default
}
void draw() {
    background(0);
    rect(200,200, 100, 100);
    fill(200);
    switch(current_query){
case query1:
render_query1(results);
break;
case query2:
Etc…..
}
render_controls();
}
void mousePressed() {
    switch(event)
case button 1:
current_query = query1;
results=query1();
break;
case button 2:
current_query = query2;
results=query2();
Etc
}