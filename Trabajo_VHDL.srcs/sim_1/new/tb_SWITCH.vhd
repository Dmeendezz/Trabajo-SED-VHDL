library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Testbench para el componente LedSwitchEnable
entity tb_SWITCH is
end tb_SWITCH;

architecture behavior of tb_SWITCH is

    -- Se declaran las señales internas para conectar con el diseño
    signal switch : STD_LOGIC := '0';      -- Interruptor
    signal rst : STD_LOGIC := '0';         -- Señal de reset
    signal enable : STD_LOGIC;             -- Señal de enable
    signal led : STD_LOGIC;                -- Señal del LED

    -- Componente que vamos a probar
    component LedSwitchEnable is
        Port ( switch : in STD_LOGIC;
               rst : in STD_LOGIC;
               enable : out STD_LOGIC;
               led : out STD_LOGIC );
    end component;

begin

    -- Instanciación del componente
    uut: LedSwitchEnable
        port map (
            switch => switch,
            rst => rst,
            enable => enable,
            led => led
        );

    -- Proceso para generar los estímulos de prueba
    stimulus: process
    begin
        -- Test 1: Reset en 1 (restablecer el sistema)
        rst <= '1'; 
        wait for 10 ns;
        rst <= '0';  -- Restablecer rst a 0
        wait for 10 ns;

        -- Test 2: Flanco ascendente en el interruptor (switch)
        switch <= '0';
        wait for 5 ns;
        switch <= '1';  -- Flanco ascendente
        wait for 10 ns;

        -- Test 3: Flanco descendente en el interruptor (switch)
        switch <= '1';
        wait for 5 ns;
        switch <= '0';  -- Flanco descendente
        wait for 10 ns;

        -- Test 4: Sin cambios en el interruptor (no debe haber cambios)
        wait for 10 ns;
        
        -- Test 5: Flanco ascendente después del reset
        switch <= '0';
        wait for 5 ns;
        switch <= '1';  -- Flanco ascendente
        wait for 10 ns;

        -- Test 6: Reset de nuevo
        rst <= '1';
        wait for 10 ns;
        rst <= '0';
        wait for 10 ns;

        -- Test 7: Sin acción, debería mantener el estado
        switch <= '0';
        wait for 10 ns;
        switch <= '1';
        wait for 10 ns;
        
        -- Finalizar la simulación
        wait;
    end process;

end behavior;

