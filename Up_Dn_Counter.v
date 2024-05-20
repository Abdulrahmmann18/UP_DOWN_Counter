module Up_Dn_Counter (
    input wire  CLK, Up, Down, Load,
    input wire [4:0] IN,
    output reg [4:0] Counter,
    output High, Low
);
    // internal signals
    reg [4:0] Counter_comb;
    // combinational 
    always @(*) begin
        if (Load)
          Counter_comb = IN;
        else if (Down && ~Low)
          Counter_comb = Counter - 1;
        else if (Up && ~Down && ~High)
          Counter_comb = Counter + 1;
    end
    // sequintial
    always @(posedge CLK) begin
        Counter <= Counter_comb;
    end
    // output flags
    assign High = (Counter == 5'd31) ? 1'b1 : 1'b0;
    assign Low = (Counter == 5'd0) ? 1'b1 : 1'b0;
endmodule