library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity CONTADORTIEMPO_2_tb is

end CONTADORTIEMPO_2_tb;

architecture Behavioral of CONTADORTIEMPO_2_tb is
   
    component CONTADORTIEMPO_2
        Port (
            clk       : in STD_LOGIC;
            reset     : in STD_LOGIC;
            enable_2    : in STD_LOGIC;
            count_out_2 : out INTEGER range 0 to 35999
        );
    end component;

    signal clk       : STD_LOGIC := '0';
    signal reset     : STD_LOGIC := '0';
    signal enable_2    : STD_LOGIC := '1';
    signal count_out_2 : INTEGER range 0 to 35999;

    constant CLK_PERIOD : time := 10 ns; 

begin
    
    uut: CONTADORTIEMPO_2
        Port map (
            clk       => clk,
            reset     => reset,
            enable_2    => enable_2,
            count_out_2 => count_out_2
        );

    clk_process : process
    begin
        while true loop
            clk <= '0';
            wait for CLK_PERIOD / 2;
            clk <= '1';
            wait for CLK_PERIOD / 2;
        end loop;
    end process;

    -- Stimulus process
    stimulus: process
    begin
        -- COMPROBAMOS QUE EL CONTADOR LLEGA A 1 Y ACTIVAMOS RESET
        wait for 160 ms; 
        
        reset <= '1';
        wait for 20 ns;
        reset <= '0';

        --AL ACTIVAR RESET SE DESACTIVA ENABLE HASTA DETECTAR FLANCO POSITIVO
        enable_2 <= '0';
        wait for 10 ms;
        enable_2 <= '1';

        wait for 120 ms;
        --SE DESACTIVA ENABLE Y VULEVE A EMPEZAR EL CONTADOR
        enable_2 <= '0';
        wait for 10 ms;
        enable_2 <= '1';

        wait for 50 ms;
        assert false report "Simulation finished successfully" severity note;
        wait;
    end process;

end Behavioral;