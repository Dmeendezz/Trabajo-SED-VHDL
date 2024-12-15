library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity CONTADORTIEMPO_2 is
    Port (
        clk       : in STD_LOGIC;               -- Reloj principal de 100 MHz
        reset     : in STD_LOGIC;               -- Señal de reset
        count_out_2 : out INTEGER range 0 to 35999 -- Salida del contador (0 a 35999)
    );
end CONTADORTIEMPO_2;

architecture Behavioral of CONTADORTIEMPO_2 is
    -- Señales internas para el generador de strobe
    signal enable_100ms : STD_LOGIC;        -- Pulso generado cada 0.1 segundos (enable)
    
    -- Contador de tiempo
    signal count_2 : INTEGER range 0 to 35999 := 0; -- Contador interno

    -- Componente strobe_generator
    component strobe_generator
        Port (
            clk         : in std_logic;       -- Reloj de entrada (100 MHz)
            reset       : in std_logic;       -- Reset
            enable_100ms : out std_logic      -- Pulso de 0.1 segundos
        );
    end component;

begin
    -- Instancia del generador de strobe
    strobe_inst: strobe_generator
        Port map (                         -- IZQ: IN/OUT componente, DER: IN/OUT/señales contador (top)
            clk         => clk,            -- Reloj de entrada (100 MHz)
            reset       => reset,          -- Reset
            enable_100ms => enable_100ms   -- Pulso de 0.1 segundos
        );

    -- Proceso que implementa el contador
    process(clk, reset)
    begin
        if reset = '1' then
            count_2 <= 0;  -- Reinicia el contador
        elsif rising_edge(clk) then         -- Sincronización con el reloj principal
            if enable_100ms = '1' then      -- Solo cuenta cuando el strobe está activo
                if count_2 = 35999 then
                    count_2 <= 0;             -- Reinicia el contador al alcanzar 35999
                else
                    count_2 <= count_2 + 1;     -- Incrementa el contador
                end if;
            end if;
        end if;
    end process;

    -- Asigna la salida del contador
    count_out_2 <= count_2;

end Behavioral;
