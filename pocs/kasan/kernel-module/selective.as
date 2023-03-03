
selective.ko:     file format elf64-x86-64


Disassembly of section .text:

0000000000000000 <__pfx_nloops_show>:
   0:	90                   	nop
   1:	90                   	nop
   2:	90                   	nop
   3:	90                   	nop
   4:	90                   	nop
   5:	90                   	nop
   6:	90                   	nop
   7:	90                   	nop
   8:	90                   	nop
   9:	90                   	nop
   a:	90                   	nop
   b:	90                   	nop
   c:	90                   	nop
   d:	90                   	nop
   e:	90                   	nop
   f:	90                   	nop

0000000000000010 <nloops_show>:
  10:	f3 0f 1e fa          	endbr64 
  14:	53                   	push   rbx
  15:	48 89 d3             	mov    rbx,rdx
  18:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
  1f:	e8 00 00 00 00       	call   24 <nloops_show+0x14>
  24:	48 8b 0d 00 00 00 00 	mov    rcx,QWORD PTR [rip+0x0]        # 2b <nloops_show+0x1b>
  2b:	be 00 10 00 00       	mov    esi,0x1000
  30:	48 89 df             	mov    rdi,rbx
  33:	48 c7 c2 00 00 00 00 	mov    rdx,0x0
  3a:	e8 00 00 00 00       	call   3f <nloops_show+0x2f>
  3f:	48 63 d8             	movsxd rbx,eax
  42:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
  49:	e8 00 00 00 00       	call   4e <nloops_show+0x3e>
  4e:	48 89 d8             	mov    rax,rbx
  51:	5b                   	pop    rbx
  52:	2e e9 00 00 00 00    	cs jmp 58 <nloops_show+0x48>
  58:	0f 1f 84 00 00 00 00 	nop    DWORD PTR [rax+rax*1+0x0]
  5f:	00 

0000000000000060 <__pfx_nloops_store>:
  60:	90                   	nop
  61:	90                   	nop
  62:	90                   	nop
  63:	90                   	nop
  64:	90                   	nop
  65:	90                   	nop
  66:	90                   	nop
  67:	90                   	nop
  68:	90                   	nop
  69:	90                   	nop
  6a:	90                   	nop
  6b:	90                   	nop
  6c:	90                   	nop
  6d:	90                   	nop
  6e:	90                   	nop
  6f:	90                   	nop

0000000000000070 <nloops_store>:
  70:	f3 0f 1e fa          	endbr64 
  74:	41 57                	push   r15
  76:	41 56                	push   r14
  78:	53                   	push   rbx
  79:	48 83 ec 10          	sub    rsp,0x10
  7d:	48 89 cb             	mov    rbx,rcx
  80:	49 89 d6             	mov    r14,rdx
  83:	65 48 8b 04 25 28 00 	mov    rax,QWORD PTR gs:0x28
  8a:	00 00 
  8c:	48 89 44 24 08       	mov    QWORD PTR [rsp+0x8],rax
  91:	49 89 e7             	mov    r15,rsp
  94:	4c 89 ff             	mov    rdi,r15
  97:	e8 00 00 00 00       	call   9c <nloops_store+0x2c>
  9c:	48 c7 04 24 00 00 00 	mov    QWORD PTR [rsp],0x0
  a3:	00 
  a4:	4c 89 f7             	mov    rdi,r14
  a7:	31 f6                	xor    esi,esi
  a9:	4c 89 fa             	mov    rdx,r15
  ac:	e8 00 00 00 00       	call   b1 <nloops_store+0x41>
  b1:	85 c0                	test   eax,eax
  b3:	78 3c                	js     f1 <nloops_store+0x81>
  b5:	48 89 e7             	mov    rdi,rsp
  b8:	e8 00 00 00 00       	call   bd <nloops_store+0x4d>
  bd:	48 83 3c 24 00       	cmp    QWORD PTR [rsp],0x0
  c2:	74 32                	je     f6 <nloops_store+0x86>
  c4:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
  cb:	e8 00 00 00 00       	call   d0 <nloops_store+0x60>
  d0:	48 89 e7             	mov    rdi,rsp
  d3:	e8 00 00 00 00       	call   d8 <nloops_store+0x68>
  d8:	48 8b 04 24          	mov    rax,QWORD PTR [rsp]
  dc:	48 89 05 00 00 00 00 	mov    QWORD PTR [rip+0x0],rax        # e3 <nloops_store+0x73>
  e3:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
  ea:	e8 00 00 00 00       	call   ef <nloops_store+0x7f>
  ef:	eb 0c                	jmp    fd <nloops_store+0x8d>
  f1:	48 63 d8             	movsxd rbx,eax
  f4:	eb 07                	jmp    fd <nloops_store+0x8d>
  f6:	48 c7 c3 ea ff ff ff 	mov    rbx,0xffffffffffffffea
  fd:	65 48 8b 04 25 28 00 	mov    rax,QWORD PTR gs:0x28
 104:	00 00 
 106:	48 3b 44 24 08       	cmp    rax,QWORD PTR [rsp+0x8]
 10b:	75 12                	jne    11f <nloops_store+0xaf>
 10d:	48 89 d8             	mov    rax,rbx
 110:	48 83 c4 10          	add    rsp,0x10
 114:	5b                   	pop    rbx
 115:	41 5e                	pop    r14
 117:	41 5f                	pop    r15
 119:	2e e9 00 00 00 00    	cs jmp 11f <nloops_store+0xaf>
 11f:	e8 00 00 00 00       	call   124 <nloops_store+0xb4>
 124:	66 66 66 2e 0f 1f 84 	data16 data16 cs nop WORD PTR [rax+rax*1+0x0]
 12b:	00 00 00 00 00 

