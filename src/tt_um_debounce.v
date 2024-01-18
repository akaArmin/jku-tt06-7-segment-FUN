module debouncer (
    input wire clk,             // Clock input
    input wire reset,           // Reset input
    input wire button_in,       // Raw button input
    output reg debounced_out    // Debounced button output
);

    // Define FSM states
    typedef enum reg [1:0] {
        WAIT_ON_CHANGE = 2'b00,
        CHANGE_STATE   = 2'b01
    } t_fsm;

    // FSM state variables
    reg t_fsm fsm_state, next_fsm_state;

    // Additional signals
    reg [COUNTER_LEN-1:0] counter_value, next_counter_value;
    reg next_debounced_signal;

    // Debounce time constant and counter length
    parameter DEBOUNCE_TIME = 45000; // Set your debounce time here
    parameter COUNTER_LEN = 20;      // Set the length of your counter here

    // FSM Process for state transition and output
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            fsm_state <= WAIT_ON_CHANGE;
            counter_value <= 0;
            debounced_out <= 0;
        end else begin
            fsm_state <= next_fsm_state;
            counter_value <= next_counter_value;
            debounced_out <= next_debounced_signal;
        end
    end

    // Combinational logic for next state and output
    always @(*) begin
        // Default assignments
        next_fsm_state = fsm_state;
        next_counter_value = counter_value;
        next_debounced_signal = debounced_out;

        case (fsm_state)
            WAIT_ON_CHANGE: begin
                if (button_in != debounced_out) begin
                    next_fsm_state = CHANGE_STATE;
                    next_counter_value = 0;
                end
            end

            CHANGE_STATE: begin
                if (button_in == debounced_out) begin
                    next_fsm_state = WAIT_ON_CHANGE;
                end else if (counter_value >= DEBOUNCE_TIME) begin
                    next_fsm_state = WAIT_ON_CHANGE;
                    next_debounced_signal = button_in;
                end else begin
                    next_counter_value = counter_value + 1;
                end
            end

            default: begin
                next_fsm_state = WAIT_ON_CHANGE;
                next_debounced_signal = 0;
            end
        endcase
    end

endmodule
