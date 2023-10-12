import processing.svg.*;
import controlP5.*;

// UI status
boolean debug_mode = false;
boolean show_controls = true;
int mouse_timeout = 0;
boolean record = false;

// Vectors
PVector vs1, vs2, ve1, ve2, hs1, hs2, he1, he2;


// Colors
color _bg1, _bg2, _bg3, _output, _primary1, _primary2, _primary3, _secondary1, _secondary2, _secondary3, _debug;


// Creatures
Creature creature_one; 

// Sketch Parameters
PImage vortex_img;
boolean vortex_effect = false;
int sketch_size = 600;
int border = 75;
int double_border = 2 * border;

// Creature Default Properties
float moving_speed = 1.0;
int line_iterations = 20;
int line_points = 40;

int vortex_iterations = 5;
float vortex_rotation = 5.0;
float vortex_scale = 0.9;

float noise_scale = 0.0;
float noise_falloff = 0.8;
float noise_factor = 0.02;

void setup() {
    // Setup the stage
    smooth();
    size(800, 800);
    strokeCap(ROUND);
    strokeJoin(ROUND);
    ellipseMode(CENTER);
    textAlign(CENTER);
    colorMode(HSB, 360, 100, 100);
    noiseSeed(100);
    noiseDetail(8, noise_falloff);

    // Theme
    _bg1 = color(0, 0, 8);
    _bg2 = color(0, 0, 18);
    _bg3 = color(0, 0, 30);
    _output = color(180, 5, 230);
    _primary1 = color(180, 80, 100);
    _primary2 = color(180, 80, 80);
    _primary3 = color(180, 80, 60);
    _secondary1 = color(100, 80, 100);
    _secondary2 = color(100, 80, 80);
    _secondary3 = color(100, 80, 60);
    _debug = color(0, 100, 100);

    // Create the controls
    cp5 = new ControlP5(this);
    cp5.setAutoDraw(false);
    setupControls();

    // Create the first creature
    creature_one = newCreature(); 
}
    
void draw() {
    background(_bg1);

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
    if (mouse_timeout > millis() - 400 && show_controls) {
        sh = true;
    }    
    return sh;
}