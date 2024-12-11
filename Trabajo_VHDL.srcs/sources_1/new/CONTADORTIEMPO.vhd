library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity CONTADORTIEMPO is
    Port (
        clk       : in STD_LOGIC;               -- Señal de reloj
        enable    : in STD_LOGIC;               -- Señal de habilitación
        count_out : out INTEGER range 0 to 35999 -- Salida del contador (0 a 35999, limite de tiempo 1h)
    );
end CONTADORTIEMPO;

architecture Behavioral of CONTADORTIEMPO is
    signal count : INTEGER range 0 to 35999 := 0; -- Contador interno
begin
    process(clk)
    begin
        if rising_edge(clk) then
            if enable = '1' then
                if count = 35999 then
                    count <= 0; -- Reinicia el contador al alcanzar 35999
                else
                    count <= count + 1; -- Incrementa el contador
                end if;
            elsif enable = '0' then
                count <= 0;
            end if;
        end if;
    end process;

    count_out <= count; -- Asigna el valor del contador interno a la salida
end Behavioral;
