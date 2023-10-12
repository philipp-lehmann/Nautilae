/* autogenerated by Processing revision 1292 on 2023-10-12 */
import processing.core.*;
import processing.data.*;
import processing.event.*;
import processing.opengl.*;

import processing.svg.*;
import controlP5.*;

import java.util.HashMap;
import java.util.ArrayList;
import java.io.File;
import java.io.BufferedReader;
import java.io.PrintWriter;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.IOException;

public class Nautilae_06 extends PApplet {




// UI status
boolean debug_mode = false;
boolean show_controls = true;
int mouse_timeout = 0;
boolean record = false;

// Vectors
PVector vs1, vs2, ve1, ve2, hs1, hs2, he1, he2;


// Colors
int _bg1, _bg2, _bg3, _output, _primary1, _primary2, _primary3, _secondary1, _secondary2, _secondary3, _debug;


// Creatures
Creature creature_one; 

// Sketch Parameters
PImage vortex_img;
boolean vortex_effect = false;
int sketch_size = 600;
int border = 75;
int double_border = 2 * border;

// Creature Default Properties
float moving_speed = 1.0f;
int line_iterations = 20;
int line_points = 40;

int vortex_iterations = 5;
float vortex_rotation = 5.0f;
float vortex_scale = 0.9f;

float noise_scale = 0.0f;
float noise_falloff = 0.8f;
float noise_factor = 0.02f;

public void setup() {
    // Setup the stage
    /* smooth commented out by preprocessor */;
    /* size commented out by preprocessor */;
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
    
public void draw() {
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



public void keyPressed() {
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

public Creature newCreature() {
    // Create the creature with all the parameters
    Creature temp_creature = new Creature(
                                    line_iterations, 
                                    line_points, 
                                    moving_speed
                                ); 
    return temp_creature;
}

public PVector randomPos() {
    PVector p = new PVector(random(width) - width * 0.5f, random(height) - height * 0.5f);
    return p;
}

public String dateString() {
    String dateString = year() + "-" + nf(month(), 2) + "-" + nf(day(), 2)+ "-" + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
    return dateString;
}

public boolean show_handles() {
    boolean sh = false;
    if (!(mouseX == pmouseX && mouseY == pmouseY)) {
        mouse_timeout = millis();
    };
    if (mouse_timeout > millis() - 400 && show_controls) {
        sh = true;
    }    
    return sh;
}
// Controls
ControlP5 cp5;
Slider slider_output_iterations, slider_points, slider_vortex_rotation, slider_vortex_iterations, slider_vortex_scale, slider_noise_scale, slider_noise_factor, slider_noise_falloff;
Toggle toggle_vortex, toggle_debug;
Button button_generate, button_record;


public void setupControls() {
    // Slider for the number of iterations between the vectors
    slider_output_iterations = cp5.addSlider("setLineIterations")
       .setLabel("Line iterations")
       .setValue(line_iterations)
       .setRange(1,30)
       .setNumberOfTickMarks(30)
       .showTickMarks(false)
       .setPosition(20,20)
       .setSize(200,10)
       .setVisible(show_controls)
       ;
    
    // Slider for the number of points draw for each line
    slider_points = cp5.addSlider("setPointsPerLine")
       .setLabel("Points per line")
       .setValue(line_points)
       .setRange(2,1000)
       .setNumberOfTickMarks(999)
       .showTickMarks(false)
       .setPosition(20,40)
       .setSize(200,10)
       .setVisible(show_controls)
       ;
    
    // Toggle for the vortex effect
    toggle_vortex = cp5.addToggle("setVortex")
       .setLabel("Vortex")
       .setValue(vortex_effect)
       .setPosition(20,80)
       .setSize(60,10)
       .setMode(ControlP5.SWITCH)
       .setVisible(show_controls);
       
    toggle_debug = cp5.addToggle("setDebug")
       .setLabel("Debug mode")
       .setValue(debug_mode)
       .setPosition(20, height - 30)
       .setSize(40,10)
       .setMode(ControlP5.SWITCH)
       .setVisible(show_controls);
    
    // Slider to adjust the rotation of each vortex iteration
    slider_vortex_rotation = cp5.addSlider("setVortexRotation")
       .setLabel("Vortex Rotation")
       .setValue(vortex_rotation)
       .setRange(-180,180)
       .setNumberOfTickMarks(121)
       .showTickMarks(false)
       .setPosition(20,100)
       .setSize(200,10)
       .setVisible(show_controls);
           // Slider to adjust the rotation of each vortex iteration
    slider_vortex_scale = cp5.addSlider("setVortexScale")
       .setLabel("Vortex Scale")
       .setValue(vortex_scale)
       .setRange(0.3f, 1.0f)
       .setPosition(20,120)
       .setSize(200,10)
       .setVisible(show_controls);
    
    // Slider to adjust the numbers of vortex iterations
    slider_vortex_iterations = cp5.addSlider("setVortexIterations")
       .setLabel("Vortex Iterations")
       .setValue(vortex_iterations)
       .setRange(1,10)
       .setPosition(20,140)
       .setSize(200,10)
       .setVisible(show_controls);
    
    // Slider to adjust the noise falloff for the details
    slider_noise_scale = cp5.addSlider("setNoiseScale")
       .setLabel("Noise scale")
       .setValue(noise_scale)
       .setRange(0,25)
       .setPosition(20,160)
       .setSize(200,10)
       .setVisible(show_controls);
    
    // Slider to adjust the noise offset radius
    slider_noise_falloff = cp5.addSlider("setNoiseFalloff")
       .setLabel("Noise falloff")
       .setValue(noise_falloff)
       .setRange(0,1)
       .setPosition(20,180)
       .setSize(200,10)
       .setVisible(show_controls);
    
    // Slider to adjust the noise detail level
    slider_noise_factor = cp5.addSlider("setNoiseFactor")
       .setLabel("Noise factor")
       .setValue(noise_factor)
       .setRange(0.001f,0.1f)
       .setPosition(20,200)
       .setSize(200,10)
       .setVisible(show_controls);
    
    // create a new button with name 'buttonA'
    button_generate = cp5.addButton("createCreature")
       .setLabel("Create")
       .setValue(0)
       .setPosition(width - 80,20)
       .setSize(60,50)
       .setVisible(show_controls);
    
    button_record = cp5.addButton("saveSVG")
        	.setPosition(width - 80,80)
        	.setSize(60, 20);


    setGlobalForegroundColor();
}

// Update theme
public void setGlobalForegroundColor() {
    for (ControllerInterface <? > controller : cp5.getAll()) {
        if (controller instanceof Controller) {
           ((Controller<?>) controller).setColorBackground(_bg3);
           ((Controller<?>) controller).setColorForeground(_primary1);
           ((Controller<?>) controller).setColorActive(_primary2);
        }
}
}

// Toggle Controls
public void showControls() {
    hideControls();
    toggleControls(true);
}

public void hideControls() {
    toggleControls(false);
}

public void toggleControls() {
    show_controls = !show_controls;
    toggleControls(show_controls);
}

public void toggleControls(boolean show_hide) {
    show_controls = show_hide;
    
    // Show and hide default controls
    button_generate.setVisible(show_controls);
    button_record.setVisible(show_controls);
    slider_output_iterations.setVisible(show_controls); 
    slider_points.setVisible(show_controls); 
    slider_vortex_rotation.setVisible(show_controls); 
    slider_vortex_scale.setVisible(show_controls); 
    slider_vortex_iterations.setVisible(show_controls); 
    slider_noise_scale.setVisible(show_controls); 
    slider_noise_factor.setVisible(show_controls); 
    slider_noise_falloff.setVisible(show_controls);
    toggle_vortex.setVisible(show_controls);
    toggle_debug.setVisible(show_controls);
}

// Control event
public void controlEvent(ControlEvent theControlEvent) {
    if (creature_one != null) {
        vortex_effect = PApplet.parseBoolean(PApplet.parseInt(toggle_vortex.getValue()));
        vortex_rotation = slider_vortex_rotation.getValue();
        vortex_scale = slider_vortex_scale.getValue();
        vortex_iterations = PApplet.parseInt(slider_vortex_iterations.getValue());
        line_iterations = PApplet.parseInt(slider_output_iterations.getValue());
        line_points = PApplet.parseInt(slider_points.getValue());
        noise_falloff = slider_noise_falloff.getValue();
        noise_scale = slider_noise_scale.getValue();
        noise_factor = slider_noise_factor.getValue();
        noiseDetail(8, noise_falloff);
        debug_mode = PApplet.parseBoolean(PApplet.parseInt(toggle_debug.getValue()));
        creature_one.line_iterations = line_iterations;
        creature_one.line_points = line_points;
}
}

// Save SVG
public void saveSVG() {
    record = true;
}
class Creature { 
    
    // Points
    PVector[] vectors = new PVector[12];
    PVector v1, v2, v3, v4;
    PVector h1, h2, h3, h4;
    PVector c1, c2, c3, c4;
    
    // Movements
    PVector m1, m2, m3, m4;
    PVector selected_vector = null;
    
    // Line properties and boundaries
    int line_iterations = 15;
    int line_points = 400;
    int stroke_weight = 5;
    
    // Noise
    float line_interpolation = 1 / PApplet.parseFloat(line_iterations);
    float noise_progress = 0.0f;
    float moving_speed = 5.0f;
    float decrease_rate = 0.98f;
    int noise_seed = 1;
    
    // Appearance
    int handle_size = 15;
    
    Creature(int iterations, int points, float speed) { 
        
        // Creature specific noise seed
        noise_seed = floor(random(100));
        noiseDetail(1);
        
        // Transfer properties to local variables
        line_iterations = iterations;
        line_points = points;
        moving_speed = speed;
        
        // Derived properties
        line_interpolation = 1 / PApplet.parseFloat(line_iterations);
        
        // Vector points
        v1 = randomPos(); 
        v2 = randomPos(); 
        v3 = randomPos();
        v4 = randomPos();
        
        // Handle points
        h1 = randomPos(); 
        h2 = randomPos(); 
        h3 = randomPos();
        h4 = randomPos();
        
        // Control points
        c1 = randomPos();
        c2 = randomPos();
        c3 = randomPos();
        c4 = randomPos();
        
        if (debug_mode) {
            h1 = new PVector( - 250, -100);
            v1 = new PVector( - 200, -200);
            c1 = new PVector( - 100, -300);
            
            c2 = new PVector( - 100,  300);
            v2 = new PVector( - 200,  200);
            h2 = new PVector( - 250,  100);
            
            h3 = new PVector(250,  100);
            v3 = new PVector(200,  200);
            c3 = new PVector(100,  300);
            
            c4 = new PVector(100, -300);
            v4 = new PVector(200, -200);
            h4 = new PVector(250, -100);
        }
        
        // Set random movement vectors
        m1 = new PVector(random( -moving_speed, moving_speed), random( -moving_speed, moving_speed));
        m2 = new PVector(random( -moving_speed, moving_speed), random( -moving_speed, moving_speed));
        m3 = new PVector(random( -moving_speed, moving_speed), random( -moving_speed, moving_speed));
        m4 = new PVector(random( -moving_speed, moving_speed), random( -moving_speed, moving_speed));
        
        assignVectorArray();
    } 
    
    public void update() { 
        // Sum up vectors
        v1.add(m1); c1.add(m2); h1.add(m3);
        v2.add(m2); c2.add(m3); h2.add(m4);
        v3.add(m3); c3.add(m4); h3.add(m1);
        v4.add(m4); c4.add(m1); h4.add(m2);
        
        // Decrease movement over time
        m1.mult(decrease_rate);
        m2.mult(decrease_rate);
        m3.mult(decrease_rate);
        m4.mult(decrease_rate);
    } 
    
    // Draw creature
    public void draw() {
        
        pushMatrix();
        translate(width * 0.5f, height * 0.5f);
        
        // Vortex settings
        int numVortex = vortex_effect ? vortex_iterations : 1;
        
        // Lines
        for (int a = 1; a <= numVortex; a++) {
            // Draw the interpolation lines
            for (int i = 0; i < line_iterations; i++) {
                
                float t = map(i, 0, line_iterations - 1, 0, 1);
                
                // Interpolate vectors for each iteration, multiply the interpolation factor
                float pAx = bezierPoint(v1.x, c1.x, c4.x, v4.x, t);
                float pAy = bezierPoint(v1.y, c1.y, c4.y, v4.y, t);
                
                float pBx = bezierPoint(v2.x, c2.x, c3.x, v3.x, t);
                float pBy = bezierPoint(v2.y, c2.y, c3.y, v3.y, t);
                
                float hAx = bezierPoint(v1.x, h1.x, h4.x, v4.x, t);
                float hAy = bezierPoint(v1.y, h1.y, h4.y, v4.y, t);
                
                float hBx = bezierPoint(h2.x, v2.x, v3.x, h3.x, t);
                float hBy = bezierPoint(h2.y, v2.y, v3.y, h3.y, t);
               
                
                // Draw line as circles with different sizes
                stroke(_output);
                beginShape();
                
                for (int j = 0; j <= line_points; j++) {
                    // Interpolate circle size for each point
                    float point_position = map(j, 0, line_points, 0, 1);
                    float x = bezierPoint(pAx, hAx, hBx, pBx, point_position);
                    float y = bezierPoint(pAy, hAy, hBy, pBy, point_position);
                    
                    // Noise rotate about position
                    PVector pt = new PVector(x, y);
                    PVector h = new PVector(noise_scale, 0);
                    h.rotate(noise(x * noise_factor, y * noise_factor) * 2 * TWO_PI);
                    
                    PVector pOut = PVector.add(pt, h);
                    
                    if (debug_mode) {
                        noStroke();
                        fill(_secondary3, 30);
                        circle(x, y, noise_scale * 2);
                        
                        stroke(_output);
                        strokeWeight(1);
                        line(pt.x, pt.y, pOut.x, pOut.y);
                    }
                    
                    vertex(pOut.x, pOut.y);
                }
                
                stroke(_output);
                strokeWeight(stroke_weight);
                noFill();
                
                endShape();
            }
            // Apply transform
            rotate(radians(vortex_rotation));
            scale(vortex_scale);
        }
        
        popMatrix();
        
    }
    
    public void drawHandles() {
        if (debug_mode || show_handles()) {
            pushMatrix();
            translate(width * 0.5f, height * 0.5f);
            
            // Handles
            noStroke();
            fill(_primary1);
            circle(v1.x, v1.y, handle_size);
            text("V1", v1.x, v1.y + 20);
            circle(v2.x, v2.y, handle_size);
            text("V2", v2.x, v2.y + 20);
            circle(h1.x, h1.y, handle_size);
            text("H1", h1.x, h1.y + 20);
            circle(h2.x, h2.y, handle_size);
            text("H2", h2.x, h2.y + 20);
            circle(c1.x, c1.y, handle_size);
            text("C1", c1.x, c1.y + 20);
            circle(c2.x, c2.y, handle_size);
            text("C2", c2.x, c2.y + 20);
            
            fill(_secondary1);
            circle(v3.x, v3.y, handle_size);
            text("V3", v3.x, v3.y + 20);
            circle(v4.x, v4.y, handle_size);
            text("V4", v4.x, v4.y + 20);
            circle(h3.x, h3.y, handle_size);
            text("H3", h3.x, h3.y + 20);
            circle(h4.x, h4.y, handle_size);
            text("H4", h4.x, h4.y + 20);
            circle(c3.x, c3.y, handle_size);
            text("C3", c3.x, c3.y + 20);
            circle(c4.x, c4.y, handle_size);
            text("C4", c4.x, c4.y + 20);
            
            noFill();
            strokeWeight(1);
            
            
            // Bezier Lines
            stroke(_primary3);
            line(v1.x, v1.y, h1.x, h1.y);
            line(h1.x, h1.y, h2.x, h2.y);
            line(h2.x, h2.y, v2.x, v2.y);
            
            stroke(_secondary3);
            line(v3.x, v3.y, h3.x, h3.y);
            line(h3.x, h3.y, h4.x, h4.y);
            line(h4.x, h4.y, v4.x, v4.y);
            
            // Distort controls
            stroke(_primary2);
            line(v1.x, v1.y, c1.x, c1.y);
            line(v2.x, v2.y, c2.x, c2.y);
            
            stroke(_secondary3);
            line(v3.x, v3.y, c3.x, c3.y);
            line(v4.x, v4.y, c4.x, c4.y);
            
            popMatrix();
        }
    }
    
    
    public void checkSelection() {
        PVector m = new PVector(mouseX - width / 2, mouseY - height / 2);
        
        if (mousePressed == false) {
            selected_vector = null;
        }
        
        if (selected_vector == null) {
            // Check for mouse hvoer
            pushMatrix();
            translate(width * 0.5f, height * 0.5f);
            for (int i = 0; i < vectors.length; i++) {
                if (m.dist(vectors[i]) < handle_size / 2) {
                    selected_vector = vectors[i];
                    noStroke();
                    fill(0, 150);
                    circle(selected_vector.x, selected_vector.y, handle_size);
                    break;
                }
                
            }
            popMatrix();
        } else {
            // Apply new position
            if (mousePressed == true) {
                selected_vector.x = m.x;
                selected_vector.y = m.y;
            }
        }
    }
    
    
    public void assignVectorArray() {
        vectors[0] = v1;
        vectors[1] = v2;
        vectors[2] = v3;
        vectors[3] = v4;
        vectors[4] = h1;
        vectors[5] = h2;
        vectors[6] = h3;
        vectors[7] = h4;
        vectors[8] = c1;
        vectors[9] = c2;
        vectors[10] = c3;
        vectors[11] = c4;
    } 
} 


  public void settings() { size(800, 800);
smooth(); }

  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "Nautilae_06" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
