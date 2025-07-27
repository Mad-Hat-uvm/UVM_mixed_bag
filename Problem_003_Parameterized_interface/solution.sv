interface stream_if #(parameter N = 4) (
    input logic clk,
    input logic rst
);

//Signal declarations
logic                 valid;
logic signed bit[7:0] data[N];

//Clocking block for timing abstraction
clocking cb@(posedge clk);
    default input #1step output #1 step;

    output valid;
    output data;

endclocking

//Modport for driver
modport drv(
    input clk, rst_n,
    output valid,
    output data,
    clocking cb
);

modport mon(
    input clk, rst_n,
    input valid,
    input data,
    clocking cb
);

endinterface