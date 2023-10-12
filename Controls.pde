void setupControls() {
    // Slider for the number of iterations between the vectors
    slider_line_iterations = cp5.addSlider("setLineIterations")
       .setLabel("Line iterations")
       .setValue(line_iterations)
       .setRange(1,30)
       .setNumberOfTickMarks(30)
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
       .setPosition(20,60)
       .setSize(200,10)
       .setVisible(show_controls)
       ;
    
    // Toggle for the vortex effect
    toggle_vortex = cp5.addToggle("setVortex")
       .setLabel("Vortex")
       .setValue(vortex_effect)
       .setPosition(20,80)
       .setSize(90,10)
       .setVisible(show_controls);
    
    // Toggle for the vortex effect
    toggle_debug = cp5.addToggle("setDebug")
       .setLabel("Debug")
       .setValue(debug_mode)
       .setPosition(120,80)
       .setSize(90,10)
       .setVisible(show_controls);
    
    // Slider to adjust the rotation of each vortex iteration
    slider_vortex_rotation = cp5.addSlider("setVortexRotation")
       .setLabel("Vortex Rotation")
       .setValue(vortex_rotation)
       .setRange(0,90)
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
       .setPosition(20,200)
       .setSize(200,10)
       .setVisible(show_controls);

    // Slider to adjust the noise offset radius
    slider_noise_falloff = cp5.addSlider("setNoiseFalloff")
       .setLabel("Noise falloff")
       .setValue(noise_falloff)
       .setRange(0,1)
       .setPosition(20,220)
       .setSize(200,10)
       .setVisible(show_controls);

    // Slider to adjust the noise detail level
    slider_noise_factor = cp5.addSlider("setNoiseFactor")
       .setLabel("Noise factor")
       .setValue(noise_factor)
       .setRange(0.001,0.1)
       .setPosition(20,240)
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
    show_handles = show_controls;
    toggleControls(show_controls);
}

void toggleControls(boolean show_hide) {
    show_controls = show_hide;
    
    // Show and hide default controls
    button_generate.setVisible(show_controls);
    button_record.setVisible(show_controls);
    slider_line_iterations.setVisible(show_controls); 
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
      updateControlValues();
      creature_one.line_iterations = line_iterations;
      creature_one.line_points = line_points;
   }
}

// Update parameters 
void updateControlValues() {
    vortex_effect = boolean(int(toggle_vortex.getValue()));
    debug_mode = boolean(int(toggle_debug.getValue()));
    vortex_rotation = slider_vortex_rotation.getValue();
    vortex_iterations = int(slider_vortex_iterations.getValue());
    line_iterations = int(slider_line_iterations.getValue());
    line_points = int(slider_points.getValue());
    noise_falloff = slider_noise_falloff.getValue();
    noise_scale = slider_noise_scale.getValue();
    noise_factor = slider_noise_factor.getValue();
    noiseDetail(8, noise_falloff);
}

// Save SVG
void saveSVG() {
    record = true;
}
