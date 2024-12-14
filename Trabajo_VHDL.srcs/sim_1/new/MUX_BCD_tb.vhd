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

    -- Generador de estímulos
    stimulus_process : PROCESS
    BEGIN
        -- Inicialización de entradas
        bcd0 <= "0000";
        bcd1 <= "0001";
        bcd2 <= "0010";
        bcd3 <= "0011";
        bcd7 <= "0111";

        -- Reset inicial
        reset <= '1';
        WAIT FOR 10 ns;
        reset <= '0';
        
        wait for 100 ns;
        reset <= '1';
        WAIT FOR 10 ns;
        reset <= '0';

        -- Finalizar la simulación
        WAIT;
    END PROCESS;

END ARCHITECTURE behavior;
