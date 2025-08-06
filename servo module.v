`timescale 1ns / 1ps

module Servo (
    input clk,             // 50 MHz clock
    input rst,             // active high reset
    input  angle_sel, // 1-bit input: 0 - 0°, 1 - 180°
    output reg servo_out   // PWM output to servo
);

    // Constants for 50 MHz
    parameter PWM_PERIOD = 1_000_000; // 20ms period (50Hz): 20ms * 50MHz = 1,000,000
    parameter PULSE_0   = 50_000;     // 1ms  = 50,000 cycles
    parameter PULSE_90 = 100000;    // 1.5ms = 100,000 cycles

    reg [19:0] counter = 0;
    reg [19:0] pulse_width;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            counter <= 0;
            servo_out <= 0;
        end else begin
            // Select pulse width based on angle_sel
            case (angle_sel)
                1'b0: pulse_width <= PULSE_0;   // 0°
                1'b1: pulse_width <= PULSE_90; // 90°
                default: pulse_width <= PULSE_0;
            endcase

            // PWM generation
            if (counter < pulse_width)
                servo_out <= 1;
            else
                servo_out <= 0;

            counter <= counter + 1;
            if (counter >= PWM_PERIOD)
                counter <= 0;
        end
    end
endmodule