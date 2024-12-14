library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity SWITCH3_tb is
end SWITCH3_tb;

architecture behavior of SWITCH3_tb is

    -- Declaración de señales internas
    signal switch3_tb : STD_LOGIC := '0'; -- Señal del interruptor (switch3)
    signal rst : STD_LOGIC := '0';        -- Señal de reset
    signal led3 : STD_LOGIC;              -- Señal del LED (led3)

    -- Declaración del componente a probar (DUT)
    component SWITCH3 is
        Port (
            switch3 : in STD_LOGIC;
            rst : in STD_LOGIC;
            led3 : out STD_LOGIC
        );
    end component;

begin

    -- Instancia del componente SWITCH3
    uut: SWITCH3
        port map (
            switch3 => switch3_tb, -- Conectar señal de prueba al DUT
            rst => rst,
            led3 => led3
        );

    -- Proceso para generar estímulos de prueba
    stimulus: process
    begin
        -- Escenario 1: Reset activo (LED apagado)
        rst <= '1'; 
        wait for 10 ns;
        rst <= '0'; -- Desactivar reset
        wait for 10 ns;

        -- Escenario 2: Flanco ascendente en switch3 (LED encendido)
        switch3_tb <= '0'; -- Inicialmente apagado
        wait for 5 ns;
        switch3_tb <= '1'; -- Flanco ascendente
        wait for 10 ns;

        -- Escenario 3: Flanco descendente en switch3 (LED apagado)
        switch3_tb <= '1'; -- Mantener encendido
        wait for 5 ns;
        switch3_tb <= '0'; -- Flanco descendente
        wait for 10 ns;

        -- Escenario 4: Secuencia rápida de flancos (Toggle rápido)
        switch3_tb <= '1'; -- Flanco ascendente
        wait for 2 ns;
        switch3_tb <= '0'; -- Flanco descendente
        wait for 2 ns;
        switch3_tb <= '1'; -- Flanco ascendente
        wait for 2 ns;
        switch3_tb <= '0'; -- Flanco descendente
        wait for 10 ns;

        -- Escenario 5: Switch3 activado durante reset
        switch3_tb <= '1'; -- Interruptor activo
        wait for 5 ns;
        rst <= '1'; -- Activar reset
        wait for 10 ns;
        rst <= '0'; -- Desactivar reset
        wait for 10 ns;

        -- Escenario 6: Sin cambios en switch3 (LED debe mantener su estado)
        switch3_tb <= '0'; -- Mantener apagado
        wait for 20 ns;
        switch3_tb <= '1'; -- Mantener encendido
        wait for 20 ns;

        -- Finalizar simulación
        wait;
    end process;

end behavior;
