library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Entidad del testbench
entity debouncer_tb is
end debouncer_tb;

architecture Behavioral of debouncer_tb is

    -- Señales para conectar al DUT (Device Under Test)
    signal CLK : STD_LOGIC := '0';
    signal RESET : STD_LOGIC := '0';
    signal SIGNAL_IN : STD_LOGIC := '0';
    signal SIGNAL_OUT : STD_LOGIC;

    -- Período del reloj
    constant CLK_PERIOD : time := 10 ns;

begin

    -- Instancia del DUT
    DUT: entity work.debouncer
        port map (
            CLK => CLK,
            RESET => RESET,
            SIGNAL_IN => SIGNAL_IN,
            SIGNAL_OUT => SIGNAL_OUT
        );

    -- Proceso para generar el reloj
    clk_process: process
    begin
        while true loop
            CLK <= '0';
            wait for CLK_PERIOD / 2;
            CLK <= '1';
            wait for CLK_PERIOD / 2;
        end loop;
        wait;
    end process;

    -- Proceso para generar estímulos
    stimulus_process: process
    begin
        -- Reinicio inicial
        RESET <= '1';
        wait for 20 ns;
        RESET <= '0';

        -- Caso 1: Señal estable baja
        SIGNAL_IN <= '0';
        wait for 200 ns;

        -- Caso 2: Señal estable alta
        SIGNAL_IN <= '1';
        wait for 200 ns;

        -- Caso 3: Señal con rebotes y reinicio en medio
        SIGNAL_IN <= '0';
        wait for 50 ns;
        SIGNAL_IN <= '1';
        wait for 10 ns;
        SIGNAL_IN <= '0';
        wait for 10 ns;
        RESET <= '1';
        wait for 20 ns;
        RESET <= '0';

        -- Caso 4: Señal larga alrededor de 600 ns
        wait for 600 ns;
        SIGNAL_IN <= '1';
        wait for 300 ns;
        SIGNAL_IN <= '0';
        wait for 300 ns;

        -- Caso 5: Señales cortas alrededor de 800 ns
        wait for 800 ns;
        SIGNAL_IN <= '1';
        wait for 5 ns;
        SIGNAL_IN <= '0';
        wait for 5 ns;
        SIGNAL_IN <= '1';
        wait for 5 ns;
        SIGNAL_IN <= '0';
        wait for 5 ns;

        -- Caso 6: Señales cortas alrededor de 900 ns
        wait for 900 ns;
        SIGNAL_IN <= '1';
        wait for 5 ns;
        SIGNAL_IN <= '0';
        wait for 5 ns;
        SIGNAL_IN <= '1';
        wait for 5 ns;
        SIGNAL_IN <= '0';
        wait for 5 ns;

        -- Caso 7: Señales cortas alrededor de 950 ns
        wait for 950 ns;
        SIGNAL_IN <= '1';
        wait for 5 ns;
        SIGNAL_IN <= '0';
        wait for 5 ns;
        SIGNAL_IN <= '1';
        wait for 5 ns;
        SIGNAL_IN <= '0';
        wait for 5 ns;

        -- Finalizar la simulación
        wait;
    end process;

end Behavioral;
