library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity bloco_soma_mult is
	
	generic(W: natural := 16);
   port(
      clk, reset: in std_logic;
      a_in, b_in: in std_logic_vector(W-1 downto 0);
		ctrl: in std_logic_vector (1 downto 0);
      r: out std_logic_vector(2*W-1 downto 0)
   );
end entity;

architecture ifsc_v1 of bloco_soma_mult is
signal r_unsigned_mult: unsigned (2*W-1 downto 0);
signal r_unsigned_soma: unsigned (W-1 downto 0);
signal a_next, b_next, a_reg, b_reg : std_logic_vector(W-1 downto 0);
signal r_next, r_reg : std_logic_vector(2*W-1 downto 0);
constant zeros : std_logic_vector(W-1 downto 0) := (others => '0');
begin
	process(reset, clk, r_next, a_next, b_next)
	begin
		if reset = '1' then
			r_reg <= (others => '0');
			a_reg <= (others => '0');
			b_reg <= (others => '0');
		elsif rising_edge (clk) then
			r_reg <= r_next;
			a_reg <= a_next;
			b_reg <= b_next;
		end if;
	end process;
	
	a_next <= a_in;
	with ctrl select
		b_next <= b_in     				when "00",
					 not b_in 				when "01",
					 b_in		 				when "10",
					 "0000000000000010"  when others;
	
	r_unsigned_mult <= unsigned(a_reg) * unsigned(b_reg);
	r_unsigned_soma <= unsigned(a_reg) + unsigned(b_reg) + 1 when ctrl = "01" else
							 unsigned(a_reg) + unsigned(b_reg);
	
	r_next <= std_logic_vector(r_unsigned_mult) when ctrl(1) = '1' else
				 zeros & std_logic_vector(r_unsigned_soma);
	r <= r_reg;
end architecture;

