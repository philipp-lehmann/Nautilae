import processing.svg.*;
import controlP5.*;


boolean debug_mode = true;

// Controls
ControlP5 cp5;
Slider slider_line_iterations, slider_points, slider_speed, slider_line_noise, slider_point_noise, slider_vortex_rotation, slider_vortex_iterations;
Toggle toggle_vortex, toggle_debug;
Button button_generate, button_reset, button_record;

// Interface status
boolean show_controls = true;
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
float line_noise_magnitude = 0.0;
float point_noise_magnitude = 0.0;
int line_iterations = 10;
int line_points = 20;

void setup() {
    // Setup the stage
    smooth();
    size(800, 800);
    strokeCap(ROUND);
    strokeJoin(ROUND);
    ellipseMode(CENTER);
    noiseSeed(100);

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

    drawCreature();

    // End SVG recording...
	if (record) {
		endRecord();
		record = false;
	}
    drawControls();
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
    updateControlValues();
    creature_one = newCreature(); 
}

Creature newCreature() {
    // Create the creature with all the parameters
    Creature temp_creature = new Creature(
                                    line_iterations, 
                                    line_points, 
                                    moving_speed, 
                                    line_noise_magnitude, 
                                    point_noise_magnitude
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