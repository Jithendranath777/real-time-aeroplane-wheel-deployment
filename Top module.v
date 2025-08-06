`timescale 1ns / 1ps

module fsm_controller (
    input clk,
    input rst,
    input echo,              // From ultrasonic sensor
    output trig,             // To ultrasonic sensor
    output servo_out,
    output  LED,
   output [7:0] data,   // LCD 8-bit data bus
   output    lcd_e,   // LCD enable
   output   lcd_rs            // To servo motor
);
	localparam D = 2900;
    wire [19:0] distance_raw;
    reg  angle_sel;
    wire a1;
    // Instantiate Ultrasonic Sensor
    Ultrasonic_3 us_inst (
        .CLOCK_50(clk),
        .ECHO(echo),
        .TRIG(trig),
        .distance_raw(distance_raw)
    );
   LCD_pro uut(.clk(clk),.rst(rst),.state(a1),.lcd_e(lcd_e),
   .lcd_rs(lcd_rs),.data(data));//Instantiate LCD_pro mudule
    // Instantiate Servo Motor
    Servo sm_inst (
        .clk(clk),
        .rst(rst),
        .angle_sel(angle_sel),
        .servo_out(servo_out)
    );
    // FSM logic to choose angle based on distance
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            angle_sel <= 1'b0; // Initially retract (0°)
            
        end else begin
            if (distance_raw < 20*D)begin
                angle_sel <= 1'b1; // Deploy wheel (180°)
                end
            else begin
                angle_sel <= 1'b0; // Retract wheel (0°)
                 end
        end
    end
   assign a1 = angle_sel; 
   assign LED=  angle_sel;
endmodule