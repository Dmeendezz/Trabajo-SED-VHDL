library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity CONTADORTIEMPO_3 is
    Port (
        clk       : in STD_LOGIC;               
        reset     : in STD_LOGIC;               
        enable_3    : in STD_LOGIC;               
        count_out_3 : out INTEGER range 0 to 35999 
    );
end CONTADORTIEMPO_3;

architecture Behavioral of CONTADORTIEMPO_3 is
    
    signal enable_100ms : STD_LOGIC;        

    -- CONTADOR INTERNO
    signal count_3 : INTEGER range 0 to 35999 := 0; 

   
    component strobe_generator
        Port (
            clk         : in std_logic;       
            reset       : in std_logic;      
            enable_100ms : out std_logic     
        );
    end component;

begin
    
    strobe_inst: strobe_generator
        Port map (
            clk         => clk,            
            reset       => reset,          
            enable_100ms => enable_100ms   
        );

    
    process(clk, reset)
    begin
        if reset = '1' then
            count_3 <= 0;  
        elsif rising_edge(clk) then  
            if enable_3 = '0' then
                count_3 <= 0; 
            elsif enable_100ms = '1' then 
                if count_3 = 35999 then
                    count_3 <= 0;        
                else
                    count_3 <= count_3 + 1; 
                end if;
            end if;
        end if;
    end process;

  
    count_out_3 <= count_3;

end Behavioral;