0000000000000130 <__pfx_idx_show>:
 130:	90                   	nop
 131:	90                   	nop
 132:	90                   	nop
 133:	90                   	nop
 134:	90                   	nop
 135:	90                   	nop
 136:	90                   	nop
 137:	90                   	nop
 138:	90                   	nop
 139:	90                   	nop
 13a:	90                   	nop
 13b:	90                   	nop
 13c:	90                   	nop
 13d:	90                   	nop
 13e:	90                   	nop
 13f:	90                   	nop

0000000000000140 <idx_show>:
 140:	f3 0f 1e fa          	endbr64 
 144:	53                   	push   rbx
 145:	48 89 d3             	mov    rbx,rdx
 148:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
 14f:	e8 00 00 00 00       	call   154 <idx_show+0x14>
 154:	8b 0d 00 00 00 00    	mov    ecx,DWORD PTR [rip+0x0]        # 15a <idx_show+0x1a>
 15a:	be 00 10 00 00       	mov    esi,0x1000
 15f:	48 89 df             	mov    rdi,rbx
 162:	48 c7 c2 00 00 00 00 	mov    rdx,0x0
 169:	e8 00 00 00 00       	call   16e <idx_show+0x2e>
 16e:	48 63 d8             	movsxd rbx,eax
 171:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
 178:	e8 00 00 00 00       	call   17d <idx_show+0x3d>
 17d:	48 89 d8             	mov    rax,rbx
 180:	5b                   	pop    rbx
 181:	2e e9 00 00 00 00    	cs jmp 187 <idx_show+0x47>
 187:	66 0f 1f 84 00 00 00 	nop    WORD PTR [rax+rax*1+0x0]
 18e:	00 00 

0000000000000190 <__pfx_idx_store>:
 190:	90                   	nop
 191:	90                   	nop
 192:	90                   	nop
 193:	90                   	nop
 194:	90                   	nop
 195:	90                   	nop
 196:	90                   	nop
 197:	90                   	nop
 198:	90                   	nop
 199:	90                   	nop
 19a:	90                   	nop
 19b:	90                   	nop
 19c:	90                   	nop
 19d:	90                   	nop
 19e:	90                   	nop
 19f:	90                   	nop

