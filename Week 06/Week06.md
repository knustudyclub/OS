## Multi-Level Feedback Queue(MLFQ)

- 등장배경: job의 runtime을 예측하는 과정에서 history기반으로 예측하는 방법은 resource를 많이쓰기 때문에 이를 해결하고자 하는 scheduling방식 (더 효율적인 history 기반 scheduling임)
- 특징: 여러개의 ready queue를 사용함
- 단점: 구현이 복잡함 (= 정해야 하는 값들이 많고,

### Rule

1. If Priority(A) > Priority(B), A runs (B doesn’t) → A가 B보다 우선순위가 높다면 A만 실행한다.
2. If Priority(A) = Priority(B), A & B run in RR → A,B의 우선순위가 같다면 Round Robin방식으로 실행한다.
3. When a job enters the system, it is placed at the highest priority. → job이 처음 들어오면 가장 높은 우선순위를 준다.
4. Once a job uses up its time allotment at a given level, its priority is reduced. → job이 time slice를 다 쓰면 우선순위가 낮아진다.
5. After some time period S(voo-doo constants), move all the jobs in the system to the topmost queue. → voo-doo constants 시간 마다 모든 job을 최고 우선순위로 올린다.

### Priority Boost

- voo-doo constants 시간 마다 모든 job을 최고 우선순위로 올리는 것
- starvation 해결, job의 행동이 변해도(CPU bound → I/O bound) 낮은 우선순위에 머무는 문제 해결
- voo-doo constants는 어떻게 정해야 할까?
    - 높은 voo-doo constants → starvation이 일어남
    - 낮은 voo-doo constants → interactive job들이 적절한 CPU권한을 갖지 못할 수 있음

### Implementation

- Time Slice
    - high-priority queues(I/O bound job들이 많을거임) → short time slices
    - low-priority queues(CPU bound job들이 많을거임) → longer time slices
