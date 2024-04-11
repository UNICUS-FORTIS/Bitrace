<p align="center">
<img width="95%" src="https://github.com/UNICUS-FORTIS/Bitrace/assets/110699030/01bd49db-2d8c-4c12-b6f5-8f6aa6302986"/>

# <p align="center"> Bitrace 〽️</p>
<p align="center">
  
<img width="30%" src="https://github.com/UNICUS-FORTIS/Bitrace/assets/110699030/fd34e3cf-8ce6-449a-9854-7d14120a8d7a"/>

#### <p align="center">Bitrace 는 업비트 API를 이용한 가상화폐의 실시간 시세 및 호가를 조회 할 수 있는 애플리캐이션입니다.<br></br></p>

<p>
<img width="19%" src="https://github.com/UNICUS-FORTIS/Bitrace/assets/110699030/9b7e2384-2943-421d-afee-408b98aa2eb3"/>
<img width="19%" src="https://github.com/UNICUS-FORTIS/Bitrace/assets/110699030/4f781df2-4cdf-466c-bf1e-d14b25249748"/>
<img width="19%" src="https://github.com/UNICUS-FORTIS/Bitrace/assets/110699030/d5faace4-c93c-4582-8ab2-0240e6c77634"/>
<img width="19%" src="https://github.com/UNICUS-FORTIS/Bitrace/assets/110699030/d5041eaf-000d-4fec-91f1-d9ed5b4ce881"/>
<img width="19%" src="https://github.com/UNICUS-FORTIS/Bitrace/assets/110699030/837c4fad-8e07-4562-aff9-a9ce34c3b279"/>
</p>

## 프로젝트 기간 🎀 
2024.03.16 ~ 2024.03.24

## 프로젝트 구분 🎀
1인 개발 프로젝트

## Deployment Target 🎀
iOS 17.0

## Main Features ✨
- 업비트에 상장되어있는 거래 가능한 마켓 리스트 조회
- 실시간 가격 변화 확인
- 실시간 매수 & 매도의 호가창 조회
- 1분, 5분, 10분, 30분, 60분 Candle 스냅샷 차트 조회
- 관심있는 마켓 북마크 기능
- 상장 마켓 내 국문, 영문 서치
- 북마크된 마켓 내 국문, 영문 서치

## Tech Stacks 🛠
- SwiftUI
- MVVM Architecture
- Combine
- Moya
- Realm Swift

## 주요 기술 🌖
- Combine 과 MVVM 아키텍처 적용으로 비동기 반응형 프로그래밍을 구현하였습니다.
- URLSessionWebSocketTask 를 사용하여 실시간 Socket 통신으로 실시간 암호화폐의 시세를 나타내도록 하였습니다.
- SwiftUI 의 **Charts** 프레임워크를 사용하여 사용하여 검색한 코인 마켓의 저가, 고가, 시가, 종가를 구현하고 시세의 상승과 하락에 따라 **실제 거래소**처럼 색상을 구분하였습니다.
- Chart 를 그릴 때 chartYScale(domain:) 모디파이어를 사용하여 차트 표현에 필요한 Y축의 가격 범위를 제한시켜 캔들의 가시성을 높였습니다.
- 호가창 구현시 GeometryReader 를 사용하여 호가창 박스의 너비를 한정하고 매도량과 매수량을 계산하는 로직을 구성해 실제 암호화폐 거래소의 호가창과 동일한 환경을 구현하였습니다.
- Searchable 을 사용하여 마켓 내 또는 북마크 내 암호화폐를 보다 간단히 검색 할 수 있도록 하였습니다.
- 메인화면에서 요청 당시에 반환되는 원화마켓의 BitCoin 시세의 스냅샷을 Refreshable 로 필요에 따라 새로고침하여 대장주의 가격변화를 읽을 수 있도록 구성하였습니다.
- Realm을 사용하여 관심있는 마켓을 북마크하고 메인화면에 생성되는 북마크 카드를 통해 쉽게 시세를 조해 할 수 있도록 구현하였습니다.
- Singleton Pattern 으로 전역상태를 관리 할 수 있도록 구현하였습니다.

## 개발시 고려 사항 💎
<br>

**1. 메인화면**
<br>
<p>
<img width="19%" src="https://github.com/UNICUS-FORTIS/Bitrace/assets/110699030/d5cc1a7f-1ec5-4370-9b6e-3eb1f9f6d36b"/>
<img width="19%" src="https://github.com/UNICUS-FORTIS/Bitrace/assets/110699030/b77c0b9c-c28e-4cc6-abc6-f021397f28c7"/>
<img width="19%" src="https://github.com/UNICUS-FORTIS/Bitrace/assets/110699030/ba0dfd24-76bc-4a63-b7d1-a04b58ef0fe1"/>
</p>

- @State 어트리뷰트를 사용해 두가지의 Boolean 타입의 변수를 만들어 아이콘이 터치 될 때 true 로 변경 될 경우 View 의 body 에서 조건문에 정의된 탐색 화면을 보여주도록 하였습니다.
- 상장된 마켓 정보를 리스팅 할 때 LazyVStack 을 사용하여 메모리를 보다 효율적으로 관리 할 수 있도록 구현하였습니다.

- 북마크된 마켓 정보를 Horizontal 방향의 스크롤뷰로 구현해 스냅샷으로 반환된 시세를 간단히 확인 할 수 있고 터치 하면 곧바로 해당 마켓의 디테일 화면으로 이동하도록 구현하였습니다.
- 북마크된 마켓이 하나도 없다면 섹션 타이틀만 남고 카드의 영역은 줄어들도록 하고 폴딩 기능을 구현하여 접어 둘 수 있도록 하였습니다.

<br>

**2. 마켓 시세 화면**
<br>

