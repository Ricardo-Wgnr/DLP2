library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity bloco_soma_mult2 is
	
	generic(W: natural := 8);
   port(
      a_in, b_in: in std_logic_vector(W-1 downto 0);
		ctrl: in std_logic_vector (1 downto 0);
      r1, r2: out std_logic_vector(2*W-1 downto 0)
   );
end entity;

architecture ifsc_v1 of bloco_soma_mult2 is
signal r_unsigned_mult: unsigned (2*W-1 downto 0);
signal r_unsigned_soma: unsigned (W-1 downto 0);
signal a_next, b_next : std_logic_vector(W-1 downto 0);
signal r_concatenado : std_logic_vector(2*W-1 downto 0);
constant zeros : std_logic_vector(W-1 downto 0) := (others => '0');
constant uns   : std_logic_vector(W-1 downto 0) := (others => '1');
begin	
	a_next <= a_in;
	with ctrl select
		b_next <= b_in     				when "00",
					 not b_in 				when "01",
					 b_in		 				when "10",
					 "00000010"  when others;
	
	r_unsigned_mult <= unsigned(a_next) * unsigned(b_next);
	r_unsigned_soma <= unsigned(a_next) + unsigned(b_next) + 1 when ctrl = "01" else
							 unsigned(a_next) + unsigned(b_next);
	r_concatenado <= std_logic(r_unsigned_soma(W-1)) & zeros & std_logic_vector(r_unsigned_soma(W-2 downto 0)) when (ctrl(1) = '0' and std_logic(r_unsigned_soma(W-1)) = '0') else
						  std_logic(r_unsigned_soma(W-1)) & uns   & std_logic_vector(r_unsigned_soma(W-2 downto 0));
	
	r1 <= std_logic_vector(r_unsigned_mult) when ctrl(1) = '1' else
		   r_concatenado;
	r2 <= std_logic_vector(r_unsigned_mult) when ctrl(1) = '1' else
		   r_concatenado 							 when ctrl(1) = '0' and r_concatenado(15) = '0' else
			std_logic_vector(unsigned(not r_concatenado) + 1);
end architecture;

