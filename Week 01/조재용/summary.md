# What is OS?

---

> “Interface”
> 

# History of OS

---

## Serial processing

<aside>
👉

</aside>

## (Single) Batch processing (batch uniprogramming)

<aside>
👉

- maximize CPU utilization

</aside>

## Multiprogramming batch processing

<aside>
👉

- maximize CPU utilization
    
    
- buffering & interrupt handling
- memory relocation & memory protection
- concurrent programming
- asynchronous I/O
- base/bound registers
</aside>

## Time-sharing processing

<aside>
👉

- round-robbin
- minimize response time
</aside>

# Three main features of OS

---

## Virtualization

<aside>
👉

- CPU (Scheduling, Process ...)
- Memory (Paging, Address Translation …)
</aside>

## Concurrency

<aside>
👉

- Threads, Locks, Semaphores, Deadlocks
- threads, global variables → Why? How to resolve?
</aside>

## Persistence

<aside>
👉

- 사전적 의미
    - 곤경과 반대에도 불구하고 굳게 또는 완고하게 행 동 방침을 유지
- 왜 필요한가
    - 디스크 고장이나 전원이 꺼지는 상황에도 불구하고, 정보를 그대로 유지해야 하기 때문에
- 어떻게 Persistence를 지키는가
    - 아직 안배움… 뭐.. Tree구조?
- File system, I/O Devices, Journaling …
- volatile → How to store data persistently?

</aside>
