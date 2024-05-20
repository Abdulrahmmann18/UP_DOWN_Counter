module Up_Dn_Counter_tb ();
    
    // signal declaration
    reg  CLK, Up_tb, Down_tb, Load_tb;
    reg [4:0] IN_tb;
    wire High_tb, Low_tb;
    wire [4:0] Counter_tb;

    // DUT instantiation
    Up_Dn_Counter DUT (
        .CLK(CLK), .Up(Up_tb), .Down(Down_tb),
        .Load(Load_tb), .IN(IN_tb), .Counter(Counter_tb),
        .High(High_tb), .Low(Low_tb)
    );

    // clock generation block
    always begin
        #4 CLK = ~CLK;
    end

    // Test stimulus
    initial begin
        // initialize all inputs
        CLK = 0;  Load_tb = 1'b1;  IN_tb = 5'd4;  Down_tb = 1'b0;  Up_tb = 1'b0;
        // case(1) test that conter_tb is loaded from IN_tb ( check the highest priority )            
        #24
        // case(2) test the down counter operation ( the second highest priority )
        Load_tb = 1'b0;  Down_tb = 1'b1;  Up_tb = 1'b1;
        #24
        // case(3) test the low flag and check that counter holds the value 0
        #24
        // case(4) reload the counter then test the up counter operation ( the lowest priority )
        Load_tb = 1'b1;  IN_tb = 5'd26;  
        #8
        Load_tb = 1'b0;  Down_tb = 1'b0;  Up_tb = 1'b1;
        #24
        // case(5) test the high flag and check that counter holds the value 31  
        #40
        $stop;
    end

endmodule