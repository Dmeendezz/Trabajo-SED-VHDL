library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity DEBOUNCER is
    Port ( 
        clk        : in STD_LOGIC;        -- Señal de reloj
        rst        : in STD_LOGIC;        -- Señal de reset
        switch     : in STD_LOGIC;        -- Entrada del switch (sincronizada)
        signal_out : out STD_LOGIC        -- Señal de salida estable
    );
end DEBOUNCER;

architecture Behavioral of DEBOUNCER is
    -- Registros internos para el debounce
    signal switch_reg     : STD_LOGIC := '0';  -- Registro del estado anterior del switch
    signal switch_stable  : STD_LOGIC := '0';  -- Switch estabilizado
    signal debounce_counter : integer range 0 to 100000 := 0; -- Contador para el debounce
begin

    -- Proceso de debounce
    process(clk, rst)
    begin
        if rst = '1' then
            -- Resetear registros y contador
            switch_reg <= '0';
            switch_stable <= '0';
            debounce_counter <= 0;
            signal_out <= '0';
        elsif rising_edge(clk) then
            -- Si la señal del switch cambió, reiniciar el contador
            if switch = switch_reg then
                -- Si la señal del switch se mantiene igual, incrementamos el contador
                if debounce_counter < 100000 then
                    debounce_counter <= debounce_counter + 1;
                else
                    -- Cuando el contador alcanza el límite, la señal del switch es estable
                    switch_stable <= switch;
                    signal_out <= switch_stable; -- Actualizamos signal_out con la señal estable
                end if;
            else
                -- Si hubo un cambio en la señal, reiniciar el contador
                debounce_counter <= 0;
            end if;

            -- Actualizar el valor del switch para la siguiente evaluación
            switch_reg <= switch_stable;
        end if;
    end process;

end Behavioral;