00000000000001a0 <idx_store>:
 1a0:	f3 0f 1e fa          	endbr64 
 1a4:	41 57                	push   r15
 1a6:	41 56                	push   r14
 1a8:	53                   	push   rbx
 1a9:	48 83 ec 10          	sub    rsp,0x10
 1ad:	48 89 cb             	mov    rbx,rcx
 1b0:	49 89 d6             	mov    r14,rdx
 1b3:	65 48 8b 04 25 28 00 	mov    rax,QWORD PTR gs:0x28
 1ba:	00 00 
 1bc:	48 89 44 24 08       	mov    QWORD PTR [rsp+0x8],rax
 1c1:	4c 8d 7c 24 04       	lea    r15,[rsp+0x4]
 1c6:	4c 89 ff             	mov    rdi,r15
 1c9:	e8 00 00 00 00       	call   1ce <idx_store+0x2e>
 1ce:	c7 44 24 04 00 00 00 	mov    DWORD PTR [rsp+0x4],0x0
 1d5:	00 
 1d6:	4c 89 f7             	mov    rdi,r14
 1d9:	31 f6                	xor    esi,esi
 1db:	4c 89 fa             	mov    rdx,r15
 1de:	e8 00 00 00 00       	call   1e3 <idx_store+0x43>
 1e3:	85 c0                	test   eax,eax
 1e5:	78 3f                	js     226 <idx_store+0x86>
 1e7:	48 8d 7c 24 04       	lea    rdi,[rsp+0x4]
 1ec:	e8 00 00 00 00       	call   1f1 <idx_store+0x51>
 1f1:	83 7c 24 04 00       	cmp    DWORD PTR [rsp+0x4],0x0
 1f6:	74 33                	je     22b <idx_store+0x8b>
 1f8:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
 1ff:	e8 00 00 00 00       	call   204 <idx_store+0x64>
 204:	48 8d 7c 24 04       	lea    rdi,[rsp+0x4]
 209:	e8 00 00 00 00       	call   20e <idx_store+0x6e>
 20e:	8b 44 24 04          	mov    eax,DWORD PTR [rsp+0x4]
 212:	89 05 00 00 00 00    	mov    DWORD PTR [rip+0x0],eax        # 218 <idx_store+0x78>
 218:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
 21f:	e8 00 00 00 00       	call   224 <idx_store+0x84>
 224:	eb 0c                	jmp    232 <idx_store+0x92>
 226:	48 63 d8             	movsxd rbx,eax
 229:	eb 07                	jmp    232 <idx_store+0x92>
 22b:	48 c7 c3 ea ff ff ff 	mov    rbx,0xffffffffffffffea
 232:	65 48 8b 04 25 28 00 	mov    rax,QWORD PTR gs:0x28
 239:	00 00 
 23b:	48 3b 44 24 08       	cmp    rax,QWORD PTR [rsp+0x8]
 240:	75 12                	jne    254 <idx_store+0xb4>
 242:	48 89 d8             	mov    rax,rbx
 245:	48 83 c4 10          	add    rsp,0x10
 249:	5b                   	pop    rbx
 24a:	41 5e                	pop    r14
 24c:	41 5f                	pop    r15
 24e:	2e e9 00 00 00 00    	cs jmp 254 <idx_store+0xb4>
 254:	e8 00 00 00 00       	call   259 <idx_store+0xb9>
 259:	0f 1f 80 00 00 00 00 	nop    DWORD PTR [rax+0x0]

0000000000000260 <__pfx_run_show>:
 260:	90                   	nop
 261:	90                   	nop
 262:	90                   	nop
 263:	90                   	nop
 264:	90                   	nop
 265:	90                   	nop
 266:	90                   	nop
 267:	90                   	nop
 268:	90                   	nop
 269:	90                   	nop
 26a:	90                   	nop
 26b:	90                   	nop
 26c:	90                   	nop
 26d:	90                   	nop
 26e:	90                   	nop
 26f:	90                   	nop

0000000000000270 <run_show>:
 270:	f3 0f 1e fa          	endbr64 
 274:	41 56                	push   r14
 276:	53                   	push   rbx
 277:	48 89 d3             	mov    rbx,rdx
 27a:	e8 51 00 00 00       	call   2d0 <proxy>
 27f:	49 89 c6             	mov    r14,rax
 282:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
 289:	e8 00 00 00 00       	call   28e <run_show+0x1e>
 28e:	be 00 10 00 00       	mov    esi,0x1000
 293:	48 89 df             	mov    rdi,rbx
 296:	48 c7 c2 00 00 00 00 	mov    rdx,0x0
 29d:	4c 89 f1             	mov    rcx,r14
 2a0:	e8 00 00 00 00       	call   2a5 <run_show+0x35>
 2a5:	48 63 d8             	movsxd rbx,eax
 2a8:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
 2af:	e8 00 00 00 00       	call   2b4 <run_show+0x44>
 2b4:	48 89 d8             	mov    rax,rbx
 2b7:	5b                   	pop    rbx
 2b8:	41 5e                	pop    r14
 2ba:	2e e9 00 00 00 00    	cs jmp 2c0 <__pfx_proxy>

00000000000002c0 <__pfx_proxy>:
 2c0:	90                   	nop
 2c1:	90                   	nop
 2c2:	90                   	nop
 2c3:	90                   	nop
 2c4:	90                   	nop
 2c5:	90                   	nop
 2c6:	90                   	nop
 2c7:	90                   	nop
 2c8:	90                   	nop
 2c9:	90                   	nop
 2ca:	90                   	nop
 2cb:	90                   	nop
 2cc:	90                   	nop
 2cd:	90                   	nop
 2ce:	90                   	nop
 2cf:	90                   	nop

