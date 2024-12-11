library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity strobe_generator is
    Port (
        clk      : in std_logic;       -- Reloj de entrada (50 MHz)
        reset    : in std_logic;       -- Reset
        enable_100ms : out std_logic     -- Strobe de décima de segundo
    );
end strobe_generator;

architecture Behavioral of strobe_generator is
    constant COUNT_MAX : natural := 5000000 - 1; -- Ciclos para 0.1 s. 
                                                 -- Hay que mirar cual es la frecuencia del clock para hacer N (ciclos) = f x 0,1s. 
                                                 -- N está calculado para una f de 50 MHz -> N = 5000000
    signal counter : natural range 0 to COUNT_MAX := 0;
begin

    process(clk, reset)
    begin
        if reset = '1' then
            counter <= 0;
            enable_100ms <= '0';
        elsif rising_edge(clk) then
            if counter = COUNT_MAX then
                counter <= 0;
                enable_100ms <= '1'; -- Genera el pulso
            else
                counter <= counter + 1;
                enable_100ms <= '0';
            end if;
        end if;
    end process;
    
    --Rama J Gasco

end Behavioral;

