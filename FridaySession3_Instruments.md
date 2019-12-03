<br>
<br>
<br>

# iOS With Stanford

<br>

## Friday Session 3

- **Instruments**
  
  - Activity Monitor
  - Time Profiler
  - Allocations
  - Leaks
  - ...

<br>
<br>

## 과거의 프로파일 방법

- **과거에는 복잡한 OS issue문제 에 대한 확인 및 대답이 어려웠음**
  - **메모리누수가 있는지** 어떻게 확인하고 싶음
  - **얼마나 오랫동안 CPU를 사용하는지, 과부하가 있는지 등...** 확인하고 싶음
  - 이런 것들을 찾기 위해서는 많은 코드를 분석하고 찾아봐야 했음
- **이런 문제에 대한 해결 책, 인스트루먼츠 (Instruments)**

<br>
<br>

## 인스트루먼츠

- **instruments**
- **인스트루먼츠에서는 프로파일 할 템플릿을 입맛따라 선택할 수 있음**
  - **ActivityMonitor, TimeProfiler, Allocations, Leaks 등 다양한 Instruments 기능 제공**
  - **이번 세션에서는 4가지의 인스트루먼츠를 사용**합니다.
    - **ActivityMonitor**
    - **TimeProfiler**
    - **Allocations**
    - **Leaks**
- **인스트루먼츠는 문제가 있을때만 가끔 사용할만한 선택적인 것이 아님**
  - 굉장히 중요한 요소
  - **앱을 제대로만들었다고 생각하도라도 앱 출시 전 메모리를 효율적으로 사용하는데 CPU에 과부하는 없는지, 메모리 누수는 없는지 등을 체크하는 것은 중요한 요소**이다.

<br>

### 프로파일

- **Xcode 상단바 Product -> Profile or Command+i 를 하면 현재 프로젝트를 빌드하기 시작**한다.
  - **이후 인스트루먼츠를 선택할 수 있는 창이 나타난다.**

<br>
<br>

## 인스트루먼츠 종류

<br>

### Activity Monitor

<img width="600" alt="ActivityMonitor" src="https://user-images.githubusercontent.com/4410021/69972244-9c373c80-1564-11ea-9349-f0daefbe752f.png">

- **CPU 메모리 디스크를 확인**하거나 **프로세스와 파일 시스템의 네트워크 사용 통계를 보여주는 Instrument**
  - 시스템 상 일어나는 일반적인 통계를 보여줌
- **자세한 정보가 아닌 High Level의 정보를 제공하는 Instrument**
  - **보다 자세한 정보를 위해서는 다른 Instrument를 사용할 필요**가 있음
- **특정 상황에서 해당 앱이 몇개의 스레드로 동작중인지, 얼마나 많은 CPU를 먹고 있는지 등을 GUI와 수치값을 통해 확인**할 수 있음
  - **특정 프로젝트에 대해서만 보고 싶다면 좌측 하단의 검색창에 해당 프로젝트 키워드를 넣고 검색**하면 된다.

<br>
<br>

### Time Profiler

<img width="600" alt="TimeProfiller" src="https://user-images.githubusercontent.com/4410021/69972312-bb35ce80-1564-11ea-89a6-0a1a2b3ea30a.png">
<br>
<img width="600" alt="TimeProfiller2" src="https://user-images.githubusercontent.com/4410021/69972318-bcff9200-1564-11ea-80ec-89d331f6f40e.png">

- **Time Profiler는 실행시간 동안의 CPU, 메인스레드/백그라운드 사용량**을 보여준다. 
- **어떤 코드에서 많은 실행시간, CPU시간을 차지하는지 알 수 있어 유용**하다.
- **하단에서는 앱 진행에 따른 호출기록, 호출스택**을 보여준다.
  - **호출 기록을 더블 클릭하면 해당 호출기록에 대한 코드를 확인** 할 수 있다.
    - **코드 내에서의 행 별 차지하는 실행시간 비중도 체크 가능**하다. 
    - 이를 통해 어떤 코드가 많은 실행시간 비중을 차지하는지 볼 수 있다.
  - **우리 앱에 대한 호출기록만을 보고 싶다면 하단의 Call Tree -> Hide System Libraries를 체크하면 시스템 라이브러리를 숨기고 앱에 대한 내용만 확인가능** 하다.