00000000000002d0 <proxy>:
 2d0:	41 56                	push   r14
 2d2:	53                   	push   rbx
 2d3:	e8 58 00 00 00       	call   330 <ktime_get_real_ns>
 2d8:	48 89 c3             	mov    rbx,rax
 2db:	48 83 3d 00 00 00 00 	cmp    QWORD PTR [rip+0x0],0x0        # 2e3 <proxy+0x13>
 2e2:	00 
 2e3:	74 29                	je     30e <proxy+0x3e>
 2e5:	45 31 f6             	xor    r14d,r14d
 2e8:	8b 05 00 00 00 00    	mov    eax,DWORD PTR [rip+0x0]        # 2ee <proxy+0x1e>
 2ee:	4c 8b 1c c5 00 00 00 	mov    r11,QWORD PTR [rax*8+0x0]
 2f5:	00 
 2f6:	8b 3d 00 00 00 00    	mov    edi,DWORD PTR [rip+0x0]        # 2fc <proxy+0x2c>
 2fc:	2e e8 00 00 00 00    	cs call 302 <proxy+0x32>
 302:	49 ff c6             	inc    r14
 305:	4c 3b 35 00 00 00 00 	cmp    r14,QWORD PTR [rip+0x0]        # 30c <proxy+0x3c>
 30c:	72 da                	jb     2e8 <proxy+0x18>
 30e:	e8 1d 00 00 00       	call   330 <ktime_get_real_ns>
 313:	48 29 d8             	sub    rax,rbx
 316:	5b                   	pop    rbx
 317:	41 5e                	pop    r14
 319:	2e e9 00 00 00 00    	cs jmp 31f <proxy+0x4f>
 31f:	90                   	nop

0000000000000320 <__pfx_ktime_get_real_ns>:
 320:	90                   	nop
 321:	90                   	nop
 322:	90                   	nop
 323:	90                   	nop
 324:	90                   	nop
 325:	90                   	nop
 326:	90                   	nop
 327:	90                   	nop
 328:	90                   	nop
 329:	90                   	nop
 32a:	90                   	nop
 32b:	90                   	nop
 32c:	90                   	nop
 32d:	90                   	nop
 32e:	90                   	nop
 32f:	90                   	nop

0000000000000330 <ktime_get_real_ns>:
 330:	31 ff                	xor    edi,edi
 332:	e9 00 00 00 00       	jmp    337 <ktime_get_real_ns+0x7>
 337:	66 0f 1f 84 00 00 00 	nop    WORD PTR [rax+rax*1+0x0]
 33e:	00 00 

0000000000000340 <__pfx_int_arg>:
 340:	90                   	nop
 341:	90                   	nop
 342:	90                   	nop
 343:	90                   	nop
 344:	90                   	nop
 345:	90                   	nop
 346:	90                   	nop
 347:	90                   	nop
 348:	90                   	nop
 349:	90                   	nop
 34a:	90                   	nop
 34b:	90                   	nop
 34c:	90                   	nop
 34d:	90                   	nop
 34e:	90                   	nop
 34f:	90                   	nop

0000000000000350 <int_arg>:
 350:	f3 0f 1e fa          	endbr64 
 354:	31 c0                	xor    eax,eax
 356:	2e e9 00 00 00 00    	cs jmp 35c <int_arg+0xc>
 35c:	0f 1f 40 00          	nop    DWORD PTR [rax+0x0]

0000000000000360 <__pfx_float_arg>:
 360:	90                   	nop
 361:	90                   	nop
 362:	90                   	nop
 363:	90                   	nop
 364:	90                   	nop
 365:	90                   	nop
 366:	90                   	nop
 367:	90                   	nop
 368:	90                   	nop
 369:	90                   	nop
 36a:	90                   	nop
 36b:	90                   	nop
 36c:	90                   	nop
 36d:	90                   	nop
 36e:	90                   	nop
 36f:	90                   	nop

0000000000000370 <float_arg>:
 370:	f3 0f 1e fa          	endbr64 
 374:	31 c0                	xor    eax,eax
 376:	2e e9 00 00 00 00    	cs jmp 37c <float_arg+0xc>

Disassembly of section .init.text:

