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

    -- Componente que genera la señal de 100ms
    component strobe_generator
        Port (
            clk          : in STD_LOGIC;       
            reset        : in STD_LOGIC;      
            enable_100ms : out STD_LOGIC     
        );
    end component;

begin

    -- Instancia del generador de 100ms
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
            count <= 0;                -- Reset global
            enable_prev <= '0';        -- Reiniciar el estado previo
        elsif rising_edge(clk) then
            -- Detectar flancos de enable
            if enable = '1' and enable_prev = '0' then  -- Flanco positivo
                count <= 0;            -- Reiniciar contador
            elsif enable = '0' and enable_prev = '1' then  -- Flanco negativo
                -- Mantener la cuenta (no se hace nada)
                null;
            elsif enable = '1' then
                -- Contar si enable está activo y llega el pulso de 100ms
                if enable_100ms = '1' then
                    if count < 35999 then
                        count <= count + 1;
                    end if;
                end if;
            end if;

            -- Actualizar estado previo
            enable_prev <= enable;
        end if;
    end process;

    -- Asignar salida
    count_out <= count;

end Behavioral;



