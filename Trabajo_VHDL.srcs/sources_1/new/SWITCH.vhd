library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity SWITCH is
    Port ( 
        switch : in STD_LOGIC;       -- Interruptor (switch)
        rst : in STD_LOGIC;          -- Señal de reset
        clk : in STD_LOGIC;          -- Señal de reloj
        led : out STD_LOGIC          -- Señal del LED
    );
end SWITCH;

architecture Behavioral of SWITCH is
    signal debounced_switch : STD_LOGIC; -- Señal del interruptor después del debouncer

    -- Instancia del debouncer
    component Debouncer
        Port (
            clk : in STD_LOGIC;
            rst : in STD_LOGIC;
            btn_in : in STD_LOGIC;
            btn_out : out STD_LOGIC
        );
    end component;

begin
    -- Instanciar el debouncer
    debouncer_inst : Debouncer
        Port map (
            clk => clk,
            rst => rst,
            btn_in => switch,
            btn_out => debounced_switch
        );

    -- Proceso para controlar el comportamiento del sistema
    process(debounced_switch, rst)
    begin
        if rst = '1' then
            -- Si rst está activo (en 1), se restablece el sistema
            led <= '0';
        elsif rising_edge(debounced_switch) then
            -- Si el interruptor tiene un flanco ascendente
            led <= '1';
        elsif falling_edge(debounced_switch) then
            -- Si el interruptor tiene un flanco descendente
            led <= '0';
        end if;
    end process;

end Behavioral;
