LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY MUX_BCD_tb IS
END ENTITY MUX_BCD_tb;

ARCHITECTURE behavior OF MUX_BCD_tb IS

    -- Declaración del DUT
    COMPONENT MUX_BCD
        PORT (
            bcd0    : IN std_logic_vector(3 DOWNTO 0);
            bcd1    : IN std_logic_vector(3 DOWNTO 0);
            bcd2    : IN std_logic_vector(3 DOWNTO 0);
            bcd3    : IN std_logic_vector(3 DOWNTO 0);
            bcd7    : IN std_logic_vector(3 DOWNTO 0);
            clk     : IN std_logic;
            reset   : IN std_logic;
            bcd_out : OUT std_logic_vector(3 DOWNTO 0)
        );
    END COMPONENT;

    -- Señales internas para el DUT
    SIGNAL bcd0, bcd1, bcd2, bcd3, bcd7 : std_logic_vector(3 DOWNTO 0);
    SIGNAL clk                          : std_logic := '0';
    SIGNAL reset                        : std_logic := '0';
    SIGNAL bcd_out                      : std_logic_vector(3 DOWNTO 0);
    SIGNAL sel_cnt : std_logic_vector(2 DOWNTO 0);  -- Señal de selección del contador anillo

BEGIN

    -- Instanciación del DUT
    uut: MUX_BCD
        PORT MAP (
            bcd0    => bcd0,
            bcd1    => bcd1,
            bcd2    => bcd2,
            bcd3    => bcd3,
            bcd7    => bcd7,
            clk     => clk,
            reset   => reset,
            bcd_out => bcd_out
        );

    -- Generador de reloj con un período de 10 ns
    clk_process : PROCESS
    BEGIN
        WAIT FOR 5 ns; -- Media onda
        clk <= NOT clk;
    END PROCESS;
 -- Generación del contador anillo (sel_cnt)
    sel_cnt_process : PROCESS
    BEGIN
        -- Primero, inicializamos el contador
        sel_cnt <= "000";
        WAIT FOR 20 ns;
        
        -- Ahora cambiamos los valores de sel_cnt simulando el contador anillo
        sel_cnt <= "001";  -- Cambia a "001"
        WAIT FOR 20 ns;
        
        sel_cnt <= "010";  -- Cambia a "010"
        WAIT FOR 20 ns;
        
        sel_cnt <= "011";  -- Cambia a "011"
        WAIT FOR 20 ns;
        
        sel_cnt <= "100";  -- Cambia a "100"
        WAIT FOR 20 ns;
        
        sel_cnt <= "101";  -- Cambia a "101"
        WAIT FOR 20 ns;
        
        sel_cnt <= "110";  -- Cambia a "110"
        WAIT FOR 20 ns;
        
        sel_cnt <= "111";  -- Cambia a "111"
        WAIT FOR 20 ns;

        -- Fin de la simulación
        WAIT;
    END PROCESS;

    -- Inicialización de las señales de entrada
    stimulus_process : PROCESS
    BEGIN
        -- Inicialización de las señales
        bcd0 <= "0000";  -- Valor de BCD0
        bcd1 <= "0001";  -- Valor de BCD1
        bcd2 <= "0010";  -- Valor de BCD2
        bcd3 <= "0011";  -- Valor de BCD3
        bcd7 <= "0111";  -- Valor de BCD7
        reset <= '0';

        -- Prueba de reset
        WAIT FOR 20 ns;
        reset <= '1';  -- Activa el reset
        WAIT FOR 20 ns;
        reset <= '0';  -- Desactiva el reset
        
        -- Esperamos que el contador se actualice para verificar las salidas
        WAIT FOR 20 ns;

        -- Fin de la simulación
        WAIT;
    END PROCESS;

END ARCHITECTURE behavior;
