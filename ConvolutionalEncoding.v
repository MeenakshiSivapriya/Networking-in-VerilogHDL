module ce(x,clk,reset,y);
  input x;
  input clk,reset;
  output reg[1:0]y;
  parameter s0=2'b00;     //constants to represent the 4 states
  parameter s1=2'b01;
  parameter s2=2'b10;
  parameter s3=2'b11;
  reg [1:0]pr_state,nx_state;  //registers that hold the present and next state value
  always @(posedge clk, reset,pr_state,x)
  begin //building the fsm
    if(reset)
      pr_state=s0;
  else pr_state=nx_state;
    case(pr_state)
      s0:
      begin
        if(x==0)
          begin
          nx_state=s0;
          y=2'b00;
          end
        else 
           begin
           nx_state=s1;
           y=2'b11;
           end
      end
    s1:
     begin
        if(x==0)
        begin
        nx_state=s2;
        y=2'b10;
        end
        else
        begin
        nx_state=s3;
        y=2'b01;
        end
     end
     s2:
      begin
        if(x==0) 
        begin 
        nx_state=s0;
        y=2'b11;
        end
        else  
        begin 
        nx_state=s1;
        y=2'b00;
        end
     end
     s3:
      begin
        if(x==0)
        begin
        nx_state=s2;
        y=2'b01;
        end
        else 
        begin 
        nx_state=s3;
        y=2'b10;
        end
      end
  endcase
  end
endmodule
