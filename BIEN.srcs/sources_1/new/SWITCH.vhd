library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity SWITCH is
    Port ( 
        switch : in STD_LOGIC;       -- Interruptor (switch)
        rst    : in STD_LOGIC;       -- Señal de reset
        clk    : in STD_LOGIC;       -- Señal de reloj
        led    : out STD_LOGIC      -- Señal del LED
    );
end SWITCH;

architecture Behavioral of SWITCH is
    signal switch_prev : STD_LOGIC := '0'; -- Guarda el valor anterior del switch
    signal led_reg     : STD_LOGIC := '0'; -- Registro para la salida LED
--    signal switch_stable  : STD_LOGIC := '0'; 

--    component DEBOUNCER
--        Port(
--            clk        : in STD_LOGIC;        -- Señal de reloj
--            rst        : in STD_LOGIC;        -- Señal de reset
--            switch     : in STD_LOGIC;        -- Entrada del switch (sincronizada)
--            signal_out : out STD_LOGIC        -- Señal de salida estable
--        );
--    end component;

begin

--    DEBOUNCER_inst: DEBOUNCER
--    Port map(
--        clk        => clk,       -- Señal de reloj
--        rst        => rst,        -- Señal de reset
--        switch     => switch,        -- Entrada del switch (sincronizada)
--        signal_out => switch_stable        -- Señal de salida estable
--    );


    -- Proceso sincronizado para detectar flancos
    process(clk, rst)
    begin
        if rst = '1' then
            -- Reset síncrono
            led_reg <= '0';
            switch_prev <= '0';
        elsif rising_edge(clk) then
            -- Detectar flanco ascendente
            if (switch  = '1' and switch_prev = '0') then
                led_reg <= '1';
            -- Detectar flanco descendente
            elsif (switch  = '0' and switch_prev = '1') then
                led_reg <= '0';
            end if;

            -- Actualizar el valor anterior del switch
            switch_prev <= switch ;
        end if;
    end process;

    -- Asignación de la salida
    led <= led_reg;

end Behavioral;


