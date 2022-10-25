library ieee;
use ieee.std_logic_1164.all;

entity practica_2 is

  port(clk, rst, x: in std_logic;
       z: out std_logic);

end practica_2;


architecture estructural_D of practica_2 is

	signal d0, d1: std_logic;
	signal q0, q1: std_logic;

begin
	
	
	FFD0: entity work.flipflopd port map(clk, rst, d0, q0);
	d0 <= (not x);

	
	FFD1: entity work.flipflopd port map(clk, rst, d1, q1);
	d1 <= ((q1 and (not q0) and (not x)) or (q0 and x));

	z <= (q1 and q0 and x);

  
end estructural_D;

-----------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity practica_2 is

  port(clk, rst, x: in std_logic;
       z: out std_logic);

end practica_2;

architecture estructural_JK of practica_2 is

	signal j0, k0: std_logic;
	signal j1, k1: std_logic;
	signal q0, q1: std_logic;

begin
	
	j0 <= not x;
	k0 <= x;
	j1 <= (q0 and x) or (q1 and (not q0) and (not x));
	k1 <= ((not q1) and (not x)) or ((not x) and q0) or (x and (not q0));

	FFD0: entity work.flipflopjk port map(clk, rst, j0, k0, q0);
	

	
	FFD1: entity work.flipflopjk port map(clk, rst, j1, k1, q1);
	
	
	z <= (q1 and q0 and x);

  
end estructural_JK;

-----------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity practica_2 is

  port(clk, rst, x: in std_logic;
       z: out std_logic);

end practica_2;

architecture fsm_funcional of practica_2 is

type estados is (s0, s1, s2, s3);

signal 

	ns, ps: estados;
	
begin
	process(x, ps)

	begin
		case ps is

		when s0 => if x = '0' then ns <= s1; z <= '0';
		else ns <= s0; z <= '0';
		end if;

		when s1 => if x = '0' then ns <= s1; z <= '0';
		else ns <= s2; z <= '0';
		end if;
			
		when s2 => if x = '0' then ns <= s3; z <= '0';
		else ns <= s0; z <= '0';
		end if;

		when s3 => if x = '0' then ns <= s1; z <= '0';
		else ns <= s2; z <= '1';
		end if;
			
		end case;

	end process;

	process(clk, rst)
	
	begin

		if rst = '1' then
		  ps <= s0;

		elsif rising_edge(clk) then
		  ps <= ns;
		
		end if;

	end process;

end fsm_funcional;