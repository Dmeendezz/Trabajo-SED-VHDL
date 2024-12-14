library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity SWITCH3 is
    Port (
        switch3 : in STD_LOGIC;  -- Interruptor para SWITCH3
        rst : in STD_LOGIC;      -- Señal de reset
        led3 : out STD_LOGIC     -- Señal del LED para SWITCH3
    );
end SWITCH3;

architecture Behavioral of SWITCH3 is
begin

    process(switch3, rst)
    begin
        if rst = '1' then
            -- Si rst está activo, el LED se apaga
            led3 <= '0';
        elsif rising_edge(switch3) then
            -- Flanco ascendente: encender el LED
            led3 <= '1';
        elsif falling_edge(switch3) then
            -- Flanco descendente: apagar el LED
            led3 <= '0';
        end if;
    end process;

end Behavioral;
