## Summary of Exception

![image.png](../image/1.png)

<Asynchronous>

- Interrupt
    - Caused by events external to the processor (e.g I/O device)
    - Unpredictable
    - Handler returns to next Instruction

<Synchronous>

Caused by events that occur as a result of executing an instruction, and triggered by the cpu itself.

- Traps
    - Intentional
    - ex) system calls (scanf, printf, fork, fp..etc)
    - rerturns control to next Instruction
- Faults
    - Unintentional
    - ex) page faults(recoverable) ← 사용자가 필요로 하는 data가 아직 memory에 없을 때
        - page faults 유의할 점: 동일한 memory layout 상황에서 반복이 될 때를 말하는 것. 이 문제가 생겼던 상황이 그대로 setting되어있는 상태에서 동일한 문제가 발생하므로 synchronous (asynchronous 아님)
    - re-executes faulting “current” instruction or aborts (might return to current instruction) ← 다시 수행해서 완료해야!
- Aborts ← 답이 없다!
    - Unintentional and Unrecoverable
    - Aborts(중단) current program (never return)

## Handling Exception

![image.png](https://prod-files-secure.s3.us-west-2.amazonaws.com/93783ba1-b7bb-4a3a-a304-641290b223bc/70a60d28-7895-4973-a6a4-addd5db3558d/image.png)

<exception 처리>

- exception handling: exception이 발생했을 때, 그 exception의 solution이 data와 code의 형태로 os안에 저장되어 있다.
- 개별 exception에 관한 것들에 대한 모든 것에 numbering을 해놓음. (numbering 되어있지 않은 문제 → abort)
- 번호에 해당하는 exception이 발생하면, exception table로 이동.
- exception table에는 pointer가 있는데, 이때 pointer들은 해당 exception을 처리하기 위한 데이터와 코드가 있는 메모리 주소를 가리킴
- 메모리 주소로 이동해서 이 데이터와 코드를 cpu가 수행함. (이때 handler들은 os에 있음 → kernel mode)

![image.png](https://prod-files-secure.s3.us-west-2.amazonaws.com/93783ba1-b7bb-4a3a-a304-641290b223bc/5951f14c-1a63-4395-9fbd-4bcc1f2256fd/image.png)

- Interrupt → hardware에서 신호가 온다. 이때, device마다 numbering이 되어 있어, 어디서 왔는지 쉽게 알 수 있다.
- 예제에서 상황별 pc, psw 체크
- page fault exception인 경우 pc, psw 확인

## DMA

- Direct Memory Access, I/O 장치와 관련된 데이터 이동에 있어서, cpu의 관여 없이 I/O 장치와 memory 사이의 데이터 이동을 가능하게 하기 위해서 들어간 하드웨어
- **It allows the external I/O device to transfer data directly to/from memory without CPU involvement**
    
    **→ I/O를 overlapping할 수 있다.**
    

![image.png](https://prod-files-secure.s3.us-west-2.amazonaws.com/93783ba1-b7bb-4a3a-a304-641290b223bc/40e95bc7-3899-4d7c-b082-1107c086aeca/image.png)

![image.png](https://prod-files-secure.s3.us-west-2.amazonaws.com/93783ba1-b7bb-4a3a-a304-641290b223bc/fef24c74-3933-4e91-af3a-401a463d3acd/image.png)

- Block Diagram of DMA
    - control logic: Read, DMA Request, DMA Acknowledgement, Interrupt, Write
    - start address: 메모리주소
    - data register: 보통 I/O의 주소가 담김
    - word count
- Operation Mode
    - Transparent: DMA가 bus를 사용할 때는 cpu가 해당 bus를 사용하지 않을때만 가능하다(bus 우선권은 cpu)
    - Burst: I/O가 급함. bus를 정리해서 대량의 data를 메모리로 보내거나 가져와야함(bus 우선권은 DMA)
    - Cycle Steal: bus를 사이좋게 나눠씀. ex) clock cycle, 각 clock마다 한번은 cpu, 한번은 DMA,…

## Advantages of DMA

- Transferring the data without the involvement of the processor will speed up the read-write task
- DMA reduces the clock cycle requires to read or write a block of data.
- Implementing DMA also reduces the overhead of the processor

## Disadvantages of DMA

- 가격
- Cache Coherence problem can occur while using DMA controller.
    - DMA가 메모리에서 데이터를 I/O장치로 보내려고함. CPU가 연산을 해서 cache 메모리값이 바뀌어져 있음. 이때 cache 값에 있는 값을 보내야하는가? 아니면 지금 데이터를 보내야하는가? → DMA가 데이터를 옮길 때 최종 데이터인가 문제
        - CPU가 사용하는 데이터는 storage, memory, cache에 있음. (똑같은 데이터가 여러 군데, 기본적으로 다 같은 데이터여야 하는데, 일시적으로 다를 수 있음)

# Chapter 4 & 5 The Abstraction: Process

## CPU Virtualization

한정된 자원으로 사용자가(혹은 응용 프로그램이) 무한한 자원이 있는 것과 같은 illusion을 제공

single core → 실제  cpu가 1개이지만 사용자에게는 무한 개인 것처럼 → time sharing

![image.png](https://prod-files-secure.s3.us-west-2.amazonaws.com/93783ba1-b7bb-4a3a-a304-641290b223bc/ac683784-03ca-4f97-a5c8-1df0a715ef7b/image.png)

**#round-robin #time slice  #time-sharing**

os의 scheduling policies: CPU와 같은 자원을 여러 프로세스나 스레드에게 어떻게 할당할지를 결정하는 방법.

cf) scheduling algorithms 종류

![image.png](https://prod-files-secure.s3.us-west-2.amazonaws.com/93783ba1-b7bb-4a3a-a304-641290b223bc/1dbb927a-9a49-4eba-b391-8ff5c4bb44c5/image.png)

## How to Our Program Can Work on Processor

![image.png](https://prod-files-secure.s3.us-west-2.amazonaws.com/93783ba1-b7bb-4a3a-a304-641290b223bc/6d369006-e7b1-4354-a60f-f205622f1195/image.png)

![image.png](https://prod-files-secure.s3.us-west-2.amazonaws.com/93783ba1-b7bb-4a3a-a304-641290b223bc/e21f9b8d-817f-4291-987d-db10eb3a2b3f/image.png)

Code → Excutable Object File(실행 가능한 파일, Storage에 저장되어있음) 

→ Process(가상 memory)

## What Is “Process”?

Process vs Program

- Process
    - Instance of a running program
    - Reside in memory
    - **An active(or executing) entity**
        - process can have different states
            - 시간에 따라 서로 다른 상태를 가짐 ← 제한된 memory를 관리하기 위해
        - request/allocate/release system resources during execution
- Program
    - The sequence of “codes (instructions)” and “a set of data associated with that code” to be executed
    - an entity before submission for execution
    - Reside in disk → not ready to be run yet
    - **Passive entity**
        - It means the program cannot have different states
        - (state가 없는 고정된 entity)

### Process API(Application Program Interface)

- Create(): Create a new process to run(새로운 프로세스를 생성, 실행)
- Destroy(): Forcefully kill a process(실행 중인 프로세스를 강제 종료)
- Wait(): Wait for a process to stop running(특정 프로세스가 종료될 때까지
    
    기다림)
    
- Status(): Get status information about a process(프로세스의 현재 상태를 조회(실행 중, 대기 중, 종료됨 등))
- Misc Control(): Other controls possible such as suspending or resuming a process(기타 프로세스 제어, 일시 중단(suspend), 재개(resume) 등))

### Process Creation

- Load a program code into memory, into the address space of the process (Fetch)
    - Programs initially reside on dist in executable format
    - OS perform the loading process lazily
        - Loading pieces of code or data only as they are needed during program execution
- The Program’s run-time stack is allocated(Allocation)
    - Use the stack for local variables, function parameters, and return address, etc
    - Initalize the stack with arguments → argc and argv array of main() funcion
- The program’s heap is created(Allocation)
    - Used for explicitly requested dynamically allocated data
    - Program request such space by calling malloc() and free it by calling free()
- The OS do some other initialization tasks
    - Input/Output (I/O) setup
        - Each process by default has three open file descriptors
        - Standard input, output and error
- Start the program running at the entry point, namely main()
    - The OS transfers control of the CPU to the newly-created proces

## Process States

![image.png](https://prod-files-secure.s3.us-west-2.amazonaws.com/93783ba1-b7bb-4a3a-a304-641290b223bc/e052c0ae-46ec-49d0-b956-9995facad6d1/image.png)

|  | CPU에 대한 권한을 가지고 있는가? | 해당 Process를 수행하기 위해 필요한 자원을 다 가지고 있는가? |
| --- | --- | --- |
| Running state | o | o |
| Ready state | x | o |
| Blocked state | x | x |

![image.png](https://prod-files-secure.s3.us-west-2.amazonaws.com/93783ba1-b7bb-4a3a-a304-641290b223bc/53cda40c-c317-4e63-84b7-7178879f3447/image.png)

- New (or created) state
    - process creation in Unix system by fork() system call
    - PCB(Process Control Block - 해당 process가 실행하기 위한 기본 정보) is allocated, “but a new process has not yet been loaded into main memory”
    - New process is being created: transient state ← **주된 상태 간 전환 도중 잠깐 동안 발생하는 상태, 완전한 정지, 대기, 또는 실행 상태로 확정되기 전의 순간적인 상태**
- Running states
    - There can be only one process that is “running state” at a time because we assume a single processor system
    - Own “processors” :  CPU 권한
    - Own “all resources” necessary: 수행에 필요한 모든 자원
    - Preemption
        - Transition from running state to ready state
        - Due to the expiration of time quantum(time slice) or apperance of higher priority process
    - Block/Wait/Sleep
        - Transition from running state to blocked(wait, asleep) state
        - Due to the resource request, such as waiting for I/O or system call completion, during execution (running)
- Ready state
    - The “ready state” process is ready to be executed
    - It owns all resources to be run **except processors**
- Blocked(Wait, Sleep) state
    - not ready to be executed
- Terminated state
    - It is removed from main memory and all queue
    - Its PCB is also deleted
- Zombie / Orphan state
