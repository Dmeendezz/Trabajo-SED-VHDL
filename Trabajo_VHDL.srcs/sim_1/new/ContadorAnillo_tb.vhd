LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY ContadorAnillo_tb IS
    -- No tiene puertos ya que es un testbench
END ENTITY ContadorAnillo_tb;

ARCHITECTURE Behavioral OF ContadorAnillo_tb IS

    -- Component Declaration for the Unit Under Test (UUT)
    COMPONENT ContadorAnillo
        PORT (
            clk   : IN  std_logic;              -- Señal de reloj
            reset : IN  std_logic;              -- Señal de reset
            sel   : OUT std_logic_vector(3 DOWNTO 0) -- Salida del contador anillo
        );
    END COMPONENT;

    -- Signals for the UUT
    SIGNAL clk   : std_logic := '0';           -- Señal de reloj
    SIGNAL reset : std_logic := '0';           -- Señal de reset
    SIGNAL sel   : std_logic_vector(3 DOWNTO 0); -- Salida del contador anillo

BEGIN

    -- Instantiate the Unit Under Test (UUT)
    uut: ContadorAnillo PORT MAP (
        clk => clk,
        reset => reset,
        sel => sel
    );

    -- Clock generation process
    CLOCK_GEN : PROCESS
    BEGIN
        -- Generar reloj de 100 MHz (período de 10 ns)
        clk <= '0';
        WAIT FOR 5 ns;
        clk <= '1';
        WAIT FOR 5 ns;
    END PROCESS;

    -- Stimulus process
    STIMULUS : PROCESS
    BEGIN
        -- Reset inicial
        reset <= '1';
        WAIT FOR 20 ns;
        reset <= '0';
        
        -- Esperar y observar los cambios de la salida
        WAIT FOR 100 ns; -- Espera durante un ciclo de prueba
        reset <= '1';
        WAIT FOR 20 ns;
        reset <= '0';

        -- Agregar más estímulos si es necesario
        WAIT FOR 200 ns;
        -- Fin de la simulación
        WAIT;
    END PROCESS;

END ARCHITECTURE Behavioral;

