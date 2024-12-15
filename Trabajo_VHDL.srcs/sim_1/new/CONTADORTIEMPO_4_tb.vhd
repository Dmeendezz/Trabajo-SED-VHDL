library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb_CONTADORTIEMPO_4 is

end tb_CONTADORTIEMPO_4;

architecture Behavioral of tb_CONTADORTIEMPO_4 is

    
    component CONTADORTIEMPO_4
        Port (
            clk         : in STD_LOGIC;
            reset       : in STD_LOGIC;
            count_out_4 : out INTEGER range 0 to 35999
        );
    end component;

    -- Señales internas para conectar con el DUT
    signal clk       : STD_LOGIC := '0';
    signal reset     : STD_LOGIC := '0';
    signal count_out : INTEGER range 0 to 35999;

    -- Constantes
    constant CLK_PERIOD : time := 10 ns; -- Periodo del reloj (100 MHz)

begin

    -- Instancia del DUT (Device Under Test)
    uut: CONTADORTIEMPO_4
        Port map (
            clk         => clk,
            reset       => reset,
            count_out_4 => count_out
        );

    -- Generación del reloj
    clk_process: process
    begin
        while true loop
            clk <= '0';
            wait for CLK_PERIOD / 2;
            clk <= '1';
            wait for CLK_PERIOD / 2;
        end loop;
    end process;

    -- Proceso de estímulo
    stimulus_process: process
    begin
        -- Inicialización
        wait for 20 ns;
        reset <= '1';  -- Activa el reset
        wait for 20 ns;
        reset <= '0';  -- Desactiva el reset

        -- Esperar hasta que el contador alcance 2
        wait for 2 * 100 ms;

        -- Activar reset nuevamente
        reset <= '1';
        wait for 20 ns;
        reset <= '0';

        -- Esperar para observar el comportamiento
        wait for 100 ms;

        -- Finalizar simulación
        wait;
    end process;

end Behavioral;