0000000000000000 <__pfx_init_module>:
   0:	90                   	nop
   1:	90                   	nop
   2:	90                   	nop
   3:	90                   	nop
   4:	90                   	nop
   5:	90                   	nop
   6:	90                   	nop
   7:	90                   	nop
   8:	90                   	nop
   9:	90                   	nop
   a:	90                   	nop
   b:	90                   	nop
   c:	90                   	nop
   d:	90                   	nop
   e:	90                   	nop
   f:	90                   	nop

0000000000000010 <init_module>:
  10:	f3 0f 1e fa          	endbr64 
  14:	53                   	push   rbx
  15:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
  1c:	e8 00 00 00 00       	call   21 <init_module+0x11>
  21:	48 8b 35 00 00 00 00 	mov    rsi,QWORD PTR [rip+0x0]        # 28 <init_module+0x18>
  28:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
  2f:	e8 00 00 00 00       	call   34 <init_module+0x24>
  34:	48 89 05 00 00 00 00 	mov    QWORD PTR [rip+0x0],rax        # 3b <init_module+0x2b>
  3b:	48 85 c0             	test   rax,rax
  3e:	74 23                	je     63 <init_module+0x53>
  40:	48 89 c7             	mov    rdi,rax
  43:	48 c7 c6 00 00 00 00 	mov    rsi,0x0
  4a:	e8 00 00 00 00       	call   4f <init_module+0x3f>
  4f:	85 c0                	test   eax,eax
  51:	74 1e                	je     71 <init_module+0x61>
  53:	89 c3                	mov    ebx,eax
  55:	48 8b 3d 00 00 00 00 	mov    rdi,QWORD PTR [rip+0x0]        # 5c <init_module+0x4c>
  5c:	e8 00 00 00 00       	call   61 <init_module+0x51>
  61:	eb 05                	jmp    68 <init_module+0x58>
  63:	bb f4 ff ff ff       	mov    ebx,0xfffffff4
  68:	89 d8                	mov    eax,ebx
  6a:	5b                   	pop    rbx
  6b:	2e e9 00 00 00 00    	cs jmp 71 <init_module+0x61>
  71:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
  78:	e8 00 00 00 00       	call   7d <init_module+0x6d>
  7d:	31 db                	xor    ebx,ebx
  7f:	eb e7                	jmp    68 <init_module+0x58>

Disassembly of section .exit.text:

0000000000000000 <__pfx_cleanup_module>:
   0:	90                   	nop
   1:	90                   	nop
   2:	90                   	nop
   3:	90                   	nop
   4:	90                   	nop
   5:	90                   	nop
   6:	90                   	nop
   7:	90                   	nop
   8:	90                   	nop
   9:	90                   	nop
   a:	90                   	nop
   b:	90                   	nop
   c:	90                   	nop
   d:	90                   	nop
   e:	90                   	nop
   f:	90                   	nop

0000000000000010 <cleanup_module>:
  10:	f3 0f 1e fa          	endbr64 
  14:	48 8b 3d 00 00 00 00 	mov    rdi,QWORD PTR [rip+0x0]        # 1b <cleanup_module+0xb>
  1b:	e8 00 00 00 00       	call   20 <cleanup_module+0x10>
  20:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
  27:	e9 00 00 00 00       	jmp    2c <__UNIQUE_ID_description167+0x8>

Disassembly of section .text.asan.module_ctor:

0000000000000000 <asan.module_ctor>:
   0:	f3 0f 1e fa          	endbr64 
   4:	be 12 00 00 00       	mov    esi,0x12
   9:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
  10:	e8 00 00 00 00       	call   15 <asan.module_ctor+0x15>
  15:	2e e9 00 00 00 00    	cs jmp 1b <asan.module_ctor+0x1b>
  1b:	cc                   	int3   
  1c:	cc                   	int3   
  1d:	cc                   	int3   
  1e:	cc                   	int3   
  1f:	cc                   	int3   

0000000000000020 <asan.module_ctor>:
  20:	f3 0f 1e fa          	endbr64 
  24:	2e e9 00 00 00 00    	cs jmp 2a <__UNIQUE_ID_description167+0x6>

Disassembly of section .text.asan.module_dtor:

0000000000000000 <asan.module_dtor>:
   0:	f3 0f 1e fa          	endbr64 
   4:	be 12 00 00 00       	mov    esi,0x12
   9:	48 c7 c7 00 00 00 00 	mov    rdi,0x0
  10:	e8 00 00 00 00       	call   15 <asan.module_dtor+0x15>
  15:	2e e9 00 00 00 00    	cs jmp 1b <_note_10+0x3>
