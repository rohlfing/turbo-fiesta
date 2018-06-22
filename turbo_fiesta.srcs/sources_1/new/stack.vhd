library IEEE;
library xil_defaultlib;
use IEEE.std_logic_1164.ALL;
use IEEE.numeric_std.ALL;
use xil_defaultlib.array2D.all;

entity stack is
  port(clk      : in  std_logic; -- Clock
       w_clk    : in  std_logic; -- Clock for write enable
       sp_clk   : in  std_logic; -- Clock for sp update
       reset    : in  std_logic; -- Reset
       num_push : in  unsigned( 1 downto 0); -- '1' if result is to be pushed
       num_pop  : in  unsigned( 1 downto 0);  -- Number removed in inst
       w_bot    : in    signed(31 downto 0);  -- Data to write onto stack
       w_top    : in    signed(31 downto 0);  -- Data to write higher onto stack (optional)
       top      : out   signed(31 downto 0);  -- Data on top of stack
       mid      : out   signed(31 downto 0);  -- Data 1 below top value
       bot      : out   signed(31 downto 0)); -- Data 2 below top value
end stack;

architecture behavioral of stack is

COMPONENT blk_mem_gen_0
  PORT (
    clka  : IN STD_LOGIC;
    ena   : IN STD_LOGIC;
    wea   : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
    addra : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
    dina  : IN STD_LOGIC_VECTOR(63 DOWNTO 0);
    douta : OUT STD_LOGIC_VECTOR(63 DOWNTO 0);
    clkb  : IN STD_LOGIC;
    enb   : IN STD_LOGIC;
    web   : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
    addrb : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
    dinb  : IN STD_LOGIC_VECTOR(63 DOWNTO 0);
    doutb : OUT STD_LOGIC_VECTOR(63 DOWNTO 0));
END COMPONENT;

  -- Registers
  signal r_sp      :   signed(15 downto 0) := x"0000";
  
  -- Read addresses
  signal s_raddr_t : std_logic_vector(15 downto 0);
  signal s_raddr_m : std_logic_vector(15 downto 0);
  signal s_raddr_b : std_logic_vector(15 downto 0);
  -- Read data
  signal s_rdata_t : std_logic_vector(31 downto 0);
  signal s_rdata_m : std_logic_vector(31 downto 0);
  signal s_rdata_b : std_logic_vector(31 downto 0);
  -- Write addresses
  signal s_waddr_t : std_logic_vector(15 downto 0);
  signal s_waddr_b : std_logic_vector(15 downto 0);

  -- integers
  signal i_n_pop   : integer;
  signal i_n_push  : integer;
  signal i_sp      : integer;
  
  -- write enables
  signal wb_en     : std_logic;
  signal wt_en     : std_logic;
  
  -- helpful
  signal read_algn : std_logic;
  signal wrte_algn : std_logic;
  
  -- memory input signals
  signal s_wea   : std_logic_vector( 7 downto 0);
  signal s_addra : std_logic_vector( 9 downto 0);
  signal s_dina  : std_logic_vector(63 downto 0);
  signal s_douta : std_logic_vector(63 downto 0);
  signal s_web   : std_logic_vector( 7 downto 0);
  signal s_addrb : std_logic_vector( 9 downto 0);
  signal s_dinb  : std_logic_vector(63 downto 0);
  signal s_doutb : std_logic_vector(63 downto 0);
      
begin

  -- Get integers
  i_n_push <= to_integer(num_push);
  i_n_pop  <= to_integer(num_pop);
  i_sp     <= to_integer(r_sp);

  -- Compute addresses
  --  Read
  s_raddr_b <= std_logic_vector(r_sp - to_signed(3, 16));
  s_raddr_m <= std_logic_vector(signed(s_raddr_b) + to_signed(1, 16));
  s_raddr_t <= std_logic_vector(signed(s_raddr_b) + to_signed(2, 16));
  --  Write
  s_waddr_b <= std_logic_vector(r_sp - to_signed(i_n_pop, 16)) when (i_sp > i_n_pop) else x"0000";
  s_waddr_t <= std_logic_vector(signed(s_waddr_b) + to_signed(1, 16));

  -- zero output when necessary
  top <= signed(s_rdata_t) when (s_raddr_t(15) = '0') else x"00000000";
  mid <= signed(s_rdata_m) when (s_raddr_m(15) = '0') else x"00000000";
  bot <= signed(s_rdata_b) when (s_raddr_b(15) = '0') else x"00000000";

  -- Update stack pointer
  sp_update_proc: process(sp_clk)
  begin
    if(rising_edge(sp_clk))
    then
      r_sp <= to_signed(to_integer(r_sp + i_n_push - i_n_pop), 16);
      if (r_sp < to_signed(0, 16))
      then
        r_sp <= x"0000";
      end if;
    end if;
  end process;

  -- TODO ADR stack memory block
  wb_en <= w_clk and (num_push(1) or num_push(0));
  wt_en <= w_clk and num_push(1);
  
  -- Assign memory addresses
  s_addra <= s_raddr_b(10 downto 1) when (w_clk = '0') else s_waddr_b(10 downto 1);
  s_addrb <= std_logic_vector(unsigned(s_addra) + to_unsigned(1, 10));
  
  -- Determine if read and write are aligned
  read_algn <= '1' when (s_raddr_b(1) = s_raddr_m(1)) else '0';
  wrte_algn <= '1' when (s_waddr_b(1) = s_waddr_t(1)) else '0';
  
  -- Write enable bits
  -- Port A
  s_wea(0) <= '1' when (wb_en='1') and (wrte_algn = '1') else '0';
  s_wea(1) <= s_wea(0);
  s_wea(2) <= s_wea(0);
  s_wea(3) <= s_wea(0);
  s_wea(4) <= '1' when (wb_en='1') and (wrte_algn = '0') else
              '1' when (wt_en='1') and (wrte_algn = '1') else
              '0';
  s_wea(5) <= s_wea(4);
  s_wea(6) <= s_wea(4);
  s_wea(7) <= s_wea(4);
  -- Port B
  s_web(0) <= '1' when (wt_en='1') and (wrte_algn = '0') else '0';
  s_web(1) <= s_web(0);
  s_web(2) <= s_web(0);
  s_web(3) <= s_web(0);
  s_web(7 downto 4) <= x"0";
  
  -- Write data (we can assume edges because we were careful with enable ports)
  -- Port A
  s_dina(31 downto  0) <= std_logic_vector(w_bot);
  s_dina(63 downto 32) <= std_logic_vector(w_top) when (wrte_algn = '1') else
                          std_logic_vector(w_bot);
  -- Port B
  s_dinb <= x"00000000" & std_logic_vector(w_top);
  
  -- Read data
  s_rdata_b <= s_douta(31 downto  0) when (read_algn = '1') else
               s_douta(63 downto 32);
  s_rdata_m <= s_douta(63 downto 32) when (read_algn = '1') else
               s_doutb(31 downto  0);
  s_rdata_t <= s_doutb(31 downto  0) when (read_algn = '1') else
               s_doutb(63 downto 32);
  
  stack_mem : blk_mem_gen_0
    PORT MAP (
      clka  => clk,
      ena   => '1',
      wea   => s_wea,
      addra => s_addra,
      dina  => s_dina,
      douta => s_douta,
      clkb  => clk,
      enb   => '1',
      web   => s_web,
      addrb => s_addrb,
      dinb  => s_dinb,
      doutb => s_doutb);
end behavioral;
