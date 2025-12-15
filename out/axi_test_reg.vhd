library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library rggen_rtl;
use rggen_rtl.rggen_rtl.all;

entity axi_test_reg is
  generic (
    ADDRESS_WIDTH: positive := 8;
    PRE_DECODE: boolean := false;
    BASE_ADDRESS: unsigned := x"0";
    ERROR_STATUS: boolean := false;
    INSERT_SLICER: boolean := false;
    ID_WIDTH: natural := 0;
    WRITE_FIRST: boolean := true
  );
  port (
    i_clk: in std_logic;
    i_rst_n: in std_logic;
    i_awvalid: in std_logic;
    o_awready: out std_logic;
    i_awid: in std_logic_vector(clip_id_width(ID_WIDTH)-1 downto 0);
    i_awaddr: in std_logic_vector(ADDRESS_WIDTH-1 downto 0);
    i_awprot: in std_logic_vector(2 downto 0);
    i_wvalid: in std_logic;
    o_wready: out std_logic;
    i_wdata: in std_logic_vector(31 downto 0);
    i_wstrb: in std_logic_vector(3 downto 0);
    o_bvalid: out std_logic;
    i_bready: in std_logic;
    o_bid: out std_logic_vector(clip_id_width(ID_WIDTH)-1 downto 0);
    o_bresp: out std_logic_vector(1 downto 0);
    i_arvalid: in std_logic;
    o_arready: out std_logic;
    i_arid: in std_logic_vector(clip_id_width(ID_WIDTH)-1 downto 0);
    i_araddr: in std_logic_vector(ADDRESS_WIDTH-1 downto 0);
    i_arprot: in std_logic_vector(2 downto 0);
    o_rvalid: out std_logic;
    i_rready: in std_logic;
    o_rid: out std_logic_vector(clip_id_width(ID_WIDTH)-1 downto 0);
    o_rdata: out std_logic_vector(31 downto 0);
    o_rresp: out std_logic_vector(1 downto 0);
    o_register_0_bit_field_0: out std_logic_vector(3 downto 0);
    o_register_0_bit_field_1: out std_logic_vector(3 downto 0);
    o_register_0_bit_field_2: out std_logic_vector(0 downto 0);
    o_register_0_bit_field_3: out std_logic_vector(1 downto 0);
    o_register_0_bit_field_4: out std_logic_vector(1 downto 0);
    o_register_0_bit_field_5: out std_logic_vector(1 downto 0);
    o_register_0_bit_field_6: out std_logic_vector(1 downto 0);
    i_register_0_bit_field_6: in std_logic_vector(1 downto 0);
    o_register_1: out std_logic_vector(0 downto 0);
    i_register_2_bit_field_0: in std_logic_vector(3 downto 0);
    i_register_2_bit_field_2_valid: in std_logic_vector(0 downto 0);
    i_register_2_bit_field_2: in std_logic_vector(3 downto 0);
    o_register_2_bit_field_2: out std_logic_vector(3 downto 0)
  );
end axi_test_reg;

architecture rtl of axi_test_reg is
  signal register_valid: std_logic;
  signal register_access: std_logic_vector(1 downto 0);
  signal register_address: std_logic_vector(7 downto 0);
  signal register_write_data: std_logic_vector(31 downto 0);
  signal register_strobe: std_logic_vector(31 downto 0);
  signal register_active: std_logic_vector(2 downto 0);
  signal register_ready: std_logic_vector(2 downto 0);
  signal register_status: std_logic_vector(5 downto 0);
  signal register_read_data: std_logic_vector(95 downto 0);
  signal register_value: std_logic_vector(95 downto 0);
