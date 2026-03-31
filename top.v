`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/26/2026 12:28:18 PM
// Design Name: 
// Module Name: top
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module top(
    input [15:0] sw,
    input btnC,
    output [15:0] led
);
    d_latch part1(
        .D(sw[0]),
        .Q(led[0]),
        .NotQ(led[1]),
        .E(btnC)
    );
    memory_system part2(
        .data(sw[15:8]),
        .addr(sw[7:6]),
        .store(btnC),
        .memory(led[15:8])
    );

endmodule

module d_latch(
    input D, E,
    output reg Q,
    output NotQ
);

    always @(D,E) begin
        if (E)
            Q <= D;
    end
       
    assign NotQ = ~Q;
endmodule

module memory_system(
    input [7:0] data,
    input store, // store and enable are interchangeable
    input [1:0] addr,
    output [7:0] memory

);
    reg [7:0] demux_o [3:0];
    wire [7:0] memIn [3:0];
    
    reg demux_s [3:0];
    // This should instantiate 4 instances of
    // byte_memory, and then demultiplex
    // data and store into the one selected by
    // addr
    
    // data demux
    always @(*) begin
        case(addr)
            2'b00: {demux_o[3], demux_o[2], demux_o[1], demux_o[0]} <= {8'b0, 8'b0, 8'b0, data};
            2'b01: {demux_o[3], demux_o[2], demux_o[1], demux_o[0]} <= {8'b0, 8'b0, data, 8'b0};
            2'b10: {demux_o[3], demux_o[2], demux_o[1], demux_o[0]} <= {8'b0, data, 8'b0, 8'b0}; 
            2'b11: {demux_o[3], demux_o[2], demux_o[1], demux_o[0]} <= {data, 8'b0, 8'b0, 8'b0};   
        endcase
    end
    
    // store demux
    always @(*) begin
        case(addr)
            2'b00: {demux_s[3], demux_s[2], demux_s[1], demux_s[0]} <= {1'b0, 1'b0, 1'b0, store};
            2'b01: {demux_s[3], demux_s[2], demux_s[1], demux_s[0]} <= {1'b0, 1'b0, store, 1'b0};
            2'b10: {demux_s[3], demux_s[2], demux_s[1], demux_s[0]} <= {1'b0, store, 1'b0, 1'b0}; 
            2'b11: {demux_s[3], demux_s[2], demux_s[1], demux_s[0]} <= {store, 1'b0, 1'b0, 1'b0};   
        endcase
    end
    
    
    byte_memory B0 (
        .data(demux_o[0]),
        .store(demux_s[0]),
        .memory(memIn[0])
    );
    
    byte_memory B1 (
        .data(demux_o[1]),
        .store(demux_s[1]),
        .memory(memIn[1])
    );
    
    byte_memory B2 (
        .data(demux_o[2]),
        .store(demux_s[2]),
        .memory(memIn[2])
    );
    
    byte_memory B3 (
        .data(demux_o[3]),
        .store(demux_s[3]),
        .memory(memIn[3])
    );
        
       
    // It should then multiplex the output of the
    // memory specified by addr into the memory
    // output for display on the LEDs
    
    assign memory = 
               addr == 2'b00 ? memIn[0]:
               addr == 2'b01 ? memIn[1]:
               addr == 2'b10 ? memIn[2]: memIn[3];

    // you will need 2 demultiplexers:
    // 1. Demultiplex data -> selected byte
    // 2. Demultiplex store -> selected byte

    // and one multiplexer:
    // 1. Multiplex selected byte -> memory

endmodule

//module mux_4to1(
//    input [7:0] data0,
//    input [7:0] data1,
//    input [7:0] data2,
//    input [7:0] data3,
//    input [1:0] Sel,
//    output [7:0] Y
//);
//    assign Y = 
//               Sel == 2'b00 ? data0:
//               Sel == 2'b01 ? data1:
//               Sel == 2'b10 ? data3: data3;
               
      
//endmodule

module byte_memory(
    input [7:0] data,
    input store,
    output reg [7:0] memory
);

    // Herein, implement D-Latch style memory
    // that stores the input data into memory
    // when store is high
    always @(store, data) begin
        if (store)
            memory <= data;
    end

    // Memory should always output the value
    // stored, and it should only change
    // when store is high

endmodule