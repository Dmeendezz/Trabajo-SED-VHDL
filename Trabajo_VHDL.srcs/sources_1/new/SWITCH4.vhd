library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity SWITCH4 is
    Port (
        switch4 : in STD_LOGIC;  -- Interruptor para SWITCH4
        rst : in STD_LOGIC;      -- Señal de reset
        led4 : out STD_LOGIC     -- Señal del LED para SWITCH4
    );
end SWITCH4;

architecture Behavioral of SWITCH4 is
begin

    process(switch4, rst)
    begin
        if rst = '1' then
            -- Si rst está activo, el LED se apaga
            led4 <= '0';
        elsif rising_edge(switch4) then
            -- Flanco ascendente: encender el LED
            led4 <= '1';
        elsif falling_edge(switch4) then
            -- Flanco descendente: apagar el LED
            led4 <= '0';
        end if;
    end process;

end Behavioral;
