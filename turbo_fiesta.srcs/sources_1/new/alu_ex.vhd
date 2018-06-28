library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity alu_ex is
    port ( clk     : in  std_logic;
           inst    : in  std_logic_vector(7 downto 0);
           bot     : in  signed(31 downto 0);
           mid     : in  signed(31 downto 0);
           top     : in  signed(31 downto 0);
           stdin   : in  signed(31 downto 0);
           redir   : out std_logic;
           smod    : out std_logic;
           bridge  : out std_logic;
           output  : out std_logic;
           strmode : out std_logic;
           n_pop   : out unsigned( 1 downto 0);
           n_push  : out unsigned( 1 downto 0);
           restop  : out   signed(31 downto 0);
           resbot  : out   signed(31 downto 0);
           dx      : out   signed( 1 downto 0);
           dy      : out   signed( 1 downto 0);
           im_addr : out std_logic_vector(15 downto 0));
end alu_ex;

architecture Behavioral of alu_ex is
  -- Registers
  signal r_strmode: std_logic := '0'; -- '1' for stringmode
  -- Copies of output signals
  signal s_redir  : std_logic := '0'; -- '1' if dx or dy change
  signal s_smod   : std_logic := '0'; -- '1' if writing to IM
  signal s_bridge : std_logic := '0'; -- '1' if '#' command
  signal s_output : std_logic := '0'; -- '1' if printing to UART
  signal s_n_pop  : unsigned( 1 downto 0) := "00"; -- Number of values popped
  signal s_n_push : unsigned( 1 downto 0) := "00"; -- Number of values to push
  signal s_restop :   signed(31 downto 0) := x"00000000"; -- 32-bit signed result to top of stack + 1
  signal s_resbot :   signed(31 downto 0) := x"00000000"; -- 32-bit signed result to top of stack
  signal s_dx     :   signed( 1 downto 0) := "00"; -- new dx/dt if changed
  signal s_dy     :   signed( 1 downto 0) := "00"; -- new dy/dt if changed
  signal mul_res  :   signed(63 downto 0) := x"0000000000000000"; -- to be trimmed later
