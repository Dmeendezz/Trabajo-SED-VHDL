library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity debouncer is
    Port (
        CLK : in STD_LOGIC;         -- Reloj del sistema
        RESET : in STD_LOGIC;       -- Señal de reinicio
        SIGNAL_IN : in STD_LOGIC;   -- Señal con posibles rebotes
        SIGNAL_OUT : out STD_LOGIC  -- Señal estable
    );
end debouncer;

architecture Behavioral of debouncer is
    signal sync_1, sync_2 : STD_LOGIC := '0';  -- Sincronización
    signal counter : integer := 0;            -- Contador para el filtro temporal
    signal signal_out_reg : STD_LOGIC := '0'; -- Señal interna para reflejar SIGNAL_OUT
    constant DEBOUNCE_TIME : integer := 10;   -- Tiempo de espera en ciclos de reloj
begin
    -- Asignar la señal interna a la salida
    SIGNAL_OUT <= signal_out_reg;

    process (CLK, RESET)
    begin
        if RESET = '1' then
            sync_1 <= '0';
            sync_2 <= '0';
            counter <= 0;
            signal_out_reg <= '0'; -- Reiniciar la señal interna
        elsif rising_edge(CLK) then
            -- Sincronización
            sync_1 <= SIGNAL_IN;
            sync_2 <= sync_1;

            -- Filtro temporal
            if sync_2 /= signal_out_reg then
                counter <= counter + 1;
                if counter >= DEBOUNCE_TIME then
                    signal_out_reg <= sync_2; -- Actualizar la salida cuando el estado sea estable
                    counter <= 0;            -- Reiniciar el contador
                end if;
            else
                counter <= 0; -- Si no hay cambio, reiniciar contador
            end if;
        end if;
    end process;

end Behavioral;
