library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity TOP is
    Port ( 
    reset:      in std_logic;
    clk:        in std_logic;
    switch1:    in std_logic;
    switch2:    in std_logic;
    switch3:    in std_logic;
    switch4:    in std_logic;
    PUSHBUTTON :    in std_logic;
    led:        out std_logic_vector(0 to 3);
    led_contador_seleccionado: out std_logic_vector(0 to 3);
    segmento:   out std_logic_vector(0 TO 6);
    DP : out std_logic;
    display_sel :   out  std_logic_vector(7 DOWNTO 0)
    --salida_contador1: out integer;
    --salida_contador2: out integer;
    --salida_contador3: out integer;
    --salida_contador4: out integer;
    --salida_unidades: out std_logic_vector(3 DOWNTO 0);
    --salida_decenas:out std_logic_vector(3 DOWNTO 0);
    --salida_centenas:out std_logic_vector(3 DOWNTO 0);
    --salida_millares:out std_logic_vector(3 DOWNTO 0);
    --salida_seleccionada: out integer;
    --salida_fsm: out std_logic_vector(1 DOWNTO 0)
    );
end TOP;

architecture Behavioral of TOP is
    signal enable_cont_tiempo1, enable_cont_tiempo2, enable_cont_tiempo3, enable_cont_tiempo4: std_logic; -- Salida leds, entrada contadores de tiempo, fsm y contador plazas libres
    signal cuenta_tiempo1, cuenta_tiempo2, cuenta_tiempo3, cuenta_tiempo4: integer; --Salida contadores, entradas mux entero
    signal cuenta_seleccionada: integer; -- Salida del mux entero
    signal select_mux_entero: std_logic_vector(1 downto 0); --Salida FSM, select del mux entero
    signal bcd_precio0, bcd_precio1, bcd_precio2, bcd_precio3: std_logic_vector(3 downto 0); -- Salidas int_to_bcd, entradas (0-3) del MUX_BCD
    signal bcd_contador_plazas: std_logic_vector(3 downto 0); -- Salida contador plazas, entrada (7) del MUX_BCD
    signal bcd_seleccionado: std_logic_vector(3 downto 0); -- Salida MUX_BCD y entrada BCD_to_7Segment
   signal syn_edg : std_logic;
    signal edg_fsm : std_logic;
   
    -------------------------- COMPONENTES ------------------------
    
    --SWITCH
    component SWITCH
        Port(
        switch      : in STD_LOGIC;       -- Interruptor (switch)
        rst         : in STD_LOGIC;          -- Señal de reset
        clk         : in STD_LOGIC;          -- Señal de reloj
        led         : out STD_LOGIC          -- Señal del LED
        );
    end component;
    
    --CONTADORTIEMPO
    component CONTADORTIEMPO
        Port(
        clk       : in STD_LOGIC;               
        reset     : in STD_LOGIC;               
        enable    : in STD_LOGIC;               
        count_out : out INTEGER range 0 to 35999
        );
    end component;
    
    --MAQUINA DE ESTADOS
    component parking_fsm
        Port(
        reset : in STD_LOGIC;
        PUSHBUTTON : in std_logic;
        clk     : in STD_LOGIC;
        salida  : out STD_LOGIC_VECTOR(1 downto 0) -- Salida binaria indicando la plaza liberada
        );
    end component;
    
    COMPONENT SYNCHRNZR -- Sincronizador
        PORT (
            CLK: IN std_logic;
            ASYNC_IN: IN std_logic;
            SYNC_OUT: OUT std_logic
        );
    END COMPONENT;

    COMPONENT EDGEDCNTRL -- detector de flanco
        PORT (
            CLK: IN std_logic;
            SYNC_IN: IN std_logic;
            EDGE: OUT std_logic
        );
    END COMPONENT;
    
    
    --MUX ENTERO 4a1
    component multiplexor_entero
        Port(
        sel         : in STD_LOGIC_VECTOR(1 downto 0); -- Selector de 2 bits
        plaza1      : in INTEGER; -- Salida del contador de la plaza 1
        plaza2      : in INTEGER; -- Salida del contador de la plaza 2
        plaza3      : in INTEGER; -- Salida del contador de la plaza 3
        plaza4      : in INTEGER; -- Salida del contador de la plaza 4
        salida      : out INTEGER -- Salida seleccionada
        );
    end component;
    
    -- ENTERO A BCD
    component int_to_bcd
        Port(
        num       : IN integer;                  
        unidades  : OUT std_logic_vector(3 DOWNTO 0); 
        decenas   : OUT std_logic_vector(3 DOWNTO 0); 
        centenas  : OUT std_logic_vector(3 DOWNTO 0); 
        millares  : OUT std_logic_vector(3 DOWNTO 0)
        );
    end component;
    
    --CONTADOR PLAZAS
    component contador_plazas_libres
        Port(
        reset : in STD_LOGIC;
        plaza_1 : in STD_LOGIC; -- 1 si ocupada, 0 si libre
        plaza_2 : in STD_LOGIC; -- 1 si ocupada, 0 si libre
        plaza_3 : in STD_LOGIC; -- 1 si ocupada, 0 si libre
        plaza_4 : in STD_LOGIC; -- 1 si ocupada, 0 si libre
        plazas_libres : out STD_LOGIC_VECTOR(3 downto 0) -- Salida en BCD del número de plazas libres
        );
    end component;
    
    --CONTADOR ANILLO YA INSTANCIADO EN MUX Y EN SELECTOR DISPLAY
    --MUX_BCD
    component MUX_BCD
        Port(
        --ENTRADAS DE PRECIO
        bcd0    : IN std_logic_vector(3 DOWNTO 0); -- Entrada BCD0
        bcd1    : IN std_logic_vector(3 DOWNTO 0); -- Entrada BCD1
        bcd2    : IN std_logic_vector(3 DOWNTO 0); -- Entrada BCD2
        bcd3    : IN std_logic_vector(3 DOWNTO 0); -- Entrada BCD3
     -- POSIBLES ENTRADAS DE TIEMPO
     
     --CONTADOR DE PLAZAS LIBRES
        bcd7    : IN std_logic_vector(3 DOWNTO 0); -- Entrada BCD7
        clk     : IN std_logic;                    -- Reloj para el contador
        reset   : IN std_logic;                    -- Reset para el contador
        bcd_out : OUT std_logic_vector(3 DOWNTO 0) -- Salida del MUX
        );
    end component;
    
    --BCD_to_7SEGMENT
    component BCD_to_7Segment
        Port(
        bcd    : IN  std_logic_vector(3 DOWNTO 0); -- Entrada BCD de 4 bits
        seg    : OUT std_logic_vector(6 DOWNTO 0)  -- Salida para los 7 segmentos
        );
    end component;
    
    --SELECTOR DISPLAY
    component SelectorDisplay
        Port(
        clk     : IN std_logic;                     -- Reloj para el selector
        reset   : IN std_logic;                     -- Reset para el selector
        display : OUT std_logic_vector(7 DOWNTO 0);  -- Selector display activo con un bit a nivel bajo
        DP: out std_logic
        );
    end component;
    
    
