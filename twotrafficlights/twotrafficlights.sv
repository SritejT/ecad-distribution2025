module twotrafficlights(
      input  logic clk,
      input  logic rst,
      output logic [2:0] lightsA, 
      output logic [2:0] lightsB
    );
  logic [2:0] state;
  
  always_ff @(posedge clk or posedge rst)
   begin
      if (rst)
        state <= 0;
      else
        state <= state + 1;
   end


  always_comb
    begin
      case (state)
        3'd0: begin
          lightsA = 3'd4;
          lightsB = 3'd6;
        end
        3'd1: begin
          lightsA = 3'd4;
          lightsB = 3'd1;
        end
        3'd2: begin
          lightsA = 3'd4;
          lightsB = 3'd2;
        end
        3'd3: begin
          lightsA = 3'd4;
          lightsB = 3'd4;
        end
        3'd4: begin
          lightsA = 3'd6;
          lightsB = 3'd4;
        end
        3'd5: begin
          lightsA = 3'd1;
          lightsB = 3'd4;
        end
        3'd6: begin
          lightsA = 3'd2;
          lightsB = 3'd4;
        end
        default: begin
          lightsA = 3'd4;
          lightsB = 3'd4;
        end
      endcase
    end


endmodule

