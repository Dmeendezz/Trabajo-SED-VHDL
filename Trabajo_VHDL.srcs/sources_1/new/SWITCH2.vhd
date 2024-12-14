library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity SWITCH2 is
    Port ( 
        switch2 : in STD_LOGIC;      -- Interruptor 2
        rst : in STD_LOGIC;          -- Señal de reset
        led2 : out STD_LOGIC         -- LED 2
    );
end SWITCH2;

architecture Behavioral of SWITCH2 is
begin

    -- Proceso para controlar el comportamiento del sistema
    process(switch2, rst)
    begin
        if rst = '1' then
            -- Reset del sistema
            led2 <= '0';
        else
            -- Control del LED 2
            if rising_edge(switch2) then
                led2 <= '1';
            elsif falling_edge(switch2) then
                led2 <= '0';
            end if;
        end if;
    end process;

end Behavioral;