begin

    -------------------------- INSTANCIAS ------------------------

    --SWITCH1
    switch1_inst: SWITCH
        Port map(
        switch => switch1,          -- PLAZA 1
        rst => reset,               -- Señal de reset
        clk      => clk,            -- Señal de reloj
        led =>  enable_cont_tiempo1  
        );
        led(0) <= enable_cont_tiempo1;
     --SWITCH2
    switch2_inst: SWITCH
        Port map(
        switch => switch2,           -- PLAZA 2
        rst => reset,                 -- Señal de reset
        clk      => clk,            -- Señal de reloj
        led => enable_cont_tiempo2
        );
        led(1) <= enable_cont_tiempo2;
        
     --SWITCH3
    switch3_inst: SWITCH
        Port map(
        switch => switch3,           -- PLAZA 3
        rst => reset,                 -- Señal de reset
        clk      => clk,            -- Señal de reloj
        led => enable_cont_tiempo3      
        );
        led(2) <= enable_cont_tiempo3;   
        
     --SWITCH4
    switch4_inst: SWITCH
        Port map(
        switch => switch4,           -- PLAZA 4
        rst => reset,                 -- Señal de reset
        clk      => clk,            -- Señal de reloj
        led => enable_cont_tiempo4     
        );
        led(3)<= enable_cont_tiempo4;    
    
    --CONTADOR TIEMPO 1
    contador1_inst: CONTADORTIEMPO
        Port map (
        clk      => clk,              
        reset    => reset,             
        enable   =>  enable_cont_tiempo1,       
        count_out => cuenta_tiempo1
        );
    
    --CONTADOR TIEMPO 2
    contador2_inst: CONTADORTIEMPO
        Port map (
        clk      => clk,              
        reset    => reset,             
        enable   =>  enable_cont_tiempo2,       
        count_out => cuenta_tiempo2
        );
        
     --CONTADOR TIEMPO 3
    contador3_inst: CONTADORTIEMPO
        Port map (
        clk      => clk,              
        reset    => reset,             
        enable   =>  enable_cont_tiempo3,       
        count_out => cuenta_tiempo3
        ); 
      
      --CONTADOR TIEMPO 4
    contador4_inst: CONTADORTIEMPO
        Port map (
        clk      => clk,              
        reset    => reset,             
        enable   =>  enable_cont_tiempo4,       
        count_out => cuenta_tiempo4
        ); 
        
     

    Inst_SYNCHRNZR: SYNCHRNZR PORT MAP (
        CLK => clk,
        ASYNC_IN => pushbutton,
        SYNC_OUT => syn_edg
    );

    Inst_EDGEDCTR: EDGEDCNTRL PORT MAP (
        CLK => clk,
        SYNC_IN => syn_edg,
        EDGE => edg_fsm
    );
    
     --MAQUINA DE ESTADOS  
     parking_fsm_inst:parking_fsm
        Port map(
        RESET => reset,
        CLK => clk,
        PUSHBUTTON => edg_fsm,
        salida => select_mux_entero
    );
        
      --MULTIPLEXOR ENTEROS 4a1 
    mux_enteros_inst: multiplexor_entero
        Port map(
        sel => select_mux_entero, -- Selector de 2 bits
        plaza1 => cuenta_tiempo1, -- Salida del contador de la plaza 1
        plaza2 => cuenta_tiempo2, -- Salida del contador de la plaza 2
        plaza3 => cuenta_tiempo3, -- Salida del contador de la plaza 3
        plaza4 => cuenta_tiempo4, -- Salida del contador de la plaza 4
        salida => cuenta_seleccionada -- Salida seleccionada
        );
        

      -- ENTERO A BCD
    entero_a_bcd_inst: int_to_bcd
        Port map(
        num       => cuenta_seleccionada,                 
        unidades  => bcd_precio3, -- Contiguo a decenas
        decenas   => bcd_precio2, -- Contiguo a centenas
        centenas  => bcd_precio1, -- Contiguo a millares
        millares  => bcd_precio0 --Irá en display de Izquierda del todo
        );
      
      --CONTADOR PLAZAS LIBRES
    contador_plazas_libres_inst: contador_plazas_libres
        Port map(
        reset => reset,
        plaza_1 => enable_cont_tiempo1, -- 1 si ocupada, 0 si libre
        plaza_2 => enable_cont_tiempo2, -- 1 si ocupada, 0 si libre
        plaza_3 => enable_cont_tiempo3, -- 1 si ocupada, 0 si libre
        plaza_4 => enable_cont_tiempo4, -- 1 si ocupada, 0 si libre
        plazas_libres  => bcd_contador_plazas -- Salida en BCD del número de plazas libres
        );
        
      --MUX_BCD
     mux_bcd_inst: MUX_BCD
        Port map(
        --ENTRADAS DE PRECIO
        bcd0    => bcd_precio0, -- Entrada BCD0
        bcd1    => bcd_precio1, -- Entrada BCD1
        bcd2    => bcd_precio2, -- Entrada BCD2
        bcd3    => bcd_precio3, -- Entrada BCD3
     -- POSIBLES ENTRADAS DE TIEMPO
     
     --CONTADOR DE PLAZAS LIBRES
        bcd7    => bcd_contador_plazas ,     -- Entrada BCD7
        clk     => clk,                      -- Reloj para el contador
        reset   => reset,                    -- Reset para el contador
        bcd_out => bcd_seleccionado -- Salida del MUX
        );

      --BCD_to_7SEGMENT
     bcd_to_7Segment_inst: BCD_to_7Segment
        Port map(
        bcd    => bcd_seleccionado, -- Entrada BCD de 4 bits
        seg    => segmento  -- Salida para los 7 segmentos
        );
        
        --SELECTOR DISPLAY
    selector_display_inst: SelectorDisplay
        Port map(
        clk     => clk,                     -- Reloj para el selector
        reset   => reset,                     -- Reset para el selector
        display => display_sel,  -- Selector display activo con un bit a nivel bajo
        DP => DP
        );
        
    
    
process (select_mux_entero)
begin
    case select_mux_entero is
        when "00" => 
            led_contador_seleccionado <= "0001"; -- LED 0 encendido
        when "01" => 
            led_contador_seleccionado <= "0010"; -- LED 1 encendido
        when "10" => 
            led_contador_seleccionado <= "0100"; -- LED 2 encendido
        when "11" => 
            led_contador_seleccionado <= "1000"; -- LED 3 encendido
        when others => 
            led_contador_seleccionado <= "0000"; -- Ningún LED encendido (estado por defecto)
    end case;
end process;
end Behavioral;
