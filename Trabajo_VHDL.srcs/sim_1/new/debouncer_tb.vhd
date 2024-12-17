library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity debouncer_tb is
-- No tiene puertos
end debouncer_tb;

architecture Behavioral of debouncer_tb is

    -- Componentes para instanciar el Debouncer
    component Debouncer
        Port (
            clk : in STD_LOGIC;
            rst : in STD_LOGIC;
            btn_in : in STD_LOGIC;
            btn_out : out STD_LOGIC
        );
    end component;

    -- Señales internas para la simulación
    signal clk : STD_LOGIC := '0';        -- Señal de reloj
    signal rst : STD_LOGIC := '0';        -- Señal de reset
    signal btn_in : STD_LOGIC := '0';     -- Entrada del interruptor (con rebotes)
    signal btn_out : STD_LOGIC;           -- Salida debounced

    constant CLK_PERIOD : time := 10 ns;  -- Período del reloj (100 MHz)

begin

    -- Instanciar el Debouncer
    uut : Debouncer
        Port map (
            clk => clk,
            rst => rst,
            btn_in => btn_in,
            btn_out => btn_out
        );

    -- Generador de reloj
    clk_process : process
    begin
        while true loop
            clk <= '0';
            wait for CLK_PERIOD / 2;
            clk <= '1';
            wait for CLK_PERIOD / 2;
        end loop;
    end process;

    -- Generador de estímulos
    stim_process : process
    begin
        -- Reset inicial
        rst <= '1';
        wait for 50 ns;
        rst <= '0';

        -- Simular rebotes del botón
        btn_in <= '1';
        wait for 10 ns;
        btn_in <= '0';
        wait for 10 ns;
        btn_in <= '1';
        wait for 10 ns;
        btn_in <= '0';
        wait for 100 ns; -- Esperar estabilización

        -- Señal estable
        btn_in <= '1';
        wait for 500 ns;
        btn_in <= '0';
        wait for 500 ns;

        -- Más rebotes
        btn_in <= '1';
        wait for 10 ns;
        btn_in <= '0';
        wait for 10 ns;
        btn_in <= '1';
        wait for 10 ns;
        btn_in <= '0';
        wait for 100 ns;

        -- Terminar simulación
        wait for 500 ns;
        wait;
    end process;

end Behavioral;
