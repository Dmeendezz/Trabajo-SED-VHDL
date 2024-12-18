library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity strobe_generator_tb is
end entity strobe_generator_tb;

architecture behavior of strobe_generator_tb is
    -- Component declaration
    component strobe_generator
        Port (
            clk        : in std_logic;
            reset      : in std_logic;
            enable_100ms : out std_logic
        );
    end component;

    -- Signals to connect to the component
    signal clk       : std_logic := '0';
    signal reset     : std_logic := '0';
    signal enable_100ms: std_logic;

    -- Clock period constant (for a 100 MHz clock)
    constant clk_period : time := 10 ns;  -- 50 MHz clock

begin
    -- Instantiate the strobe_generator
    uut: strobe_generator
        port map (
            clk        => clk,
            reset      => reset,
            enable_100ms => enable_100ms
        );

    -- Clock generation process
    clk_process :process
    begin
        clk <= '0';
        wait for clk_period / 2;
        clk <= '1';
        wait for clk_period / 2;
    end process;

    -- Stimulus process
    stimulus_process :process
    begin
        -- Apply reset
        reset <= '1';
        wait for 50 ns;
        reset <= '0';  -- Release reset

        -- Run simulation for 1 second
        wait for 1000000000 ns; 

        -- End of simulation
        assert false report "Simulation completed" severity note;
        wait;
    end process;
    
end behavior;
