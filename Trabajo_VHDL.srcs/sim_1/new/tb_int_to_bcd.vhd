LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY tb_int_to_bcd IS
-- Testbench no tiene puertos
END ENTITY;

ARCHITECTURE behavior OF tb_int_to_bcd IS
  -- Componentes del DUT (Device Under Test)
  COMPONENT int_to_bcd
    PORT (
      num : IN integer;
      bcd : OUT std_logic_vector(15 DOWNTO 0)
    );
  END COMPONENT;

  -- Señales para conectar al DUT
  SIGNAL num : integer := 0;
  SIGNAL bcd : std_logic_vector(15 DOWNTO 0);

BEGIN
  
  uut: int_to_bcd
    PORT MAP (
      num => num,
      bcd => bcd
    );


  stim_proc: PROCESS
  BEGIN
    -- SI HAN PASADO 123 MIN
    num <= 123;
    WAIT FOR 50 ns;
    ASSERT bcd = "000000111110" -- BCD esperado: 246 (123 * 2)
      REPORT "Error: num = 123, BCD incorrecto" SEVERITY ERROR;

    -- SI HA PASADO 50 MIN
    num <= 50;
    WAIT FOR 50 ns;
    ASSERT bcd = "000001100100" -- BCD esperado: 100 (50 * 2)
      REPORT "Error: num = 50, BCD incorrecto" SEVERITY ERROR;

    -- SI HAN PASADO 0 MIN
    num <= 0;
    WAIT FOR 50 ns;
    ASSERT bcd = "000000000000" -- BCD esperado: 0
      REPORT "Error: num = 0, BCD incorrecto" SEVERITY ERROR;

    -- SIN HAN PASADO 5000 MIN (ERROR)
    num <= 5000;
    WAIT FOR 50 ns;
    ASSERT bcd = "000000000000" -- BCD esperado: fuera de rango, todo ceros
      REPORT "Error: num = 4999, BCD incorrecto" SEVERITY ERROR;

    -- SI HAN PASADO 200 MIN
    num <= 200;
    WAIT FOR 50 ns;
    ASSERT bcd = "000011001000" -- BCD esperado: 400 (200 * 2)
      REPORT "Error: num = 200, BCD incorrecto" SEVERITY ERROR;

    -- SI HAN PASADO 3456 MIN
    num <= 3456;
    WAIT FOR 50 ns;
    ASSERT bcd = "011010110100" -- BCD esperado: 6912 (3456 * 2)
      REPORT "Error: num = 3456, BCD incorrecto" SEVERITY ERROR;

    -- SI HA PASADO 1 MIN
    num <= 1;
    WAIT FOR 50 ns;
    ASSERT bcd = "000000000010" -- BCD esperado: 2 (1 * 2)
      REPORT "Error: num = 1, BCD incorrecto" SEVERITY ERROR;

    
    WAIT;
  END PROCESS;
END ARCHITECTURE;


