library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL; -- Necesario para manejar enteros y to_unsigned

entity contador_plazas_libres is
    Port (
        reset : in STD_LOGIC;
        plaza_1 : in STD_LOGIC; -- 1 si ocupada, 0 si libre
        plaza_2 : in STD_LOGIC; -- 1 si ocupada, 0 si libre
        plaza_3 : in STD_LOGIC; -- 1 si ocupada, 0 si libre
        plaza_4 : in STD_LOGIC; -- 1 si ocupada, 0 si libre
        plazas_libres : out STD_LOGIC_VECTOR(3 downto 0) -- Salida en BCD del número de plazas libres
    );
end contador_plazas_libres;

architecture Behavioral of contador_plazas_libres is
    signal prev_plaza : STD_LOGIC_VECTOR(3 downto 0) := "0000"; -- Estado previo de las plazas
    signal ocupadas : integer range 0 to 4 := 0; -- Contador de plazas ocupadas
    constant TOTAL_PLAZAS : integer := 4; -- Total de plazas
begin

    process(reset, plaza_1, plaza_2, plaza_3, plaza_4)
    begin
        if reset = '1' then
            ocupadas <= 0; -- Reiniciar el contador de ocupadas
            prev_plaza <= "0000"; -- Asumir todas las plazas como libres al reiniciar
        else
            -- Detectar flancos positivos y negativos para cada plaza
            if prev_plaza(3) = '0' and plaza_1 = '1' then
                if ocupadas < TOTAL_PLAZAS then
                    ocupadas <= ocupadas + 1; -- Flanco positivo: incrementa ocupadas
                end if;
            elsif prev_plaza(3) = '1' and plaza_1 = '0' then
                if ocupadas > 0 then
                    ocupadas <= ocupadas - 1; -- Flanco negativo: decrementa ocupadas
                end if;
            end if;

            if prev_plaza(2) = '0' and plaza_2 = '1' then
                if ocupadas < TOTAL_PLAZAS then
                    ocupadas <= ocupadas + 1;
                end if;
            elsif prev_plaza(2) = '1' and plaza_2 = '0' then
                if ocupadas > 0 then
                    ocupadas <= ocupadas - 1;
                end if;
            end if;

            if prev_plaza(1) = '0' and plaza_3 = '1' then
                if ocupadas < TOTAL_PLAZAS then
                    ocupadas <= ocupadas + 1;
                end if;
            elsif prev_plaza(1) = '1' and plaza_3 = '0' then
                if ocupadas > 0 then
                    ocupadas <= ocupadas - 1;
                end if;
            end if;

            if prev_plaza(0) = '0' and plaza_4 = '1' then
                if ocupadas < TOTAL_PLAZAS then
                    ocupadas <= ocupadas + 1;
                end if;
            elsif prev_plaza(0) = '1' and plaza_4 = '0' then
                if ocupadas > 0 then
                    ocupadas <= ocupadas - 1;
                end if;
            end if;

            -- Actualizar el estado previo de las plazas
            prev_plaza <= plaza_1 & plaza_2 & plaza_3 & plaza_4;
        end if;
    end process;

    -- Calcular las plazas libres: TOTAL_PLAZAS - ocupadas
    plazas_libres <= std_logic_vector(to_unsigned(TOTAL_PLAZAS - ocupadas, 4)); -- Salida en formato BCD

end Behavioral;
