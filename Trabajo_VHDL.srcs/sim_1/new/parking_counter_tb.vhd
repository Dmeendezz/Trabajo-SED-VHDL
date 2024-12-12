library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity parking_counter_tb is
-- Testbench no tiene puertos
end parking_counter_tb;

architecture Behavioral of parking_counter_tb is

    -- Declaración del componente a probar
    component parking_counter
        Port (
            reset : in STD_LOGIC;
            plaza_1 : in STD_LOGIC;
            plaza_2 : in STD_LOGIC;
            plaza_3 : in STD_LOGIC;
            plaza_4 : in STD_LOGIC;
            plazas_libres : out STD_LOGIC_VECTOR(3 downto 0)
        );
    end component;

    -- Señales para conectar al DUT (Device Under Test)
    signal reset : STD_LOGIC := '0';
    signal plaza_1 : STD_LOGIC := '0';
    signal plaza_2 : STD_LOGIC := '0';
    signal plaza_3 : STD_LOGIC := '0';
    signal plaza_4 : STD_LOGIC := '0';
    signal plazas_libres : STD_LOGIC_VECTOR(3 downto 0);

begin

    -- Instancia del componente bajo prueba (DUT)
    uut: parking_counter
        Port map (
            reset => reset,
            plaza_1 => plaza_1,
            plaza_2 => plaza_2,
            plaza_3 => plaza_3,
            plaza_4 => plaza_4,
            plazas_libres => plazas_libres
        );

    -- Proceso de estimulación
    stimulus_process : process
    begin
        -- Escenario 1: Reinicio del sistema
        reset <= '1'; -- Activar reset
        wait for 20 ns;
        reset <= '0'; -- Desactivar reset
        wait for 20 ns;

        -- Escenario 2: Flancos positivos en las señales (incrementa plazas libres)
        plaza_1 <= '1'; -- Flanco positivo en plaza_1
        wait for 20 ns;
        plaza_2 <= '1'; -- Flanco positivo en plaza_2
        wait for 20 ns;
        plaza_3 <= '1'; -- Flanco positivo en plaza_3
        wait for 20 ns;
        plaza_4 <= '1'; -- Flanco positivo en plaza_4
        wait for 20 ns;

        -- Escenario 3: Flancos negativos en las señales (decrementa plazas libres)
        plaza_1 <= '0'; -- Flanco negativo en plaza_1
        wait for 20 ns;
        plaza_2 <= '0'; -- Flanco negativo en plaza_2
        wait for 20 ns;
        plaza_3 <= '0'; -- Flanco negativo en plaza_3
        wait for 20 ns;
        plaza_4 <= '0'; -- Flanco negativo en plaza_4
        wait for 20 ns;

        -- Escenario 4: Actividad mixta
        plaza_1 <= '1'; -- Flanco positivo en plaza_1
        wait for 20 ns;
        plaza_2 <= '0'; -- Flanco negativo en plaza_2
        wait for 20 ns;
        plaza_3 <= '1'; -- Flanco positivo en plaza_3
        wait for 20 ns;
        plaza_4 <= '0'; -- Flanco negativo en plaza_4
        wait for 20 ns;

        -- Escenario 5: Comprobar que las plazas pueden quedar todas libres
        plaza_1 <= '0';
        plaza_2 <= '0';
        plaza_3 <= '1';
        plaza_4 <= '0';
        wait for 40 ns;
        
         plaza_1 <= '0';
        plaza_2 <= '0';
        plaza_3 <= '0';
        plaza_4 <= '0';
        wait for 40 ns;
        

        -- Finalizar simulación
        wait;
    end process;

end Behavioral;

