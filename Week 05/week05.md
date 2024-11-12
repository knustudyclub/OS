## 7- State Model

![OS_Ch4&5-22.jpg](https://prod-files-secure.s3.us-west-2.amazonaws.com/93783ba1-b7bb-4a3a-a304-641290b223bc/64358747-8cff-4b0f-9eb3-30f0c2f6d8c7/OS_Ch45-22.jpg)

- 기존 3, 5 state model 과의 큰 차이점은 suspend(ready, blocked) state이다.
- OS 기준 우선 순위 : Running > Ready > Blocked
- main memory 관리의 차원에서 우선 순위에 따라 하위 두 state를 disk를 내려보내고, 필요한 경우 다시 memory로 가져온다 → Swapping temporarily !!!
- Swapping 또한 I/O 이기 때문에 빈도와 성능이 반비례 하므로, 빈도를 줄이는 것이 좋다.

## PCB

: OS에서 관리하는 각 process의 신분증 !!!

![OS_Ch4&5-28.jpg](https://prod-files-secure.s3.us-west-2.amazonaws.com/93783ba1-b7bb-4a3a-a304-641290b223bc/238ac269-18ae-4815-ac5b-f1b1ac49c2bf/OS_Ch45-28.jpg)

- 하나의 PCB에서 갖고 있는 정보들은 위와 같다.
- process가 만들어지면 OS로부터 고유한 memory 영역(Kernel space)을 할당 받고, 여기에 PCB를 생성한다.
- time slice 값이 작아질수록 더 빈번히 running process를 교체해야 하므로 context switching 빈도도 많아져서 이에 따른 overhead가 발생한다.
- time slice VS context overhead → 상황에 따라 이 구도에서의 최적화가 필요함

# Process Scheduling

![OS_Ch7-7.jpg](https://prod-files-secure.s3.us-west-2.amazonaws.com/93783ba1-b7bb-4a3a-a304-641290b223bc/48078352-e32f-438f-a553-6da179cae328/OS_Ch7-7.jpg)

각 state queue마다 scheduling이 필요하지만 여기선 ready queue에서 어느 process를 running state으로 이동시킬지에 관한 scheduling을 다룬다. (Short-term)

scheduling 기법 선정 기준은 다음과 같다.

- User-oriented : 시간 기준 → TAT, Response time …
- System-oriented : 처리량 기준 → Throughput …
- 기타 등등 → Fairness, priority …

CPU utilization

Throughput

Turnaroundtime

Waiting time

Response time

Fairness

Impossible to optimize all of them simultaneously !! → 상황에 따라 최적 scheduling 선정 알고리즘 필요

## Terminiology For Scheduling

- Non preemtive scheduling : 다음 process를 실행시키기 위해선 현재 실행 중인 process가 다 끝나야 한다. (중간에 끊을 수 X) → context switch 적게 발생, 평균 response time 증가
- Preemptive scheduling : 다음 process를 실행시키기 위해서 현재 실행 중인 process를 중단시킬 수 있다. (중간에 끊을 수 O) → context switch 빈번, 공유 자원 접근 비용 발생
- I/O bound process : has many short CPU bursts (I/O 가 main)
- CPU bound process : mignt have a few long CPU bursts (CPU가 main)

## Scheduling

아래의 가정을 세워놓고 하나씩 지워가며 scheduling metric을 평가함으로써 상황에 따라 어느 기법이 최적인지 알아보자.

![스크린샷 2024-10-20 오후 11.25.01.png](https://prod-files-secure.s3.us-west-2.amazonaws.com/93783ba1-b7bb-4a3a-a304-641290b223bc/c2e9cd9e-3114-4390-a852-5b8435cb9934/%E1%84%89%E1%85%B3%E1%84%8F%E1%85%B3%E1%84%85%E1%85%B5%E1%86%AB%E1%84%89%E1%85%A3%E1%86%BA_2024-10-20_%E1%84%8B%E1%85%A9%E1%84%92%E1%85%AE_11.25.01.png)

## Turnaround time (TAT)

: job이 시작되어 최종 완료되는데까지 걸리는 시간

### FCFS( == FIFO) - First come, First served

: 먼저 도착하는 순서대로 Job을 실행한다.

- Relax assumption 1, and Convoy effect happens.
* Convoy effect ?
: Short process stuck behind long process (ex - 마트 계산대)

### SJF - Shortest Job First

: 짧은 Job들을 우선적으로 실행한다. (단, non-preemptive)

- Non-preemptive
- Relax assumption 2, and 뒤늦게 다른 job들이 도착했을 때 짧은 실행 시간을 가진 job들이 밀려서 Convoy effect 발생

 

### STCF - Shortest Time-to-Completion First

: 짧은 Job들을 우선적으로 실행한다. (단, preemptive)

- SJF에서 assumption 5를 relax한 기법
- 뒤늦게 다른 job들이 도착했을 때 현재 실행 중인 job의 남은 실행 시간과 다른 job들의 실행 시간을 비교하여 짧은 것부터 실행한다.
- Starvation for longer processes - 각 job마다 요구되는 processing time을 추정하기 어렵고, 추정치가 실제 running time과 많이 차이나게 되면 system은 그 job을 중단시킬 수도 있다.
* 수식 의미 설명 필요

## Response time

: job이 시작되어 첫 response가 오기까지 걸리는 시간 (메뉴 주문 ~ 첫 번째 메뉴 수령)

### RR scheduling ( == Time slice scheduling)

: time slice 만큼 job들을 나눠서 번갈아가며 수행

- Fair but, TAT 기준 성능치가 좋지 않음
- 기준에 따라 성능치가 달라지기 때문에 상황에 알맞은 metric을 사용해야한다.

# HDD

: 전자기 유도 현상을 이용하여 data read & write기능을 수행한다.

구성요소

- Platter(Surface) → Track들의 모임, 양면 이용
- Spindle (축)
- Track → Sector들의 모임
- Sector → data 최소 저장 단위
- Disk Arm
- Disk Head

![스크린샷 2024-10-21 오전 11.46.34.png](https://prod-files-secure.s3.us-west-2.amazonaws.com/93783ba1-b7bb-4a3a-a304-641290b223bc/0a0ddcbb-15dd-4cc9-bc67-df41e6f4aeaf/%E1%84%89%E1%85%B3%E1%84%8F%E1%85%B3%E1%84%85%E1%85%B5%E1%86%AB%E1%84%89%E1%85%A3%E1%86%BA_2024-10-21_%E1%84%8B%E1%85%A9%E1%84%8C%E1%85%A5%E1%86%AB_11.46.34.png)

data read & write 기능을 수행할 때, 특정 Platter의 K번째 Track부터 K+1, K+2 순으로 sequential하게 작성하는 것이 아니라, 여러 Platter의 K번째 Track에 동시에 작성한다.

## Disk Capacity (사실 이번 보강에서 가장 중요한 부분)

: 저장할 수 있는 최대 bits를 의미하며, 아래 3가지 요인에 의해 결정된다.

- Linear or Recording density → BPI (bits per inch of a track)
: 하나의 track 당 sector가 얼마나 많이 있는가
- Track density → TPI (tracks per inch)
: 하나의 Platter에서 track이 얼마나 많이 있는가
- Areal density → BPSI (bits per squared inch)
: 단위 면적 당 얼마나 많은 information이 저장될 수 있는지에 대한 개념으로서, BPI * TPI로 계산할 수 있다.

### Zoning

: track마다 sector수를 같게 분할하는 것이 아닌, 모든 sector의 크기가 같도록 한다. zoning을 하지 않으면 내부에 비해 외부 sector의 공간이 크기 때문에 비효율적이다. 

- 외부 zone들은 sectors per track이 많기 때문에 data transfer rate가 좋다.

### Capacity 
= (# bytes / sector ) 
* (avg. # sectors / track) 
* (# tracks / surface) 
* (# surfaces / platter ) 
* (# platters / disk)

### Disk Access

: Total Access Time = [avg.seek](http://avg.seek) time + avg.rotation time + avg.transfer time

1. Seek (arm을 움직여 track 탐색)
2. Rotate (platter를 회전시켜 sector 탐색)
3. Data transfer (read & write)

- [avg.seek](http://avg.seek) time = [max.seek](http://max.seek) time / 3
- avg.rotation time = (1 / 2) * (1 / RPMs) * (60sec / 1min)
- avg.transfer time = (1 / RPMs) * (60sec / 1min) * (1 / avg. # of sectors per tracks)

<aside>

**Access time dominated by seek time & rotational latency**

</aside>

|  | **Sequential read** | **Random read** |
| --- | --- | --- |
| bottleneck | transfer time | seek time + rotation latency |
|  | 순차적으로 읽으면 seek, rotate하는 시간이 0에 수렴 | 매번 위치를 찾아야함 |
