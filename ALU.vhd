library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.numeric_std.all;

entity ALU is
port(
A,B : in std_logic_vector(7 downto 0);
operation : in std_logic_vector(2 downto 0);
result: out std_logic_vector(7 downto 0);
carryout : out std_logic);
end ALU;

architecture behavioral of ALU is
signal alu_res: std_logic_vector(7 downto 0);
signal temp: std_logic_vector(8 downto 0);
begin 
process(A,B,operation) is
begin
case(operation) is

when "000" => -- condition 1 for addition (let)
alu_res <= A+B;
temp <= ('0' & A) + ('0' & B); -- This is the syntax to add an extension in the form of a carry , by 1 bit. if carry doesnt exists , the default value is assigned 0 (case for addition)

when "001" => -- condition 2 for substraction (let)
alu_res <= A-B;
temp <= ('0' & A) - ('0' & B);  -- This is the syntax to add an extension in the form of a carry , by 1 bit. if carry doesnt exists , the default value is assigned 0 (case for substraction)

when "010" => -- condition 3 for multiplication (let)
alu_res<= std_logic_vector(to_unsigned(to_integer(unsigned(A)) * to_integer(unsigned(B)),8)); -- syntax for interconversion before multiplication 

when "011" => -- condition 4 for division (let)                                                   (more details in notes)
alu_res<= std_logic_vector(to_unsigned(to_integer(unsigned(A)) / to_integer(unsigned(B)),8));  -- syntax for interconversion before division.      

when "100" => -- condition 5 for XOR
alu_res<= A xor B;

when "101" => -- condition 6 for XNOR
alu_res<= A xnor B;

when "110" => -- condition 7 for checking greater or less
if(A>B) then
alu_res<= x"01";
elsif(A<B) then
alu_res<= x"00";
end if; 

when "111" => -- condition 8 for checking equality
if(A=B) then
alu_res<= x"10";
end if;

when others =>
alu_res <= A;
end case;
end process;
result <= alu_res; --assigning the signal to the result 
carryout <= temp(8);
end behavioral;
