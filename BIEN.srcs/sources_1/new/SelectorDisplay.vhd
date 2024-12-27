library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity SelectorDisplay is
Port ( 
    clk     : IN std_logic;                     -- Reloj para el selector
    reset   : IN std_logic;                     -- Reset para el selector
    display : OUT std_logic_vector(7 DOWNTO 0);  -- Selector display activo con un bit a nivel bajo
    DP: out std_logic
    );
end SelectorDisplay;

architecture Behavioral of SelectorDisplay is
    signal display_i : std_logic_vector(7 DOWNTO 0) := "11111111";  -- Todos apagados inicialmente. Bit a 0 -> display seleccionado
    signal sel_cnt : std_logic_vector(2 DOWNTO 0);
    
    -- Componente del ContadorAnillo
    COMPONENT ContadorAnillo
        PORT (
            clk   : IN  std_logic;              -- Señal de reloj
            reset : IN  std_logic;              -- Señal de reset
            sel   : OUT std_logic_vector(2 DOWNTO 0) -- Salida del contador anillo
        );
    END COMPONENT;
begin
-- Instanciación del ContadorAnillo
    contador_inst : ContadorAnillo
        PORT MAP (
            clk => clk,
            reset => reset,
            sel => sel_cnt  -- Conectamos la salida del contador al señal de selección
        );

    process(sel_cnt, reset)
    begin
        if reset = '1' then
            display_i <= "11111111";  -- Reset: Ningún display seleccionado
        else
            case sel_cnt is
                -- Los 4 displays de la izquierda para mostrar el precio
                when "000" => display_i <= "01111111"; -- Seleccionado display 7
                when "001" => display_i <= "10111111"; -- Seleccionado display 6
                when "010" => display_i <= "11011111"; -- Seleccionado display 5
                when "011" => display_i <= "11101111"; -- Seleccionado display 4
                -- Posibilidad de mostrar el tiempo en displays 4, 5 y 6    
                when "100" => display_i <= "11110111"; -- Seleccionado display 3
                when "101" => display_i <= "11111011"; -- Seleccionado display 2
                when "110" => display_i <= "11111101"; -- Seleccionado display 1
                -- El display de la derecha controlado por el contador de plazas libres    
                when "111" => display_i <= "11111110"; -- Seleccionado display 0
                when others => display_i <= "11111111"; -- Apaga todos los displays (por seguridad)
            end case;
            
            if sel_cnt = "001" then
            DP <= '0';
            else
            DP <= '1';
            end if;
        end if;
    end process;
    
    
    -- Asignación de salida
    display <= display_i;

end Behavioral;
