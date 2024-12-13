LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY int_to_bcd IS
  PORT (
    num : IN integer; --ENTRADA ENTERO
    bcd : OUT std_logic_vector(15 DOWNTO 0) -- 4 BCD
  );
END ENTITY;

ARCHITECTURE behavior OF int_to_bcd IS
BEGIN
  PROCESS(num)
    VARIABLE num_multiplied : integer;
  BEGIN
    
    num_multiplied := num * 2; -- PREICO POR MINUTO PONER EL INDICADO

    
    IF (num_multiplied >= 0 AND num_multiplied <= 9999) THEN
      
      bcd(15 DOWNTO 12) <= std_logic_vector(to_unsigned((num_multiplied / 1000) MOD 10, 4)); -- Miles
      bcd(11 DOWNTO 8)  <= std_logic_vector(to_unsigned((num_multiplied / 100) MOD 10, 4)); -- Centenas
      bcd(7 DOWNTO 4)   <= std_logic_vector(to_unsigned((num_multiplied / 10) MOD 10, 4));  -- Decenas
      bcd(3 DOWNTO 0)   <= std_logic_vector(to_unsigned(num_multiplied MOD 10, 4));         -- Unidades
    ELSE
      -- SI ESTA FUERA DE RANGO
      bcd <= (OTHERS => '0');
    END IF;
  END PROCESS;
END ARCHITECTURE;


