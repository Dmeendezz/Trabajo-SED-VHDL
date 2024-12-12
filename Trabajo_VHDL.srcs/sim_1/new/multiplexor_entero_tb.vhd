library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity multiplexor_entero_tb is
-- No ports for a testbench
end multiplexor_entero_tb;

architecture Behavioral of multiplexor_entero_tb is

    -- Component declaration for the Unit Under Test (UUT)
    component multiplexor_entero
        Port (
            sel : in STD_LOGIC_VECTOR(1 downto 0);
            plaza1 : in INTEGER;
            plaza2 : in INTEGER;
            plaza3 : in INTEGER;
            plaza4 : in INTEGER;
            salida : out INTEGER
        );
    end component;

    -- Signals to connect to UUT
    signal sel : STD_LOGIC_VECTOR(1 downto 0) := "00";
    signal plaza1 : INTEGER := 0;
    signal plaza2 : INTEGER := 0;
    signal plaza3 : INTEGER := 0;
    signal plaza4 : INTEGER := 0;
    signal salida : INTEGER;

begin

    -- Instantiate the Unit Under Test (UUT)
    uut: multiplexor_entero
        Port map (
            sel => sel,
            plaza1 => plaza1,
            plaza2 => plaza2,
            plaza3 => plaza3,
            plaza4 => plaza4,
            salida => salida
        );

    -- Stimulus process
    stim_proc: process
    begin
        -- Test case 1: Select plaza1
        plaza1 <= 15; plaza2 <= 25; plaza3 <= 35; plaza4 <= 45;
        sel <= "00";
        wait for 10 ns;

        -- Test case 2: Select plaza2
        sel <= "01";
        wait for 10 ns;

        -- Test case 3: Select plaza3
        sel <= "10";
        wait for 10 ns;

        -- Test case 4: Select plaza4
        sel <= "11";
        wait for 10 ns;

        -- Test case 5: Default case (Invalid selector)
        sel <= "XX";
        wait for 10 ns;

        -- End simulation
        wait;
    end process;

end Behavioral;

