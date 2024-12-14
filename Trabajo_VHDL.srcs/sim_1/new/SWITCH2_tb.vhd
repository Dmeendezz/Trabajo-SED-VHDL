library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity SWITCH2_tb is
end SWITCH2_tb;

architecture behavior of SWITCH2_tb is

    -- Declaración de señales internas
    signal switch2_tb : STD_LOGIC := '0'; -- Señal del interruptor (switch2)
    signal rst : STD_LOGIC := '0';        -- Señal de reset
    signal led2 : STD_LOGIC;              -- Señal del LED (led2)

    -- Declaración del componente a probar (DUT)
    component SWITCH2 is
        Port (
            switch2 : in STD_LOGIC;
            rst : in STD_LOGIC;
            led2 : out STD_LOGIC
        );
    end component;

begin

    -- Instancia del componente SWITCH2
    uut: SWITCH2
        port map (
            switch2 => switch2_tb, -- Conectar señal de prueba al DUT
            rst => rst,
            led2 => led2
        );

    -- Proceso para generar estímulos de prueba
    stimulus: process
    begin
        -- Escenario 1: Reset activo (LED apagado)
        rst <= '1'; 
        wait for 10 ns;
        rst <= '0'; -- Desactivar reset
        wait for 10 ns;

        -- Escenario 2: Flanco ascendente en switch2 (LED encendido)
        switch2_tb <= '0'; -- Inicialmente apagado
        wait for 5 ns;
        switch2_tb <= '1'; -- Flanco ascendente
        wait for 10 ns;

        -- Escenario 3: Flanco descendente en switch2 (LED apagado)
        switch2_tb <= '1'; -- Mantener encendido
        wait for 5 ns;
        switch2_tb <= '0'; -- Flanco descendente
        wait for 10 ns;

        -- Escenario 4: Secuencia rápida de flancos (Toggle rápido)
        switch2_tb <= '1'; -- Flanco ascendente
        wait for 2 ns;
        switch2_tb <= '0'; -- Flanco descendente
        wait for 2 ns;
        switch2_tb <= '1'; -- Flanco ascendente
        wait for 2 ns;
        switch2_tb <= '0'; -- Flanco descendente
        wait for 10 ns;

        -- Escenario 5: Switch2 activado durante reset
        switch2_tb <= '1'; -- Interruptor activo
        wait for 5 ns;
        rst <= '1'; -- Activar reset
        wait for 10 ns;
        rst <= '0'; -- Desactivar reset
        wait for 10 ns;

        -- Escenario 6: Sin cambios en switch2 (LED debe mantener su estado)
        switch2_tb <= '0'; -- Mantener apagado
        wait for 20 ns;
        switch2_tb <= '1'; -- Mantener encendido
        wait for 20 ns;

        -- Finalizar simulación
        wait;
    end process;

end behavior;

