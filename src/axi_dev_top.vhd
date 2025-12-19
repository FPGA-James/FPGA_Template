-- ============================================================================
--  Project        : FPGA_Template
--  File           : <FILENAME>
--  Description    : <SHORT DESCRIPTION>
--
--  Created Date   : <YYYY-MM-DD>
--  Modified Date  : 2025-12-19
--  Checksum       : 758c77a4f3021ee1712b60a8da90496c40cffc595eb864af723ad33acf6f793f
--
--  Author         : <AUTHOR>
--  Company        : <COMPANY>
--
--  Notes:
--    - Created Date is set once at file creation.
--    - Modified Date and Checksum are maintained automatically
--      via Git pre-commit hooks.
--    - Checksum excludes this header block.
-- ============================================================================

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- @wavedrom
-- {
--   "signal":[{"name":"clk","wave":"p....."},{"name":"valid","wave":"01.0.."}]
-- }
-- @endwavedrom
entity axi_dev_top is
    generic (
        DATA_WIDTH : integer := 32;
        ADDR_WIDTH : integer := 32
    );
    port (
        clk_i : in std_logic;
        rst_n_i : in std_logic;
        
        -- AXI Stream Slave
        s_axis_tdata_i : in std_logic_vector(DATA_WIDTH - 1 downto 0);
        s_axis_tvalid_i : in std_logic;
        s_axis_tready_o : out std_logic;
        s_axis_tlast_i : in std_logic;
        
        -- AXI Lite Slave
        s_axi_awaddr_i : in std_logic_vector(ADDR_WIDTH - 1 downto 0);
        s_axi_awvalid_i : in std_logic;
        s_axi_awready_o : out std_logic;
        s_axi_wdata_i : in std_logic_vector(31 downto 0);
        s_axi_wstrb_i : in std_logic_vector(3 downto 0);
        s_axi_wvalid_i : in std_logic;
        s_axi_wready_o : out std_logic;
        s_axi_bresp_o : out std_logic_vector(1 downto 0);
        s_axi_bvalid_o : out std_logic;
        s_axi_bready_i : in std_logic;
        
        s_axi_araddr_i : in std_logic_vector(ADDR_WIDTH - 1 downto 0);
        s_axi_arvalid_i : in std_logic;
        s_axi_arready_o : out std_logic;
        s_axi_rdata_o : out std_logic_vector(31 downto 0);
        s_axi_rresp_o : out std_logic_vector(1 downto 0);
        s_axi_rvalid_o : out std_logic;
        s_axi_rready_i : in std_logic
    );
end entity axi_dev_top;


-- description od the architecture
architecture rtl of axi_dev_top is
    constant c_test2 : std_logic := '1';
    

begin
    
-- Add your logic here
-- Instantiate the axi_test_reg
axi_test_reg_inst : entity work.axi_test_reg
    generic map (
        ADDRESS_WIDTH => ADDR_WIDTH,
        PRE_DECODE => false,
        BASE_ADDRESS => (others => '0'),
        ERROR_STATUS => false,
        INSERT_SLICER => false,
        ID_WIDTH => 0,
        WRITE_FIRST => true
    )
    port map (
        i_clk => clk_i,
        i_rst_n => rst_n_i,
        i_awvalid => s_axi_awvalid_i,
        o_awready => s_axi_awready_o,
        i_awid => (others => '0'),  -- Adjust as necessary
        i_awaddr => s_axi_awaddr_i,
        i_awprot => (others => '0'), -- Adjust as necessary
        i_wvalid => s_axi_wvalid_i,
        o_wready => s_axi_wready_o,
        i_wdata => s_axi_wdata_i,
        i_wstrb => s_axi_wstrb_i,
        o_bvalid => s_axi_bvalid_o,
        i_bready => s_axi_bready_i,
        o_bid => (others => '0'), -- Adjust as necessary
        o_bresp => s_axi_bresp_o,
        i_arvalid => s_axi_arvalid_i,
        o_arready => s_axi_arready_o,
        i_arid => (others => '0'), -- Adjust as necessary
        i_araddr => s_axi_araddr_i,
        i_arprot => (others => '0'), -- Adjust as necessary
        o_rvalid => s_axi_rvalid_o,
        i_rready => s_axi_rready_i,
        o_rid => (others => '0'), -- Adjust as necessary
        o_rdata => s_axi_rdata_o,
        o_rresp => s_axi_rresp_o,
        -- Register connections
        o_register_0_bit_field_0 => open,
        o_register_0_bit_field_1 => open,
        o_register_0_bit_field_2 => open,
        o_register_0_bit_field_3 => open,
        o_register_0_bit_field_4 => open,
        o_register_0_bit_field_5 => open,
        o_register_0_bit_field_6 => open,
        i_register_0_bit_field_6 => (others => '0'), -- Adjust as necessary
        o_register_1 => open,
        i_register_2_bit_field_0 => (others => '0'), -- Adjust as necessary
        i_register_2_bit_field_2_valid => (others => '0'), -- Adjust as necessary
        i_register_2_bit_field_2 => (others => '0'), -- Adjust as necessary
        o_register_2_bit_field_2 => open
    );


    -- @wavedrom
    -- {
    --   "signal": [
    --     { "name": "ACLK",   "wave": "p................" },
    --     { "name": "TVALID", "wave": "0..1110..10......" },
    --     { "name": "TREADY", "wave": "1..10.1..01......" },
    --     { "name": "TDATA",  "wave": "x..=.=.=..=.......",
    --       "data": ["DEADBEEF", "FEEDC0DE", "01234567", "CAFEBABE"]
    --     },
    --     { "name": "TKEEP",  "wave": "x..=.=.=..=.......",
    --       "data": ["F", "F", "C", "F"]
    --     },
    --     { "name": "TLAST",  "wave": "0....0..10......." },
    --     { "name": "TID",    "wave": "x..=.............",
    --       "data": ["3"]
    --     },
    --     { "name": "TDEST",  "wave": "x..=.............",
    --       "data": ["1"]
    --     }
    --   ],
    --   "config": {
    --     "hscale": 1
    --   }
    -- }
    -- @endwavedrom

    -- test comment
    process (rising_edge clk_i)
    begin
        
    end process;


end architecture rtl;