<p>
<img width="19%" src="https://github.com/UNICUS-FORTIS/Bitrace/assets/110699030/73664c72-d200-4e32-bc8e-d37a7327c3e8"/>
<img width="19%" src="https://github.com/UNICUS-FORTIS/Bitrace/assets/110699030/87930d4d-8acf-4d1e-813e-a6ec78a1a036"/>
<img width="19%" src="https://github.com/UNICUS-FORTIS/Bitrace/assets/110699030/51ada32c-f935-4b3c-b6f3-3b4a632c3c58"/>
<img width="19%" src="https://github.com/UNICUS-FORTIS/Bitrace/assets/110699030/9dd04e4f-4601-4a5f-b8e3-48ffe4679c4f"/>
<img width="19%" src="https://github.com/UNICUS-FORTIS/Bitrace/assets/110699030/d5faace4-c93c-4582-8ab2-0240e6c77634"/>
</p>

- Chart를 사용할 때 저가 고가를 나타내는 Rectangle 과 시가, 종가를 나타내는 Rectangle 의 너비를 다르게 하고 두 Rectangle 을 중첩시켜 실제 암호화폐 거래소의 캔들 차트를 구현했습니다.
- 다수의 캔들을 보여주기 위해 가로 스크롤이 가능하도록 하였습니다.
- 열거형을 통해 각 캔들의 분 단위를 구분하고 HStack 과 Vstack을 조합하여 Tab 기능을 구현하고 onTapGesture 를 통해 해당 캔들의 시간에 맞는 네트워크 통신을 시작하도록 구현했습니다.
- 마켓의 실시간 시세 이하의 블록을 ScrollView로 감싸서 호가를 확인 할 수 있고 호가 또한 매도와 매수를 Tab 으로 구분하여 선택적으로 확인 할 수 있도록 하였습니다.
- 네비게이션 영역의 BackButton의 Title 을 제거하기 위하여 @Environment 어트리뷰트를 사용해 Binding<PresentationMode> 타입의 변수를 선언하고 버튼을 커스텀하여 뒤로 갈 수 있는 기능을 구현하였습니다.
<br>

**3.북마크 검색 또는 상장 마켓 내 검색 화면**
<br>

<p>
<img width="19%" src="https://github.com/UNICUS-FORTIS/Bitrace/assets/110699030/a9d00e65-6291-4264-a45c-c38ed2967d52"/>
<img width="19%" src="https://github.com/UNICUS-FORTIS/Bitrace/assets/110699030/a2d9fa0c-ad67-4b9c-92ba-0ac3dbb990ea"/>
<img width="19%" src="https://github.com/UNICUS-FORTIS/Bitrace/assets/110699030/a0429f55-a977-4c3c-a628-406fc7387220"/>
</p>


- 영문, 국문 어느쪽으로도 검색 가능한 검색 로직을 생성하여 상장 마켓 내, 북마크 내 마켓 항목을 검색 할 수 있도록 구현하였습니다.
- searchable 의 isPresented 옵션과 메인화면에서 @State로 선언된 Boolean 변수를 바인딩하여 Cancel 버튼이 트리거 되었을 때 현재 검색 화면이 종료되고 이전화면이 등장하도록 구성하였습니다.
<br>

## 회고 & Future Action
- 암호화폐 트레이딩을 했던 경험이 있었기에 API의 레퍼런스를 빠르게 이해하고 SwiftUI 로 뷰를 구성하는데 적용 할 수 있었습니다.
- Chart 를 구현하는데 있어서 X 축과 Y축의 레이블을 커스터마이징하는데 많은 시간을 할애하면서 알게된 바 로는, 데이터 모델이 Hashable 또는 Identifiable 프로토콜을 채택 하더라도 Chart에 데이터가 그려 질 때
X축의 데이터가 동일 한 값을 가질 경우 같은 해당 데이터는 하나의 축으로 작성된다는것을 알았습니다. <br>
Bitrace앱은 Chart 의 X 축에 날짜와 시간을 'H:mm' 형식으로 포맷하여 표시하고 있습니다. 1시간 봉 차트에서 표시하는 기간이 24시간 이상 초과 할 때 하나의 차트뷰에서 동일한 시간대가 두 번 나타나게 되는데 그 두개의 시간은 하나의 X축 데이터로 합쳐지게 되어 동일한 시간에 두개의 데이터가 존재하게 되었습니다. 사실 이 문제 해결은 현재 진행중이고 데이터의 혼선을 막기 위해 캔들 요청 수를 24개로 제한 한 상태이며 해결해야할 과제가 되었습니다.
- 원화 비트코인 또는 대부분 BTC 마켓의 경우 예를들어 98,000,000 또는, 0.0000014 처럼 표시하는 숫자가 매우 크거나 매우 작습니다. 이런 경우 차트 Y축 데이터는 Chart에 의해 상황에 따라 지수표기법으로 바뀌는데 현재 해결중에 있습니다.
- SwiftUI에서 제공하는 어트리뷰트 키워드들을 사용해 리액티브 프로그래밍이 가능해지면서 네트워크통신쪽에만 Combine 을 사용해 보았습니다. 이 또한 Combine 을 많이 사용해보지 않았지만 그동안 RxSwift 를 사용했던 경험이 많은 도움이 되었습니다.
- 이전 프로젝트까지 작은 단위로 실행하던 커밋에서 가능한 한 Feature 와 Update 단위의 커밋으로 실행했습니다. 8일간의 프로젝트이지만 현재 메인 브랜치에서 일어난 전체적인 컨텍스트를 이해하기가 조금은 더 수월해졌습니다.<br>
또 아직 100% 해결되지 않은 사항들에 대해서는 다른 브랜치를 생성해 처리할 예정입니다.

