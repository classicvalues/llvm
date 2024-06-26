// RUN: not llvm-mc -triple x86_64-unknown-unknown --show-encoding %s 2> %t.err | FileCheck --check-prefix=X86-64 %s
// RUN: FileCheck --check-prefix=ERR64 < %t.err %s
// RUN: not llvm-mc -triple i386-unknown-unknown --show-encoding %s 2> %t.err | FileCheck --check-prefix=X86-32 %s
// RUN: FileCheck --check-prefix=ERR32 < %t.err %s
// RUN: not llvm-mc -triple i386-unknown-unknown-code16 --show-encoding %s 2> %t.err | FileCheck --check-prefix=X86-16 %s
// RUN: FileCheck --check-prefix=ERR16 < %t.err %s

// ERR64: error: 'data32' is not supported in 64-bit mode
// ERR32: error: redundant data32 prefix
// X86-16: lgdtl 0
// X86-16-SAME: encoding: [0x66,0x0f,0x01,0x16,0x00,0x00]
data32 lgdt 0

// X86-64: data16
// X86-64: encoding: [0x66]
// X86-64: lgdtq 0
// X86-64: encoding: [0x0f,0x01,0x14,0x25,0x00,0x00,0x00,0x00]
// X86-32: data16
// X86-32: encoding: [0x66]
// X86-32: lgdtl 0
// X86-32: encoding: [0x0f,0x01,0x15,0x00,0x00,0x00,0x00]
// ERR16: error: redundant data16 prefix
data16 lgdt 0

// X86-64:      data16    # encoding: [0x66]
// X86-64-NEXT: callq  0  # encoding: [0xe8,A,A,A,A]
// X86-32:      data16    # encoding: [0x66]
// X86-32-NEXT: calll  0  # encoding: [0xe8,A,A,A,A]
// ERR16: {{.*}}.s:[[#@LINE+1]]:1: error: redundant data16 prefix
data16 call 0
