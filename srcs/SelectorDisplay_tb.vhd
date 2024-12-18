library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity SelectorDisplay_tb is
end SelectorDisplay_tb;

architecture Behavioral of SelectorDisplay_tb is

    component SelectorDisplay
        Port ( 
            clk     : IN std_logic;
            reset   : IN std_logic;
            display : OUT std_logic_vector(7 DOWNTO 0)
        );
    end component;

    signal clk     : std_logic := '0';
    signal reset   : std_logic := '0';
    signal display : std_logic_vector(7 DOWNTO 0);

begin

    uut: SelectorDisplay
        Port Map (
            clk     => clk,
            reset   => reset,
            display => display
        );

    -- Generador de reloj con un período de 10 ns
    clk_process : process
    begin
        wait for 5 ns; -- Media onda
        clk <= not clk;
    end process;

    -- Proceso de estímulos
    stimulus_process : process
    begin
        -- Inicialización
        reset <= '1';       -- Activar reset
        wait for 10 ns;     -- Espera un ciclo de reloj
        reset <= '0';       -- Desactivar reset

        wait for 100 ns;
        reset <= '1';
        WAIT FOR 10 ns;
        reset <= '0';

        -- Finalizar simulación
        wait;
    end process;

end Behavioral;
