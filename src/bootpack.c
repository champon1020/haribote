#include "bootpack.h"

void HariMain(void)
{
  struct BOOTINFO *binfo;
  char s[32], mcursor[256];
  int mx, my;

  init_gdtidt();
  init_pic();
  io_sti();
  
  init_palette();
  binfo = (struct BOOTINFO *) 0x0ff0;
  init_screen(binfo->vram, binfo->scrnx, binfo->scrny);
  init_mouse_cursor8(mcursor, COL8_008484);

  mx = (binfo->scrnx - 16) / 2;
  my = (binfo->scrny - 28 - 16) / 2;
  putblock8_8(binfo->vram, binfo->scrnx, 16, 16, mx, my, mcursor, 16);

  sprintf(s, "(%d, %d)", mx, my);
  putfonts8_asc(binfo->vram, binfo->scrnx, 0, 0, COL8_FFFFFF, s);

  io_out8(PIC0_IMR, 0xf9);
  io_out8(PIC1_IMR, 0xef);

  io_hlt();
}
