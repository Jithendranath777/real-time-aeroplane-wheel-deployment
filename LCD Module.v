`timescale 1ns / 1ps


module LCD_pro(
input clk,
input rst,
input  state,
output reg lcd_e,lcd_rs,
output [7:0]data);


parameter idle = 1'b1, s1 = 1'b0;
reg [7:0] lcd_cmd;
reg [19:0] lcd_state = 0;
reg [19:0] count = 0;
assign data = lcd_cmd;
reg [2:0] prev_state;
always @(posedge clk or posedge rst) begin
  if (rst) begin
   lcd_e<=0;
 lcd_rs<=0;
    lcd_state <= 0;
    count <= 0;
    prev_state <= 0;
  end 
   else begin
    if (state != prev_state) begin
 lcd_state <= 0;
      count <= 0;
      prev_state <= state;
    end else begin
      case (state)
 
idle: 
begin
 case(lcd_state)
 
0: begin
   lcd_e <= 0;
   lcd_rs <= 0;
   
   if(count == 750000) begin
   count <= 0;
   lcd_state <= lcd_state+1;
   end
   
  else 
  count <= count +1;
  end
  
1: begin

 lcd_e <= 1;
 lcd_cmd <= 8'h30;
 
 if(count == 12) begin
 count <= 0;
lcd_state <= lcd_state+1;
 end
 else
 count <= count + 1;
 end    
 
2: begin
 lcd_e <= 0;
 
 if(count == 250000)begin
 count <= 0;
lcd_state <= lcd_state+1;
 end
 else
 count <= count + 1;
 end
 
3: begin 

lcd_e <= 1;
lcd_cmd <= 8'h30;

if(count == 12) begin

count <= 0;
lcd_state <= lcd_state+1;
end
count <= count+1;
end

4: begin

lcd_e <= 0;

if(count == 8000) begin

count <= 0;
lcd_state <= lcd_state+1;
end

else
count <= count +1;
end

5: begin

lcd_e <= 1;
lcd_cmd <= 8'h30;

if(count == 12)begin
 count <= 0;
lcd_state <= lcd_state+1;
 end
  else 
  count <= count + 1;
  end
  
6:begin
lcd_e<=0;
if(count==8000)begin  // WAIT FOR 2000 CLOCK CYCLES
count<=0;
lcd_state <= lcd_state+1;
end
else
count<=count+1;
end    

//INITIALIZATION DONE------ end of power on initialization-


//----DISPLAY CONFIGURATION

//---Start of FUNCTION SET COMMAND= 28h- 
 
7:begin
lcd_e <= 1;
lcd_cmd <= 8'h38;

if(count == 12) begin
 count <= 0;
lcd_state <= lcd_state+1;
 end
 else
 count <= count + 1;
 end
 
8: begin

if(count == 12)begin
lcd_e <= 0;
count <= 0;
lcd_state <= lcd_state+1;
end
else
count <= count + 1;
end

9:begin
if(count == 2000)begin
count <= 0;
lcd_state <= lcd_state+1;
end 
else
count <= count + 1;
end

10: begin
lcd_e <= 1;
lcd_cmd <= 8'h06;
if(count == 12) begin
 count <= 0;
lcd_state <= lcd_state+1;
 end
 else
 count <= count + 1;
 end
 
11: begin

if(count == 12)begin
lcd_e <= 0;
count <= 0;
lcd_state <= lcd_state+1;
end
else
count <= count + 1;
end

12:begin
if(count == 2000)begin
count <= 0;
lcd_state <= lcd_state+1;
end 
else
count <= count + 1;
end

13: begin
lcd_e <= 1;
lcd_cmd <= 8'h0c;

if(count == 12) begin
 count <= 0;
lcd_state <= lcd_state+1;
 end
 else
 count <= count + 1;
 end
 
14: begin

if(count == 12)begin
lcd_e <= 0;
count <= 0;
lcd_state <= lcd_state+1;
end
else
count <= count + 1;
end

15:begin
if(count == 2000)begin
count <= 0;
lcd_state <= lcd_state+1;
end 
else
count <= count + 1;
end

16: begin
lcd_e <= 1;
lcd_cmd <= 8'h01;

if(count == 12) begin
 count <= 0;
lcd_state <= lcd_state+1;
 end
 else
 count <= count + 1;
 end
 
17: begin

if(count == 12)begin
count <= 0;
lcd_e <= 0;
lcd_state <= lcd_state+1;
end
else
count <= count + 1;
end

18:begin
if(count == 82000)begin
count <= 0;
lcd_state <= lcd_state+1;
end 
else
count <= count + 1;
end
 
//----- writing dtat into LCD----

// issue COMMAND=80h to move crusor to first row


19:begin
lcd_e <= 1;
lcd_cmd <= 8'h80;
if(count == 12) begin
 count <= 0;
lcd_state <= lcd_state+1;
 end
 else
 count <= count + 1;
 end
  
20: begin

if(count == 12)begin
lcd_e <= 0;
count <= 0;
lcd_state <= lcd_state+1;
end
else
count <= count + 1;
end

21:begin
if(count == 2000)begin
count <= 0;
lcd_state <= lcd_state+1;
end 
else
count <= count + 1;
end  
//------ WRITING DATA INTO LCD

22:begin
lcd_e <= 1;
lcd_rs <= 1;
lcd_cmd <= 8'h46;
if(count == 12) begin
 count <= 0;
lcd_state <= lcd_state+1;
 end
 else
 count <= count + 1;
 end
  
23: begin

if(count == 12)begin
lcd_e <= 0;
count <= 0;
lcd_state <= lcd_state+1;
end
else
count <= count + 1;
end

24:begin
if(count == 2000)begin
count <= 0;
lcd_state <= lcd_state+1;
end 
else
count <= count + 1;
end  
  
25:begin
lcd_e <= 1;
lcd_rs <= 1;
lcd_cmd <= 8'h4c;
if(count == 12) begin
 count <= 0;
lcd_state <= lcd_state+1;
 end
 else
 count <= count + 1;
 end
  
26: begin

if(count == 12)begin
lcd_e <= 0;
count <= 0;
lcd_state <= lcd_state+1;
end
else
count <= count + 1;
end

27:begin
if(count == 2000)begin
count <= 0;
lcd_state <= lcd_state+1;
end 
else
count <= count + 1;
end  

28:begin
lcd_e <= 1;
lcd_rs <= 1;
lcd_cmd <= 8'h49;
if(count == 12) begin
 count <= 0;
lcd_state <= lcd_state+1;
 end
 else
 count <= count + 1;
 end
  
29: begin

if(count == 12)begin
lcd_e <= 0;
count <= 0;
lcd_state <= lcd_state+1;
end
else
count <= count + 1;
end

30:begin
if(count == 2000)begin
count <= 0;
lcd_state <= lcd_state+1;
end 
else
count <= count + 1;
end  

31:begin
lcd_e <= 1;
lcd_rs <= 1;
lcd_cmd <= 8'h47;
if(count == 12) begin
 count <= 0;
lcd_state <= lcd_state+1;
 end
 else
 count <= count + 1;
 end
  
32: begin

if(count == 12)begin
lcd_e <= 0;
count <= 0;
lcd_state <= lcd_state+1;
end
else
count <= count + 1;
end

33:begin
if(count == 2000)begin
count <= 0;
lcd_state <= lcd_state+1;
end 
else
count <= count + 1;
end
34:begin
lcd_e <= 1;
lcd_rs <= 1;
lcd_cmd <= 8'h48;
if(count == 12) begin
 count <= 0;
lcd_state <= lcd_state+1;
 end
 else
 count <= count + 1;
 end
  
35: begin

if(count == 12)begin
lcd_e <= 0;
count <= 0;
lcd_state <= lcd_state+1;
end
else
count <= count + 1;
end

36:begin
if(count == 2000)begin
count <= 0;
lcd_state <= lcd_state+1;
end 
else
count <= count + 1;
end 

37:begin
lcd_e <= 1;
lcd_rs <= 1;
lcd_cmd <= 8'h54;
if(count == 12) begin
 count <= 0;
lcd_state <= lcd_state+1;
 end
 else
 count <= count + 1;
 end
  
38: begin

if(count == 12)begin
lcd_e <= 0;
count <= 0;
lcd_state <= lcd_state+1;
end
else
count <= count + 1;
end

39:begin
if(count == 2000)begin
count <= 0;
lcd_state <= lcd_state+1;
end 
else
count <= count + 1;
end 

40:begin
lcd_e <= 1;
lcd_rs <= 1;
lcd_cmd <= 8'h20;
if(count == 12) begin
 count <= 0;
lcd_state <= lcd_state+1;
 end
 else
 count <= count + 1;
 end
  
41: begin

if(count == 12)begin
lcd_e <= 0;
count <= 0;
lcd_state <= lcd_state+1;
end
else
count <= count + 1;
end

42:begin
if(count == 2000)begin
count <= 0;
lcd_state <= lcd_state+1;
end 
else
count <= count + 1;
end 

43:begin
lcd_e <= 1;
lcd_rs <= 1;
lcd_cmd <= 8'h4c;
if(count == 12) begin
 count <= 0;
lcd_state <= lcd_state+1;
 end
 else
 count <= count + 1;
 end
  
44: begin

if(count == 12)begin
lcd_e <= 0;
count <= 0;
lcd_state <= lcd_state+1;
end
else
count <= count + 1;
end

45:begin
if(count == 2000)begin
count <= 0;
lcd_state <= lcd_state+1;
end 
else
count <= count + 1;
end 

46:begin
lcd_e <= 1;
lcd_rs <= 1;
lcd_cmd <= 8'h41;
if(count == 12) begin
 count <= 0;
lcd_state <= lcd_state+1;
 end
 else
 count <= count + 1;
 end
  
47: begin

if(count == 12)begin
lcd_e <= 0;
count <= 0;
lcd_state <= lcd_state+1;
end
else
count <= count + 1;
end

48:begin
if(count == 2000)begin
count <= 0;
lcd_state <= lcd_state+1;
end 
else
count <= count + 1;
end 

49:begin
lcd_e <= 1;
lcd_rs <= 1;
lcd_cmd <= 8'h4e;
if(count == 12) begin
 count <= 0;
lcd_state <= lcd_state+1;
 end
 else
 count <= count + 1;
 end
  
50: begin

if(count == 12)begin
lcd_e <= 0;
count <= 0;
lcd_state <= lcd_state+1;
end
else
count <= count + 1;
end

51:begin
if(count == 2000)begin
count <= 0;
lcd_state <= lcd_state+1;
end 
else
count <= count + 1;
end 

52:begin
lcd_e <= 1;
lcd_rs <= 1;
lcd_cmd <= 8'h44;
if(count == 12) begin
 count <= 0;
lcd_state <= lcd_state+1;
 end
 else
 count <= count + 1;
 end
  
53: begin

if(count == 12)begin
lcd_e <= 0;
count <= 0;
lcd_state <= lcd_state+1;
end
else
count <= count + 1;
end

54:begin
if(count == 2000)begin
count <= 0;
lcd_state <= lcd_state+1;
end 
else
count <= count + 1;
end 

55:begin
lcd_e <= 1;
lcd_rs <= 1;
lcd_cmd <= 8'h49;
if(count == 12) begin
 count <= 0;
lcd_state <= lcd_state+1;
 end
 else
 count <= count + 1;
 end
  
56: begin

if(count == 12)begin
lcd_e <= 0;
count <= 0;
lcd_state <= lcd_state+1;
end
else
count <= count + 1;
end

57:begin
if(count == 2000)begin
count <= 0;
lcd_state <= lcd_state+1;
end 
else
count <= count + 1;
end 

58:begin
lcd_e <= 1;
lcd_rs <= 1;
lcd_cmd <= 8'h4e;
if(count == 12) begin
 count <= 0;
lcd_state <= lcd_state+1;
 end
 else
 count <= count + 1;
 end
  
59: begin

if(count == 12)begin
lcd_e <= 0;
count <= 0;
lcd_state <= lcd_state+1;
end
else
count <= count + 1;
end

60:begin
if(count == 2000)begin
count <= 0;
lcd_state <= lcd_state+1;
end 
else
count <= count + 1;
end 

61:begin
lcd_e <= 1;
lcd_rs <= 1;
lcd_cmd <= 8'h47;
if(count == 12) begin
 count <= 0;
lcd_state <= lcd_state+1;
 end
 else
 count <= count + 1;
 end
  
62: begin

if(count == 12)begin
lcd_e <= 0;
count <= 0;
lcd_state <= lcd_state+1;
end
else
count <= count + 1;
end

63:begin
if(count == 2000)begin
count <= 0;
lcd_state <= lcd_state+1;
end 
else
count <= count + 1;
end 

endcase 
end /////////////////FLIGHT LANDING//////////////////////////////////////////////////////////////////////////////////////////////////////

//FOR FLIGHT TAKE OFF 
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

s1:begin
 case(lcd_state)
 
0: begin
   lcd_e <= 0;
   lcd_rs <= 0;
   
   if(count == 750000) begin
   count <= 0;
   lcd_state <= lcd_state+1;
   end
   
  else 
  count <= count +1;
  end
  
1: begin

 lcd_e <= 1;
 lcd_cmd <= 8'h30;
 
 if(count == 12) begin
 count <= 0;
lcd_state <= lcd_state+1;
 end
 else
 count <= count + 1;
 end    
 
2: begin
 lcd_e <= 0;
 
 if(count == 250000)begin
 count <= 0;
lcd_state <= lcd_state+1;
 end
 else
 count <= count + 1;
 end
 
3: begin 

lcd_e <= 1;
lcd_cmd <= 8'h30;

if(count == 12) begin

count <= 0;
lcd_state <= lcd_state+1;
end
count <= count+1;
end

4: begin

lcd_e <= 0;

if(count == 8000) begin

count <= 0;
lcd_state <= lcd_state+1;
end

else
count <= count +1;
end

5: begin

lcd_e <= 1;
lcd_cmd <= 8'h30;

if(count == 12)begin
 count <= 0;
lcd_state <= lcd_state+1;
 end
  else 
  count <= count + 1;
  end
  
6:begin
lcd_e<=0;
if(count==8000)begin  // WAIT FOR 2000 CLOCK CYCLES
count<=0;
lcd_state <= lcd_state+1;
end
else
count<=count+1;
end    

//INITIALIZATION DONE------ end of power on initialization-


//----DISPLAY CONFIGURATION

//---Start of FUNCTION SET COMMAND= 28h- 
 
7:begin
lcd_e <= 1;
lcd_cmd <= 8'h38;

if(count == 12) begin
 count <= 0;
lcd_state <= lcd_state+1;
 end
 else
 count <= count + 1;
 end
 
8: begin

if(count == 12)begin
lcd_e <= 0;
count <= 0;
lcd_state <= lcd_state+1;
end
else
count <= count + 1;
end

9:begin
if(count == 2000)begin
count <= 0;
lcd_state <= lcd_state+1;
end 
else
count <= count + 1;
end

10: begin
lcd_e <= 1;
lcd_cmd <= 8'h06;
if(count == 12) begin
 count <= 0;
lcd_state <= lcd_state+1;
 end
 else
 count <= count + 1;
 end
 
11: begin

if(count == 12)begin
lcd_e <= 0;
count <= 0;
lcd_state <= lcd_state+1;
end
else
count <= count + 1;
end

12:begin
if(count == 2000)begin
count <= 0;
lcd_state <= lcd_state+1;
end 
else
count <= count + 1;
end

13: begin
lcd_e <= 1;
lcd_cmd <= 8'h0c;

if(count == 12) begin
 count <= 0;
lcd_state <= lcd_state+1;
 end
 else
 count <= count + 1;
 end
 
14: begin

if(count == 12)begin
lcd_e <= 0;
count <= 0;
lcd_state <= lcd_state+1;
end
else
count <= count + 1;
end

15:begin
if(count == 2000)begin
count <= 0;
lcd_state <= lcd_state+1;
end 
else
count <= count + 1;
end

16: begin
lcd_e <= 1;
lcd_cmd <= 8'h01;

if(count == 12) begin
 count <= 0;
lcd_state <= lcd_state+1;
 end
 else
 count <= count + 1;
 end
 
17: begin

if(count == 12)begin
count <= 0;
lcd_e <= 0;
lcd_state <= lcd_state+1;
end
else
count <= count + 1;
end

18:begin
if(count == 82000)begin
count <= 0;
lcd_state <= lcd_state+1;
end 
else
count <= count + 1;
end
 
//----- writing dtat into LCD----

// issue COMMAND=80h to move crusor to first row


19:begin
lcd_e <= 1;
lcd_cmd <= 8'h80;
if(count == 12) begin
 count <= 0;
lcd_state <= lcd_state+1;
 end
 else
 count <= count + 1;
 end
  
20: begin

if(count == 12)begin
lcd_e <= 0;
count <= 0;
lcd_state <= lcd_state+1;
end
else
count <= count + 1;
end

21:begin
if(count == 2000)begin
count <= 0;
lcd_state <= lcd_state+1;
end 
else
count <= count + 1;
end  
//------ WRITING DATA INTO LCD //FLIGHT TAKE OFF

22:begin
lcd_e <= 1;
lcd_rs <= 1;
lcd_cmd <= 8'h46;
if(count == 12) begin
 count <= 0;
lcd_state <= lcd_state+1;
 end
 else
 count <= count + 1;
 end
  
23: begin

if(count == 12)begin
lcd_e <= 0;
count <= 0;
lcd_state <= lcd_state+1;
end
else
count <= count + 1;
end

24:begin
if(count == 2000)begin
count <= 0;
lcd_state <= lcd_state+1;
end 
else
count <= count + 1;
end  
  
25:begin
lcd_e <= 1;
lcd_rs <= 1;
lcd_cmd <= 8'h4c;
if(count == 12) begin
 count <= 0;
lcd_state <= lcd_state+1;
 end
 else
 count <= count + 1;
 end
  
26: begin

if(count == 12)begin
lcd_e <= 0;
count <= 0;
lcd_state <= lcd_state+1;
end
else
count <= count + 1;
end

27:begin
if(count == 2000)begin
count <= 0;
lcd_state <= lcd_state+1;
end 
else
count <= count + 1;
end  

28:begin
lcd_e <= 1;
lcd_rs <= 1;
lcd_cmd <= 8'h49;
if(count == 12) begin
 count <= 0;
lcd_state <= lcd_state+1;
 end
 else
 count <= count + 1;
 end
  
29: begin

if(count == 12)begin
lcd_e <= 0;
count <= 0;
lcd_state <= lcd_state+1;
end
else
count <= count + 1;
end

30:begin
if(count == 2000)begin
count <= 0;
lcd_state <= lcd_state+1;
end 
else
count <= count + 1;
end  

31:begin
lcd_e <= 1;
lcd_rs <= 1;
lcd_cmd <= 8'h47;
if(count == 12) begin
 count <= 0;
lcd_state <= lcd_state+1;
 end
 else
 count <= count + 1;
 end
  
32: begin

if(count == 12)begin
lcd_e <= 0;
count <= 0;
lcd_state <= lcd_state+1;
end
else
count <= count + 1;
end

33:begin
if(count == 2000)begin
count <= 0;
lcd_state <= lcd_state+1;
end 
else
count <= count + 1;
end
34:begin
lcd_e <= 1;
lcd_rs <= 1;
lcd_cmd <= 8'h48;
if(count == 12) begin
 count <= 0;
lcd_state <= lcd_state+1;
 end
 else
 count <= count + 1;
 end
  
35: begin

if(count == 12)begin
lcd_e <= 0;
count <= 0;
lcd_state <= lcd_state+1;
end
else
count <= count + 1;
end

36:begin
if(count == 2000)begin
count <= 0;
lcd_state <= lcd_state+1;
end 
else
count <= count + 1;
end  

37:begin
lcd_e <= 1;
lcd_rs <= 1;
lcd_cmd <= 8'h54;
if(count == 12) begin
 count <= 0;
lcd_state <= lcd_state+1;
 end
 else
 count <= count + 1;
 end
  
38: begin

if(count == 12)begin
lcd_e <= 0;
count <= 0;
lcd_state <= lcd_state+1;
end
else
count <= count + 1;
end

39:begin
if(count == 2000)begin
count <= 0;
lcd_state <= lcd_state+1;
end 
else
count <= count + 1;
end

40:begin
lcd_e <= 1;
lcd_rs <= 1;
lcd_cmd <= 8'h20;
if(count == 12) begin
 count <= 0;
lcd_state <= lcd_state+1;
 end
 else
 count <= count + 1;
 end
  
41: begin

if(count == 12)begin
lcd_e <= 0;
count <= 0;
lcd_state <= lcd_state+1;
end
else
count <= count + 1;
end

42:begin
if(count == 2000)begin
count <= 0;
lcd_state <= lcd_state+1;
end 
else
count <= count + 1;
end
43:begin
lcd_e <= 1;
lcd_rs <= 1;
lcd_cmd <= 8'h54;
if(count == 12) begin
 count <= 0;
lcd_state <= lcd_state+1;
 end
 else
 count <= count + 1;
 end
  
44: begin

if(count == 12)begin
lcd_e <= 0;
count <= 0;
lcd_state <= lcd_state+1;
end
else
count <= count + 1;
end

45:begin
if(count == 2000)begin
count <= 0;
lcd_state <= lcd_state+1;
end 
else
count <= count + 1;
end
46:begin
lcd_e <= 1;
lcd_rs <= 1;
lcd_cmd <= 8'h41;
if(count == 12) begin
 count <= 0;
lcd_state <= lcd_state+1;
 end
 else
 count <= count + 1;
 end
  
47: begin

if(count == 12)begin
lcd_e <= 0;
count <= 0;
lcd_state <= lcd_state+1;
end
else
count <= count + 1;
end

48:begin
if(count == 2000)begin
count <= 0;
lcd_state <= lcd_state+1;
end 
else
count <= count + 1;
end
49:begin
lcd_e <= 1;
lcd_rs <= 1;
lcd_cmd <= 8'h4b;
if(count == 12) begin
 count <= 0;
lcd_state <= lcd_state+1;
 end
 else
 count <= count + 1;
 end
  
50: begin

if(count == 12)begin
lcd_e <= 0;
count <= 0;
lcd_state <= lcd_state+1;
end
else
count <= count + 1;
end

51:begin
if(count == 2000)begin
count <= 0;
lcd_state <= lcd_state+1;
end 
else
count <= count + 1;
end 
52:begin
lcd_e <= 1;
lcd_rs <= 1;
lcd_cmd <= 8'h45;
if(count == 12) begin
 count <= 0;
lcd_state <= lcd_state+1;
 end
 else
 count <= count + 1;
 end
  
53: begin

if(count == 12)begin
lcd_e <= 0;
count <= 0;
lcd_state <= lcd_state+1;
end
else
count <= count + 1;
end

54:begin
if(count == 2000)begin
count <= 0;
lcd_state <= lcd_state+1;
end 
else
count <= count + 1;
end 
55:begin
lcd_e <= 1;
lcd_rs <= 1;
lcd_cmd <= 8'h4f;
if(count == 12) begin
 count <= 0;
lcd_state <= lcd_state+1;
 end
 else
 count <= count + 1;
 end
  
56: begin

if(count == 12)begin
lcd_e <= 0;
count <= 0;
lcd_state <= lcd_state+1;
end
else
count <= count + 1;
end

57:begin
if(count == 2000)begin
count <= 0;
lcd_state <= lcd_state+1;
end 
else
count <= count + 1;
end 
58:begin
lcd_e <= 1;
lcd_rs <= 1;
lcd_cmd <= 8'h46;
if(count == 12) begin
 count <= 0;
lcd_state <= lcd_state+1;
 end
 else
 count <= count + 1;
 end
  
59: begin

if(count == 12)begin
lcd_e <= 0;
count <= 0;
lcd_state <= lcd_state+1;
end
else
count <= count + 1;
end

60:begin
if(count == 2000)begin
count <= 0;
lcd_state <= lcd_state+1;
end 
else
count <= count + 1;
end 
61:begin
lcd_e <= 1;
lcd_rs <= 1;
lcd_cmd <= 8'h46;
if(count == 12) begin
 count <= 0;
lcd_state <= lcd_state+1;
 end
 else
 count <= count + 1;
 end
  
62: begin

if(count == 12)begin
lcd_e <= 0;
count <= 0;
lcd_state <= lcd_state+1;
end
else
count <= count + 1;
end

63:begin
if(count == 2000)begin
count <= 0;
lcd_state <= lcd_state+1;
end 
else
count <= count + 1;
end 
endcase
end

endcase
end
end

end

endmodule