begin

  -- Outputs
  redir   <= s_redir;
  smod    <= s_smod;
  bridge  <= s_bridge;
  output  <= s_output;
  strmode <= r_strmode;
  n_pop   <= s_n_pop;
  n_push  <= s_n_push;
  restop  <= s_restop;
  resbot  <= s_resbot;
  dx      <= s_dx;
  dy      <= s_dy;

  -- Some values can be only used output from one thing
  im_addr <= std_logic_vector(mid(15 downto 0) + (to_signed(80, 8) * top(7 downto 0)));
  mul_res <= mid * top;
  
  exec: process(clk)
  begin
  if(rising_edge(clk))
  then
    if r_strmode = '1'
    then
      s_smod   <= '0';
      s_redir  <= '0';
      s_bridge <= '0';
      s_output <= '0';
      r_strmode<= '1';
      s_dx     <= "00";
      s_dy     <= "00";
      s_n_push <= "01";
      s_n_pop  <= "00";
      s_resbot <= signed(x"000000" & inst);
      s_restop <= x"00000000";
      if inst = x"22"
      then
        r_strmode <= '0';
        s_n_push <= "00";
      end if;
    else
      s_smod   <= '0';
      s_redir  <= '0';
      s_bridge <= '0';
      s_output <= '0';
      r_strmode<= '0';
      s_dx     <= "00";
      s_dy     <= "00";
      s_resbot <= x"00000000";
      s_restop <= x"00000000";
      
      case inst is
        when x"2b" => -- +      
          s_n_pop  <= "10"; 
          s_n_push <= "01";
          s_resbot <= mid + top;
        when x"2d" => -- -      
          s_n_pop  <= "10"; 
          s_n_push <= "01";
          s_resbot <= mid - top;
        when x"2a" => -- *      
          s_n_pop  <= "10"; 
          s_n_push <= "01";
          s_resbot <= mul_res(31 downto 0);
        when x"2f" => -- /      
          s_n_pop  <= "10"; 
          s_n_push <= "01";
          s_resbot <= mid / top;
        when x"25" => -- %      
          s_n_pop  <= "10"; 
          s_n_push <= "01";
          s_resbot <= mid mod top;
        when x"21" => -- !      
          s_n_pop  <= "01"; 
          s_n_push <= "01";
          if (top = x"00000000")
          then 
            s_resbot <= x"00000001";
          else
            s_resbot <= x"00000000";
          end if;
        when x"60" => -- `      
          s_n_pop  <= "10";
          s_n_push <= "01";
          if (mid > top)
          then 
            s_resbot <= x"00000001";
          else
            s_resbot <= x"00000000";
          end if;
        when x"3e" => -- >      
          s_n_pop  <= "00";
          s_n_push <= "00";
          s_redir  <= '1';
          s_dx     <= "01";
          s_dy     <= "00";
        when x"3c" => -- <      
          s_n_pop  <= "00"; 
          s_n_push <= "00";
          s_redir  <= '1';
          s_dx     <= "11";
          s_dy     <= "00";
        when x"5e" => -- ^
          s_n_pop  <= "00"; 
          s_n_push <= "00";
          s_redir  <= '1';
          s_dx     <= "00";
          s_dy     <= "11";
        when x"76" => -- v
          s_n_pop  <= "00"; 
          s_n_push <= "00";
          s_redir  <= '1';
          s_dx     <= "00";
          s_dy     <= "01";
        when x"3f" => -- ?
          s_n_pop  <= "01"; 
          s_n_push <= "00";
          s_redir  <= '1';
          -- TODO ADR randomize this
          s_dx     <= "11";
          s_dy     <= "00";
        when x"5f" => -- _      
          s_n_pop  <= "01"; 
          s_n_push <= "00";
          s_redir  <= '1';
          if (top = x"00000000")
          then
            s_dx   <= "01";
          else
            s_dx   <= "11";
          end if;
          s_dy     <= "00";
        when x"7c" => -- |      
          s_n_pop  <= "01"; 
          s_n_push <= "00";
          s_redir <= '1';
          s_dx     <= "00";
          if (top = x"00000000")
          then
            s_dy   <= "01";
          else
            s_dy   <= "11";
          end if;
        when x"22" => -- "      
          s_n_pop  <= "00"; 
          s_n_push <= "00";
          r_strmode<= '1';
        when x"3a" => -- :      
          s_n_pop  <= "01"; 
          s_n_push <= "10";
          s_resbot <= top;
          s_restop <= top;
        when x"5c" => -- \      
          s_n_pop  <= "10"; 
          s_n_push <= "10";
          s_resbot <= top;
          s_restop <= mid;
        when x"24" => -- $      
          s_n_pop  <= "01"; 
          s_n_push <= "00";
        when x"2e" => -- .      
          s_n_pop  <= "01"; 
          s_n_push <= "00";
          s_resbot <= top;
          s_output <= '1';
          -- TODO ADR figure out output
        when x"2c" => -- ,      
          s_n_pop  <= "01"; 
          s_n_push <= "00";
          s_resbot <= top;
          s_output <= '1';
          -- TODO ADR figure out output
        when x"23" => -- #      
          s_n_pop  <= "00"; 
          s_n_push <= "00";
        when x"67" => -- g      
          s_n_pop  <= "10"; 
          s_n_push <= "01";
          --s_resbot <= im_rdata; -- Now implemented at top level
        when x"70" => -- p      
          s_n_pop  <= "11"; 
          s_n_push <= "00";
          s_smod   <= '1';
          s_resbot <= bot;
        when x"26" => -- &      
          s_n_pop  <= "10"; 
          s_n_push <= "01";
          s_resbot <= stdin; 
        when x"7e" => -- ~      
          s_n_pop  <= "10"; 
          s_n_push <= "01";
          s_resbot <= mid + top;
          s_dx     <= "00";
          s_dy     <= "00";
        when x"40" => -- '@'     
          s_n_pop  <= "00"; 
          s_n_push <= "00";
          s_redir  <= '1'; 
          s_dx     <= "00";
          s_dy     <= "00";
        when x"30" => -- '0'     
          s_n_pop  <= "00"; 
          s_n_push <= "01";
          s_resbot <= x"00000000";
        when x"31" => -- '1'     
          s_n_pop  <= "00"; 
          s_n_push <= "01";
          s_resbot <= x"00000001";
        when x"32" => -- '2'     
          s_n_pop  <= "00"; 
          s_n_push <= "01";
          s_resbot <= x"00000002";
        when x"33" => -- '3'     
          s_n_pop  <= "00"; 
          s_n_push <= "01";
          s_resbot <= x"00000003";
        when x"34" => -- '4'     
          s_n_pop  <= "00"; 
          s_n_push <= "01";
          s_resbot <= x"00000004";
        when x"35" => -- '5'     
          s_n_pop  <= "00"; 
          s_n_push <= "01";
          s_resbot <= x"00000005";
        when x"36" => -- '6'     
          s_n_pop  <= "00"; 
          s_n_push <= "01";
          s_resbot <= x"00000006";
        when x"37" => -- '7'     
          s_n_pop  <= "00"; 
          s_n_push <= "01";
          s_resbot <= x"00000007";
        when x"38" => -- '8'     
          s_n_pop  <= "00"; 
          s_n_push <= "01";
          s_resbot <= x"00000008";
        when x"39" => -- '9'     
          s_n_pop  <= "00"; 
          s_n_push <= "01";
          s_resbot <= x"00000009";
        when x"61" => -- 'a'     
          s_n_pop  <= "00"; 
          s_n_push <= "01";
          s_resbot <= x"0000000a";
        when x"62" => -- 'b'     
          s_n_pop  <= "00"; 
          s_n_push <= "01";
          s_resbot <= x"0000000b";
        when x"63" => -- 'c'     
          s_n_pop  <= "00"; 
          s_n_push <= "01";
          s_resbot <= x"0000000c";
        when x"64" => -- 'd'     
          s_n_pop  <= "00"; 
          s_n_push <= "01";
          s_resbot <= x"0000000d";
        when x"65" => -- 'e'     
          s_n_pop  <= "00"; 
          s_n_push <= "01";
          s_resbot <= x"0000000e";
        when x"66" => -- 'f'     
          s_n_pop  <= "00"; 
          s_n_push <= "01";
          s_resbot <= x"0000000f";
        -- Treat anything undefined as a noop
        when others => -- ' '
          s_n_pop  <= "00";
          s_n_push <= "00";
      end case;
    end if;
  end if;
  end process;

end Behavioral;