begin
  u_adapter: entity rggen_rtl.rggen_axi4lite_adapter
    generic map (
      ID_WIDTH            => ID_WIDTH,
      ADDRESS_WIDTH       => ADDRESS_WIDTH,
      LOCAL_ADDRESS_WIDTH => 8,
      BUS_WIDTH           => 32,
      REGISTERS           => 3,
      PRE_DECODE          => PRE_DECODE,
      BASE_ADDRESS        => BASE_ADDRESS,
      BYTE_SIZE           => 256,
      ERROR_STATUS        => ERROR_STATUS,
      INSERT_SLICER       => INSERT_SLICER,
      WRITE_FIRST         => WRITE_FIRST
    )
    port map (
      i_clk                 => i_clk,
      i_rst_n               => i_rst_n,
      i_awvalid             => i_awvalid,
      o_awready             => o_awready,
      i_awid                => i_awid,
      i_awaddr              => i_awaddr,
      i_awprot              => i_awprot,
      i_wvalid              => i_wvalid,
      o_wready              => o_wready,
      i_wdata               => i_wdata,
      i_wstrb               => i_wstrb,
      o_bvalid              => o_bvalid,
      i_bready              => i_bready,
      o_bid                 => o_bid,
      o_bresp               => o_bresp,
      i_arvalid             => i_arvalid,
      o_arready             => o_arready,
      i_arid                => i_arid,
      i_araddr              => i_araddr,
      i_arprot              => i_arprot,
      o_rvalid              => o_rvalid,
      i_rready              => i_rready,
      o_rid                 => o_rid,
      o_rdata               => o_rdata,
      o_rresp               => o_rresp,
      o_register_valid      => register_valid,
      o_register_access     => register_access,
      o_register_address    => register_address,
      o_register_write_data => register_write_data,
      o_register_strobe     => register_strobe,
      i_register_active     => register_active,
      i_register_ready      => register_ready,
      i_register_status     => register_status,
      i_register_read_data  => register_read_data
    );
  g_register_0: block
    signal bit_field_read_valid: std_logic;
    signal bit_field_write_valid: std_logic;
    signal bit_field_mask: std_logic_vector(31 downto 0);
    signal bit_field_write_data: std_logic_vector(31 downto 0);
    signal bit_field_read_data: std_logic_vector(31 downto 0);
    signal bit_field_value: std_logic_vector(31 downto 0);
  begin
    \g_tie_off\: for \__i\ in 0 to 31 generate
      g: if (bit_slice(x"0001ffff", \__i\) = '0') generate
        bit_field_read_data(\__i\) <= '0';
        bit_field_value(\__i\) <= '0';
      end generate;
    end generate;
    u_register: entity rggen_rtl.rggen_default_register
      generic map (
        READABLE        => true,
        WRITABLE        => true,
        ADDRESS_WIDTH   => 8,
        OFFSET_ADDRESS  => x"00",
        BUS_WIDTH       => 32,
        DATA_WIDTH      => 32
      )
      port map (
        i_clk                   => i_clk,
        i_rst_n                 => i_rst_n,
        i_register_valid        => register_valid,
        i_register_access       => register_access,
        i_register_address      => register_address,
        i_register_write_data   => register_write_data,
        i_register_strobe       => register_strobe,
        o_register_active       => register_active(0),
        o_register_ready        => register_ready(0),
        o_register_status       => register_status(1 downto 0),
        o_register_read_data    => register_read_data(31 downto 0),
        o_register_value        => register_value(31 downto 0),
        o_bit_field_read_valid  => bit_field_read_valid,
        o_bit_field_write_valid => bit_field_write_valid,
        o_bit_field_mask        => bit_field_mask,
        o_bit_field_write_data  => bit_field_write_data,
        i_bit_field_read_data   => bit_field_read_data,
        i_bit_field_value       => bit_field_value
      );
    g_bit_field_0: block
    begin
      u_bit_field: entity rggen_rtl.rggen_bit_field
        generic map (
          WIDTH           => 4,
          INITIAL_VALUE   => slice(x"0", 4, 0),
          SW_WRITE_ONCE   => false,
          TRIGGER         => false
        )
        port map (
          i_clk             => i_clk,
          i_rst_n           => i_rst_n,
          i_sw_read_valid   => bit_field_read_valid,
          i_sw_write_valid  => bit_field_write_valid,
          i_sw_write_enable => "1",
          i_sw_mask         => bit_field_mask(3 downto 0),
          i_sw_write_data   => bit_field_write_data(3 downto 0),
          o_sw_read_data    => bit_field_read_data(3 downto 0),
          o_sw_value        => bit_field_value(3 downto 0),
          o_write_trigger   => open,
          o_read_trigger    => open,
          i_hw_write_enable => "0",
          i_hw_write_data   => (others => '0'),
          i_hw_set          => (others => '0'),
          i_hw_clear        => (others => '0'),
          i_value           => (others => '0'),
          i_mask            => (others => '1'),
          o_value           => o_register_0_bit_field_0,
          o_value_unmasked  => open
        );
    end block;
    g_bit_field_1: block
    begin
      u_bit_field: entity rggen_rtl.rggen_bit_field
        generic map (
          WIDTH           => 4,
          INITIAL_VALUE   => slice(x"0", 4, 0),
          SW_WRITE_ONCE   => false,
          TRIGGER         => false
        )
        port map (
          i_clk             => i_clk,
          i_rst_n           => i_rst_n,
          i_sw_read_valid   => bit_field_read_valid,
          i_sw_write_valid  => bit_field_write_valid,
          i_sw_write_enable => "1",
          i_sw_mask         => bit_field_mask(7 downto 4),
          i_sw_write_data   => bit_field_write_data(7 downto 4),
          o_sw_read_data    => bit_field_read_data(7 downto 4),
          o_sw_value        => bit_field_value(7 downto 4),
          o_write_trigger   => open,
          o_read_trigger    => open,
          i_hw_write_enable => "0",
          i_hw_write_data   => (others => '0'),
          i_hw_set          => (others => '0'),
          i_hw_clear        => (others => '0'),
          i_value           => (others => '0'),
          i_mask            => (others => '1'),
          o_value           => o_register_0_bit_field_1,
          o_value_unmasked  => open
        );
    end block;
    g_bit_field_2: block
    begin
      u_bit_field: entity rggen_rtl.rggen_bit_field
        generic map (
          WIDTH           => 1,
          INITIAL_VALUE   => slice(x"0", 1, 0),
          SW_WRITE_ONCE   => false,
          TRIGGER         => false
        )
        port map (
          i_clk             => i_clk,
          i_rst_n           => i_rst_n,
          i_sw_read_valid   => bit_field_read_valid,
          i_sw_write_valid  => bit_field_write_valid,
          i_sw_write_enable => "1",
          i_sw_mask         => bit_field_mask(8 downto 8),
          i_sw_write_data   => bit_field_write_data(8 downto 8),
          o_sw_read_data    => bit_field_read_data(8 downto 8),
          o_sw_value        => bit_field_value(8 downto 8),
          o_write_trigger   => open,
          o_read_trigger    => open,
          i_hw_write_enable => "0",
          i_hw_write_data   => (others => '0'),
          i_hw_set          => (others => '0'),
          i_hw_clear        => (others => '0'),
          i_value           => (others => '0'),
          i_mask            => (others => '1'),
          o_value           => o_register_0_bit_field_2,
          o_value_unmasked  => open
        );
    end block;
    g_bit_field_3: block
    begin
      u_bit_field: entity rggen_rtl.rggen_bit_field
        generic map (
          WIDTH           => 2,
          INITIAL_VALUE   => slice(x"0", 2, 0),
          SW_WRITE_ONCE   => true,
          TRIGGER         => false
        )
        port map (
          i_clk             => i_clk,
          i_rst_n           => i_rst_n,
          i_sw_read_valid   => bit_field_read_valid,
          i_sw_write_valid  => bit_field_write_valid,
          i_sw_write_enable => "1",
          i_sw_mask         => bit_field_mask(10 downto 9),
          i_sw_write_data   => bit_field_write_data(10 downto 9),
          o_sw_read_data    => bit_field_read_data(10 downto 9),
          o_sw_value        => bit_field_value(10 downto 9),
          o_write_trigger   => open,
          o_read_trigger    => open,
          i_hw_write_enable => "0",
          i_hw_write_data   => (others => '0'),
          i_hw_set          => (others => '0'),
          i_hw_clear        => (others => '0'),
          i_value           => (others => '0'),
          i_mask            => (others => '1'),
          o_value           => o_register_0_bit_field_3,
          o_value_unmasked  => open
        );
    end block;
    g_bit_field_4: block
    begin
      u_bit_field: entity rggen_rtl.rggen_bit_field
        generic map (
          WIDTH           => 2,
          INITIAL_VALUE   => slice(x"0", 2, 0),
          SW_READ_ACTION  => RGGEN_READ_CLEAR
        )
        port map (
          i_clk             => i_clk,
          i_rst_n           => i_rst_n,
          i_sw_read_valid   => bit_field_read_valid,
          i_sw_write_valid  => bit_field_write_valid,
          i_sw_write_enable => "1",
          i_sw_mask         => bit_field_mask(12 downto 11),
          i_sw_write_data   => bit_field_write_data(12 downto 11),
          o_sw_read_data    => bit_field_read_data(12 downto 11),
          o_sw_value        => bit_field_value(12 downto 11),
          o_write_trigger   => open,
          o_read_trigger    => open,
          i_hw_write_enable => "0",
          i_hw_write_data   => (others => '0'),
          i_hw_set          => (others => '0'),
          i_hw_clear        => (others => '0'),
          i_value           => (others => '0'),
          i_mask            => (others => '1'),
          o_value           => o_register_0_bit_field_4,
          o_value_unmasked  => open
        );
    end block;
    g_bit_field_5: block
    begin
      u_bit_field: entity rggen_rtl.rggen_bit_field
        generic map (
          WIDTH           => 2,
          INITIAL_VALUE   => slice(x"0", 2, 0),
          SW_READ_ACTION  => RGGEN_READ_SET
        )
        port map (
          i_clk             => i_clk,
          i_rst_n           => i_rst_n,
          i_sw_read_valid   => bit_field_read_valid,
          i_sw_write_valid  => bit_field_write_valid,
          i_sw_write_enable => "1",
          i_sw_mask         => bit_field_mask(14 downto 13),
          i_sw_write_data   => bit_field_write_data(14 downto 13),
          o_sw_read_data    => bit_field_read_data(14 downto 13),
          o_sw_value        => bit_field_value(14 downto 13),
          o_write_trigger   => open,
          o_read_trigger    => open,
          i_hw_write_enable => "0",
          i_hw_write_data   => (others => '0'),
          i_hw_set          => (others => '0'),
          i_hw_clear        => (others => '0'),
          i_value           => (others => '0'),
          i_mask            => (others => '1'),
          o_value           => o_register_0_bit_field_5,
          o_value_unmasked  => open
        );
    end block;
    g_bit_field_6: block
    begin
      u_bit_field: entity rggen_rtl.rggen_bit_field
        generic map (
          WIDTH               => 2,
          INITIAL_VALUE       => slice(x"0", 2, 0),
          EXTERNAL_READ_DATA  => true,
          TRIGGER             => false
        )
        port map (
          i_clk             => i_clk,
          i_rst_n           => i_rst_n,
          i_sw_read_valid   => bit_field_read_valid,
          i_sw_write_valid  => bit_field_write_valid,
          i_sw_write_enable => "1",
          i_sw_mask         => bit_field_mask(16 downto 15),
          i_sw_write_data   => bit_field_write_data(16 downto 15),
          o_sw_read_data    => bit_field_read_data(16 downto 15),
          o_sw_value        => bit_field_value(16 downto 15),
          o_write_trigger   => open,
          o_read_trigger    => open,
          i_hw_write_enable => "0",
          i_hw_write_data   => (others => '0'),
          i_hw_set          => (others => '0'),
          i_hw_clear        => (others => '0'),
          i_value           => i_register_0_bit_field_6,
          i_mask            => (others => '1'),
          o_value           => o_register_0_bit_field_6,
          o_value_unmasked  => open
        );
    end block;
  end block;
  g_register_1: block
    signal bit_field_read_valid: std_logic;
    signal bit_field_write_valid: std_logic;
    signal bit_field_mask: std_logic_vector(31 downto 0);
    signal bit_field_write_data: std_logic_vector(31 downto 0);
    signal bit_field_read_data: std_logic_vector(31 downto 0);
    signal bit_field_value: std_logic_vector(31 downto 0);
  begin
    \g_tie_off\: for \__i\ in 0 to 31 generate
      g: if (bit_slice(x"00000001", \__i\) = '0') generate
        bit_field_read_data(\__i\) <= '0';
        bit_field_value(\__i\) <= '0';
      end generate;
    end generate;
    u_register: entity rggen_rtl.rggen_default_register
      generic map (
        READABLE        => true,
        WRITABLE        => true,
        ADDRESS_WIDTH   => 8,
        OFFSET_ADDRESS  => x"04",
        BUS_WIDTH       => 32,
        DATA_WIDTH      => 32
      )
      port map (
        i_clk                   => i_clk,
        i_rst_n                 => i_rst_n,
        i_register_valid        => register_valid,
        i_register_access       => register_access,
        i_register_address      => register_address,
        i_register_write_data   => register_write_data,
        i_register_strobe       => register_strobe,
        o_register_active       => register_active(1),
        o_register_ready        => register_ready(1),
        o_register_status       => register_status(3 downto 2),
        o_register_read_data    => register_read_data(63 downto 32),
        o_register_value        => register_value(63 downto 32),
        o_bit_field_read_valid  => bit_field_read_valid,
        o_bit_field_write_valid => bit_field_write_valid,
        o_bit_field_mask        => bit_field_mask,
        o_bit_field_write_data  => bit_field_write_data,
        i_bit_field_read_data   => bit_field_read_data,
        i_bit_field_value       => bit_field_value
      );
    g_register_1: block
    begin
      u_bit_field: entity rggen_rtl.rggen_bit_field
        generic map (
          WIDTH           => 1,
          INITIAL_VALUE   => slice(x"0", 1, 0),
          SW_WRITE_ONCE   => false,
          TRIGGER         => false
        )
        port map (
          i_clk             => i_clk,
          i_rst_n           => i_rst_n,
          i_sw_read_valid   => bit_field_read_valid,
          i_sw_write_valid  => bit_field_write_valid,
          i_sw_write_enable => "1",
          i_sw_mask         => bit_field_mask(0 downto 0),
          i_sw_write_data   => bit_field_write_data(0 downto 0),
          o_sw_read_data    => bit_field_read_data(0 downto 0),
          o_sw_value        => bit_field_value(0 downto 0),
          o_write_trigger   => open,
          o_read_trigger    => open,
          i_hw_write_enable => "0",
          i_hw_write_data   => (others => '0'),
          i_hw_set          => (others => '0'),
          i_hw_clear        => (others => '0'),
          i_value           => (others => '0'),
          i_mask            => (others => '1'),
          o_value           => o_register_1,
          o_value_unmasked  => open
        );
    end block;
  end block;
  g_register_2: block
    signal bit_field_read_valid: std_logic;
    signal bit_field_write_valid: std_logic;
    signal bit_field_mask: std_logic_vector(31 downto 0);
    signal bit_field_write_data: std_logic_vector(31 downto 0);
    signal bit_field_read_data: std_logic_vector(31 downto 0);
    signal bit_field_value: std_logic_vector(31 downto 0);
  begin
    \g_tie_off\: for \__i\ in 0 to 31 generate
      g: if (bit_slice(x"000fff0f", \__i\) = '0') generate
        bit_field_read_data(\__i\) <= '0';
        bit_field_value(\__i\) <= '0';
      end generate;
    end generate;
    u_register: entity rggen_rtl.rggen_default_register
      generic map (
        READABLE        => true,
        WRITABLE        => false,
        ADDRESS_WIDTH   => 8,
        OFFSET_ADDRESS  => x"08",
        BUS_WIDTH       => 32,
        DATA_WIDTH      => 32
      )
      port map (
        i_clk                   => i_clk,
        i_rst_n                 => i_rst_n,
        i_register_valid        => register_valid,
        i_register_access       => register_access,
        i_register_address      => register_address,
        i_register_write_data   => register_write_data,
        i_register_strobe       => register_strobe,
        o_register_active       => register_active(2),
        o_register_ready        => register_ready(2),
        o_register_status       => register_status(5 downto 4),
        o_register_read_data    => register_read_data(95 downto 64),
        o_register_value        => register_value(95 downto 64),
        o_bit_field_read_valid  => bit_field_read_valid,
        o_bit_field_write_valid => bit_field_write_valid,
        o_bit_field_mask        => bit_field_mask,
        o_bit_field_write_data  => bit_field_write_data,
        i_bit_field_read_data   => bit_field_read_data,
        i_bit_field_value       => bit_field_value
      );
    g_bit_field_0: block
    begin
      u_bit_field: entity rggen_rtl.rggen_bit_field
        generic map (
          WIDTH               => 4,
          STORAGE             => false,
          EXTERNAL_READ_DATA  => true,
          TRIGGER             => false
        )
        port map (
          i_clk             => i_clk,
          i_rst_n           => i_rst_n,
          i_sw_read_valid   => bit_field_read_valid,
          i_sw_write_valid  => bit_field_write_valid,
          i_sw_write_enable => "0",
          i_sw_mask         => bit_field_mask(3 downto 0),
          i_sw_write_data   => bit_field_write_data(3 downto 0),
          o_sw_read_data    => bit_field_read_data(3 downto 0),
          o_sw_value        => bit_field_value(3 downto 0),
          o_write_trigger   => open,
          o_read_trigger    => open,
          i_hw_write_enable => "0",
          i_hw_write_data   => (others => '0'),
          i_hw_set          => (others => '0'),
          i_hw_clear        => (others => '0'),
          i_value           => i_register_2_bit_field_0,
          i_mask            => (others => '1'),
          o_value           => open,
          o_value_unmasked  => open
        );
    end block;
    g_bit_field_1: block
    begin
      u_bit_field: entity rggen_rtl.rggen_bit_field
        generic map (
          WIDTH               => 8,
          STORAGE             => false,
          EXTERNAL_READ_DATA  => true
        )
        port map (
          i_clk             => '0',
          i_rst_n           => '0',
          i_sw_read_valid   => bit_field_read_valid,
          i_sw_write_valid  => bit_field_write_valid,
          i_sw_write_enable => "0",
          i_sw_mask         => bit_field_mask(15 downto 8),
          i_sw_write_data   => bit_field_write_data(15 downto 8),
          o_sw_read_data    => bit_field_read_data(15 downto 8),
          o_sw_value        => bit_field_value(15 downto 8),
          o_write_trigger   => open,
          o_read_trigger    => open,
          i_hw_write_enable => "0",
          i_hw_write_data   => (others => '0'),
          i_hw_set          => (others => '0'),
          i_hw_clear        => (others => '0'),
          i_value           => slice(x"ab", 8, 0),
          i_mask            => (others => '1'),
          o_value           => open,
          o_value_unmasked  => open
        );
    end block;
    g_bit_field_2: block
    begin
      u_bit_field: entity rggen_rtl.rggen_bit_field
        generic map (
          WIDTH           => 4,
          INITIAL_VALUE   => slice(x"0", 4, 0),
          SW_WRITE_ACTION => RGGEN_WRITE_NONE,
          HW_WRITE        => true
        )
        port map (
          i_clk             => i_clk,
          i_rst_n           => i_rst_n,
          i_sw_read_valid   => bit_field_read_valid,
          i_sw_write_valid  => bit_field_write_valid,
          i_sw_write_enable => "1",
          i_sw_mask         => bit_field_mask(19 downto 16),
          i_sw_write_data   => bit_field_write_data(19 downto 16),
          o_sw_read_data    => bit_field_read_data(19 downto 16),
          o_sw_value        => bit_field_value(19 downto 16),
          o_write_trigger   => open,
          o_read_trigger    => open,
          i_hw_write_enable => i_register_2_bit_field_2_valid,
          i_hw_write_data   => i_register_2_bit_field_2,
          i_hw_set          => (others => '0'),
          i_hw_clear        => (others => '0'),
          i_value           => (others => '0'),
          i_mask            => (others => '1'),
          o_value           => o_register_2_bit_field_2,
          o_value_unmasked  => open
        );
    end block;
  end block;
end rtl;
