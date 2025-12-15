#ifndef AXI_TEST_REG_H
#define AXI_TEST_REG_H
#include "stdint.h"
#define AXI_TEST_REG_REGISTER_0_BIT_FIELD_0_BIT_WIDTH 4
#define AXI_TEST_REG_REGISTER_0_BIT_FIELD_0_BIT_MASK 0xf
#define AXI_TEST_REG_REGISTER_0_BIT_FIELD_0_BIT_OFFSET 0
#define AXI_TEST_REG_REGISTER_0_BIT_FIELD_1_BIT_WIDTH 4
#define AXI_TEST_REG_REGISTER_0_BIT_FIELD_1_BIT_MASK 0xf
#define AXI_TEST_REG_REGISTER_0_BIT_FIELD_1_BIT_OFFSET 4
#define AXI_TEST_REG_REGISTER_0_BIT_FIELD_2_BIT_WIDTH 1
#define AXI_TEST_REG_REGISTER_0_BIT_FIELD_2_BIT_MASK 0x1
#define AXI_TEST_REG_REGISTER_0_BIT_FIELD_2_BIT_OFFSET 8
#define AXI_TEST_REG_REGISTER_0_BIT_FIELD_3_BIT_WIDTH 2
#define AXI_TEST_REG_REGISTER_0_BIT_FIELD_3_BIT_MASK 0x3
#define AXI_TEST_REG_REGISTER_0_BIT_FIELD_3_BIT_OFFSET 9
#define AXI_TEST_REG_REGISTER_0_BIT_FIELD_4_BIT_WIDTH 2
#define AXI_TEST_REG_REGISTER_0_BIT_FIELD_4_BIT_MASK 0x3
#define AXI_TEST_REG_REGISTER_0_BIT_FIELD_4_BIT_OFFSET 11
#define AXI_TEST_REG_REGISTER_0_BIT_FIELD_5_BIT_WIDTH 2
#define AXI_TEST_REG_REGISTER_0_BIT_FIELD_5_BIT_MASK 0x3
#define AXI_TEST_REG_REGISTER_0_BIT_FIELD_5_BIT_OFFSET 13
#define AXI_TEST_REG_REGISTER_0_BIT_FIELD_6_BIT_WIDTH 2
#define AXI_TEST_REG_REGISTER_0_BIT_FIELD_6_BIT_MASK 0x3
#define AXI_TEST_REG_REGISTER_0_BIT_FIELD_6_BIT_OFFSET 15
#define AXI_TEST_REG_REGISTER_0_BYTE_WIDTH 4
#define AXI_TEST_REG_REGISTER_0_BYTE_SIZE 4
#define AXI_TEST_REG_REGISTER_0_BYTE_OFFSET 0x0
#define AXI_TEST_REG_REGISTER_1_BIT_WIDTH 1
#define AXI_TEST_REG_REGISTER_1_BIT_MASK 0x1
#define AXI_TEST_REG_REGISTER_1_BIT_OFFSET 0
#define AXI_TEST_REG_REGISTER_1_FOO 0x0
#define AXI_TEST_REG_REGISTER_1_BAR 0x1
#define AXI_TEST_REG_REGISTER_1_BYTE_WIDTH 4
#define AXI_TEST_REG_REGISTER_1_BYTE_SIZE 4
#define AXI_TEST_REG_REGISTER_1_BYTE_OFFSET 0x4
#define AXI_TEST_REG_REGISTER_2_BIT_FIELD_0_BIT_WIDTH 4
#define AXI_TEST_REG_REGISTER_2_BIT_FIELD_0_BIT_MASK 0xf
#define AXI_TEST_REG_REGISTER_2_BIT_FIELD_0_BIT_OFFSET 0
#define AXI_TEST_REG_REGISTER_2_BIT_FIELD_1_BIT_WIDTH 8
#define AXI_TEST_REG_REGISTER_2_BIT_FIELD_1_BIT_MASK 0xff
#define AXI_TEST_REG_REGISTER_2_BIT_FIELD_1_BIT_OFFSET 8
#define AXI_TEST_REG_REGISTER_2_BIT_FIELD_2_BIT_WIDTH 4
#define AXI_TEST_REG_REGISTER_2_BIT_FIELD_2_BIT_MASK 0xf
#define AXI_TEST_REG_REGISTER_2_BIT_FIELD_2_BIT_OFFSET 16
#define AXI_TEST_REG_REGISTER_2_BYTE_WIDTH 4
#define AXI_TEST_REG_REGISTER_2_BYTE_SIZE 4
#define AXI_TEST_REG_REGISTER_2_BYTE_OFFSET 0x8
typedef struct {
  uint32_t register_0;
  uint32_t register_1;
  uint32_t register_2;
  uint32_t __reserved_0x0c;
  uint32_t __reserved_0x10;
  uint32_t __reserved_0x14;
  uint32_t __reserved_0x18;
  uint32_t __reserved_0x1c;
  uint32_t __reserved_0x20;
  uint32_t __reserved_0x24;
  uint32_t __reserved_0x28;
  uint32_t __reserved_0x2c;
  uint32_t __reserved_0x30;
  uint32_t __reserved_0x34;
  uint32_t __reserved_0x38;
  uint32_t __reserved_0x3c;
  uint32_t __reserved_0x40;
  uint32_t __reserved_0x44;
  uint32_t __reserved_0x48;
  uint32_t __reserved_0x4c;
  uint32_t __reserved_0x50;
  uint32_t __reserved_0x54;
  uint32_t __reserved_0x58;
  uint32_t __reserved_0x5c;
  uint32_t __reserved_0x60;
  uint32_t __reserved_0x64;
  uint32_t __reserved_0x68;
  uint32_t __reserved_0x6c;
  uint32_t __reserved_0x70;
  uint32_t __reserved_0x74;
  uint32_t __reserved_0x78;
  uint32_t __reserved_0x7c;
  uint32_t __reserved_0x80;
  uint32_t __reserved_0x84;
  uint32_t __reserved_0x88;
  uint32_t __reserved_0x8c;
  uint32_t __reserved_0x90;
  uint32_t __reserved_0x94;
  uint32_t __reserved_0x98;
  uint32_t __reserved_0x9c;
  uint32_t __reserved_0xa0;
  uint32_t __reserved_0xa4;
  uint32_t __reserved_0xa8;
  uint32_t __reserved_0xac;
  uint32_t __reserved_0xb0;
  uint32_t __reserved_0xb4;
  uint32_t __reserved_0xb8;
  uint32_t __reserved_0xbc;
  uint32_t __reserved_0xc0;
  uint32_t __reserved_0xc4;
  uint32_t __reserved_0xc8;
  uint32_t __reserved_0xcc;
  uint32_t __reserved_0xd0;
  uint32_t __reserved_0xd4;
  uint32_t __reserved_0xd8;
  uint32_t __reserved_0xdc;
  uint32_t __reserved_0xe0;
  uint32_t __reserved_0xe4;
  uint32_t __reserved_0xe8;
  uint32_t __reserved_0xec;
  uint32_t __reserved_0xf0;
  uint32_t __reserved_0xf4;
  uint32_t __reserved_0xf8;
  uint32_t __reserved_0xfc;
} axi_test_reg_t;
#endif
