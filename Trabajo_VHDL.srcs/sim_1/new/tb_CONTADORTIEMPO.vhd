library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_CONTADORTIEMPO is
-- El testbench no tiene puertos
end tb_CONTADORTIEMPO;

architecture Behavioral of tb_CONTADORTIEMPO is
    -- Señales para conectar al contador
    signal clk       : STD_LOGIC := '0';           -- Señal de reloj
    signal enable    : STD_LOGIC := '0';           -- Señal de habilitación
    signal count_out : INTEGER range 0 to 35999;   -- Salida del contador

    -- Instancia del componente a probar
    component CONTADORTIEMPO
        Port (
            clk       : in STD_LOGIC;
            enable    : in STD_LOGIC;
            count_out : out INTEGER range 0 to 35999
        );
    end component;

begin
    -- Instancia del contador
    uut: CONTADORTIEMPO
        Port map (
            clk       => clk,
            enable    => enable,
            count_out => count_out
        );

    -- Generador de reloj: Periodo de 0.1 segundos (100 ms)
    process
    begin
        while True loop
            clk <= '0';
            wait for 50 ms; -- Medio periodo
            clk <= '1';
            wait for 50 ms; -- Medio periodo
        end loop;
    end process;

    -- Proceso de prueba
    process
    begin
        -- Inicialización
        wait for 0.2 sec; -- Espera inicial de 200 ms para estabilizar

        -- Prueba 1: Habilitar el contador y observar el incremento
        enable <= '1';  -- Habilitamos el contador
        wait for 1 sec; -- Espera 1 segundo para observar el conteo

        -- Prueba 2: Deshabilitar el contador y verificar que se detiene
        enable <= '0';  -- Deshabilitamos el contador
        wait for 0.5 sec; -- Observamos el comportamiento con el enable desactivado

        -- Prueba 3: Habilitar el contador nuevamente
        enable <= '1';  -- Volvemos a habilitarlo
        wait for 1 sec; -- Observamos el conteo por 1 segundo

        -- Finalizar la simulación
        wait;
    end process;
end Behavioral;
