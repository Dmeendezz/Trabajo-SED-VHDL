library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity parking_fsm_tb is
-- Testbench no tiene puertos
end parking_fsm_tb;

architecture Behavioral of parking_fsm_tb is

    -- Component declaration
    component parking_fsm
        Port (
            reset : in STD_LOGIC;
            plaza_1 : in STD_LOGIC;
            plaza_2 : in STD_LOGIC;
            plaza_3 : in STD_LOGIC;
            plaza_4 : in STD_LOGIC;
            salida : out STD_LOGIC_VECTOR(1 downto 0)
        );
    end component;

    -- Signals to connect to the DUT (Device Under Test)
    signal reset : STD_LOGIC := '0';
    signal plaza_1 : STD_LOGIC := '1';
    signal plaza_2 : STD_LOGIC := '1';
    signal plaza_3 : STD_LOGIC := '1';
    signal plaza_4 : STD_LOGIC := '1';
    signal salida : STD_LOGIC_VECTOR(1 downto 0);

begin

    -- Instantiate the Unit Under Test (UUT)
    uut: parking_fsm
        Port map (
            reset => reset,
            plaza_1 => plaza_1,
            plaza_2 => plaza_2,
            plaza_3 => plaza_3,
            plaza_4 => plaza_4,
            salida => salida
        );

    -- Stimulus process
    stimulus_process : process
    begin
        -- Test 1: Reset the system
        reset <= '1';
        wait for 20 ms;
        reset <= '0';
        wait for 20 ms;

        -- Test 2: Flanco negativo en plaza_1
        plaza_1 <= '0';
        wait for 20 ms;
        plaza_2 <= '0';      
        wait for 20 ms;
        
        -- Test 3: Flanco negativo en plaza_2
        plaza_1 <= '1';
        wait for 20 ms;
        plaza_2 <= '1';
        wait for 20 ms;

        -- Test 4: Flanco negativo en plaza_3
        plaza_3 <= '0';
        wait for 20 ms;
        plaza_3 <= '1';
        wait for 20 ms;

        -- Test 5: Flanco negativo en plaza_4
        plaza_4 <= '0';
        wait for 20 ms;
        plaza_4 <= '1';
        wait for 20 ms;

        -- Test 6: Reset nuevamente
        reset <= '1';
        wait for 20 ms;
        reset <= '0';
        wait for 20 ms;
        
        reset <='1';
        wait for 20 ms;
        reset <= '0';
        wait for 20 ms;

        -- Stop simulation
        wait;
    end process;

end Behavioral;

