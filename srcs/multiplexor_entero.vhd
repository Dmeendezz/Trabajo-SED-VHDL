library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity multiplexor_entero is
    Port (
        sel : in STD_LOGIC_VECTOR(1 downto 0); -- Selector de 2 bits
        plaza1 : in INTEGER; -- Salida del contador de la plaza 1
        plaza2 : in INTEGER; -- Salida del contador de la plaza 2
        plaza3 : in INTEGER; -- Salida del contador de la plaza 3
        plaza4 : in INTEGER; -- Salida del contador de la plaza 4
        salida : out INTEGER -- Salida seleccionada
    );
end multiplexor_entero;

architecture Behavioral of multiplexor_entero is
signal salida_i: integer;
begin
    process(sel, plaza1, plaza2, plaza3, plaza4)
    begin
        case sel is
            when "00" =>
                salida_i <= plaza1; -- Selecciona la plaza 1
            when "01" =>
                salida_i <= plaza2; -- Selecciona la plaza 2
            when "10" =>
                salida_i <= plaza3; -- Selecciona la plaza 3
            when "11" =>
                salida_i <= plaza4; -- Selecciona la plaza 4
            when others =>
                salida_i <= 0; -- Default: salida a 0
        end case;
    end process;
    salida <= salida_i;
end Behavioral;
