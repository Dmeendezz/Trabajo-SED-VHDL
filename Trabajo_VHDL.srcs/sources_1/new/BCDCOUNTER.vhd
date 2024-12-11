library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all; -- Para usar unsigned

entity BCDCOUNTER is  
    generic(
        WIDTH : positive := 4    -- Ancho del contador (puedes ajustarlo)
    );
    port(
        RST_N   : in std_logic;                      -- Reset asíncrono (activo bajo)
        CLK     : in std_logic;                      -- Reloj de entrada
        STROBE  : in std_logic;                      -- Señal strobe (pulso cada 100 ms)
        COUNT   : out unsigned(WIDTH - 1 downto 0)    -- Salida paralela del contador
    );
end entity BCDCOUNTER;

architecture BEHAVIORAL of BCDCOUNTER is
    signal count_i : unsigned(COUNT'range);  -- Señal interna para el contador
begin
    sr : process (RST_N, CLK)  -- Reloj y reset asíncrono
    begin
        -- Verificar el reset asíncrono
        if RST_N = '0' then
            count_i <= (others => '0');  -- Reset al valor 0
        -- Verificar el flanco de subida del reloj
        elsif rising_edge(CLK) then
            if STROBE = '1' then  -- Incrementar solo cuando el strobe esté activo
                count_i <= count_i + 1;
                if count_i = 10 then  -- Contador BCD, se reinicia después de 9
                    count_i <= (others => '0');
                end if;
            end if;
        end if;  
    end process;

    COUNT <= count_i;  -- Asignar la señal interna al puerto de salida

end architecture BEHAVIORAL;
