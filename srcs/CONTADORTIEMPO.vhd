library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity CONTADORTIEMPO is
    Port (
        clk       : in STD_LOGIC;                -- Reloj principal
        reset     : in STD_LOGIC;                -- Reset global
        enable    : in STD_LOGIC;                -- Entrada enable (switch)
        count_out : out INTEGER range 0 to 35999 -- Salida del contador
    );
end CONTADORTIEMPO;

architecture Behavioral of CONTADORTIEMPO is

    signal enable_100ms : STD_LOGIC;         -- Pulso cada 100ms
    signal count        : INTEGER range 0 to 35999 := 0; -- Contador interno
    signal enable_prev  : STD_LOGIC := '0'; -- Estado previo de enable
    signal counting     : STD_LOGIC := '0'; -- Señal que indica si se debe contar

    component strobe_generator
        Port (
            clk          : in std_logic;       -- Reloj de entrada (100 MHz)
            reset        : in std_logic;       -- Reset
            enable_100ms : out std_logic       -- Strobe de décima de segundo
        );
    end component;

begin

    -- Instancia del generador de pulsos
    strobe_inst: strobe_generator
    Port map (
        clk          => clk,
        reset        => reset,
        enable_100ms => enable_100ms
    );

    -- Proceso principal del contador
    process(clk, reset)
    begin
        if reset = '1' then
            count <= 0;                -- Reiniciar el contador
            counting <= '0';           -- Detener el conteo
            enable_prev <= '0';        -- Reiniciar el estado previo
        elsif rising_edge(clk) then
            -- Detectar flanco positivo de enable
            if enable = '1' and enable_prev = '0' then
                count <= 0;            -- Reiniciar el contador en flanco positivo
                counting <= '1';       -- Habilitar el conteo
            elsif enable = '1' and counting = '1' then
                -- Contar si está habilitado y llega el pulso de 100ms
                if enable_100ms = '1' then
                    if count < 35999 then
                        count <= count + 1;
                    end if;
                end if;
            elsif enable = '0' then
                counting <= '0';       -- Mantener el valor pero detener el conteo
            end if;

            -- Actualizar estado previo de enable
            enable_prev <= enable;
        end if;
    end process;

    -- Asignar la salida del contador
    count_out <= count;

end Behavioral;



