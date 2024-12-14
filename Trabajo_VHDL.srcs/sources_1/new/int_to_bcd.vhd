LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY int_to_bcd IS
  PORT (
    num       : IN integer;                  
    unidades  : OUT std_logic_vector(3 DOWNTO 0); 
    decenas   : OUT std_logic_vector(3 DOWNTO 0); 
    centenas  : OUT std_logic_vector(3 DOWNTO 0); 
    millares  : OUT std_logic_vector(3 DOWNTO 0)  
  );
END ENTITY;

ARCHITECTURE behavior OF int_to_bcd IS
BEGIN
  PROCESS(num)
    VARIABLE num_multiplied : integer;
  BEGIN
    num_multiplied := num * 2; --MULTIPLICACION PRECIO POR MINUTO.

    IF (num_multiplied >= 0 AND num_multiplied <= 9999) THEN
      
      millares <= std_logic_vector(to_unsigned((num_multiplied / 1000) MOD 10, 4));
      centenas <= std_logic_vector(to_unsigned((num_multiplied / 100) MOD 10, 4));
      decenas  <= std_logic_vector(to_unsigned((num_multiplied / 10) MOD 10, 4));
      unidades <= std_logic_vector(to_unsigned(num_multiplied MOD 10, 4));
    ELSE
      -- SI ESTA FUERA DE RANGO 
      millares <= (OTHERS => '0');
      centenas <= (OTHERS => '0');
      decenas  <= (OTHERS => '0');
      unidades <= (OTHERS => '0');
    END IF;
  END PROCESS;
END ARCHITECTURE;


