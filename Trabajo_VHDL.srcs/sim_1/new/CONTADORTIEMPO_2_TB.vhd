library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity CONTADORTIEMPO_2_tb is
   
end CONTADORTIEMPO_2_tb;

architecture Behavioral of CONTADORTIEMPO_2_tb is
    
    signal clk         : std_logic := '0';
    signal reset       : std_logic := '0';
    signal count_out_2 : integer range 0 to 499;
    signal enable_100ms : std_logic := '0';

    
    constant clk_period : time := 10 ns; 

    
    component CONTADORTIEMPO_2
        Port (
            clk       : in std_logic;
            reset     : in std_logic;
            count_out_2 : out integer range 0 to 499
        );
    end component;

begin
    
    DUT: CONTADORTIEMPO_2
        Port map (
            clk       => clk,
            reset     => reset,
            count_out_2 => count_out_2
        );

    
    clk_process: process
    begin
        while true loop
            clk <= not clk;
            wait for clk_period / 2; 
        end loop;
    end process;

   
    strobe_process: process
    begin
        while true loop
            enable_100ms <= '1';
            wait for 10 ms; 
            enable_100ms <= '0';
            wait for 90 ms; 
        end loop;
    end process;

   
    test_process: process
    begin
        -- RESETEA INICIALMENTE
        reset <= '1';
        wait for 50 ns; 
        reset <= '0';

        -- CUENTA HASTA 4
        wait for 0.4 sec; 
        assert count_out_2 = 4 report "Error: El contador no llegó a 4" severity error;

        -- CUANDO LLEGA A 4 RESET
        reset <= '1';
        wait for 50 ns; 
        reset <= '0';
        assert count_out_2 = 0 report "Error: El contador no se reinició correctamente" severity error;

       
        wait for 0.1 sec;
        assert false report "Fin de la simulación" severity note;
        wait;
    end process;

end Behavioral;


