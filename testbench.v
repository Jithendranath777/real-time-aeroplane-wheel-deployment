`timescale 1ns / 1ps

module tb_fsm_controller;

    // Inputs
    reg clk;
    reg rst;
    reg echo;

    // Outputs
    wire trig;
    wire servo_out;
    wire LED;
    wire [7:0] data;
    wire lcd_e;
    wire lcd_rs;

    // Instantiate the DUT (Design Under Test)
    fsm_controller uut (
        .clk(clk),
        .rst(rst),
        .echo(echo),
        .trig(trig),
        .servo_out(servo_out),
        .LED(LED),
        .data(data),
        .lcd_e(lcd_e),
        .lcd_rs(lcd_rs)
    );

    // Clock Generation (50 MHz)
    always #10 clk = ~clk;  // Clock period = 20 ns

    initial begin
        // Initialization
        clk = 0;
        rst = 1;
        echo = 0;
        #100;  // Global reset delay

        rst = 0;

        // Test Case 1: Distance < 20 cm => LED and servo_out should be 1
        force uut.us_inst.distance_raw = 20000;  // < threshold
        #50000;

        // Test Case 2: Distance > 20 cm => LED and servo_out should be 0
        force uut.us_inst.distance_raw = 60000;  // > threshold
        #50000;

        // Test Case 3: Distance slightly less than threshold
        force uut.us_inst.distance_raw = 25000;  // < threshold again
        #50000;

        // Stop forcing the internal signal
        release uut.us_inst.distance_raw;

        #50000;
        $finish;
    end

    // Monitor signals for observation
    initial begin
        $monitor("Time = %0t | Distance = %d | Servo = %b | LED = %b", 
                  $time, uut.us_inst.distance_raw, servo_out, LED);
    end

endmodule