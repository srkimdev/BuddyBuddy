# Buddy Buddy
// 앱 소개

## 개발 환경
```
- 개발 인원 : iOS 3명, BE 1명
- 개발 기간 : 2024.11.05 - 2024.12.09 (약 1달)
- Swift 5.10
- Xcode 15.3
- iOS 15.0+
- 세로모드/라이트 모드 지원
- 다국어(영어/한국어) 지원
```

## 기술스택

| 기술 | 버전 |
| -- | -- |
| UIKit | - |
| RxSwift | 6.8.0 |
| Alamofire | 5.10.1 |
| Nuke | 12.8.0 |
| Realm | 10.54.1 |
| SocketIO | 16.1.1 |

## 프로젝트 구조
#### Clean Architecture
![Clean Architecture](Documents/BuddyCleanArchitecture.png)
// 설명
#### Coordinator Pattern
![Coordinator Pattern](Documents/BuddyCoordinator.png)

#### DIContainer

## 핵심 기능
- (그룹, 개인) 채팅
- 소셜 로그인
- 유저, 채널 검색
- 유저 프로필 확인
- 플레이그라운드 및 채널 생성, 참여, 삭제, 수정, 관리자 권한 적용

## 주요 기술
- Socket 통신
- 폴링 방식을 활용한 실시간 수신
- 이미지 다운 샘플링, NSCache (불필요한 네트워크 횟수 줄이기)
- Network monitoring, 상태처리

## 트러블슈팅
- DMList 호출 시간
- NSCache -> 메모리 캐시 (용량 -> 앱마다 캐싱 전략⭐️ 확립!)


## 회고
- DIContainer register 기준
- Coordinator


- 소켓 끊겼을 때 처리 + 재연결 시점 + 핑퐁 + 소켓 
- (다운 샘플링 찾아보기💥)