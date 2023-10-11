void drawCreature() {
	// Update every frame
    blendMode(NORMAL);
    creature_one.update();
}

void drawControls() {
	// Draw controls
    blendMode(NORMAL);
    cp5.draw();
}
