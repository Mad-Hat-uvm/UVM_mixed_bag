module perf_counter(
    input logic         clk,      //Clock input
    input logic         reset,    //Synchronous active-high reset
    input logic         enable,   //Enable counting
    input logic         valid,    //Source valid
    input logic         ready,    //Receiver ready
    output logic [3:0]  count     //4-bit counter
);

always_ff @(posedge clk) begin
    if (reset)
    count <= 4'd0;
    else if (enable && valid && ready)
     count <= (count == 4'd15) ? 4'd0 : count + 1;
end

endmodule