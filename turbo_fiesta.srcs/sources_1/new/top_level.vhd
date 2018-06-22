library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity top_level is
    Port (CLK100MHZ    : in  std_logic;
          reset        : in  std_logic;
          uart_rxd_out : out std_logic);
end top_level;

architecture Behavioral of top_level is

component clk_control
  port(clk      : in  std_logic; -- Clock
       reset    : in  std_logic; -- Reset pin
       pc_clk   : out std_logic; -- Clock for PC
       alu_clk  : out std_logic; -- Clock for ALU computation
       im_clk   : out std_logic; -- Clock to enable instruction mem write
       st_clk   : out std_logic);-- Clock to enable stack push
end component;

component pc
  port(clk      : in  std_logic; -- Clock
       reset    : in  std_logic; -- '1' to reset to top-left moving left
       stall    : in  std_logic; -- '1' to prevent PC advancement
       chng_dir : in  std_logic; -- '1' if direction is changed
       bridge   : in  std_logic; -- for '#' instructions
       dx       : in    signed( 1 downto 0); -- dPCx/dt
       dy       : in    signed( 1 downto 0); -- dPCy/dt
       o_PC_x   : out unsigned( 7 downto 0); -- PC x output
       o_PC_y   : out unsigned( 7 downto 0); -- PC y output
       o_addr   : out std_logic_vector(15 downto 0));-- 1D mem address
end component;

COMPONENT im_blk_mem_gen_0
  PORT (
    clka  : IN STD_LOGIC;
    ena   : IN STD_LOGIC;
    wea   : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
    addra : IN STD_LOGIC_VECTOR(10 DOWNTO 0);
    dina  : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
    douta : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
    clkb  : IN STD_LOGIC;
    enb   : IN STD_LOGIC;
    web   : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
    addrb : IN STD_LOGIC_VECTOR(10 DOWNTO 0);
    dinb  : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
    doutb : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
  );
END COMPONENT;

component stack
  port(clk      : in  std_logic; -- Clock
       w_clk    : in  std_logic; -- Clock for write enable
       sp_clk   : in  std_logic; -- Clock for sp update
       reset    : in  std_logic; -- Reset
       num_push : in  unsigned( 1 downto 0); -- '1' if result is to be pushed
       num_pop  : in  unsigned( 1 downto 0);  -- Number removed in inst
       w_bot    : in    signed(31 downto 0);  -- Data to write onto stack
       w_top    : in    signed(31 downto 0);  -- Data to write higher onto stack
       top      : out   signed(31 downto 0);  -- Data on top of stack
       mid      : out   signed(31 downto 0);  -- Data 1 below top value
       bot      : out   signed(31 downto 0)); -- Data 2 below top value
end component;

component alu_ex
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
end component;

component uart_buff
    generic( LOGN : integer := 8;
                N : integer := 256);
    Port ( clk  : in STD_LOGIC;
           w_clk: in std_logic;
           data : in STD_LOGIC_VECTOR (7 downto 0);
           w_en : in STD_LOGIC;
           uart : out STD_LOGIC);
end component;

signal s_stall   : std_logic := '0'; 

-- Clock Signals
signal s_pc_clk  : std_logic;
signal s_alu_clk : std_logic;
signal s_im_clk  : std_logic;
signal s_st_clk  : std_logic;

-- PC output signals
signal s_pc_addr : std_logic_vector(15 downto 0);
signal s_pc_x    :         unsigned( 7 downto 0);
signal s_pc_y    :         unsigned( 7 downto 0);

-- IM input signals
signal s_web     : std_logic_vector(0 downto 0);
-- IM output signals
signal s_inst    : std_logic_vector(7 downto 0);
signal s_get     : std_logic_vector(7 downto 0);

-- Stack input signals
signal s_botval  : signed(31 downto 0);
-- Stack output signals
signal s_top     : signed(31 downto 0);
signal s_mid     : signed(31 downto 0);
signal s_bot     : signed(31 downto 0);

-- ALU output signals
signal s_redir   : std_logic;
signal s_smod    : std_logic;
signal s_bridge  : std_logic;
signal s_output  : std_logic;
signal s_strmode : std_logic;
signal s_n_pop   : unsigned(1 downto 0);
signal s_n_push  : unsigned(1 downto 0);
signal s_restop  : signed(31 downto 0);
signal s_resbot  : signed(31 downto 0);
signal s_dx      : signed(1 downto 0);
signal s_dy      : signed(1 downto 0);
signal s_im_addr : std_logic_vector(15 downto 0);
begin

-- Clock signal generator
clk_impl: clk_control
  port map(clk      => CLK100MHZ,
           reset    => reset,
           pc_clk   => s_pc_clk,
           alu_clk  => s_alu_clk,
           im_clk   => s_im_clk,
           st_clk   => s_st_clk);

-- Program Counter
pc_impl: pc
  port map(clk      => s_pc_clk,
           reset    => reset,
           stall    => s_stall,
           chng_dir => s_redir,
           bridge   => s_bridge,
           dx       => s_dx,
           dy       => s_dy,
           o_PC_x   => s_pc_x,
           o_PC_y   => s_pc_y,
           o_addr   => s_pc_addr);
           
-- Instruction Memory
s_web(0) <= s_smod;
im_impl : im_blk_mem_gen_0
  PORT MAP (
    clka  => CLK100MHZ,
    ena   => '1',
    wea   => "0",
    addra => s_pc_addr(10 downto 0),
    dina  => x"00",
    douta => s_inst,
    clkb  => CLK100MHZ,
    enb   => s_im_clk,
    web   => s_web,
    addrb => s_im_addr(10 downto 0),
    dinb  => std_logic_vector(s_resbot(7 downto 0)),
    doutb => s_get);

-- Stack Memory
-- TODO ADR stringmode
s_botval <= signed(x"000000" & s_get) when ((s_inst = x"67") and (s_strmode='0')) else s_resbot;
stack_impl: stack
  port map(clk      => CLK100MHZ,
           w_clk    => s_st_clk,
           sp_clk   => s_pc_clk,
           reset    => reset,
           num_push => s_n_push,
           num_pop  => s_n_pop,
           w_bot    => s_botval,
           w_top    => s_restop,
           top      => s_top,
           mid      => s_mid,
           bot      => s_bot);

-- ALU and instruction execution
alu_impl: alu_ex
    port map (clk     => s_alu_clk,
              inst    => s_inst,
              bot     => s_bot,
              mid     => s_mid,
              top     => s_top,
              stdin   => x"00000000", -- TODO ADR stdin?
              redir   => s_redir,
              smod    => s_smod,
              bridge  => s_bridge,
              output  => s_output,
              strmode => s_strmode,
              n_pop   => s_n_pop,
              n_push  => s_n_push,
              restop  => s_restop,
              resbot  => s_resbot,
              dx      => s_dx,
              dy      => s_dy,
              im_addr => s_im_addr);

output_buff: uart_buff
    Port map(clk   => CLK100MHZ,
             w_clk => s_im_clk,
             data  => std_logic_vector(s_resbot(7 downto 0)),
             w_en  => s_output,
             uart  => uart_rxd_out);
end Behavioral;