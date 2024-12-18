library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity parking_fsm is
    Port (
        reset : in STD_LOGIC;
        plaza_1 : in STD_LOGIC; -- 1 si ocupada, 0 si libre
        plaza_2 : in STD_LOGIC; -- 1 si ocupada, 0 si libre
        plaza_3 : in STD_LOGIC; -- 1 si ocupada, 0 si libre
        plaza_4 : in STD_LOGIC; -- 1 si ocupada, 0 si libre
        salida : out STD_LOGIC_VECTOR(1 downto 0) -- Salida binaria indicando la plaza liberada
    );
end parking_fsm;

architecture Behavioral of parking_fsm is
    signal prev_plaza : STD_LOGIC_VECTOR(3 downto 0) := "1111"; -- Estado previo de las plazas
    signal current_output : STD_LOGIC_VECTOR(1 downto 0) := "XX"; -- Salida actualizada
begin

    process(reset, plaza_1, plaza_2, plaza_3, plaza_4)
    begin
        if reset = '1' then
            current_output <= "XX"; -- Reinicia la salida a X
            prev_plaza <= "1111";
        else
            -- Detectar flanco negativo de cada plaza
            if prev_plaza(3) = '1' and plaza_1 = '0' then
                current_output <= "00";
            elsif prev_plaza(2) = '1' and plaza_2 = '0' then
                current_output <= "01";
            elsif prev_plaza(1) = '1' and plaza_3 = '0' then
                current_output <= "10";
            elsif prev_plaza(0) = '1' and plaza_4 = '0' then
                current_output <= "11";
            end if;

            -- Actualizar el estado previo de las plazas
            prev_plaza <= plaza_1 & plaza_2 & plaza_3 & plaza_4;
        end if;
    end process;

    salida <= current_output; -- Asignar la salida actualizada

end Behavioral;

