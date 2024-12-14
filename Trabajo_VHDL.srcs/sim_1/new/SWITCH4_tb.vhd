library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity SWITCH4_tb is
end SWITCH4_tb;

architecture behavior of SWITCH4_tb is

    -- Declaración de señales internas
    signal switch4_tb : STD_LOGIC := '0'; -- Señal del interruptor (switch4)
    signal rst : STD_LOGIC := '0';        -- Señal de reset
    signal led4 : STD_LOGIC;              -- Señal del LED (led4)

    -- Declaración del componente a probar (DUT)
    component SWITCH4 is
        Port (
            switch4 : in STD_LOGIC;
            rst : in STD_LOGIC;
            led4 : out STD_LOGIC
        );
    end component;

begin

    -- Instancia del componente SWITCH4
    uut: SWITCH4
        port map (
            switch4 => switch4_tb, -- Conectar señal de prueba al DUT
            rst => rst,
            led4 => led4
        );

    -- Proceso para generar estímulos de prueba
    stimulus: process
    begin
        -- Escenario 1: Reset activo (LED apagado)
        rst <= '1'; 
        wait for 10 ns;
        rst <= '0'; -- Desactivar reset
        wait for 10 ns;

        -- Escenario 2: Flanco ascendente en switch4 (LED encendido)
        switch4_tb <= '0'; -- Inicialmente apagado
        wait for 5 ns;
        switch4_tb <= '1'; -- Flanco ascendente
        wait for 10 ns;

        -- Escenario 3: Flanco descendente en switch4 (LED apagado)
        switch4_tb <= '1'; -- Mantener encendido
        wait for 5 ns;
        switch4_tb <= '0'; -- Flanco descendente
        wait for 10 ns;

        -- Escenario 4: Secuencia rápida de flancos (Toggle rápido)
        switch4_tb <= '1'; -- Flanco ascendente
        wait for 2 ns;
        switch4_tb <= '0'; -- Flanco descendente
        wait for 2 ns;
        switch4_tb <= '1'; -- Flanco ascendente
        wait for 2 ns;
        switch4_tb <= '0'; -- Flanco descendente
        wait for 10 ns;

        -- Escenario 5: Switch4 activado durante reset
        switch4_tb <= '1'; -- Interruptor activo
        wait for 5 ns;
        rst <= '1'; -- Activar reset
        wait for 10 ns;
        rst <= '0'; -- Desactivar reset
        wait for 10 ns;

        -- Escenario 6: Sin cambios en switch4 (LED debe mantener su estado)
        switch4_tb <= '0'; -- Mantener apagado
        wait for 20 ns;
        switch4_tb <= '1'; -- Mantener encendido
        wait for 20 ns;

        -- Finalizar simulación
        wait;
    end process;

end behavior;
