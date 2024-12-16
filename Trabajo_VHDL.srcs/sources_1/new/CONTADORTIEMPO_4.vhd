library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity CONTADORTIEMPO_4 is
    Port (
        clk       : in STD_LOGIC;               
        reset     : in STD_LOGIC;               
        enable_4    : in STD_LOGIC;               
        count_out_4 : out INTEGER range 0 to 35999 
    );
end CONTADORTIEMPO_4;

architecture Behavioral of CONTADORTIEMPO_4 is
    
    signal enable_100ms : STD_LOGIC;        

    -- CONTADOR INTERNO
    signal count_4 : INTEGER range 0 to 35999 := 0; 

   
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
            count_4 <= 0;  
        elsif rising_edge(clk) then  
            if enable_4 = '0' then
                count_4 <= 0; 
            elsif enable_100ms = '1' then 
                if count_4 = 35999 then
                    count_4 <= 0;        
                else
                    count_4 <= count_4 + 1; 
                end if;
            end if;
        end if;
    end process;

  
    count_out_4 <= count_4;

end Behavioral;