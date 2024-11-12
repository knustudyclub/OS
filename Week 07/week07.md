# 9. Proportional Share Scheduling

## Introduction

- Proportional-share Scheduling
    - == Fair-share Scheduling
    - Each user is assigned a share of the processor ⇒ 각 사용자에게 프로세서의 공유가 할당됨 (??)
    - job들이 CPU 권한을 확보하도록 보장
        - fair share 보다 많은 usage ⇒ give fewer resources
        - fair share 보다 적은 usage ⇒ give more resources
        - TAT, response time 에 최적화 x
- Lottery Scheduling
- Stride Scheduling

## Tickets

- Tickets
    - The percent of tickets: cpu 권한을 받을 수 있는 확률
    - The more tickets, the more chances to win ← (win == cpu 권한을 얻는 것)
    - 우선순위가 높은 process에 많은 tickets, ticket을 못 받는 process가 없도록 함
        - ⇒ ticket을 활용한 fairness 보장의 기본 idea

## Lottery Scheduling

1. 우선순위 높 ⇒ ticket 많이
2. 우선순위 낮 ⇒ ticket 적게
3. 최소한 1개 이상은 갖게
4. **Random selection** of ticket from the set of all tickets competing for a resource
    - CPU 권한 선정: ready queue에 있는 process들 중 그 다음에 어떤 것을 수행할지는, ticket을 random하게 뽑아서 선정
        - ⇒ probabilistically fair
5. The expected allocation of resources to **client** is proportional to the number of tickets that they hold. ← 여기서  client가 의미하는게 뭘까용
6. 실제 할당된 비율은 예상 비율과 정확히 일치하지 않을 수 있다.

- 확률적으로 fair ⇒ 시행횟수가 많으면, 확률적으로 보장된다. (절대적 보장 x)

## Ticket Mechanisms

1. Ticket Currency(통화)
    1. 각 user가 자신만의  tickets가 있음. 이를 currency로 사용
    2. user는 원하는 currency로 자신의 job에 ticket을 할당. 
        1. base currency와 환율(exchange rate)가 설정
    3. Scheduler가 자동으로 local currency를 global value로 변환하여 ticket 값을 기준으로 공정한 resource 분배
2. Ticket Transfer : Ticket을  아예 넘겨줄 수도 있다
    1. A process can hand off its tickets to another process
    2. process가 blocked된 경우, 다른 process에 ticket을 넘기는 것이 client- server setting에 유용하다.
    3. client-server setting 에서는 server 가 client 의 ticket을 받아 CPU time을 늘릴 수 있음
        
        ⇒ client를 대신하여 작업하는 동안 성능이 향상됨
        
3. Ticket Inflation / Deflation
    1. process가 소유한 ticket 수를 일시적으로 늘리거나 줄일 수 있음
    2. 특정 process가 더 많은 CPU time이 필요할 때, ticket을 일시적으로 증가시킬 수 있어서 유용
    3. 신뢰할 수 있는 process group에서 유용하게 사용할 수 있음, greedy process가 과도한 ticket을 할당하여 악용할 가능성도 있음.

## Key Mechanism of Lottery Scheduling

- One Straightforward way : Simple list-based Lottery
    - Step 1 : Pick a random number as a winning ticket
        - From 0 to number of total tickets - 1
    - Step 2 : Search a list of jobs to find out the job holding that ticket
    - Make the list of processes in descending order to reduce number of iteration
        
        ⇒ 검색 효율 🆙
        

![image.png](https://prod-files-secure.s3.us-west-2.amazonaws.com/93783ba1-b7bb-4a3a-a304-641290b223bc/421d14f9-cde1-487b-ae81-a2c3453f2188/image.png)

## Fairness

- U : unfairness metric
    - U = First job complete time / Second job complete time
    - U will be close to 1 when both jobs finish at nearly the same time
        - When U becomes 1, the scheduler archieves perfectly fairness(모든 process가 거의 동시에 완료)
- Round Robin: U의 값이 1에 가까워짐 ⇒ 모든 Process가 동일한 확률로 순서에 따라 접근 ⇒ Fair함
- Fairness study
    - When the jobs run for a short time, the lottery scheduler provides low fairness
    - When the jobs run for a long time, the lottery scheduler achieves high fairness
    - length가 길면 수행 횟수가 많다(여러번 수행)
    - 수행 횟수가 짧으면 fairness가 보장 x

## Dark Side of Lottery Scheduling

- Strengths
    - Simple
    - Easily Understood
    - Support for dynamic operations
        - 시간에 따라 job의 개수, 종류가 바뀌어도 전체 system이 갖고 있는 ticket의 개수를 유지, 할당하면 되기 때문
- Weakness
    - Probabilistic guarantees ⇒ 실제 fairness를 determinisic하게 보장 x
    - Poor short-term accuaracy
    - High response time variability
