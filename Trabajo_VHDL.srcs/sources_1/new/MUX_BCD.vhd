LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY MUX_BCD IS
    PORT (
        bcd0    : IN std_logic_vector(3 DOWNTO 0); -- Entrada BCD0
        bcd1    : IN std_logic_vector(3 DOWNTO 0); -- Entrada BCD1
        bcd2    : IN std_logic_vector(3 DOWNTO 0); -- Entrada BCD2
        bcd3    : IN std_logic_vector(3 DOWNTO 0); -- Entrada BCD3
        sel     : IN std_logic_vector(3 DOWNTO 0);  -- Selección de entrada (4 bits)
        bcd_out : OUT std_logic_vector(3 DOWNTO 0)  -- Salida: 1 BCD de 4 bits
    );
END ENTITY MUX_BCD;

ARCHITECTURE behavior OF MUX_BCD IS
BEGIN
    PROCESS(bcd0, bcd1, bcd2, bcd3, sel)
    BEGIN
        CASE sel IS
            WHEN "0001" => bcd_out <= bcd0;   -- Seleccionar BCD0
            WHEN "0010" => bcd_out <= bcd1;   -- Seleccionar BCD1
            WHEN "0100" => bcd_out <= bcd2;   -- Seleccionar BCD2
            WHEN "1000" => bcd_out <= bcd3;   -- Seleccionar BCD3
            WHEN OTHERS => bcd_out <= "0000"; -- Valor por defecto
        END CASE;
    END PROCESS;
END ARCHITECTURE behavior;