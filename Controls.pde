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
    slider_speed = cp5.addSlider("setMovingSpeed")
        .setLabel("Moving speed")
        .setValue(moving_speed)
        .setRange(0,10)
        .setNumberOfTickMarks(11)
        .setPosition(20,40)
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

    // Slider to adjust the amount of y-noise added to the points
    slider_line_noise = cp5.addSlider("setLineNoise")
        .setLabel("Line noise")
        .setValue(line_noise_magnitude)
        .setRange(0,200)
        .setPosition(20,160)
        .setSize(200,10)
        .setVisible(show_controls);

    // Slider to adjust the amount of y-noise added to the points
    slider_point_noise = cp5.addSlider("setPointNoise")
        .setLabel("Point noise")
        .setValue(point_noise_magnitude)
        .setRange(0,25)
        .setPosition(20,180)
        .setSize(200,10)
        .setVisible(show_controls);

    // create a new button with name 'buttonA'
    button_generate = cp5.addButton("createCreature")
        .setLabel("Create")
        .setValue(0)
        .setPosition(width-80,20)
        .setSize(60,50)
        .setVisible(show_controls);
    
    button_record = cp5.addButton("saveSVG")
		.setPosition(width-80,80)
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
    toggleControls(show_controls);
}
void toggleControls(boolean show_hide) {
    show_controls = show_hide;

    // show and hide default controls
    button_generate.setVisible(show_controls);
    button_reset.setVisible(show_controls);
    slider_line_iterations.setVisible(show_controls); 
}

// Update parameters 
void updateControlValues() {
    vortex_effect = boolean(int(toggle_vortex.getValue()));
    debug_mode = boolean(int(toggle_debug.getValue()));
    vortex_rotation = slider_vortex_rotation.getValue();
    vortex_iterations = int(slider_vortex_iterations.getValue());
    moving_speed = slider_speed.getValue();
    line_noise_magnitude = slider_line_noise.getValue();
    line_iterations = int(slider_line_iterations.getValue());
    line_points = int(slider_points.getValue());
    point_noise_magnitude = slider_point_noise.getValue();
}

// Update parameters 
void resetControls() {
    toggle_vortex.setValue(0);
    slider_vortex_rotation.setValue(0.0);
    slider_vortex_iterations.setValue(0.0);
    slider_speed.setValue(0);
    slider_line_noise.setValue(0);
    slider_line_iterations.setValue(1);
    slider_points.setValue(400);
    slider_point_noise.setValue(0);
    hideControls();
    createCreature();
}


void saveSVG() {
	record = true;
}
