import processing.svg.*;
import controlP5.*;

// UI status
boolean debug_mode = false;
boolean show_controls = true;
int mouse_timeout = 0;
boolean record = false;

// Vectors
PVector vs1, vs2, ve1, ve2, hs1, hs2, he1, he2;

// Creatures
Creature creature_one; 

// Sketch Parameters
PImage vortex_img;
boolean vortex_effect = false;
int vortex_iterations = 5;
int sketch_size = 600;
int border = 75;
int double_border = 2 * border;

// Creature Default Properties
float vortex_rotation = 5.0;
float moving_speed = 1.0;
int line_iterations = 10;
int line_points = 20;
float noise_falloff = 0.8;
float noise_scale = 15.0;
float noise_factor = 0.02;

void setup() {
    // Setup the stage
    smooth();
    size(800, 800);
    strokeCap(ROUND);
    strokeJoin(ROUND);
    ellipseMode(CENTER);
    noiseSeed(100);
    noiseDetail(8, noise_falloff);

    // Create the controls
    cp5 = new ControlP5(this);
    cp5.setAutoDraw(false);
    setupControls();

    // Create the first creature
    creature_one = newCreature(); 
}
    
void draw() {
    background(255);

    // Start recording
    if (record) {
		beginRecord(SVG, "export/objects-" + dateString() + ".svg");
    }

    // Update every frame
    blendMode(NORMAL);
    creature_one.update();
    creature_one.draw();
    creature_one.checkSelection();
    

    // End SVG recording...
	if (record) {
		endRecord();
		record = false;
	}

    creature_one.drawHandles();

    // Draw controls
    blendMode(NORMAL);
    cp5.draw();
}



void keyPressed() {
    // Recreate creature
    if (key == 'r' || key == 'R') {
        createCreature();
    }

    // Show/Hide controls
    if (key == 'c' || key == 'C') {
        toggleControls();
    }
}

public void createCreature() {
    creature_one = newCreature(); 
}

Creature newCreature() {
    // Create the creature with all the parameters
    Creature temp_creature = new Creature(
                                    line_iterations, 
                                    line_points, 
                                    moving_speed
                                ); 
    return temp_creature;
}

PVector randomPos() {
    PVector p = new PVector(random(width) - width * 0.5, random(height) - height * 0.5);
    return p;
}

String dateString() {
    String dateString = year() + "-" + nf(month(), 2) + "-" + nf(day(), 2)+ "-" + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
    return dateString;
}

boolean show_handles() {
    boolean sh = false;
    if (!(mouseX == pmouseX && mouseY == pmouseY)) {
        mouse_timeout = millis();
    };
    if (mouse_timeout > millis() - 400) {
        sh = true;
    }    
    return sh;
}