- **소요가 큰 작업을 메인스레드에서 동작시키면 CPU Usage, Main Thread 칸의 그래프가 치솟는것을 확인**할 수 있다. 

<br>
<br>

### Allocations

<img width="600" alt="Allocations" src="https://user-images.githubusercontent.com/4410021/69972418-ef10f400-1564-11ea-9e13-f96d349220bd.png">

- **프로그램 안에서 실행 시간 동안 얼마나 시간에 따라 얼마나 많은 메모리가 할당되며 동작하는지를 보여주는 instruments**
- **작업을 종료했는데도 메모리 할당 그래프가 내려오지 않으면 무언가 문제가 있음을 의미**한다.
  - **메모리가 할당 후 제대로 해제되지 않는 것을 보고 메모리가 효율적으로 할당되지 않는 경우를 발견**할 수 있다.

<br>
<br>

### Leaks

<img width="600" alt="Leaks" src="https://user-images.githubusercontent.com/4410021/69972471-0354f100-1565-11ea-97bc-dee6772ba22e.png">

- **메모리 누수를 파악하고 수정하도록 해주는 Instruments**
- **Leak Checks 를 통해 메모리 누수가 있는지의 상태를 확인할 수 있다.**
  - **그래프 부분의 초록색 체크 표시는 메모리 누수가 발견되지 않은 상태 임을 표시**한다.
  - **빨강 바탕의 X 표시는 메모리 누수가 발견됨을 의미**한다.
    - **메모리 누수 표시를 갖다 대면 세부적인 메모리 누수 정보를 확인** 할 수 있다.
    - **메모리 누수 갯수, 위치 등 확인가능**
  - **하단 창의 Cycles & Roots 옵션을 통해 메모리 순환문제의 도식을 확인** 할 수 있다.
- **메모리 순환 문제를 해결하는 방법?**
  - 메모리 순환 발생여지가 있는 변수를 nil로 만들어주어 참조카운트를 0으로 만들어준다.
    - **하지만 매번 클래스와 힙 할당을 하는 곳에 이러한 처리를 하는 것은 비효율적**이다.
  - **클로져 내 [weak self], [unowned self]를 사용한 순환참조 문제 사전 차단**
    - **객체 할당 시 RC를 증가시키지 않으면서 참조할때 nil일 경우 실행을 안하거나(weak), 앱크래시를 일으키는 방식(unowned)으로 순환참조문제를 해결**할 수 있다.
  - **꼭 RC(Reference Counting)가 필요 없는 경우, 꼭 클래스로 만들 필요가 없는 경우에는 클래스 대신 구조체로 지정하여 사용하면 순환참조 문제를 해결** 할 수 있다. 
    - **구조체는 주소참조타입이 아니며, RC로 관리되지 않는 값참조 타입이기때문에 메모리 할당 누수문제가 발생하지 않는다.**

<br>
<br>

### 그 외 다양한 Instruments

- **이 외에도 Core Animation 등 다양한 상황에서 사용할 수 있는 Instruments들이 존재**한다.

<br>
<br>

## 총 정리

- **Instruments**

  - **앱 실행 간 발생할 수 있는 문제를 체크하고 Profiling해주는 도구**

- **Instruments 종류**

  - **Activity Monitor**
    - **앱이 얼마나 많은 스레드와 CPU를 먹고 있는지 등 High Level 정보 제공**

  - **Leaks**
    - **앱 실행 간 메모리 누수문제를 발견하는데 사용**
  - **Allocations**
    - **앱 실행 간 메모리 할당 상태를 확인 가능**
  - **Time Profiler**
    - **앱 실행 간 메인스레드, 백그라운드 스레드 등의 CPU 사용량 확인 가능**
  - And so on...

<br><br>
