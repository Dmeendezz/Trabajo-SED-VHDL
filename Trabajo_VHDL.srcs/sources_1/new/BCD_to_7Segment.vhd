LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY BCD_to_7Segment IS
    PORT (
        bcd    : IN  std_logic_vector(3 DOWNTO 0); -- Entrada BCD de 4 bits
        seg    : OUT std_logic_vector(6 DOWNTO 0)  -- Salida para los 7 segmentos
    );
END ENTITY BCD_to_7Segment;

ARCHITECTURE behavior OF BCD_to_7Segment IS

BEGIN
    PROCESS(bcd)
    BEGIN
        CASE bcd IS
        when "0000" => seg <= "0000001"; -- 0
        when "0001" => seg <= "1001111"; -- 1
        when "0010" => seg <= "0010010"; -- 2
        when "0011" => seg <= "0000110"; -- 3
        when "0100" => seg <= "1001100"; -- 4
        when "0101" => seg <= "0100100"; -- 5
        when "0110" => seg <= "0100000"; -- 6
        when "0111" => seg <= "0001111"; -- 7
        when "1000" => seg <= "0000000"; -- 8
        when "1001" => seg <= "0000100"; -- 9
        when others => seg <= "1111111"; -- Todos apagados
        END CASE;
    END PROCESS;
END ARCHITECTURE behavior;
