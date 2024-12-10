library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity strobe_generator is
    Port (
        clk      : in std_logic;       -- Reloj de entrada (50 MHz)
        reset    : in std_logic;       -- Reset
        enable_1ms : out std_logic     -- Strobe de décima de segundo
    );
end strobe_generator;

architecture Behavioral of strobe_generator is
    constant COUNT_MAX : natural := 5000000 - 1; -- Ciclos para 0.1 s
    signal counter : natural range 0 to COUNT_MAX := 0;
begin

    process(clk, reset)
    begin
        if reset = '1' then
            counter <= 0;
            enable_1ms <= '0';
        elsif rising_edge(clk) then
            if counter = COUNT_MAX then
                counter <= 0;
                enable_1ms <= '1'; -- Genera el pulso
            else
                counter <= counter + 1;
                enable_1ms <= '0';
            end if;
        end if;
    end process;

end Behavioral;

