# Buddy Buddy
> ㅇㅇㅇㅇ
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
- 세로모드/라이트 모드 지원
- 다국어(영어/한국어) 지원

<br/>

## 프로젝트 구조
#### Clean Architecture
![Clean Architecture](Documents/BuddyCleanArchitecture.png)
// 설명
#### Coordinator Pattern
![Coordinator Pattern](Documents/BuddyCoordinator.png)

#### DIContainer


## 핵심 기술 구현 사항

  - ### Socket 통신
    - Alamofire의 RequestIntercepter 프로토콜을 채택하여 adapt, retry 로직 구현 
    - Access Token 만료 시 retry함수를 거쳐 새로운 엑세스 토큰 발급
    - Refresh Token 만료 시 로그인 화면으로 이동
  
  <br>

  - ### 폴링 방식을 활용한 실시간 메세지 수신
    - Alamofire의 RequestIntercepter 프로토콜을 채택하여 adapt, retry 로직 구현 
    - Access Token 만료 시 retry함수를 거쳐 새로운 엑세스 토큰 발급
    - Refresh Token 만료 시 로그인 화면으로 이동

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
    - Alamofire의 RequestIntercepter 프로토콜을 채택하여 adapt, retry 로직 구현 
    - Access Token 만료 시 retry함수를 거쳐 새로운 엑세스 토큰 발급
    - Refresh Token 만료 시 로그인 화면으로 이동

  <br>

## 트러블슈팅
- DMList 호출 시간
- NSCache -> 메모리 캐시 (용량 -> 앱마다 캐싱 전략⭐️ 확립!)


## 회고
- DIContainer register 기준
- Coordinator


- 소켓 끊겼을 때 처리 + 재연결 시점 + 핑퐁 + 소켓 
- (다운 샘플링 찾아보기💥)
