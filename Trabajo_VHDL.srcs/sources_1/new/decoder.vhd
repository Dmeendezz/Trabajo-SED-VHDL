LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_arith.ALL;
USE ieee.std_logic_unsigned.ALL;
ENTITY decoder IS
PORT (
code_bcd : IN std_logic_vector(3 DOWNTO 0);
led_segment : OUT std_logic_vector(6 DOWNTO 0)
);
END ENTITY decoder;


ARCHITECTURE dataflow OF decoder IS
COMPONENT decoder
END COMPONENT;
BEGIN
WITH code_bcd SELECT
led_segment <= "0000001" WHEN "0000",
"1001111" WHEN "0001", --1
"0010010" WHEN "0010", --2
"0000110" WHEN "0011", --3
"1001100" WHEN "0100",
"0100100" WHEN "0101",
"0100000" WHEN "0110",
"0001111" WHEN "0111",
"0000000" WHEN "1000",
"0000100" WHEN "1001", --9
"0000000" WHEN others; --

END ARCHITECTURE dataflow;
