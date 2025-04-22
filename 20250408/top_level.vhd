library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity top_level is
generic(W_TOP: natural := 8);
port ( 
	clk_top, rst_top : in std_logic;
	a_in_top, b_in_top: in std_logic_vector(W_TOP-1 downto 0);
	ctrl_top : in std_logic_vector (1 downto 0);
	SSD0, SSD1, SSD2, SSD3, SSD4, SSD5 : out std_logic_vector (6 downto 0)
);
end entity;

architecture ifsc_top of top_level is
signal r_out_top, soma_mult_2_bin : std_logic_vector (2*W_TOP-1 downto 0);
signal bcd0_2_ssd, bcd1_2_ssd, bcd2_2_ssd, bcd3_2_ssd, bcd4_2_ssd: std_logic_vector(3 downto 0);

	 component bloco_soma_mult2 is
	 generic(W: natural := 8);
	 port(
		 a_in, b_in: in std_logic_vector(W-1 downto 0);
	 	 ctrl: in std_logic_vector (1 downto 0);
	 	 r1, r2: out std_logic_vector(2*W-1 downto 0)
	 );
	 end component;
	 
	 component bin2bcd is
    generic(N: positive := 16);
    port(
        clk, reset: in std_logic;
        binary_in: in std_logic_vector(N-1 downto 0);
        bcd0, bcd1, bcd2, bcd3, bcd4: out std_logic_vector(3 downto 0)
    );
	 end component;
	 
	 component bcd2ssd is
	 port (
		BCD : in std_logic_vector (3 downto 0);
		SSD : out std_logic_vector (6 downto 0)
	 );
	 end component;
	 
	 begin
	 U1: bloco_soma_mult2
	 generic map (
		W => 8
	 )
	 port map (
		a_in => a_in_top,
		b_in => b_in_top,
		ctrl => ctrl_top,
		r1	  => r_out_top,
		r2	  => soma_mult_2_bin
	 );
	 
	 U2: bin2bcd
	 generic map (
		N => 16
	 )
	 port map(
		clk => clk_top,
		reset => rst_top,
		binary_in => soma_mult_2_bin,
		bcd0 => bcd0_2_ssd,
		bcd1 => bcd1_2_ssd,
		bcd2 => bcd2_2_ssd,
		bcd3 => bcd3_2_ssd,
		bcd4 => bcd4_2_ssd
	 );
	 
	 U3: bcd2ssd
	 port map (
		BCD => bcd0_2_ssd,
		SSD => SSD0
	 );

	 U4: bcd2ssd
	 port map (
		BCD => bcd1_2_ssd,
		SSD => SSD1
	 );
	 
	 U5: bcd2ssd
	 port map (
		BCD => bcd2_2_ssd,
		SSD => SSD2
	 );
	 
	 U6: bcd2ssd
	 port map (
		BCD => bcd3_2_ssd,
		SSD => SSD3
	 );
	 
	 U7: bcd2ssd
	 port map (
		BCD => bcd4_2_ssd,
		SSD => SSD4
	 );
	 
	 SSD5 <= not r_out_top(15) & "111111";
	 
end architecture;