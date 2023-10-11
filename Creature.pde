class Creature { 
    
    // Vector 1: Start, Handler Start, Handler End, End
    
    
    PVector v1, v2, v3, v4;
    PVector h1, h2, h3, h4;
    PVector c1, c2, c3, c4;
    PVector n1, n2, n3, n4;
    
    // Moving Vector
    PVector m1, m2, m3, m4;
    
    // Line properties and boundaries
    int line_iterations = 15;
    int line_points = 400;
    int stroke_weight = 5;
    
    // Noise
    float line_interpolation = 1 / float(line_iterations);
    float line_noise_magnitude = 0.0;
    float point_noise_magnitude = 0.0;
    float noise_progress = 0.0;
    float moving_speed = 3.0;
    float decrease_rate = 0.98;
    int noise_seed = 1;
    
    Creature(int iterations, int points, float speed, float line_magnitude, float point_magnitude) { 
        // Creature specific noise seed
        noise_seed = floor(random(100));
        noiseDetail(1);
        
        // Transfer properties to local variables
        line_iterations = iterations;
        line_points = points;
        moving_speed = speed;
        line_noise_magnitude = line_magnitude;
        point_noise_magnitude = point_magnitude;
        
        // Derived properties
        line_interpolation = 1 / float(line_iterations);
        
        
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
            v1 = new PVector( -200, -200);
            v3 = new PVector(200, -200);
            v2 = new PVector( -200,200);
            v4 = new PVector(200,200);
            
            h1 = new PVector( -100, -300);
            h3 = new PVector(100, -300);
            h2 = new PVector( -100,300);
            h4 = new PVector(100,300);
            
            c1 = new PVector( -100, -100);
            c2 = new PVector(100, -100);
            c3 = new PVector( -100,100);
            c4 = new PVector(100,100);
        }

        
        // Set random movement vectors
        m1 = new PVector(random( -moving_speed, moving_speed), random( -moving_speed, moving_speed));
        m2 = new PVector(random( -moving_speed, moving_speed), random( -moving_speed, moving_speed));
        m3 = new PVector(random( -moving_speed, moving_speed), random( -moving_speed, moving_speed));
        m4 = new PVector(random( -moving_speed, moving_speed), random( -moving_speed, moving_speed));
    } 
    
    void update() { 
        // Update the progress of the creature
        // noiseSeed(noise_seed);
        // noise_progress = noise_progress + .01;
        updateNoise();

        // Sum up vectors
        v1.add(m1); c1.add(m2); h1.add(m3);
        v2.add(m2); c2.add(m3); h2.add(m4);
        v3.add(m3); c3.add(m4); h3.add(m1);
        v4.add(m4); c4.add(m1); h4.add(m2);

        draw();
        
        // Decrease movement over time
        m1.mult(decrease_rate);
        m2.mult(decrease_rate);
        m3.mult(decrease_rate);
        m4.mult(decrease_rate);
    } 
    
    // Draw the creature
    void draw() {
        
        
        // Create several lines by interpolating start and end vector
        int numVortex = vortex_effect ? vortex_iterations : 1;
        
        pushMatrix();
        translate(width * 0.5, height * 0.5);
        
        if (debug_mode) {
            drawHandles();
            
        }   
        
        // Lines
        
        
        for (int a = 1; a <= numVortex; a++) {
            // Draw the interpolation lines
            for (int i = 0; i < line_iterations; i++) {
                
                float t = map(i, 0, line_iterations - 1, 0, 1);
                
                // Interpolate vectors for each iteration, multiply the interpolation factor
                float p1x = bezierPoint(v1.x, c1.x, c2.x, v3.x, t);
                float p1y = bezierPoint(v1.y, c1.y, c2.y, v3.y, t);
                float h1x = bezierPoint(h1.x, c1.x, c2.x, h3.x, t);
                float h1y = bezierPoint(h1.y, c1.y, c2.y, h3.y, t);
                
                float p2x = bezierPoint(v2.x, c3.x, c4.x, v4.x, t);
                float p2y = bezierPoint(v2.y, c3.y, c4.y, v4.y, t);
                float h2x = bezierPoint(h2.x, c3.x, c4.x, h4.x, t);
                float h2y = bezierPoint(h2.y, c3.y, c4.y, h4.y, t);
                
                // Draw line as circles with different sizes
                
                beginShape();
                for (int j = 0; j <= line_points; j++) {
                    // Interpolate circle size for each point
                    float point_position = map(j, 0, line_points - 1, 0, 1);
                    float x = bezierPoint(p1x, h1x, h2x, p2x, point_position);
                    float y = bezierPoint(p1y, h1y, h2y, p2y, point_position);
                    
                    y += noisePlusMinus(line_noise_magnitude, i, j, 0.01);
                    y += noisePlusMinus(point_noise_magnitude, i, j, 1);
                    x += noisePlusMinus(line_noise_magnitude, x, y, 0.01);
                    x += noisePlusMinus(point_noise_magnitude, x, y, 1);

                    if (debug_mode) {
                        noStroke();
                        fill(128,128,128);
                        circle(x, y, 10);
                    }
                    
                    vertex(x, y);
                }

                stroke(1);
                strokeWeight(stroke_weight);
                noFill();

                endShape();
            }
            // Apply transform
            rotate(radians(vortex_rotation));
            scale(1 - ((float) a / vortex_iterations * 0.5));
        }
        popMatrix();
    }
    
    // Perlinnoise (Amplitude, X, Y, Factor)
    float noisePlusMinus(float amp, float x, float y, float f) {
        float n = amp * noise(y * f, x) - amp * 0.5;
        return(n);
    }

    void updateNoise() {
        n1 = new PVector(noise(v1.x, v1.y), noise(h1.x, h1.y));
        n2 = new PVector(noise(v2.x, v2.y), noise(h2.x, h2.y));
        n3 = new PVector(noise(v3.x, v3.y), noise(h3.x, h3.y));
        n4 = new PVector(noise(v4.x, v4.y), noise(h4.x, h4.y));

        n1.mult(10);
        n2.mult(10);
        n3.mult(10);
        n4.mult(10);
    }
    
    // Traces
    void drawHandles() {
        // Handles
        noStroke();
        fill(255,0,0);
        circle(v1.x, v1.y, 60);
        circle(v3.x, v3.y, 60);
        circle(v2.x, v2.y, 60);
        circle(v4.x, v4.y, 60);
        
        fill(0,255,0);
        circle(h1.x, h1.y, 40);
        circle(h2.x, h2.y, 40);
        circle(h3.x, h3.y, 40);
        circle(h4.x, h4.y, 40);
        
        fill(0,0,255);
        circle(c1.x, c1.y, 20);
        circle(c2.x, c2.y, 20);
        circle(c3.x, c3.y, 20);
        circle(c4.x, c4.y, 20);
        
        noFill();
        strokeWeight(1);
        stroke(255,0,0);
        
        // Bezier Lines
        line(v1.x, v1.y, h1.x, h1.y);
        line(h1.x, h1.y, h2.x, h2.y);
        line(h2.x, h2.y, v2.x, v2.y);
        
        line(v3.x, v3.y, h3.x, h3.y);
        line(h3.x, h3.y, h4.x, h4.y);
        line(h4.x, h4.y, v4.x, v4.y);
        
        // Distort controls
        stroke(0,0,255);
        line(v1.x, v1.y, c1.x, c1.y);
        line(v3.x, v3.y, c2.x, c2.y);
        line(v2.x, v2.y, c3.x, c3.y);
        line(v4.x, v4.y, c4.x, c4.y);
    }
} 
