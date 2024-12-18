LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY tb_int_to_bcd IS

END ENTITY;

ARCHITECTURE behavior OF tb_int_to_bcd IS

  
  COMPONENT int_to_bcd
    PORT (
      num       : IN integer;
      unidades  : OUT std_logic_vector(3 DOWNTO 0);
      decenas   : OUT std_logic_vector(3 DOWNTO 0);
      centenas  : OUT std_logic_vector(3 DOWNTO 0);
      millares  : OUT std_logic_vector(3 DOWNTO 0)
    );
  END COMPONENT;

  
  SIGNAL num       : integer := 0;
  SIGNAL unidades  : std_logic_vector(3 DOWNTO 0);
  SIGNAL decenas   : std_logic_vector(3 DOWNTO 0);
  SIGNAL centenas  : std_logic_vector(3 DOWNTO 0);
  SIGNAL millares  : std_logic_vector(3 DOWNTO 0);

BEGIN

  
  uut: int_to_bcd
    PORT MAP (
      num       => num,
      unidades  => unidades,
      decenas   => decenas,
      centenas  => centenas,
      millares  => millares
    );

  
  stimulus: PROCESS
  BEGIN
    -- 0 MINUTOS
    num <= 0;
    WAIT FOR 50 ns;

    -- 1234 MINUTOS
    num <= 1234;
    WAIT FOR 50 ns;

    -- 9999 MINUTOS
    num <= 9999;
    WAIT FOR 50 ns;

    -- 4567 MINUTOS
    num <= 4567;
    WAIT FOR 50 ns;

    -- 1 MINUTO 
    num <= 1;
    WAIT FOR 50 ns;

    -- 10000 MINUTOS (ERROR. FUERA DE RANGO)
    num <= 10000;
    WAIT FOR 50 ns;

    -- -123 MINUTOS (ERROR. FUERA DE RANGO)
    num <= -123;
    WAIT FOR 50 ns;


    WAIT;
  END PROCESS;

END ARCHITECTURE;



