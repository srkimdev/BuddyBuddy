# Buddy Buddy
> 외국인 친구들과 실시간 채팅을 통해 서로의 언어를 교환하며 배울 수 있는 앱
<br/>

## 스크린샷

<br>

## 프로젝트 환경
- 개발 인원:
  - iOS 3명, BE 1명
- 개발 기간:
  - 24.11.05 - 24.12.09 (약 1달)
- 개발 환경:
    
    | iOS version | <img src="https://img.shields.io/badge/iOS-15.0+-black?logo=apple"/> |
    |:-:|:-:|
    | Framework | UIKit |
    | Architecture | Clean Architecture + MVVM |
    | Reactive | RxSwift |
    | 다국어 | 한국어, 영어 |

<br/>

## 기술 스택 및 라이브러리
- UI: `SnapKit`, `RxDataSource`
- Network: `SocketIO`, `Alamofire`, `Nuke`
- Database: `Realm`

<br/>

## 핵심 기능

- 같은 플레이그라운드 내의 유저들과 채널 채팅, DM 기능
- 소셜 로그인 
- 채널, 유저 검색
- 유저 프로필 확인 및 DM
- 플레이그라운드 및 채널 생성, 참여, 삭제, 수정, 관리자 권한 적용

<br/>

## 프로젝트 구조
#### Clean Architecture
![Clean Architecture](Documents/BuddyCleanArchitecture.png)
// 설명
#### Coordinator Pattern
![Coordinator Pattern](Documents/BuddyCoordinator.png)

#### DIContainer
- usecase와 repository의 의존성 주입을 매번 해주는 번거로움을 줄이기 위해 DIContainer 도입
- 많이 사용되는 usecase와 repository 객체를 저장하고 필요 시 가져다 쓸 수 있도록 딕셔너리 형태로 구현

<br>

## 핵심 기술 구현 사항

  - ### Socket 통신
    - socketIO 라이브러리를 이용하여 SocketManager, SocketIOClient 객체를 생성하고 소켓통신을 위한 url 연결 및 핸들러 등록
    - 메세지가 올 때 마다 RxSwift의 PublishRelay를 이용하여 이벤트를 방출하고 Presentation영역에서 구독하여 사용
    - SceneDelegate에서 백그라운드/포어그라운드 진입을 감지하여 notification을 통해 이벤트를 전달하고 백그라운드 시 소켓 연결을 해제하고, 포어그라운드 시 소켓 연결을 재설정하도록 구현.
  
  <br>

  - ### 폴링 방식을 활용한 실시간 메세지 수신
    - 모든 채팅방에 대해 소켓통신을 열어놓아 메세지를 수신받는 것이 리소스 낭비라고 판단하여 폴링방식 도입
    - RxSwift의 interval 오퍼레이터를 이용하여 1초에 한번 씩 HTTP요청을 보내 채팅방 목록 업데이트

  <br>

  - ### 이미지 다운 샘플링
    - Alamofire의 RequestIntercepter 프로토콜을 채택하여 adapt, retry 로직 구현 
    - Access Token 만료 시 retry함수를 거쳐 새로운 엑세스 토큰 발급
    - Refresh Token 만료 시 로그인 화면으로 이동

  <br>

  - ### NS Cashe
    - Alamofire의 RequestIntercepter 프로토콜을 채택하여 adapt, retry 로직 구현 
    - Access Token 만료 시 retry함수를 거쳐 새로운 엑세스 토큰 발급
    - Refresh Token 만료 시 로그인 화면으로 이동

  <br>

  - ### Network monitoring, 상태코드 처리
    - 네트워크 통신이 끊겼을 때를 실시간으로 감시하여 끊길 시, 로딩화면을 띄어주어 사용자에게 알림 
    - 네트워크 통신이 끊길 시, 모든 채팅방의 소켓통신을 해제
    - 네트워크 통신 시 상태 코드를 기준으로 에러를 분기하여 문제 발생 지점을 파악할 수 있도록 구성

  <br>

## 트러블슈팅
### 1. DM 채팅방목록 로드가 각각 따로되고 시간이 오래걸리는 문제
- 상황
  - DM 채팅방 목록을 위해서는 DM 채팅방 목록 조회, 각 채팅방의 채팅 목록 조회, 안읽은 메세지 개수 조회 총 3개의 통신이 일어남
  - RxSwift의 interval 오퍼레이터를 사용하여 1초에 한번씩 트리거를 주어 3개의 통신을 계속 해주고 있음
  
- 원인 분석
  - 3개의 통신 중 어느하나라도 먼저 완료가 되면 다른 통신을 기다리지 않고 넘어가서 모든 데이터를 다 받아오지 못함
  - interval은 1초에 한번씩 이벤트를 방출하지만 처음 0초에는 방출하지 않아 1초 후에야 모든 통신이 시작됨

- 해결
  - Observable.zip을 사용하여 모든 통신이 다 끝났을 때 이벤트를 방출하여 구독할 수 있도록 구성
  - interval 오퍼레이터 사용 시 처음에도 이벤트를 발생할 수 있도록 concat을 사용하여 Observable.just(0)을 같이 결합 


<br>
- DMList 호출 시간
- NSCache -> 메모리 캐시 (용량 -> 앱마다 캐싱 전략⭐️ 확립!)


## 회고
- DIContainer register 기준
- Coordinator


- 소켓 끊겼을 때 처리 + 재연결 시점 + 핑퐁 + 소켓 
- (다운 샘플링 찾아보기💥)
