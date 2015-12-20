
obj/mpos-kern:     file format elf32-i386


Disassembly of section .text:

00100000 <multiboot>:
  100000:	02 b0 ad 1b 00 00    	add    0x1bad(%eax),%dh
  100006:	00 00                	add    %al,(%eax)
  100008:	fe 4f 52             	decb   0x52(%edi)
  10000b:	e4 bc                	in     $0xbc,%al

0010000c <multiboot_start>:
# The multiboot_start routine sets the stack pointer to the top of the
# MiniprocOS's kernel stack, then jumps to the 'start' routine in mpos-kern.c.

.globl multiboot_start
multiboot_start:
	movl $0x200000, %esp
  10000c:	bc 00 00 20 00       	mov    $0x200000,%esp
	pushl $0
  100011:	6a 00                	push   $0x0
	popfl
  100013:	9d                   	popf   
	call start
  100014:	e8 49 02 00 00       	call   100262 <start>
  100019:	90                   	nop

0010001a <sys_int48_handler>:

# Interrupt handlers
.align 2

sys_int48_handler:
	pushl $0
  10001a:	6a 00                	push   $0x0
	pushl $48
  10001c:	6a 30                	push   $0x30
	jmp _generic_int_handler
  10001e:	eb 3a                	jmp    10005a <_generic_int_handler>

00100020 <sys_int49_handler>:

sys_int49_handler:
	pushl $0
  100020:	6a 00                	push   $0x0
	pushl $49
  100022:	6a 31                	push   $0x31
	jmp _generic_int_handler
  100024:	eb 34                	jmp    10005a <_generic_int_handler>

00100026 <sys_int50_handler>:

sys_int50_handler:
	pushl $0
  100026:	6a 00                	push   $0x0
	pushl $50
  100028:	6a 32                	push   $0x32
	jmp _generic_int_handler
  10002a:	eb 2e                	jmp    10005a <_generic_int_handler>

0010002c <sys_int51_handler>:

sys_int51_handler:
	pushl $0
  10002c:	6a 00                	push   $0x0
	pushl $51
  10002e:	6a 33                	push   $0x33
	jmp _generic_int_handler
  100030:	eb 28                	jmp    10005a <_generic_int_handler>

00100032 <sys_int52_handler>:

sys_int52_handler:
	pushl $0
  100032:	6a 00                	push   $0x0
	pushl $52
  100034:	6a 34                	push   $0x34
	jmp _generic_int_handler
  100036:	eb 22                	jmp    10005a <_generic_int_handler>

00100038 <sys_int53_handler>:

sys_int53_handler:
	pushl $0
  100038:	6a 00                	push   $0x0
	pushl $53
  10003a:	6a 35                	push   $0x35
	jmp _generic_int_handler
  10003c:	eb 1c                	jmp    10005a <_generic_int_handler>

0010003e <sys_int54_handler>:

sys_int54_handler:
	pushl $0
  10003e:	6a 00                	push   $0x0
	pushl $54
  100040:	6a 36                	push   $0x36
	jmp _generic_int_handler
  100042:	eb 16                	jmp    10005a <_generic_int_handler>

00100044 <sys_int55_handler>:

sys_int55_handler:
	pushl $0
  100044:	6a 00                	push   $0x0
	pushl $55
  100046:	6a 37                	push   $0x37
	jmp _generic_int_handler
  100048:	eb 10                	jmp    10005a <_generic_int_handler>

0010004a <sys_int56_handler>:

sys_int56_handler:
	pushl $0
  10004a:	6a 00                	push   $0x0
	pushl $56
  10004c:	6a 38                	push   $0x38
	jmp _generic_int_handler
  10004e:	eb 0a                	jmp    10005a <_generic_int_handler>

00100050 <sys_int57_handler>:

sys_int57_handler:
	pushl $0
  100050:	6a 00                	push   $0x0
	pushl $57
  100052:	6a 39                	push   $0x39
	jmp _generic_int_handler
  100054:	eb 04                	jmp    10005a <_generic_int_handler>

00100056 <default_int_handler>:

	.globl default_int_handler
default_int_handler:
	pushl $0
  100056:	6a 00                	push   $0x0
	jmp _generic_int_handler
  100058:	eb 00                	jmp    10005a <_generic_int_handler>

0010005a <_generic_int_handler>:
	# When we get here, the processor's interrupt mechanism has
	# pushed the old task status and stack registers onto the kernel stack.
	# Then one of the specific handlers pushed the interrupt number.
	# Now, we complete the 'registers_t' structure by pushing the extra
	# segment definitions and the general CPU registers.
	pushl %ds
  10005a:	1e                   	push   %ds
	pushl %es
  10005b:	06                   	push   %es
	pushal
  10005c:	60                   	pusha  

	# Call the kernel's 'interrupt' function.
	pushl %esp
  10005d:	54                   	push   %esp
	call interrupt
  10005e:	e8 58 00 00 00       	call   1000bb <interrupt>

00100063 <sys_int_handlers>:
  100063:	1a 00                	sbb    (%eax),%al
  100065:	10 00                	adc    %al,(%eax)
  100067:	20 00                	and    %al,(%eax)
  100069:	10 00                	adc    %al,(%eax)
  10006b:	26 00 10             	add    %dl,%es:(%eax)
  10006e:	00 2c 00             	add    %ch,(%eax,%eax,1)
  100071:	10 00                	adc    %al,(%eax)
  100073:	32 00                	xor    (%eax),%al
  100075:	10 00                	adc    %al,(%eax)
  100077:	38 00                	cmp    %al,(%eax)
  100079:	10 00                	adc    %al,(%eax)
  10007b:	3e 00 10             	add    %dl,%ds:(%eax)
  10007e:	00 44 00 10          	add    %al,0x10(%eax,%eax,1)
  100082:	00 4a 00             	add    %cl,0x0(%edx)
  100085:	10 00                	adc    %al,(%eax)
  100087:	50                   	push   %eax
  100088:	00 10                	add    %dl,(%eax)
  10008a:	00 90 83 ec 0c a1    	add    %dl,-0x5ef3137d(%eax)

0010008c <schedule>:
 *
 *****************************************************************************/

