module viterbi_decoder(y,clk,reset,x);
  output reg x;
  input clk,reset;
  input [1:0]y;
  parameter s0=2'b00; //Set values for 4 states
  parameter s1=2'b01;
  parameter s2=2'b10;
  parameter s3=2'b11;
  reg [1:0]pr_state,nx_state;
  
  always @(posedge clk, reset,pr_state,x)
  begin
    if(reset)
      pr_state=s0; //Start with state 00
  else begin pr_state=nx_state; $display (pr_state); end
    case(pr_state)
      s0:
      begin
        if(y==2'b00)
          begin
          nx_state=s0;
          x=1'b0;
          end
        else 
           begin
           nx_state=s1;
           x=1'b1;
           end
      end
    s1:
     begin
        if(y==2'b10)
        begin
        nx_state=s2;
        x=1'b0;
        end
        else
        begin
        nx_state=s3;
        x=1'b1;
        end
     end
     s2:
      begin
        if(y==2'b00) 
        begin 
        nx_state=s1;
        x=1'b1;
        end
        else  
        begin 
        nx_state=s0;
        x=1'b0;
        end
     end
     s3:
      begin
        if(y==2'b10)
        begin
        nx_state=s3;
        x=1'b1;
        end
        else 
        begin 
        nx_state=s2;
        x=1'b0;
        end
      end
  endcase
  end
endmodule
