module client_server(clk,reset,q,p);  //q=client o/p, p=server o/p
  input clk,reset;
  output reg [2:0] q,p;
  reg [2:0]prc,nxc, prs, nxs;
  parameter [2:0]oc=3'b000;           //client
  parameter [2:0]synsent=3'b001;      //client
  parameter [2:0]established=3'b010;  //client
  reg c;                              //client response
  parameter [2:0]listen=3'b011;       //server
  parameter [2:0]synrec=3'b100;       //server
  parameter [2:0]establish=3'b101;    //server
 always @(posedge clk or reset)
  begin
      if (reset==1) begin prc=oc; prs=listen; end
      else begin prc=nxc; prs=nxs; end
  end
  always @(prc or reset or clk)
  begin
  case(prc)                                                                        //client side
    oc : begin c=1; nxc=synsent; q=3'b000; end
    synsent : begin c=1; nxc=established; q=3'b001; end
    established : begin c=1; nxc=oc; q=3'b010;end
  endcase
  end

  always @(prs, reset, c)                    //server side
  begin
  case(prs)
    listen : begin p=3'b011;if(c==1) nxs=synrec;
              else nxs=listen; end
    synrec : begin p=3'b100;if(c==1) nxs=establish;
                else nxs=synrec; end
    establish : begin p=3'b101; if (c==1) nxs=listen;
              else nxs=establish;end
 endcase
 end                                            
endmodule
