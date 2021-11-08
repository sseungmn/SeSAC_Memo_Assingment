## 최초 진입 화면
- [ ] 최초로 실행했을 경우를 판단
- [ ] walkthrough를 띄워주기

## UI 구성 & 기능 구현
* Storyboard UI, Autolayout
	- [x] Storyboard로 모든 개체 Positioning
	- [x] 🧹 Color Extension으로 사용할 색상만 등록
	- [x] 🧹 BackgroundColor같은 경우, AppDelegate에 초깃값 변경
* TableView
	- [x] Xib으로 Cell구성
	- [x] Xib과 VC연결, 등록
	- [ ] FixedMemo, Memo를 Section으로 구분
		* Fix가 없을 때, Fixed Section을 숨김처리
* 메모 Title
	* [ ] 메모 개수를 Title로 설정
	* [ ] 이거 navigation Large title??
	* [ ] 100개가 넘어갈 경우, 3자리마다 콤마
* Realm 연동
  - [x] realm 모델 생성
  - [x] table과 realm 모델 연동
* 메모 삭제
  - [ ] Swipe로 삭제
  - [ ] 삭제 되기 전에 삭제 여부 확인
* 메모 고정
  - [ ] Swfpe로 고정
  - [ ] Section으로 관리.
  - [ ] 최신순으로 정렬, 최대 5개까지 고정가능
  - [ ] `PIN` 개수 5개 이내로 유지, 아닐시 경고 Alert
* 메모 날짜 포멧
  - [x] 오늘 작성한 메모 -> 시간만 표시
  - [x] 이번주 작성한 메모 -> 요일만 표시
  - [x] 그 외 -> 모든 시간기록 표시
  - [x] 🧹 Extension을 활용해서 `toString()`메서드안에 케이스별 formatter 구현

## 검색 기능

## 작성 / 수정 화면

## 기능 녹화
* iPhone 8, iPhone 13 Pro Max로 녹화영상
* 최소 10개의 메모 등록 후 녹화, README.md에 첨부