void
schedule(void)
{
  10008c:	83 ec 0c             	sub    $0xc,%esp
	pid_t pid = current->p_pid;
  10008f:	a1 b8 9f 10 00       	mov    0x109fb8,%eax
	while (1) {
		pid = (pid + 1) % NPROCS;
  100094:	b9 10 00 00 00       	mov    $0x10,%ecx
 *****************************************************************************/

void
schedule(void)
{
	pid_t pid = current->p_pid;
  100099:	8b 10                	mov    (%eax),%edx
	while (1) {
		pid = (pid + 1) % NPROCS;
  10009b:	8d 42 01             	lea    0x1(%edx),%eax
  10009e:	99                   	cltd   
  10009f:	f7 f9                	idiv   %ecx
		if (proc_array[pid].p_state == P_RUNNABLE)
  1000a1:	6b c2 54             	imul   $0x54,%edx,%eax
  1000a4:	83 b8 58 92 10 00 01 	cmpl   $0x1,0x109258(%eax)
  1000ab:	75 ee                	jne    10009b <schedule+0xf>
			run(&proc_array[pid]);
  1000ad:	83 ec 0c             	sub    $0xc,%esp
  1000b0:	05 10 92 10 00       	add    $0x109210,%eax
  1000b5:	50                   	push   %eax
  1000b6:	e8 c9 03 00 00       	call   100484 <run>

001000bb <interrupt>:

static pid_t do_fork(process_t *parent);

void
interrupt(registers_t *reg)
{
  1000bb:	55                   	push   %ebp
	// the application's state on the kernel's stack, then jumping to
	// kernel assembly code (in mpos-int.S, for your information).
	// That code saves more registers on the kernel's stack, then calls
	// interrupt().  The first thing we must do, then, is copy the saved
	// registers into the 'current' process descriptor.
	current->p_registers = *reg;
  1000bc:	b9 11 00 00 00       	mov    $0x11,%ecx

static pid_t do_fork(process_t *parent);

void
interrupt(registers_t *reg)
{
  1000c1:	89 e5                	mov    %esp,%ebp
  1000c3:	57                   	push   %edi
  1000c4:	56                   	push   %esi
  1000c5:	53                   	push   %ebx
  1000c6:	83 ec 2c             	sub    $0x2c,%esp
  1000c9:	8b 45 08             	mov    0x8(%ebp),%eax
	// the application's state on the kernel's stack, then jumping to
	// kernel assembly code (in mpos-int.S, for your information).
	// That code saves more registers on the kernel's stack, then calls
	// interrupt().  The first thing we must do, then, is copy the saved
	// registers into the 'current' process descriptor.
	current->p_registers = *reg;
  1000cc:	8b 1d b8 9f 10 00    	mov    0x109fb8,%ebx
  1000d2:	89 c6                	mov    %eax,%esi
  1000d4:	8d 7b 04             	lea    0x4(%ebx),%edi
  1000d7:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)

	switch (reg->reg_intno) {
  1000d9:	8b 40 28             	mov    0x28(%eax),%eax
  1000dc:	83 e8 30             	sub    $0x30,%eax
  1000df:	83 f8 04             	cmp    $0x4,%eax
  1000e2:	0f 87 f5 00 00 00    	ja     1001dd <interrupt+0x122>
  1000e8:	ff 24 85 3c 0a 10 00 	jmp    *0x100a3c(,%eax,4)
  1000ef:	b8 ac 92 10 00       	mov    $0x1092ac,%eax
  1000f4:	ba 01 00 00 00       	mov    $0x1,%edx
  1000f9:	eb 14                	jmp    10010f <interrupt+0x54>
		// The 'sys_getpid' system call returns the current
		// process's process ID.  System calls return results to user
		// code by putting those results in a register.  Like Linux,
		// we use %eax for system call return values.  The code is
		// surprisingly simple:
		current->p_registers.reg_eax = current->p_pid;
  1000fb:	8b 03                	mov    (%ebx),%eax
		run(current);
  1000fd:	83 ec 0c             	sub    $0xc,%esp
		// The 'sys_getpid' system call returns the current
		// process's process ID.  System calls return results to user
		// code by putting those results in a register.  Like Linux,
		// we use %eax for system call return values.  The code is
		// surprisingly simple:
		current->p_registers.reg_eax = current->p_pid;
  100100:	89 43 20             	mov    %eax,0x20(%ebx)
		run(current);
  100103:	53                   	push   %ebx
  100104:	eb 22                	jmp    100128 <interrupt+0x6d>
	// YOUR CODE HERE!
	// First, find an empty process descriptor.  If there is no empty
	//   process descriptor, return -1.  Remember not to use proc_array[0].
	int emptyProc = 1;
	while (emptyProc <= 15 && proc_array[emptyProc].p_state != P_EMPTY)
		emptyProc++;
  100106:	42                   	inc    %edx
  100107:	83 c0 54             	add    $0x54,%eax
{
	// YOUR CODE HERE!
	// First, find an empty process descriptor.  If there is no empty
	//   process descriptor, return -1.  Remember not to use proc_array[0].
	int emptyProc = 1;
	while (emptyProc <= 15 && proc_array[emptyProc].p_state != P_EMPTY)
  10010a:	83 fa 10             	cmp    $0x10,%edx
  10010d:	74 0a                	je     100119 <interrupt+0x5e>
  10010f:	83 38 00             	cmpl   $0x0,(%eax)
  100112:	75 f2                	jne    100106 <interrupt+0x4b>
  100114:	e9 c6 00 00 00       	jmp    1001df <interrupt+0x124>
  100119:	83 ca ff             	or     $0xffffffff,%edx
		run(current);

	case INT_SYS_FORK:
		// The 'sys_fork' system call should create a new process.
		// You will have to complete the do_fork() function!
		current->p_registers.reg_eax = do_fork(current);
  10011c:	89 53 20             	mov    %edx,0x20(%ebx)
		run(current);
  10011f:	83 ec 0c             	sub    $0xc,%esp
  100122:	ff 35 b8 9f 10 00    	pushl  0x109fb8
  100128:	e8 57 03 00 00       	call   100484 <run>
	case INT_SYS_YIELD:
		// The 'sys_yield' system call asks the kernel to schedule a
		// different process.  (MiniprocOS is cooperatively
		// scheduled, so we need a special system call to do this.)
		// The schedule() function picks another process and runs it.
		schedule();
  10012d:	e8 5a ff ff ff       	call   10008c <schedule>
		// non-runnable.
		// The process stored its exit status in the %eax register
		// before calling the system call.  The %eax REGISTER has
		// changed by now, but we can read the APPLICATION's setting
		// for this register out of 'current->p_registers'.
		current->p_state = P_ZOMBIE;
  100132:	a1 b8 9f 10 00       	mov    0x109fb8,%eax
		current->p_exit_status = current->p_registers.reg_eax;
  100137:	b9 ac 92 10 00       	mov    $0x1092ac,%ecx
  10013c:	8b 50 20             	mov    0x20(%eax),%edx
		// non-runnable.
		// The process stored its exit status in the %eax register
		// before calling the system call.  The %eax REGISTER has
		// changed by now, but we can read the APPLICATION's setting
		// for this register out of 'current->p_registers'.
		current->p_state = P_ZOMBIE;
  10013f:	c7 40 48 03 00 00 00 	movl   $0x3,0x48(%eax)
		current->p_exit_status = current->p_registers.reg_eax;
  100146:	89 50 4c             	mov    %edx,0x4c(%eax)
  100149:	ba 01 00 00 00       	mov    $0x1,%edx
		{
			int i;
			for (i = 1; i < NPROCS; i++)
			{
				if (proc_array[i].p_state == P_BLOCKED && proc_array[i].p_wait_for_pid == current->p_pid)
  10014e:	83 39 02             	cmpl   $0x2,(%ecx)
  100151:	75 29                	jne    10017c <interrupt+0xc1>
  100153:	8b 59 08             	mov    0x8(%ecx),%ebx
  100156:	3b 18                	cmp    (%eax),%ebx
  100158:	75 22                	jne    10017c <interrupt+0xc1>
				{
					proc_array[i].p_wait_for_pid = -1;
  10015a:	6b d2 54             	imul   $0x54,%edx,%edx
					proc_array[i].p_registers.reg_eax = current->p_exit_status;
  10015d:	8b 40 4c             	mov    0x4c(%eax),%eax
			int i;
			for (i = 1; i < NPROCS; i++)
			{
				if (proc_array[i].p_state == P_BLOCKED && proc_array[i].p_wait_for_pid == current->p_pid)
				{
					proc_array[i].p_wait_for_pid = -1;
  100160:	c7 82 60 92 10 00 ff 	movl   $0xffffffff,0x109260(%edx)
  100167:	ff ff ff 
					proc_array[i].p_registers.reg_eax = current->p_exit_status;
  10016a:	89 82 30 92 10 00    	mov    %eax,0x109230(%edx)
					proc_array[i].p_state = P_RUNNABLE;
  100170:	c7 82 58 92 10 00 01 	movl   $0x1,0x109258(%edx)
  100177:	00 00 00 
					break;
  10017a:	eb 09                	jmp    100185 <interrupt+0xca>
		// for this register out of 'current->p_registers'.
		current->p_state = P_ZOMBIE;
		current->p_exit_status = current->p_registers.reg_eax;
		{
			int i;
			for (i = 1; i < NPROCS; i++)
  10017c:	42                   	inc    %edx
  10017d:	83 c1 54             	add    $0x54,%ecx
  100180:	83 fa 10             	cmp    $0x10,%edx
  100183:	75 c9                	jne    10014e <interrupt+0x93>
					proc_array[i].p_state = P_RUNNABLE;
					break;
				}
			}
		}
		schedule();
  100185:	e8 02 ff ff ff       	call   10008c <schedule>
		// * A process that doesn't exist (p_state == P_EMPTY).
		// (In the Unix operating system, only process P's parent
		// can call sys_wait(P).  In MiniprocOS, we allow ANY
		// process to call sys_wait(P).)

		pid_t p = current->p_registers.reg_eax;
  10018a:	a1 b8 9f 10 00       	mov    0x109fb8,%eax
  10018f:	8b 50 20             	mov    0x20(%eax),%edx

		if (p <= 0 || p >= NPROCS || p == current->p_pid
  100192:	8d 4a ff             	lea    -0x1(%edx),%ecx
  100195:	83 f9 0e             	cmp    $0xe,%ecx
  100198:	77 14                	ja     1001ae <interrupt+0xf3>
  10019a:	3b 10                	cmp    (%eax),%edx
  10019c:	74 10                	je     1001ae <interrupt+0xf3>
		    || proc_array[p].p_state == P_EMPTY)
  10019e:	6b da 54             	imul   $0x54,%edx,%ebx
  1001a1:	8d 8b 18 92 10 00    	lea    0x109218(%ebx),%ecx
  1001a7:	8b 71 40             	mov    0x40(%ecx),%esi
		// can call sys_wait(P).  In MiniprocOS, we allow ANY
		// process to call sys_wait(P).)

		pid_t p = current->p_registers.reg_eax;

		if (p <= 0 || p >= NPROCS || p == current->p_pid
  1001aa:	85 f6                	test   %esi,%esi
  1001ac:	75 09                	jne    1001b7 <interrupt+0xfc>
		    || proc_array[p].p_state == P_EMPTY)
			current->p_registers.reg_eax = -1;
  1001ae:	c7 40 20 ff ff ff ff 	movl   $0xffffffff,0x20(%eax)
		// can call sys_wait(P).  In MiniprocOS, we allow ANY
		// process to call sys_wait(P).)

		pid_t p = current->p_registers.reg_eax;

		if (p <= 0 || p >= NPROCS || p == current->p_pid
  1001b5:	eb 21                	jmp    1001d8 <interrupt+0x11d>
		    || proc_array[p].p_state == P_EMPTY)
			current->p_registers.reg_eax = -1;
		else if (proc_array[p].p_state == P_ZOMBIE)
  1001b7:	83 fe 03             	cmp    $0x3,%esi
  1001ba:	75 12                	jne    1001ce <interrupt+0x113>
		{
			current->p_registers.reg_eax = proc_array[p].p_exit_status;
  1001bc:	8b 93 5c 92 10 00    	mov    0x10925c(%ebx),%edx
			proc_array[p].p_state = P_EMPTY; // this was added for exercise 4
  1001c2:	c7 41 40 00 00 00 00 	movl   $0x0,0x40(%ecx)
		if (p <= 0 || p >= NPROCS || p == current->p_pid
		    || proc_array[p].p_state == P_EMPTY)
			current->p_registers.reg_eax = -1;
		else if (proc_array[p].p_state == P_ZOMBIE)
		{
			current->p_registers.reg_eax = proc_array[p].p_exit_status;
  1001c9:	89 50 20             	mov    %edx,0x20(%eax)
  1001cc:	eb 0a                	jmp    1001d8 <interrupt+0x11d>
			proc_array[p].p_state = P_EMPTY; // this was added for exercise 4
		}
		else
		{
			current->p_wait_for_pid = p;
  1001ce:	89 50 50             	mov    %edx,0x50(%eax)
			current->p_state = P_BLOCKED;
  1001d1:	c7 40 48 02 00 00 00 	movl   $0x2,0x48(%eax)
		}
		schedule();
  1001d8:	e8 af fe ff ff       	call   10008c <schedule>
  1001dd:	eb fe                	jmp    1001dd <interrupt+0x122>
	//                What should sys_fork() return to the child process?)
	// You need to set one other process descriptor field as well.
	// Finally, return the child's process ID to the parent.

	pid_t child = emptyProc;
	proc_array[child].p_registers = parent->p_registers;
  1001df:	6b c2 54             	imul   $0x54,%edx,%eax
  1001e2:	b9 11 00 00 00       	mov    $0x11,%ecx
  1001e7:	8d 73 04             	lea    0x4(%ebx),%esi
	dest_stack_top = PROC1_STACK_ADDR + (dest->p_pid * PROC_STACK_SIZE);
	dest_stack_bottom = dest_stack_top - (src_stack_top - src_stack_bottom);

	// YOUR CODE HERE: memcpy the stack and set dest->p_registers.reg_esp

	memcpy((void*)dest_stack_bottom, (void*)src_stack_bottom, src_stack_top - src_stack_bottom);
  1001ea:	83 ec 04             	sub    $0x4,%esp
  1001ed:	89 55 e0             	mov    %edx,-0x20(%ebp)
	//                What should sys_fork() return to the child process?)
	// You need to set one other process descriptor field as well.
	// Finally, return the child's process ID to the parent.

	pid_t child = emptyProc;
	proc_array[child].p_registers = parent->p_registers;
  1001f0:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  1001f3:	05 10 92 10 00       	add    $0x109210,%eax
  1001f8:	89 c7                	mov    %eax,%edi
  1001fa:	83 c7 04             	add    $0x4,%edi
  1001fd:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
	// YOUR CODE HERE!

	src_stack_top = PROC1_STACK_ADDR + (src->p_pid * PROC_STACK_SIZE);
	src_stack_bottom = src->p_registers.reg_esp;
	dest_stack_top = PROC1_STACK_ADDR + (dest->p_pid * PROC_STACK_SIZE);
	dest_stack_bottom = dest_stack_top - (src_stack_top - src_stack_bottom);
  1001ff:	8b 7d d4             	mov    -0x2c(%ebp),%edi
	//                What should sys_fork() return to the child process?)
	// You need to set one other process descriptor field as well.
	// Finally, return the child's process ID to the parent.

	pid_t child = emptyProc;
	proc_array[child].p_registers = parent->p_registers;
  100202:	89 45 e4             	mov    %eax,-0x1c(%ebp)
	// and then how to actually copy the stack.  (Hint: use memcpy.)
	// We have done one for you.

	// YOUR CODE HERE!

	src_stack_top = PROC1_STACK_ADDR + (src->p_pid * PROC_STACK_SIZE);
  100205:	8b 03                	mov    (%ebx),%eax
	src_stack_bottom = src->p_registers.reg_esp;
  100207:	8b 4b 40             	mov    0x40(%ebx),%ecx
	dest_stack_top = PROC1_STACK_ADDR + (dest->p_pid * PROC_STACK_SIZE);
	dest_stack_bottom = dest_stack_top - (src_stack_top - src_stack_bottom);
  10020a:	8b b7 10 92 10 00    	mov    0x109210(%edi),%esi
	// and then how to actually copy the stack.  (Hint: use memcpy.)
	// We have done one for you.

	// YOUR CODE HERE!

	src_stack_top = PROC1_STACK_ADDR + (src->p_pid * PROC_STACK_SIZE);
  100210:	83 c0 0a             	add    $0xa,%eax
  100213:	c1 e0 12             	shl    $0x12,%eax
	src_stack_bottom = src->p_registers.reg_esp;
	dest_stack_top = PROC1_STACK_ADDR + (dest->p_pid * PROC_STACK_SIZE);
	dest_stack_bottom = dest_stack_top - (src_stack_top - src_stack_bottom);
  100216:	c1 e6 12             	shl    $0x12,%esi
  100219:	8d b4 0e 00 00 28 00 	lea    0x280000(%esi,%ecx,1),%esi
  100220:	29 c6                	sub    %eax,%esi

	// YOUR CODE HERE: memcpy the stack and set dest->p_registers.reg_esp

	memcpy((void*)dest_stack_bottom, (void*)src_stack_bottom, src_stack_top - src_stack_bottom);
  100222:	29 c8                	sub    %ecx,%eax
  100224:	50                   	push   %eax
  100225:	51                   	push   %ecx
  100226:	56                   	push   %esi
  100227:	e8 30 03 00 00       	call   10055c <memcpy>
	dest->p_registers.reg_esp = dest_stack_bottom;
  10022c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
	proc_array[child].p_registers = parent->p_registers;
	copy_stack(&proc_array[child], parent);
	proc_array[child].p_registers.reg_eax = 0; // this is the other difference; because we cannot return a value to the child process, we manually set the eax register to 0
	proc_array[child].p_exit_status = 0;
	proc_array[child].p_wait_for_pid = -1; // added after exercise 3
	proc_array[child].p_state = P_RUNNABLE;
  10022f:	83 c4 10             	add    $0x10,%esp
	// Finally, return the child's process ID to the parent.

	pid_t child = emptyProc;
	proc_array[child].p_registers = parent->p_registers;
	copy_stack(&proc_array[child], parent);
	proc_array[child].p_registers.reg_eax = 0; // this is the other difference; because we cannot return a value to the child process, we manually set the eax register to 0
  100232:	c7 87 30 92 10 00 00 	movl   $0x0,0x109230(%edi)
  100239:	00 00 00 
  10023c:	8b 55 e0             	mov    -0x20(%ebp),%edx
	proc_array[child].p_exit_status = 0;
  10023f:	c7 87 5c 92 10 00 00 	movl   $0x0,0x10925c(%edi)
  100246:	00 00 00 
	proc_array[child].p_wait_for_pid = -1; // added after exercise 3
	proc_array[child].p_state = P_RUNNABLE;
  100249:	c7 87 58 92 10 00 01 	movl   $0x1,0x109258(%edi)
  100250:	00 00 00 
	dest_stack_bottom = dest_stack_top - (src_stack_top - src_stack_bottom);

	// YOUR CODE HERE: memcpy the stack and set dest->p_registers.reg_esp

	memcpy((void*)dest_stack_bottom, (void*)src_stack_bottom, src_stack_top - src_stack_bottom);
	dest->p_registers.reg_esp = dest_stack_bottom;
  100253:	89 70 40             	mov    %esi,0x40(%eax)
	pid_t child = emptyProc;
	proc_array[child].p_registers = parent->p_registers;
	copy_stack(&proc_array[child], parent);
	proc_array[child].p_registers.reg_eax = 0; // this is the other difference; because we cannot return a value to the child process, we manually set the eax register to 0
	proc_array[child].p_exit_status = 0;
	proc_array[child].p_wait_for_pid = -1; // added after exercise 3
  100256:	c7 40 50 ff ff ff ff 	movl   $0xffffffff,0x50(%eax)
  10025d:	e9 ba fe ff ff       	jmp    10011c <interrupt+0x61>

00100262 <start>:
 *
 *****************************************************************************/

void
start(void)
{
  100262:	53                   	push   %ebx
  100263:	83 ec 0c             	sub    $0xc,%esp
	const char *s;
	int whichprocess;
	pid_t i;

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
  100266:	68 40 05 00 00       	push   $0x540
  10026b:	6a 00                	push   $0x0
  10026d:	68 10 92 10 00       	push   $0x109210
  100272:	e8 49 03 00 00       	call   1005c0 <memset>
  100277:	b8 10 92 10 00       	mov    $0x109210,%eax
  10027c:	31 d2                	xor    %edx,%edx
  10027e:	83 c4 10             	add    $0x10,%esp
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
  100281:	89 10                	mov    %edx,(%eax)
	int whichprocess;
	pid_t i;

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
  100283:	42                   	inc    %edx
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
  100284:	c7 40 48 00 00 00 00 	movl   $0x0,0x48(%eax)
		proc_array[i].p_wait_for_pid = -1; // added after exercise 3; all processes don't wait when initialized
  10028b:	c7 40 50 ff ff ff ff 	movl   $0xffffffff,0x50(%eax)
	int whichprocess;
	pid_t i;

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
  100292:	83 c0 54             	add    $0x54,%eax
  100295:	83 fa 10             	cmp    $0x10,%edx
  100298:	75 e7                	jne    100281 <start+0x1f>
		proc_array[i].p_state = P_EMPTY;
		proc_array[i].p_wait_for_pid = -1; // added after exercise 3; all processes don't wait when initialized
	}

	// The first process has process ID 1.
	current = &proc_array[1];
  10029a:	c7 05 b8 9f 10 00 64 	movl   $0x109264,0x109fb8
  1002a1:	92 10 00 

	// Set up x86 hardware, and initialize the first process's
	// special registers.  This only needs to be done once, at boot time.
	// All other processes' special registers can be copied from the
	// first process.
	segments_init();
  1002a4:	e8 73 00 00 00       	call   10031c <segments_init>
	special_registers_init(current);
  1002a9:	83 ec 0c             	sub    $0xc,%esp
  1002ac:	ff 35 b8 9f 10 00    	pushl  0x109fb8
  1002b2:	e8 e4 01 00 00       	call   10049b <special_registers_init>

	// Erase the console, and initialize the cursor-position shared
	// variable to point to its upper left.
	console_clear();
  1002b7:	e8 2f 01 00 00       	call   1003eb <console_clear>

	// Figure out which program to run.
	cursorpos = console_printf(cursorpos, 0x0700, "Type '1' to run mpos-app, or '2' to run mpos-app2.");
  1002bc:	83 c4 0c             	add    $0xc,%esp
  1002bf:	68 50 0a 10 00       	push   $0x100a50
  1002c4:	68 00 07 00 00       	push   $0x700
  1002c9:	ff 35 00 00 06 00    	pushl  0x60000
  1002cf:	e8 4e 07 00 00       	call   100a22 <console_printf>
  1002d4:	83 c4 10             	add    $0x10,%esp
  1002d7:	a3 00 00 06 00       	mov    %eax,0x60000
	do {
		whichprocess = console_read_digit();
  1002dc:	e8 4d 01 00 00       	call   10042e <console_read_digit>
	} while (whichprocess != 1 && whichprocess != 2);
  1002e1:	8d 58 ff             	lea    -0x1(%eax),%ebx
  1002e4:	83 fb 01             	cmp    $0x1,%ebx
  1002e7:	77 f3                	ja     1002dc <start+0x7a>
	console_clear();
  1002e9:	e8 fd 00 00 00       	call   1003eb <console_clear>

	// Load the process application code and data into memory.
	// Store its entry point into the first process's EIP
	// (instruction pointer).
	program_loader(whichprocess - 1, &current->p_registers.reg_eip);
  1002ee:	50                   	push   %eax
  1002ef:	50                   	push   %eax
  1002f0:	a1 b8 9f 10 00       	mov    0x109fb8,%eax
  1002f5:	83 c0 34             	add    $0x34,%eax
  1002f8:	50                   	push   %eax
  1002f9:	53                   	push   %ebx
  1002fa:	e8 d1 01 00 00       	call   1004d0 <program_loader>

	// Set the main process's stack pointer, ESP.
	current->p_registers.reg_esp = PROC1_STACK_ADDR + PROC_STACK_SIZE;
  1002ff:	a1 b8 9f 10 00       	mov    0x109fb8,%eax
  100304:	c7 40 40 00 00 2c 00 	movl   $0x2c0000,0x40(%eax)

	// Mark the process as runnable!
	current->p_state = P_RUNNABLE;
  10030b:	c7 40 48 01 00 00 00 	movl   $0x1,0x48(%eax)

	// Switch to the main process using run().
	run(current);
  100312:	89 04 24             	mov    %eax,(%esp)
  100315:	e8 6a 01 00 00       	call   100484 <run>
  10031a:	90                   	nop
  10031b:	90                   	nop

0010031c <segments_init>:
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  10031c:	b8 50 97 10 00       	mov    $0x109750,%eax
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  100321:	b9 56 00 10 00       	mov    $0x100056,%ecx
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  100326:	89 c2                	mov    %eax,%edx
  100328:	c1 ea 10             	shr    $0x10,%edx
extern void default_int_handler(void);


void
segments_init(void)
{
  10032b:	53                   	push   %ebx
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  10032c:	bb 56 00 10 00       	mov    $0x100056,%ebx
  100331:	c1 eb 10             	shr    $0x10,%ebx
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  100334:	66 a3 ee 1a 10 00    	mov    %ax,0x101aee
  10033a:	c1 e8 18             	shr    $0x18,%eax
  10033d:	88 15 f0 1a 10 00    	mov    %dl,0x101af0
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  100343:	ba b8 97 10 00       	mov    $0x1097b8,%edx
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  100348:	a2 f3 1a 10 00       	mov    %al,0x101af3
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  10034d:	31 c0                	xor    %eax,%eax
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  10034f:	66 c7 05 ec 1a 10 00 	movw   $0x68,0x101aec
  100356:	68 00 
  100358:	c6 05 f2 1a 10 00 40 	movb   $0x40,0x101af2
		= SEG16(STS_T32A, (uint32_t) &kernel_task_descriptor,
			sizeof(taskstate_t), 0);
	segments[SEGSEL_TASKSTATE >> 3].sd_s = 0;
  10035f:	c6 05 f1 1a 10 00 89 	movb   $0x89,0x101af1

	// Set up kernel task descriptor, so we can receive interrupts
	kernel_task_descriptor.ts_esp0 = KERNEL_STACK_TOP;
  100366:	c7 05 54 97 10 00 00 	movl   $0x80000,0x109754
  10036d:	00 08 00 
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;
  100370:	66 c7 05 58 97 10 00 	movw   $0x10,0x109758
  100377:	10 00 

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  100379:	66 89 0c c5 b8 97 10 	mov    %cx,0x1097b8(,%eax,8)
  100380:	00 
  100381:	66 c7 44 c2 02 08 00 	movw   $0x8,0x2(%edx,%eax,8)
  100388:	c6 44 c2 04 00       	movb   $0x0,0x4(%edx,%eax,8)
  10038d:	c6 44 c2 05 8e       	movb   $0x8e,0x5(%edx,%eax,8)
  100392:	66 89 5c c2 06       	mov    %bx,0x6(%edx,%eax,8)
	kernel_task_descriptor.ts_esp0 = KERNEL_STACK_TOP;
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
  100397:	40                   	inc    %eax
  100398:	3d 00 01 00 00       	cmp    $0x100,%eax
  10039d:	75 da                	jne    100379 <segments_init+0x5d>
  10039f:	66 b8 30 00          	mov    $0x30,%ax

	// System calls get special handling.
	// Note that the last argument is '3'.  This means that unprivileged
	// (level-3) applications may generate these interrupts.
	for (i = INT_SYS_GETPID; i < INT_SYS_GETPID + 10; i++)
		SETGATE(interrupt_descriptors[i], 0,
  1003a3:	ba b8 97 10 00       	mov    $0x1097b8,%edx
  1003a8:	8b 0c 85 a3 ff 0f 00 	mov    0xfffa3(,%eax,4),%ecx
  1003af:	66 c7 44 c2 02 08 00 	movw   $0x8,0x2(%edx,%eax,8)
  1003b6:	66 89 0c c5 b8 97 10 	mov    %cx,0x1097b8(,%eax,8)
  1003bd:	00 
  1003be:	c1 e9 10             	shr    $0x10,%ecx
  1003c1:	c6 44 c2 04 00       	movb   $0x0,0x4(%edx,%eax,8)
  1003c6:	c6 44 c2 05 ee       	movb   $0xee,0x5(%edx,%eax,8)
  1003cb:	66 89 4c c2 06       	mov    %cx,0x6(%edx,%eax,8)
			SEGSEL_KERN_CODE, default_int_handler, 0);

	// System calls get special handling.
	// Note that the last argument is '3'.  This means that unprivileged
	// (level-3) applications may generate these interrupts.
	for (i = INT_SYS_GETPID; i < INT_SYS_GETPID + 10; i++)
  1003d0:	40                   	inc    %eax
  1003d1:	83 f8 3a             	cmp    $0x3a,%eax
  1003d4:	75 d2                	jne    1003a8 <segments_init+0x8c>
		SETGATE(interrupt_descriptors[i], 0,
			SEGSEL_KERN_CODE, sys_int_handlers[i - INT_SYS_GETPID], 3);

	// Reload segment pointers
	asm volatile("lgdt global_descriptor_table\n\t"
  1003d6:	b0 28                	mov    $0x28,%al
  1003d8:	0f 01 15 b4 1a 10 00 	lgdtl  0x101ab4
  1003df:	0f 00 d8             	ltr    %ax
  1003e2:	0f 01 1d bc 1a 10 00 	lidtl  0x101abc
		     "lidt interrupt_descriptor_table"
		     : : "r" ((uint16_t) SEGSEL_TASKSTATE));

	// Convince compiler that all symbols were used
	(void) global_descriptor_table, (void) interrupt_descriptor_table;
}
  1003e9:	5b                   	pop    %ebx
  1003ea:	c3                   	ret    

001003eb <console_clear>:
 *
 *****************************************************************************/

void
console_clear(void)
{
  1003eb:	56                   	push   %esi
	int i;
	cursorpos = (uint16_t *) 0xB8000;
  1003ec:	31 c0                	xor    %eax,%eax
 *
 *****************************************************************************/

void
console_clear(void)
{
  1003ee:	53                   	push   %ebx
	int i;
	cursorpos = (uint16_t *) 0xB8000;
  1003ef:	c7 05 00 00 06 00 00 	movl   $0xb8000,0x60000
  1003f6:	80 0b 00 

	for (i = 0; i < 80 * 25; i++)
		cursorpos[i] = ' ' | 0x0700;
  1003f9:	66 c7 84 00 00 80 0b 	movw   $0x720,0xb8000(%eax,%eax,1)
  100400:	00 20 07 
console_clear(void)
{
	int i;
	cursorpos = (uint16_t *) 0xB8000;

	for (i = 0; i < 80 * 25; i++)
  100403:	40                   	inc    %eax
  100404:	3d d0 07 00 00       	cmp    $0x7d0,%eax
  100409:	75 ee                	jne    1003f9 <console_clear+0xe>
}

static inline void
outb(int port, uint8_t data)
{
	asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
  10040b:	be d4 03 00 00       	mov    $0x3d4,%esi
  100410:	b0 0e                	mov    $0xe,%al
  100412:	89 f2                	mov    %esi,%edx
  100414:	ee                   	out    %al,(%dx)
  100415:	31 c9                	xor    %ecx,%ecx
  100417:	bb d5 03 00 00       	mov    $0x3d5,%ebx
  10041c:	88 c8                	mov    %cl,%al
  10041e:	89 da                	mov    %ebx,%edx
  100420:	ee                   	out    %al,(%dx)
  100421:	b0 0f                	mov    $0xf,%al
  100423:	89 f2                	mov    %esi,%edx
  100425:	ee                   	out    %al,(%dx)
  100426:	88 c8                	mov    %cl,%al
  100428:	89 da                	mov    %ebx,%edx
  10042a:	ee                   	out    %al,(%dx)
		cursorpos[i] = ' ' | 0x0700;
	outb(0x3D4, 14);
	outb(0x3D5, 0 / 256);
	outb(0x3D4, 15);
	outb(0x3D5, 0 % 256);
}
  10042b:	5b                   	pop    %ebx
  10042c:	5e                   	pop    %esi
  10042d:	c3                   	ret    

0010042e <console_read_digit>:

static inline uint8_t
inb(int port)
{
	uint8_t data;
	asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
  10042e:	ba 64 00 00 00       	mov    $0x64,%edx
  100433:	ec                   	in     (%dx),%al
int
console_read_digit(void)
{
	uint8_t data;

	if ((inb(KBSTATP) & KBS_DIB) == 0)
  100434:	a8 01                	test   $0x1,%al
  100436:	74 45                	je     10047d <console_read_digit+0x4f>
  100438:	b2 60                	mov    $0x60,%dl
  10043a:	ec                   	in     (%dx),%al
		return -1;

	data = inb(KBDATAP);
	if (data >= 0x02 && data <= 0x0A)
  10043b:	8d 50 fe             	lea    -0x2(%eax),%edx
  10043e:	80 fa 08             	cmp    $0x8,%dl
  100441:	77 05                	ja     100448 <console_read_digit+0x1a>
		return data - 0x02 + 1;
  100443:	0f b6 c0             	movzbl %al,%eax
  100446:	48                   	dec    %eax
  100447:	c3                   	ret    
	else if (data == 0x0B)
  100448:	3c 0b                	cmp    $0xb,%al
  10044a:	74 35                	je     100481 <console_read_digit+0x53>
		return 0;
	else if (data >= 0x47 && data <= 0x49)
  10044c:	8d 50 b9             	lea    -0x47(%eax),%edx
  10044f:	80 fa 02             	cmp    $0x2,%dl
  100452:	77 07                	ja     10045b <console_read_digit+0x2d>
		return data - 0x47 + 7;
  100454:	0f b6 c0             	movzbl %al,%eax
  100457:	83 e8 40             	sub    $0x40,%eax
  10045a:	c3                   	ret    
	else if (data >= 0x4B && data <= 0x4D)
  10045b:	8d 50 b5             	lea    -0x4b(%eax),%edx
  10045e:	80 fa 02             	cmp    $0x2,%dl
  100461:	77 07                	ja     10046a <console_read_digit+0x3c>
		return data - 0x4B + 4;
  100463:	0f b6 c0             	movzbl %al,%eax
  100466:	83 e8 47             	sub    $0x47,%eax
  100469:	c3                   	ret    
	else if (data >= 0x4F && data <= 0x51)
  10046a:	8d 50 b1             	lea    -0x4f(%eax),%edx
  10046d:	80 fa 02             	cmp    $0x2,%dl
  100470:	77 07                	ja     100479 <console_read_digit+0x4b>
		return data - 0x4F + 1;
  100472:	0f b6 c0             	movzbl %al,%eax
  100475:	83 e8 4e             	sub    $0x4e,%eax
  100478:	c3                   	ret    
	else if (data == 0x53)
  100479:	3c 53                	cmp    $0x53,%al
  10047b:	74 04                	je     100481 <console_read_digit+0x53>
  10047d:	83 c8 ff             	or     $0xffffffff,%eax
  100480:	c3                   	ret    
  100481:	31 c0                	xor    %eax,%eax
		return 0;
	else
		return -1;
}
  100483:	c3                   	ret    

00100484 <run>:
 *
 *****************************************************************************/

void
run(process_t *proc)
{
  100484:	8b 44 24 04          	mov    0x4(%esp),%eax
	current = proc;
  100488:	a3 b8 9f 10 00       	mov    %eax,0x109fb8

	asm volatile("movl %0,%%esp\n\t"
  10048d:	83 c0 04             	add    $0x4,%eax
  100490:	89 c4                	mov    %eax,%esp
  100492:	61                   	popa   
  100493:	07                   	pop    %es
  100494:	1f                   	pop    %ds
  100495:	83 c4 08             	add    $0x8,%esp
  100498:	cf                   	iret   
  100499:	eb fe                	jmp    100499 <run+0x15>

0010049b <special_registers_init>:
 *
 *****************************************************************************/

void
special_registers_init(process_t *proc)
{
  10049b:	53                   	push   %ebx
  10049c:	83 ec 0c             	sub    $0xc,%esp
  10049f:	8b 5c 24 14          	mov    0x14(%esp),%ebx
	memset(&proc->p_registers, 0, sizeof(registers_t));
  1004a3:	6a 44                	push   $0x44
  1004a5:	6a 00                	push   $0x0
  1004a7:	8d 43 04             	lea    0x4(%ebx),%eax
  1004aa:	50                   	push   %eax
  1004ab:	e8 10 01 00 00       	call   1005c0 <memset>
	proc->p_registers.reg_cs = SEGSEL_APP_CODE | 3;
  1004b0:	66 c7 43 38 1b 00    	movw   $0x1b,0x38(%ebx)
	proc->p_registers.reg_ds = SEGSEL_APP_DATA | 3;
  1004b6:	66 c7 43 28 23 00    	movw   $0x23,0x28(%ebx)
	proc->p_registers.reg_es = SEGSEL_APP_DATA | 3;
  1004bc:	66 c7 43 24 23 00    	movw   $0x23,0x24(%ebx)
	proc->p_registers.reg_ss = SEGSEL_APP_DATA | 3;
  1004c2:	66 c7 43 44 23 00    	movw   $0x23,0x44(%ebx)
}
  1004c8:	83 c4 18             	add    $0x18,%esp
  1004cb:	5b                   	pop    %ebx
  1004cc:	c3                   	ret    
  1004cd:	90                   	nop
  1004ce:	90                   	nop
  1004cf:	90                   	nop

001004d0 <program_loader>:
		    uint32_t filesz, uint32_t memsz);
static void loader_panic(void);

void
program_loader(int program_id, uint32_t *entry_point)
{
  1004d0:	55                   	push   %ebp
  1004d1:	57                   	push   %edi
  1004d2:	56                   	push   %esi
  1004d3:	53                   	push   %ebx
  1004d4:	83 ec 1c             	sub    $0x1c,%esp
  1004d7:	8b 44 24 30          	mov    0x30(%esp),%eax
	struct Proghdr *ph, *eph;
	struct Elf *elf_header;
	int nprograms = sizeof(ramimages) / sizeof(ramimages[0]);

	if (program_id < 0 || program_id >= nprograms)
  1004db:	83 f8 01             	cmp    $0x1,%eax
  1004de:	7f 04                	jg     1004e4 <program_loader+0x14>
  1004e0:	85 c0                	test   %eax,%eax
  1004e2:	79 02                	jns    1004e6 <program_loader+0x16>
  1004e4:	eb fe                	jmp    1004e4 <program_loader+0x14>
		loader_panic();

	// is this a valid ELF?
	elf_header = (struct Elf *) ramimages[program_id].begin;
  1004e6:	8b 34 c5 f4 1a 10 00 	mov    0x101af4(,%eax,8),%esi
	if (elf_header->e_magic != ELF_MAGIC)
  1004ed:	81 3e 7f 45 4c 46    	cmpl   $0x464c457f,(%esi)
  1004f3:	74 02                	je     1004f7 <program_loader+0x27>
  1004f5:	eb fe                	jmp    1004f5 <program_loader+0x25>
		loader_panic();

	// load each program segment (ignores ph flags)
	ph = (struct Proghdr*) ((const uint8_t *) elf_header + elf_header->e_phoff);
  1004f7:	8b 5e 1c             	mov    0x1c(%esi),%ebx
	eph = ph + elf_header->e_phnum;
  1004fa:	0f b7 6e 2c          	movzwl 0x2c(%esi),%ebp
	elf_header = (struct Elf *) ramimages[program_id].begin;
	if (elf_header->e_magic != ELF_MAGIC)
		loader_panic();

	// load each program segment (ignores ph flags)
	ph = (struct Proghdr*) ((const uint8_t *) elf_header + elf_header->e_phoff);
  1004fe:	01 f3                	add    %esi,%ebx
	eph = ph + elf_header->e_phnum;
  100500:	c1 e5 05             	shl    $0x5,%ebp
  100503:	8d 2c 2b             	lea    (%ebx,%ebp,1),%ebp
	for (; ph < eph; ph++)
  100506:	eb 3f                	jmp    100547 <program_loader+0x77>
		if (ph->p_type == ELF_PROG_LOAD)
  100508:	83 3b 01             	cmpl   $0x1,(%ebx)
  10050b:	75 37                	jne    100544 <program_loader+0x74>
			copyseg((void *) ph->p_va,
  10050d:	8b 43 08             	mov    0x8(%ebx),%eax
// then clear the memory from 'va+filesz' up to 'va+memsz' (set it to 0).
static void
copyseg(void *dst, const uint8_t *src, uint32_t filesz, uint32_t memsz)
{
	uint32_t va = (uint32_t) dst;
	uint32_t end_va = va + filesz;
  100510:	8b 7b 10             	mov    0x10(%ebx),%edi
	memsz += va;
  100513:	8b 53 14             	mov    0x14(%ebx),%edx
// then clear the memory from 'va+filesz' up to 'va+memsz' (set it to 0).
static void
copyseg(void *dst, const uint8_t *src, uint32_t filesz, uint32_t memsz)
{
	uint32_t va = (uint32_t) dst;
	uint32_t end_va = va + filesz;
  100516:	01 c7                	add    %eax,%edi
	memsz += va;
  100518:	01 c2                	add    %eax,%edx
	va &= ~(PAGESIZE - 1);		// round to page boundary
  10051a:	25 00 f0 ff ff       	and    $0xfffff000,%eax
static void
copyseg(void *dst, const uint8_t *src, uint32_t filesz, uint32_t memsz)
{
	uint32_t va = (uint32_t) dst;
	uint32_t end_va = va + filesz;
	memsz += va;
  10051f:	89 54 24 0c          	mov    %edx,0xc(%esp)
	va &= ~(PAGESIZE - 1);		// round to page boundary

	// copy data
	memcpy((uint8_t *) va, src, end_va - va);
  100523:	52                   	push   %edx
  100524:	89 fa                	mov    %edi,%edx
  100526:	29 c2                	sub    %eax,%edx
  100528:	52                   	push   %edx
  100529:	8b 53 04             	mov    0x4(%ebx),%edx
  10052c:	01 f2                	add    %esi,%edx
  10052e:	52                   	push   %edx
  10052f:	50                   	push   %eax
  100530:	e8 27 00 00 00       	call   10055c <memcpy>
  100535:	83 c4 10             	add    $0x10,%esp
  100538:	eb 04                	jmp    10053e <program_loader+0x6e>

	// clear bss segment
	while (end_va < memsz)
		*((uint8_t *) end_va++) = 0;
  10053a:	c6 07 00             	movb   $0x0,(%edi)
  10053d:	47                   	inc    %edi

	// copy data
	memcpy((uint8_t *) va, src, end_va - va);

	// clear bss segment
	while (end_va < memsz)
  10053e:	3b 7c 24 0c          	cmp    0xc(%esp),%edi
  100542:	72 f6                	jb     10053a <program_loader+0x6a>
		loader_panic();

	// load each program segment (ignores ph flags)
	ph = (struct Proghdr*) ((const uint8_t *) elf_header + elf_header->e_phoff);
	eph = ph + elf_header->e_phnum;
	for (; ph < eph; ph++)
  100544:	83 c3 20             	add    $0x20,%ebx
  100547:	39 eb                	cmp    %ebp,%ebx
  100549:	72 bd                	jb     100508 <program_loader+0x38>
			copyseg((void *) ph->p_va,
				(const uint8_t *) elf_header + ph->p_offset,
				ph->p_filesz, ph->p_memsz);

	// store the entry point from the ELF header
	*entry_point = elf_header->e_entry;
  10054b:	8b 56 18             	mov    0x18(%esi),%edx
  10054e:	8b 44 24 34          	mov    0x34(%esp),%eax
  100552:	89 10                	mov    %edx,(%eax)
}
  100554:	83 c4 1c             	add    $0x1c,%esp
  100557:	5b                   	pop    %ebx
  100558:	5e                   	pop    %esi
  100559:	5f                   	pop    %edi
  10055a:	5d                   	pop    %ebp
  10055b:	c3                   	ret    

0010055c <memcpy>:
 *
 *   We must provide our own implementations of these basic functions. */

void *
memcpy(void *dst, const void *src, size_t n)
{
  10055c:	56                   	push   %esi
  10055d:	31 d2                	xor    %edx,%edx
  10055f:	53                   	push   %ebx
  100560:	8b 44 24 0c          	mov    0xc(%esp),%eax
  100564:	8b 5c 24 10          	mov    0x10(%esp),%ebx
  100568:	8b 74 24 14          	mov    0x14(%esp),%esi
	const char *s = (const char *) src;
	char *d = (char *) dst;
	while (n-- > 0)
  10056c:	eb 08                	jmp    100576 <memcpy+0x1a>
		*d++ = *s++;
  10056e:	8a 0c 13             	mov    (%ebx,%edx,1),%cl
  100571:	4e                   	dec    %esi
  100572:	88 0c 10             	mov    %cl,(%eax,%edx,1)
  100575:	42                   	inc    %edx
void *
memcpy(void *dst, const void *src, size_t n)
{
	const char *s = (const char *) src;
	char *d = (char *) dst;
	while (n-- > 0)
  100576:	85 f6                	test   %esi,%esi
  100578:	75 f4                	jne    10056e <memcpy+0x12>
		*d++ = *s++;
	return dst;
}
  10057a:	5b                   	pop    %ebx
  10057b:	5e                   	pop    %esi
  10057c:	c3                   	ret    

0010057d <memmove>:

void *
memmove(void *dst, const void *src, size_t n)
{
  10057d:	57                   	push   %edi
  10057e:	56                   	push   %esi
  10057f:	53                   	push   %ebx
  100580:	8b 44 24 10          	mov    0x10(%esp),%eax
  100584:	8b 7c 24 14          	mov    0x14(%esp),%edi
  100588:	8b 54 24 18          	mov    0x18(%esp),%edx
	const char *s = (const char *) src;
	char *d = (char *) dst;
	if (s < d && s + n > d) {
  10058c:	39 c7                	cmp    %eax,%edi
  10058e:	73 26                	jae    1005b6 <memmove+0x39>
  100590:	8d 34 17             	lea    (%edi,%edx,1),%esi
  100593:	39 c6                	cmp    %eax,%esi
  100595:	76 1f                	jbe    1005b6 <memmove+0x39>
		s += n, d += n;
  100597:	8d 3c 10             	lea    (%eax,%edx,1),%edi
  10059a:	31 c9                	xor    %ecx,%ecx
		while (n-- > 0)
  10059c:	eb 07                	jmp    1005a5 <memmove+0x28>
			*--d = *--s;
  10059e:	8a 1c 0e             	mov    (%esi,%ecx,1),%bl
  1005a1:	4a                   	dec    %edx
  1005a2:	88 1c 0f             	mov    %bl,(%edi,%ecx,1)
  1005a5:	49                   	dec    %ecx
{
	const char *s = (const char *) src;
	char *d = (char *) dst;
	if (s < d && s + n > d) {
		s += n, d += n;
		while (n-- > 0)
  1005a6:	85 d2                	test   %edx,%edx
  1005a8:	75 f4                	jne    10059e <memmove+0x21>
  1005aa:	eb 10                	jmp    1005bc <memmove+0x3f>
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  1005ac:	8a 1c 0f             	mov    (%edi,%ecx,1),%bl
  1005af:	4a                   	dec    %edx
  1005b0:	88 1c 08             	mov    %bl,(%eax,%ecx,1)
  1005b3:	41                   	inc    %ecx
  1005b4:	eb 02                	jmp    1005b8 <memmove+0x3b>
  1005b6:	31 c9                	xor    %ecx,%ecx
	if (s < d && s + n > d) {
		s += n, d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  1005b8:	85 d2                	test   %edx,%edx
  1005ba:	75 f0                	jne    1005ac <memmove+0x2f>
			*d++ = *s++;
	return dst;
}
  1005bc:	5b                   	pop    %ebx
  1005bd:	5e                   	pop    %esi
  1005be:	5f                   	pop    %edi
  1005bf:	c3                   	ret    

001005c0 <memset>:

void *
memset(void *v, int c, size_t n)
{
  1005c0:	53                   	push   %ebx
  1005c1:	8b 44 24 08          	mov    0x8(%esp),%eax
  1005c5:	8b 5c 24 0c          	mov    0xc(%esp),%ebx
  1005c9:	8b 4c 24 10          	mov    0x10(%esp),%ecx
	char *p = (char *) v;
  1005cd:	89 c2                	mov    %eax,%edx
	while (n-- > 0)
  1005cf:	eb 04                	jmp    1005d5 <memset+0x15>
		*p++ = c;
  1005d1:	88 1a                	mov    %bl,(%edx)
  1005d3:	49                   	dec    %ecx
  1005d4:	42                   	inc    %edx

void *
memset(void *v, int c, size_t n)
{
	char *p = (char *) v;
	while (n-- > 0)
  1005d5:	85 c9                	test   %ecx,%ecx
  1005d7:	75 f8                	jne    1005d1 <memset+0x11>
		*p++ = c;
	return v;
}
  1005d9:	5b                   	pop    %ebx
  1005da:	c3                   	ret    

001005db <strlen>:

size_t
strlen(const char *s)
{
  1005db:	8b 54 24 04          	mov    0x4(%esp),%edx
  1005df:	31 c0                	xor    %eax,%eax
	size_t n;
	for (n = 0; *s != '\0'; ++s)
  1005e1:	eb 01                	jmp    1005e4 <strlen+0x9>
		++n;
  1005e3:	40                   	inc    %eax

size_t
strlen(const char *s)
{
	size_t n;
	for (n = 0; *s != '\0'; ++s)
  1005e4:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
  1005e8:	75 f9                	jne    1005e3 <strlen+0x8>
		++n;
	return n;
}
  1005ea:	c3                   	ret    

001005eb <strnlen>:

size_t
strnlen(const char *s, size_t maxlen)
{
  1005eb:	8b 4c 24 04          	mov    0x4(%esp),%ecx
  1005ef:	31 c0                	xor    %eax,%eax
  1005f1:	8b 54 24 08          	mov    0x8(%esp),%edx
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
  1005f5:	eb 01                	jmp    1005f8 <strnlen+0xd>
		++n;
  1005f7:	40                   	inc    %eax

size_t
strnlen(const char *s, size_t maxlen)
{
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
  1005f8:	39 d0                	cmp    %edx,%eax
  1005fa:	74 06                	je     100602 <strnlen+0x17>
  1005fc:	80 3c 01 00          	cmpb   $0x0,(%ecx,%eax,1)
  100600:	75 f5                	jne    1005f7 <strnlen+0xc>
		++n;
	return n;
}
  100602:	c3                   	ret    

00100603 <console_putc>:
 *
 *   Print a message onto the console, starting at the given cursor position. */

static uint16_t *
console_putc(uint16_t *cursor, unsigned char c, int color)
{
  100603:	56                   	push   %esi
	if (cursor >= CONSOLE_END)
  100604:	3d 9f 8f 0b 00       	cmp    $0xb8f9f,%eax
 *
 *   Print a message onto the console, starting at the given cursor position. */

static uint16_t *
console_putc(uint16_t *cursor, unsigned char c, int color)
{
  100609:	53                   	push   %ebx
  10060a:	89 c3                	mov    %eax,%ebx
	if (cursor >= CONSOLE_END)
  10060c:	76 05                	jbe    100613 <console_putc+0x10>
  10060e:	bb 00 80 0b 00       	mov    $0xb8000,%ebx
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
  100613:	80 fa 0a             	cmp    $0xa,%dl
  100616:	75 2c                	jne    100644 <console_putc+0x41>
		int pos = (cursor - CONSOLE_BEGIN) % 80;
  100618:	8d 83 00 80 f4 ff    	lea    -0xb8000(%ebx),%eax
  10061e:	be 50 00 00 00       	mov    $0x50,%esi
  100623:	d1 f8                	sar    %eax
		for (; pos != 80; pos++)
			*cursor++ = ' ' | color;
  100625:	83 c9 20             	or     $0x20,%ecx
console_putc(uint16_t *cursor, unsigned char c, int color)
{
	if (cursor >= CONSOLE_END)
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
		int pos = (cursor - CONSOLE_BEGIN) % 80;
  100628:	99                   	cltd   
  100629:	f7 fe                	idiv   %esi
  10062b:	89 de                	mov    %ebx,%esi
  10062d:	89 d0                	mov    %edx,%eax
		for (; pos != 80; pos++)
  10062f:	eb 07                	jmp    100638 <console_putc+0x35>
			*cursor++ = ' ' | color;
  100631:	66 89 0e             	mov    %cx,(%esi)
{
	if (cursor >= CONSOLE_END)
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
		int pos = (cursor - CONSOLE_BEGIN) % 80;
		for (; pos != 80; pos++)
  100634:	40                   	inc    %eax
			*cursor++ = ' ' | color;
  100635:	83 c6 02             	add    $0x2,%esi
{
	if (cursor >= CONSOLE_END)
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
		int pos = (cursor - CONSOLE_BEGIN) % 80;
		for (; pos != 80; pos++)
  100638:	83 f8 50             	cmp    $0x50,%eax
  10063b:	75 f4                	jne    100631 <console_putc+0x2e>
  10063d:	29 d0                	sub    %edx,%eax
  10063f:	8d 04 43             	lea    (%ebx,%eax,2),%eax
  100642:	eb 0b                	jmp    10064f <console_putc+0x4c>
			*cursor++ = ' ' | color;
	} else
		*cursor++ = c | color;
  100644:	0f b6 d2             	movzbl %dl,%edx
  100647:	09 ca                	or     %ecx,%edx
  100649:	66 89 13             	mov    %dx,(%ebx)
  10064c:	8d 43 02             	lea    0x2(%ebx),%eax
	return cursor;
}
  10064f:	5b                   	pop    %ebx
  100650:	5e                   	pop    %esi
  100651:	c3                   	ret    

00100652 <fill_numbuf>:
static const char lower_digits[] = "0123456789abcdef";

static char *
fill_numbuf(char *numbuf_end, uint32_t val, int base, const char *digits,
	    int precision)
{
  100652:	56                   	push   %esi
  100653:	53                   	push   %ebx
  100654:	8b 74 24 0c          	mov    0xc(%esp),%esi
	*--numbuf_end = '\0';
  100658:	8d 58 ff             	lea    -0x1(%eax),%ebx
  10065b:	c6 40 ff 00          	movb   $0x0,-0x1(%eax)
	if (precision != 0 || val != 0)
  10065f:	83 7c 24 10 00       	cmpl   $0x0,0x10(%esp)
  100664:	75 04                	jne    10066a <fill_numbuf+0x18>
  100666:	85 d2                	test   %edx,%edx
  100668:	74 10                	je     10067a <fill_numbuf+0x28>
		do {
			*--numbuf_end = digits[val % base];
  10066a:	89 d0                	mov    %edx,%eax
  10066c:	31 d2                	xor    %edx,%edx
  10066e:	f7 f1                	div    %ecx
  100670:	4b                   	dec    %ebx
  100671:	8a 14 16             	mov    (%esi,%edx,1),%dl
  100674:	88 13                	mov    %dl,(%ebx)
			val /= base;
  100676:	89 c2                	mov    %eax,%edx
  100678:	eb ec                	jmp    100666 <fill_numbuf+0x14>
		} while (val != 0);
	return numbuf_end;
}
  10067a:	89 d8                	mov    %ebx,%eax
  10067c:	5b                   	pop    %ebx
  10067d:	5e                   	pop    %esi
  10067e:	c3                   	ret    

0010067f <console_vprintf>:
#define FLAG_PLUSPOSITIVE	(1<<4)
static const char flag_chars[] = "#0- +";

uint16_t *
console_vprintf(uint16_t *cursor, int color, const char *format, va_list val)
{
  10067f:	55                   	push   %ebp
  100680:	57                   	push   %edi
  100681:	56                   	push   %esi
  100682:	53                   	push   %ebx
  100683:	83 ec 38             	sub    $0x38,%esp
  100686:	8b 74 24 4c          	mov    0x4c(%esp),%esi
  10068a:	8b 7c 24 54          	mov    0x54(%esp),%edi
  10068e:	8b 5c 24 58          	mov    0x58(%esp),%ebx
	int flags, width, zeros, precision, negative, numeric, len;
#define NUMBUFSIZ 20
	char numbuf[NUMBUFSIZ];
	char *data;

	for (; *format; ++format) {
  100692:	e9 60 03 00 00       	jmp    1009f7 <console_vprintf+0x378>
		if (*format != '%') {
  100697:	80 fa 25             	cmp    $0x25,%dl
  10069a:	74 13                	je     1006af <console_vprintf+0x30>
			cursor = console_putc(cursor, *format, color);
  10069c:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  1006a0:	0f b6 d2             	movzbl %dl,%edx
  1006a3:	89 f0                	mov    %esi,%eax
  1006a5:	e8 59 ff ff ff       	call   100603 <console_putc>
  1006aa:	e9 45 03 00 00       	jmp    1009f4 <console_vprintf+0x375>
			continue;
		}

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
  1006af:	47                   	inc    %edi
  1006b0:	c7 44 24 14 00 00 00 	movl   $0x0,0x14(%esp)
  1006b7:	00 
  1006b8:	eb 12                	jmp    1006cc <console_vprintf+0x4d>
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
				++flagc;
  1006ba:	41                   	inc    %ecx

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
  1006bb:	8a 11                	mov    (%ecx),%dl
  1006bd:	84 d2                	test   %dl,%dl
  1006bf:	74 1a                	je     1006db <console_vprintf+0x5c>
  1006c1:	89 e8                	mov    %ebp,%eax
  1006c3:	38 c2                	cmp    %al,%dl
  1006c5:	75 f3                	jne    1006ba <console_vprintf+0x3b>
  1006c7:	e9 3f 03 00 00       	jmp    100a0b <console_vprintf+0x38c>
			continue;
		}

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
  1006cc:	8a 17                	mov    (%edi),%dl
  1006ce:	84 d2                	test   %dl,%dl
  1006d0:	74 0b                	je     1006dd <console_vprintf+0x5e>
  1006d2:	b9 84 0a 10 00       	mov    $0x100a84,%ecx
  1006d7:	89 d5                	mov    %edx,%ebp
  1006d9:	eb e0                	jmp    1006bb <console_vprintf+0x3c>
  1006db:	89 ea                	mov    %ebp,%edx
			flags |= (1 << (flagc - flag_chars));
		}

		// process width
		width = -1;
		if (*format >= '1' && *format <= '9') {
  1006dd:	8d 42 cf             	lea    -0x31(%edx),%eax
  1006e0:	3c 08                	cmp    $0x8,%al
  1006e2:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
  1006e9:	00 
  1006ea:	76 13                	jbe    1006ff <console_vprintf+0x80>
  1006ec:	eb 1d                	jmp    10070b <console_vprintf+0x8c>
			for (width = 0; *format >= '0' && *format <= '9'; )
				width = 10 * width + *format++ - '0';
  1006ee:	6b 54 24 0c 0a       	imul   $0xa,0xc(%esp),%edx
  1006f3:	0f be c0             	movsbl %al,%eax
  1006f6:	47                   	inc    %edi
  1006f7:	8d 44 02 d0          	lea    -0x30(%edx,%eax,1),%eax
  1006fb:	89 44 24 0c          	mov    %eax,0xc(%esp)
		}

		// process width
		width = -1;
		if (*format >= '1' && *format <= '9') {
			for (width = 0; *format >= '0' && *format <= '9'; )
  1006ff:	8a 07                	mov    (%edi),%al
  100701:	8d 50 d0             	lea    -0x30(%eax),%edx
  100704:	80 fa 09             	cmp    $0x9,%dl
  100707:	76 e5                	jbe    1006ee <console_vprintf+0x6f>
  100709:	eb 18                	jmp    100723 <console_vprintf+0xa4>
				width = 10 * width + *format++ - '0';
		} else if (*format == '*') {
  10070b:	80 fa 2a             	cmp    $0x2a,%dl
  10070e:	c7 44 24 0c ff ff ff 	movl   $0xffffffff,0xc(%esp)
  100715:	ff 
  100716:	75 0b                	jne    100723 <console_vprintf+0xa4>
			width = va_arg(val, int);
  100718:	83 c3 04             	add    $0x4,%ebx
			++format;
  10071b:	47                   	inc    %edi
		width = -1;
		if (*format >= '1' && *format <= '9') {
			for (width = 0; *format >= '0' && *format <= '9'; )
				width = 10 * width + *format++ - '0';
		} else if (*format == '*') {
			width = va_arg(val, int);
  10071c:	8b 53 fc             	mov    -0x4(%ebx),%edx
  10071f:	89 54 24 0c          	mov    %edx,0xc(%esp)
			++format;
		}

		// process precision
		precision = -1;
		if (*format == '.') {
  100723:	83 cd ff             	or     $0xffffffff,%ebp
  100726:	80 3f 2e             	cmpb   $0x2e,(%edi)
  100729:	75 37                	jne    100762 <console_vprintf+0xe3>
			++format;
  10072b:	47                   	inc    %edi
			if (*format >= '0' && *format <= '9') {
  10072c:	31 ed                	xor    %ebp,%ebp
  10072e:	8a 07                	mov    (%edi),%al
  100730:	8d 50 d0             	lea    -0x30(%eax),%edx
  100733:	80 fa 09             	cmp    $0x9,%dl
  100736:	76 0d                	jbe    100745 <console_vprintf+0xc6>
  100738:	eb 17                	jmp    100751 <console_vprintf+0xd2>
				for (precision = 0; *format >= '0' && *format <= '9'; )
					precision = 10 * precision + *format++ - '0';
  10073a:	6b ed 0a             	imul   $0xa,%ebp,%ebp
  10073d:	0f be c0             	movsbl %al,%eax
  100740:	47                   	inc    %edi
  100741:	8d 6c 05 d0          	lea    -0x30(%ebp,%eax,1),%ebp
		// process precision
		precision = -1;
		if (*format == '.') {
			++format;
			if (*format >= '0' && *format <= '9') {
				for (precision = 0; *format >= '0' && *format <= '9'; )
  100745:	8a 07                	mov    (%edi),%al
  100747:	8d 50 d0             	lea    -0x30(%eax),%edx
  10074a:	80 fa 09             	cmp    $0x9,%dl
  10074d:	76 eb                	jbe    10073a <console_vprintf+0xbb>
  10074f:	eb 11                	jmp    100762 <console_vprintf+0xe3>
					precision = 10 * precision + *format++ - '0';
			} else if (*format == '*') {
  100751:	3c 2a                	cmp    $0x2a,%al
  100753:	75 0b                	jne    100760 <console_vprintf+0xe1>
				precision = va_arg(val, int);
  100755:	83 c3 04             	add    $0x4,%ebx
				++format;
  100758:	47                   	inc    %edi
			++format;
			if (*format >= '0' && *format <= '9') {
				for (precision = 0; *format >= '0' && *format <= '9'; )
					precision = 10 * precision + *format++ - '0';
			} else if (*format == '*') {
				precision = va_arg(val, int);
  100759:	8b 6b fc             	mov    -0x4(%ebx),%ebp
				++format;
			}
			if (precision < 0)
  10075c:	85 ed                	test   %ebp,%ebp
  10075e:	79 02                	jns    100762 <console_vprintf+0xe3>
  100760:	31 ed                	xor    %ebp,%ebp
		}

		// process main conversion character
		negative = 0;
		numeric = 0;
		switch (*format) {
  100762:	8a 07                	mov    (%edi),%al
  100764:	3c 64                	cmp    $0x64,%al
  100766:	74 34                	je     10079c <console_vprintf+0x11d>
  100768:	7f 1d                	jg     100787 <console_vprintf+0x108>
  10076a:	3c 58                	cmp    $0x58,%al
  10076c:	0f 84 a2 00 00 00    	je     100814 <console_vprintf+0x195>
  100772:	3c 63                	cmp    $0x63,%al
  100774:	0f 84 bf 00 00 00    	je     100839 <console_vprintf+0x1ba>
  10077a:	3c 43                	cmp    $0x43,%al
  10077c:	0f 85 d0 00 00 00    	jne    100852 <console_vprintf+0x1d3>
  100782:	e9 a3 00 00 00       	jmp    10082a <console_vprintf+0x1ab>
  100787:	3c 75                	cmp    $0x75,%al
  100789:	74 4d                	je     1007d8 <console_vprintf+0x159>
  10078b:	3c 78                	cmp    $0x78,%al
  10078d:	74 5c                	je     1007eb <console_vprintf+0x16c>
  10078f:	3c 73                	cmp    $0x73,%al
  100791:	0f 85 bb 00 00 00    	jne    100852 <console_vprintf+0x1d3>
  100797:	e9 86 00 00 00       	jmp    100822 <console_vprintf+0x1a3>
		case 'd': {
			int x = va_arg(val, int);
  10079c:	83 c3 04             	add    $0x4,%ebx
  10079f:	8b 53 fc             	mov    -0x4(%ebx),%edx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x > 0 ? x : -x, 10, upper_digits, precision);
  1007a2:	89 d1                	mov    %edx,%ecx
  1007a4:	c1 f9 1f             	sar    $0x1f,%ecx
  1007a7:	89 0c 24             	mov    %ecx,(%esp)
  1007aa:	31 ca                	xor    %ecx,%edx
  1007ac:	55                   	push   %ebp
  1007ad:	29 ca                	sub    %ecx,%edx
  1007af:	68 8c 0a 10 00       	push   $0x100a8c
  1007b4:	b9 0a 00 00 00       	mov    $0xa,%ecx
  1007b9:	8d 44 24 40          	lea    0x40(%esp),%eax
  1007bd:	e8 90 fe ff ff       	call   100652 <fill_numbuf>
  1007c2:	89 44 24 0c          	mov    %eax,0xc(%esp)
			if (x < 0)
  1007c6:	58                   	pop    %eax
  1007c7:	5a                   	pop    %edx
  1007c8:	ba 01 00 00 00       	mov    $0x1,%edx
  1007cd:	8b 04 24             	mov    (%esp),%eax
  1007d0:	83 e0 01             	and    $0x1,%eax
  1007d3:	e9 a5 00 00 00       	jmp    10087d <console_vprintf+0x1fe>
				negative = 1;
			numeric = 1;
			break;
		}
		case 'u': {
			unsigned x = va_arg(val, unsigned);
  1007d8:	83 c3 04             	add    $0x4,%ebx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x, 10, upper_digits, precision);
  1007db:	b9 0a 00 00 00       	mov    $0xa,%ecx
  1007e0:	8b 53 fc             	mov    -0x4(%ebx),%edx
  1007e3:	55                   	push   %ebp
  1007e4:	68 8c 0a 10 00       	push   $0x100a8c
  1007e9:	eb 11                	jmp    1007fc <console_vprintf+0x17d>
			numeric = 1;
			break;
		}
		case 'x': {
			unsigned x = va_arg(val, unsigned);
  1007eb:	83 c3 04             	add    $0x4,%ebx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x, 16, lower_digits, precision);
  1007ee:	8b 53 fc             	mov    -0x4(%ebx),%edx
  1007f1:	55                   	push   %ebp
  1007f2:	68 a0 0a 10 00       	push   $0x100aa0
  1007f7:	b9 10 00 00 00       	mov    $0x10,%ecx
  1007fc:	8d 44 24 40          	lea    0x40(%esp),%eax
  100800:	e8 4d fe ff ff       	call   100652 <fill_numbuf>
  100805:	ba 01 00 00 00       	mov    $0x1,%edx
  10080a:	89 44 24 0c          	mov    %eax,0xc(%esp)
  10080e:	31 c0                	xor    %eax,%eax
			numeric = 1;
			break;
  100810:	59                   	pop    %ecx
  100811:	59                   	pop    %ecx
  100812:	eb 69                	jmp    10087d <console_vprintf+0x1fe>
		}
		case 'X': {
			unsigned x = va_arg(val, unsigned);
  100814:	83 c3 04             	add    $0x4,%ebx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x, 16, upper_digits, precision);
  100817:	8b 53 fc             	mov    -0x4(%ebx),%edx
  10081a:	55                   	push   %ebp
  10081b:	68 8c 0a 10 00       	push   $0x100a8c
  100820:	eb d5                	jmp    1007f7 <console_vprintf+0x178>
			numeric = 1;
			break;
		}
		case 's':
			data = va_arg(val, char *);
  100822:	83 c3 04             	add    $0x4,%ebx
  100825:	8b 43 fc             	mov    -0x4(%ebx),%eax
  100828:	eb 40                	jmp    10086a <console_vprintf+0x1eb>
			break;
		case 'C':
			color = va_arg(val, int);
  10082a:	83 c3 04             	add    $0x4,%ebx
  10082d:	8b 53 fc             	mov    -0x4(%ebx),%edx
  100830:	89 54 24 50          	mov    %edx,0x50(%esp)
			goto done;
  100834:	e9 bd 01 00 00       	jmp    1009f6 <console_vprintf+0x377>
		case 'c':
			data = numbuf;
			numbuf[0] = va_arg(val, int);
  100839:	83 c3 04             	add    $0x4,%ebx
  10083c:	8b 43 fc             	mov    -0x4(%ebx),%eax
			numbuf[1] = '\0';
  10083f:	8d 4c 24 24          	lea    0x24(%esp),%ecx
  100843:	c6 44 24 25 00       	movb   $0x0,0x25(%esp)
  100848:	89 4c 24 04          	mov    %ecx,0x4(%esp)
		case 'C':
			color = va_arg(val, int);
			goto done;
		case 'c':
			data = numbuf;
			numbuf[0] = va_arg(val, int);
  10084c:	88 44 24 24          	mov    %al,0x24(%esp)
  100850:	eb 27                	jmp    100879 <console_vprintf+0x1fa>
			numbuf[1] = '\0';
			break;
		normal:
		default:
			data = numbuf;
			numbuf[0] = (*format ? *format : '%');
  100852:	84 c0                	test   %al,%al
  100854:	75 02                	jne    100858 <console_vprintf+0x1d9>
  100856:	b0 25                	mov    $0x25,%al
  100858:	88 44 24 24          	mov    %al,0x24(%esp)
			numbuf[1] = '\0';
  10085c:	c6 44 24 25 00       	movb   $0x0,0x25(%esp)
			if (!*format)
  100861:	80 3f 00             	cmpb   $0x0,(%edi)
  100864:	74 0a                	je     100870 <console_vprintf+0x1f1>
  100866:	8d 44 24 24          	lea    0x24(%esp),%eax
  10086a:	89 44 24 04          	mov    %eax,0x4(%esp)
  10086e:	eb 09                	jmp    100879 <console_vprintf+0x1fa>
				format--;
  100870:	8d 54 24 24          	lea    0x24(%esp),%edx
  100874:	4f                   	dec    %edi
  100875:	89 54 24 04          	mov    %edx,0x4(%esp)
  100879:	31 d2                	xor    %edx,%edx
  10087b:	31 c0                	xor    %eax,%eax
			break;
		}

		if (precision >= 0)
			len = strnlen(data, precision);
  10087d:	31 c9                	xor    %ecx,%ecx
			if (!*format)
				format--;
			break;
		}

		if (precision >= 0)
  10087f:	83 fd ff             	cmp    $0xffffffff,%ebp
  100882:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  100889:	74 1f                	je     1008aa <console_vprintf+0x22b>
  10088b:	89 04 24             	mov    %eax,(%esp)
  10088e:	eb 01                	jmp    100891 <console_vprintf+0x212>
size_t
strnlen(const char *s, size_t maxlen)
{
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
		++n;
  100890:	41                   	inc    %ecx

size_t
strnlen(const char *s, size_t maxlen)
{
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
  100891:	39 e9                	cmp    %ebp,%ecx
  100893:	74 0a                	je     10089f <console_vprintf+0x220>
  100895:	8b 44 24 04          	mov    0x4(%esp),%eax
  100899:	80 3c 08 00          	cmpb   $0x0,(%eax,%ecx,1)
  10089d:	75 f1                	jne    100890 <console_vprintf+0x211>
  10089f:	8b 04 24             	mov    (%esp),%eax
				format--;
			break;
		}

		if (precision >= 0)
			len = strnlen(data, precision);
  1008a2:	89 0c 24             	mov    %ecx,(%esp)
  1008a5:	eb 1f                	jmp    1008c6 <console_vprintf+0x247>
size_t
strlen(const char *s)
{
	size_t n;
	for (n = 0; *s != '\0'; ++s)
		++n;
  1008a7:	42                   	inc    %edx
  1008a8:	eb 09                	jmp    1008b3 <console_vprintf+0x234>
  1008aa:	89 d1                	mov    %edx,%ecx
  1008ac:	8b 14 24             	mov    (%esp),%edx
  1008af:	89 44 24 08          	mov    %eax,0x8(%esp)

size_t
strlen(const char *s)
{
	size_t n;
	for (n = 0; *s != '\0'; ++s)
  1008b3:	8b 44 24 04          	mov    0x4(%esp),%eax
  1008b7:	80 3c 10 00          	cmpb   $0x0,(%eax,%edx,1)
  1008bb:	75 ea                	jne    1008a7 <console_vprintf+0x228>
  1008bd:	8b 44 24 08          	mov    0x8(%esp),%eax
  1008c1:	89 14 24             	mov    %edx,(%esp)
  1008c4:	89 ca                	mov    %ecx,%edx

		if (precision >= 0)
			len = strnlen(data, precision);
		else
			len = strlen(data);
		if (numeric && negative)
  1008c6:	85 c0                	test   %eax,%eax
  1008c8:	74 0c                	je     1008d6 <console_vprintf+0x257>
  1008ca:	84 d2                	test   %dl,%dl
  1008cc:	c7 44 24 08 2d 00 00 	movl   $0x2d,0x8(%esp)
  1008d3:	00 
  1008d4:	75 24                	jne    1008fa <console_vprintf+0x27b>
			negative = '-';
		else if (flags & FLAG_PLUSPOSITIVE)
  1008d6:	f6 44 24 14 10       	testb  $0x10,0x14(%esp)
  1008db:	c7 44 24 08 2b 00 00 	movl   $0x2b,0x8(%esp)
  1008e2:	00 
  1008e3:	75 15                	jne    1008fa <console_vprintf+0x27b>
			negative = '+';
		else if (flags & FLAG_SPACEPOSITIVE)
  1008e5:	8b 44 24 14          	mov    0x14(%esp),%eax
  1008e9:	83 e0 08             	and    $0x8,%eax
  1008ec:	83 f8 01             	cmp    $0x1,%eax
  1008ef:	19 c9                	sbb    %ecx,%ecx
  1008f1:	f7 d1                	not    %ecx
  1008f3:	83 e1 20             	and    $0x20,%ecx
  1008f6:	89 4c 24 08          	mov    %ecx,0x8(%esp)
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
  1008fa:	3b 2c 24             	cmp    (%esp),%ebp
  1008fd:	7e 0d                	jle    10090c <console_vprintf+0x28d>
  1008ff:	84 d2                	test   %dl,%dl
  100901:	74 40                	je     100943 <console_vprintf+0x2c4>
			zeros = precision - len;
  100903:	2b 2c 24             	sub    (%esp),%ebp
  100906:	89 6c 24 10          	mov    %ebp,0x10(%esp)
  10090a:	eb 3f                	jmp    10094b <console_vprintf+0x2cc>
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  10090c:	84 d2                	test   %dl,%dl
  10090e:	74 33                	je     100943 <console_vprintf+0x2c4>
  100910:	8b 44 24 14          	mov    0x14(%esp),%eax
  100914:	83 e0 06             	and    $0x6,%eax
  100917:	83 f8 02             	cmp    $0x2,%eax
  10091a:	75 27                	jne    100943 <console_vprintf+0x2c4>
  10091c:	45                   	inc    %ebp
  10091d:	75 24                	jne    100943 <console_vprintf+0x2c4>
			 && numeric && precision < 0
			 && len + !!negative < width)
  10091f:	31 c0                	xor    %eax,%eax
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
			zeros = precision - len;
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  100921:	8b 0c 24             	mov    (%esp),%ecx
			 && numeric && precision < 0
			 && len + !!negative < width)
  100924:	83 7c 24 08 00       	cmpl   $0x0,0x8(%esp)
  100929:	0f 95 c0             	setne  %al
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
			zeros = precision - len;
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  10092c:	8d 14 08             	lea    (%eax,%ecx,1),%edx
  10092f:	3b 54 24 0c          	cmp    0xc(%esp),%edx
  100933:	7d 0e                	jge    100943 <console_vprintf+0x2c4>
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
  100935:	8b 54 24 0c          	mov    0xc(%esp),%edx
  100939:	29 ca                	sub    %ecx,%edx
  10093b:	29 c2                	sub    %eax,%edx
  10093d:	89 54 24 10          	mov    %edx,0x10(%esp)
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
			zeros = precision - len;
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  100941:	eb 08                	jmp    10094b <console_vprintf+0x2cc>
  100943:	c7 44 24 10 00 00 00 	movl   $0x0,0x10(%esp)
  10094a:	00 
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
  10094b:	8b 6c 24 0c          	mov    0xc(%esp),%ebp
  10094f:	31 c0                	xor    %eax,%eax
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  100951:	8b 4c 24 14          	mov    0x14(%esp),%ecx
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
  100955:	2b 2c 24             	sub    (%esp),%ebp
  100958:	83 7c 24 08 00       	cmpl   $0x0,0x8(%esp)
  10095d:	0f 95 c0             	setne  %al
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  100960:	83 e1 04             	and    $0x4,%ecx
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
  100963:	29 c5                	sub    %eax,%ebp
  100965:	89 f0                	mov    %esi,%eax
  100967:	2b 6c 24 10          	sub    0x10(%esp),%ebp
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  10096b:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  10096f:	eb 0f                	jmp    100980 <console_vprintf+0x301>
			cursor = console_putc(cursor, ' ', color);
  100971:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100975:	ba 20 00 00 00       	mov    $0x20,%edx
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  10097a:	4d                   	dec    %ebp
			cursor = console_putc(cursor, ' ', color);
  10097b:	e8 83 fc ff ff       	call   100603 <console_putc>
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  100980:	85 ed                	test   %ebp,%ebp
  100982:	7e 07                	jle    10098b <console_vprintf+0x30c>
  100984:	83 7c 24 0c 00       	cmpl   $0x0,0xc(%esp)
  100989:	74 e6                	je     100971 <console_vprintf+0x2f2>
			cursor = console_putc(cursor, ' ', color);
		if (negative)
  10098b:	83 7c 24 08 00       	cmpl   $0x0,0x8(%esp)
  100990:	89 c6                	mov    %eax,%esi
  100992:	74 23                	je     1009b7 <console_vprintf+0x338>
			cursor = console_putc(cursor, negative, color);
  100994:	0f b6 54 24 08       	movzbl 0x8(%esp),%edx
  100999:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  10099d:	e8 61 fc ff ff       	call   100603 <console_putc>
  1009a2:	89 c6                	mov    %eax,%esi
  1009a4:	eb 11                	jmp    1009b7 <console_vprintf+0x338>
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
  1009a6:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  1009aa:	ba 30 00 00 00       	mov    $0x30,%edx
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
  1009af:	4e                   	dec    %esi
			cursor = console_putc(cursor, '0', color);
  1009b0:	e8 4e fc ff ff       	call   100603 <console_putc>
  1009b5:	eb 06                	jmp    1009bd <console_vprintf+0x33e>
  1009b7:	89 f0                	mov    %esi,%eax
  1009b9:	8b 74 24 10          	mov    0x10(%esp),%esi
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
  1009bd:	85 f6                	test   %esi,%esi
  1009bf:	7f e5                	jg     1009a6 <console_vprintf+0x327>
  1009c1:	8b 34 24             	mov    (%esp),%esi
  1009c4:	eb 15                	jmp    1009db <console_vprintf+0x35c>
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
			cursor = console_putc(cursor, *data, color);
  1009c6:	8b 4c 24 04          	mov    0x4(%esp),%ecx
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
  1009ca:	4e                   	dec    %esi
			cursor = console_putc(cursor, *data, color);
  1009cb:	0f b6 11             	movzbl (%ecx),%edx
  1009ce:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  1009d2:	e8 2c fc ff ff       	call   100603 <console_putc>
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
  1009d7:	ff 44 24 04          	incl   0x4(%esp)
  1009db:	85 f6                	test   %esi,%esi
  1009dd:	7f e7                	jg     1009c6 <console_vprintf+0x347>
  1009df:	eb 0f                	jmp    1009f0 <console_vprintf+0x371>
			cursor = console_putc(cursor, *data, color);
		for (; width > 0; --width)
			cursor = console_putc(cursor, ' ', color);
  1009e1:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  1009e5:	ba 20 00 00 00       	mov    $0x20,%edx
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
			cursor = console_putc(cursor, *data, color);
		for (; width > 0; --width)
  1009ea:	4d                   	dec    %ebp
			cursor = console_putc(cursor, ' ', color);
  1009eb:	e8 13 fc ff ff       	call   100603 <console_putc>
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
			cursor = console_putc(cursor, *data, color);
		for (; width > 0; --width)
  1009f0:	85 ed                	test   %ebp,%ebp
  1009f2:	7f ed                	jg     1009e1 <console_vprintf+0x362>
  1009f4:	89 c6                	mov    %eax,%esi
	int flags, width, zeros, precision, negative, numeric, len;
#define NUMBUFSIZ 20
	char numbuf[NUMBUFSIZ];
	char *data;

	for (; *format; ++format) {
  1009f6:	47                   	inc    %edi
  1009f7:	8a 17                	mov    (%edi),%dl
  1009f9:	84 d2                	test   %dl,%dl
  1009fb:	0f 85 96 fc ff ff    	jne    100697 <console_vprintf+0x18>
			cursor = console_putc(cursor, ' ', color);
	done: ;
	}

	return cursor;
}
  100a01:	83 c4 38             	add    $0x38,%esp
  100a04:	89 f0                	mov    %esi,%eax
  100a06:	5b                   	pop    %ebx
  100a07:	5e                   	pop    %esi
  100a08:	5f                   	pop    %edi
  100a09:	5d                   	pop    %ebp
  100a0a:	c3                   	ret    
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
				++flagc;
			if (*flagc == '\0')
				break;
			flags |= (1 << (flagc - flag_chars));
  100a0b:	81 e9 84 0a 10 00    	sub    $0x100a84,%ecx
  100a11:	b8 01 00 00 00       	mov    $0x1,%eax
  100a16:	d3 e0                	shl    %cl,%eax
			continue;
		}

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
  100a18:	47                   	inc    %edi
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
				++flagc;
			if (*flagc == '\0')
				break;
			flags |= (1 << (flagc - flag_chars));
  100a19:	09 44 24 14          	or     %eax,0x14(%esp)
  100a1d:	e9 aa fc ff ff       	jmp    1006cc <console_vprintf+0x4d>

00100a22 <console_printf>:
uint16_t *
console_printf(uint16_t *cursor, int color, const char *format, ...)
{
	va_list val;
	va_start(val, format);
	cursor = console_vprintf(cursor, color, format, val);
  100a22:	8d 44 24 10          	lea    0x10(%esp),%eax
  100a26:	50                   	push   %eax
  100a27:	ff 74 24 10          	pushl  0x10(%esp)
  100a2b:	ff 74 24 10          	pushl  0x10(%esp)
  100a2f:	ff 74 24 10          	pushl  0x10(%esp)
  100a33:	e8 47 fc ff ff       	call   10067f <console_vprintf>
  100a38:	83 c4 10             	add    $0x10,%esp
	va_end(val);
	return cursor;
}
  100a3b:	c3                   	ret    
