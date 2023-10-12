// Controls
ControlP5 cp5;
Slider slider_output_iterations, slider_points, slider_vortex_rotation, slider_vortex_iterations, slider_noise_scale, slider_noise_factor, slider_noise_falloff;
Toggle toggle_vortex, toggle_debug;
Button button_generate, button_record;


void setupControls() {
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
       .setPosition(20,100)
       .setSize(200,10)
       .setVisible(show_controls);
    
    // Slider to adjust the numbers of vortex iterations
    slider_vortex_iterations = cp5.addSlider("setVortexIterations")
       .setLabel("Vortex Iterations")
       .setValue(vortex_iterations)
       .setRange(1,10)
       .setPosition(20,120)
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
       .setRange(0.001,0.1)
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
void setGlobalForegroundColor() {
    for (ControllerInterface <? > controller : cp5.getAll()) {
        if (controller instanceof Controller) {
           ((Controller<?>) controller).setColorBackground(_bg3);
           ((Controller<?>) controller).setColorForeground(_primary1);
           ((Controller<?>) controller).setColorActive(_primary2);
        }
}
}

// Toggle Controls
void showControls() {
    hideControls();
    toggleControls(true);
}

void hideControls() {
    toggleControls(false);
}

void toggleControls() {
    show_controls = !show_controls;
    toggleControls(show_controls);
}

void toggleControls(boolean show_hide) {
    show_controls = show_hide;
    
    // Show and hide default controls
    button_generate.setVisible(show_controls);
    button_record.setVisible(show_controls);
    slider_output_iterations.setVisible(show_controls); 
    slider_points.setVisible(show_controls); 
    slider_vortex_rotation.setVisible(show_controls); 
    slider_vortex_iterations.setVisible(show_controls); 
    slider_noise_scale.setVisible(show_controls); 
    slider_noise_factor.setVisible(show_controls); 
    slider_noise_falloff.setVisible(show_controls);
    toggle_vortex.setVisible(show_controls);
    toggle_debug.setVisible(show_controls);
}

// Control event
void controlEvent(ControlEvent theControlEvent) {
    if (creature_one != null) {
        vortex_effect = boolean(int(toggle_vortex.getValue()));
        vortex_rotation = slider_vortex_rotation.getValue();
        vortex_iterations = int(slider_vortex_iterations.getValue());
        line_iterations = int(slider_output_iterations.getValue());
        line_points = int(slider_points.getValue());
        noise_falloff = slider_noise_falloff.getValue();
        noise_scale = slider_noise_scale.getValue();
        noise_factor = slider_noise_factor.getValue();
        noiseDetail(8, noise_falloff);
        debug_mode = boolean(int(toggle_debug.getValue()));
        creature_one.line_iterations = line_iterations;
        creature_one.line_points = line_points;
}
}

// Save SVG
void saveSVG() {
    record = true;
}
