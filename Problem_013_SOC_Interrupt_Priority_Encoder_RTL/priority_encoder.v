module priority_encoder(
  input  logic [7:0] irq_req,     //Interrupt request lines
  output logic [2:0] irq_id,      //Index of highest priority active reset 
  output logic       valid        //At least one interrupt active
);

always comb begin
    valid = 1'b1;
    unique casez(irq_req)
        8'b1???????: irq_id = 3'd7;
        8'b01??????: irq_id = 3'd6;
        8'b001?????: irq_id = 3'd5;
        8'b0001????: irq_id = 3'd4;
        8'b00001???: irq_id = 3'd3;
        8'b000001??: irq_id = 3'd2;
        8'b0000001?: irq_id = 3'd1;
        8'b00000001: irq_id = 3'd0;
        
        default:  begin   
            irq_id = 3'd0;
            valid  = 0;
        end
    endcase
end
endmodule