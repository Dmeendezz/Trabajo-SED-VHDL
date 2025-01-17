library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity parking_fsm is
    Port (
        reset : in STD_LOGIC;
        PUSHBUTTON : in std_logic;
        clk     : in STD_LOGIC;
        salida  : out STD_LOGIC_VECTOR(1 downto 0); -- Salida binaria indicando la plaza liberada
        led_contador_seleccionado: out std_logic_vector(0 to 3)
    );
end parking_fsm;

architecture Behavioral of parking_fsm is
 -- Declaración de los estados
    type state_type is (STATE0, STATE1, STATE2, STATE3);
    signal current_state, next_state : state_type;
    signal salida_reg : std_logic_vector(0 TO 1) := "00";
    signal btn_sync, btn_prev : std_logic := '0'; -- Sincronización del botón
 
begin
salida <= salida_reg;
 process(CLK)
    begin
        if rising_edge(CLK) then
            btn_prev <= btn_sync;
            btn_sync <= PUSHBUTTON;
        end if;
    end process;

 -- Proceso de transición de estados
 process(CLK)
    begin
        if rising_edge(CLK) then
            if RESET = '1' then
                current_state <= STATE0; -- Volver al estado inicial
            else
                current_state <= next_state; -- Actualizar el estado
            end if;
        end if;
    end process;
    
  -- Lógica de transición de estados
    process(current_state, btn_sync, btn_prev)
    begin
        -- Por defecto, mantener el estado actual
        next_state <= current_state;

        -- Transición de estados solo si el botón se presiona (flanco positivo)
        if btn_sync = '1' and btn_prev = '0' then
            case current_state is
                when STATE0 =>
                    next_state <= STATE1;
                when STATE1 =>
                    next_state <= STATE2;
                when STATE2 =>
                    next_state <= STATE3;
                when STATE3 =>
                    next_state <= STATE0;
                when others =>
                    next_state <= STATE0;
            end case;
        end if;
    end process;
    
    -- Lógica de salida según el estado
    process(current_state)
    begin
        case current_state is
            when STATE0 =>
                salida_reg <= "00"; -- Enciende LED 0
                led_contador_seleccionado <= "0001";
            when STATE1 =>
                salida_reg <= "01"; -- Enciende LED 1
                led_contador_seleccionado <= "0010";
            when STATE2 =>
                salida_reg <= "10"; -- Enciende LED 2
                led_contador_seleccionado <= "0100";
            when STATE3 =>
                salida_reg <= "11"; -- Enciende LED 3
                led_contador_seleccionado <= "1000";
            when others =>
                salida_reg <= "00";
                led_contador_seleccionado <= "0000";
        end case;
    end process;
 
end Behavioral;
