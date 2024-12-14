library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity SWITCH is
    Port ( 
        switch : in STD_LOGIC;       -- Interruptor (switch)
        rst : in STD_LOGIC;          -- Señal de reset
        led : out STD_LOGIC          -- Señal del LED
    );
end SWITCH;

architecture Behavioral of SWITCH is
begin

    -- Proceso para controlar el comportamiento del sistema
    process(switch, rst)
    begin
        if rst = '1' then
            -- Si rst está activo (en 1), se restablece el sistema
            led <= '0';
        elsif rising_edge(switch) then
            -- Si el interruptor tiene un flanco ascendente
            led <= '1';
        elsif falling_edge(switch) then
            -- Si el interruptor tiene un flanco descendente
            led <= '0';
        end if;
    end process;

end Behavioral;
