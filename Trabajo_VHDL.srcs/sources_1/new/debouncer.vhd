library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Debouncer is
    Port (
        clk : in STD_LOGIC;          -- Señal de reloj
        rst : in STD_LOGIC;          -- Señal de reset
        btn_in : in STD_LOGIC;       -- Entrada del interruptor (con rebotes)
        btn_out : out STD_LOGIC      -- Salida debounced
    );
end Debouncer;

architecture Behavioral of Debouncer is
    signal counter : unsigned(19 downto 0) := (others => '0'); -- Contador para temporización
    signal btn_sync : STD_LOGIC := '0';                       -- Señal sincronizada con el reloj
    signal btn_stable : STD_LOGIC := '0';                     -- Estado estable del botón
begin

    process(clk, rst)
    begin
        if rst = '1' then
            counter <= (others => '0');
            btn_sync <= '0';
            btn_stable <= '0';
        elsif rising_edge(clk) then
            -- Sincronizar la entrada del botón con el reloj
            btn_sync <= btn_in;

            -- Si el botón cambia, reinicia el contador
            if btn_sync /= btn_stable then
                counter <= (others => '0');
            else
                -- Incrementa el contador si no hay cambios
                if counter < 1_000_000 then -- Ajusta según el tiempo de debounce deseado
                    counter <= counter + 1;
                else
                    -- Si el contador alcanza el valor máximo, actualiza el estado estable
                    btn_stable <= btn_sync;
                end if;
            end if;
        end if;
    end process; 
    end Behavioral;