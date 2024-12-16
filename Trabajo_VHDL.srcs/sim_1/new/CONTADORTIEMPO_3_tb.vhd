library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb_CONTADORTIEMPO_3 is

end tb_CONTADORTIEMPO_3;

architecture Behavioral of tb_CONTADORTIEMPO_3 is

    
    component CONTADORTIEMPO_3
        Port (
            clk         : in STD_LOGIC;
            reset       : in STD_LOGIC;
            count_out_3 : out INTEGER range 0 to 35999
        );
    end component;

    
    signal clk       : STD_LOGIC := '0';
    signal reset     : STD_LOGIC := '0';
    signal count_out : INTEGER range 0 to 35999;

    -- Constantes
    constant CLK_PERIOD : time := 10 ns; 

begin

    
    uut: CONTADORTIEMPO_3
        Port map (
            clk         => clk,
            reset       => reset,
            count_out_3 => count_out
        );

    
    clk_process: process
    begin
        while true loop
            clk <= '0';
            wait for CLK_PERIOD / 2;
            clk <= '1';
            wait for CLK_PERIOD / 2;
        end loop;
    end process;

    
    stimulus_process: process
    begin
        --RESET INICIAL
        wait for 20 ns;
        reset <= '1';  
        wait for 20 ns;
        reset <= '0';  

        -- EL CONTADOR ALCANZA 2 
        wait for 2 * 100 ms;

        
        reset <= '1';
        wait for 20 ns;
        reset <= '0';

       
        wait for 100 ms;

        
        wait;
    end process;

end Behavioral;

