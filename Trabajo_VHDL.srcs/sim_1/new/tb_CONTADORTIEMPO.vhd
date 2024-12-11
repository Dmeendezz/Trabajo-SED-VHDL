library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity CONTADORTIEMPO_TB is
-- Testbench no tiene puertos
end CONTADORTIEMPO_TB;

architecture Behavioral of CONTADORTIEMPO_TB is

    -- Señales para el DUT (Device Under Test)
    signal clk       : std_logic := '0'; -- Reloj principal
    signal reset     : std_logic := '0'; -- Señal de reset
    signal count_out : integer range 0 to 35999;
    signal enable_100ms : std_logic; -- Señal de strobe para observación

    -- Constante para generar el reloj a 100 MHz
    constant CLOCK_PERIOD : time := 10 ns; -- Periodo del reloj principal (100 MHz)

    -- Instancia del DUT
    component CONTADORTIEMPO
        Port (
            clk       : in STD_LOGIC;
            reset     : in STD_LOGIC;
            count_out : out INTEGER range 0 to 35999
        );
    end component;

    component strobe_generator
        Port (
            clk         : in std_logic;
            reset       : in std_logic;
            enable_100ms : out std_logic
        );
    end component;

begin

    -- Instancia del módulo CONTADORTIEMPO
    DUT: CONTADORTIEMPO
        port map (
            clk       => clk,
            reset     => reset,
            count_out => count_out
        );

    -- Instancia del generador de strobe para observación
    STROBE_INST: strobe_generator
        port map (
            clk         => clk,
            reset       => reset,
            enable_100ms => enable_100ms
        );

    -- Generador del reloj
    clk_process: process
    begin
            clk <= '0';
            wait for CLOCK_PERIOD /2;
            clk <= '1';
            wait for CLOCK_PERIOD /2;
    end process;

    -- Estímulos de prueba
    stimulus_process: process
    begin
        -- Inicialización
        reset <= '1';
        wait for 50 ns; -- Mantén el reset activo por un breve periodo
        reset <= '0';-- Espera unos ciclos para observar el comportamiento del contador
        wait for 120 ms;
        reset <= '1';
        wait for 50 ns; -- Mantén el reset activo por un breve periodo
        reset <= '0';

        wait for 1 sec;

        -- Finaliza la simulación
        wait;
    end process;

end Behavioral;

