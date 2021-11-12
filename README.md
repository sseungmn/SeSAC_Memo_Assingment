## 최초 진입 화면
- [ ] 최초로 실행했을 경우를 판단
- [ ] walkthrough를 띄워주기

## UI 구성 & 기능 구현
* Storyboard UI, Autolayout
	- [x] Storyboard로 모든 개체 Positioning (21.11.08)
	- [x] 🧹 Color Extension으로 사용할 색상만 등록 (21.11.08)
	- [x] 🧹 BackgroundColor같은 경우, AppDelegate에 초깃값 변경 (21.11.08)
	    * 나중에 보니 BGColor을 변경할 필요가 없어서 지워주었다.
* TableView
	- [x] Xib으로 Cell구성 (21.11.08)
	- [x] Xib과 VC연결, 등록 (21.11.08)
	- [x] FixedMemo, Memo를 Section으로 구분 (21.11.09)
		* Fix가 없을 때, Fixed Section을 숨김처리 (21.11.09)
		* ![2021-11-09_03-07-37](/Users/sseungmn/Library/Containers/com.majimakHARU.GrabIt/Data/2021-11-09_03-07-37.png)
		* HeaderTitle이 왜 이렇게 leftInset이 들어가는지 모르겠음 (21.11.08)
	- [x] TableView.style == .insetGrouped일 때, header에서 indent가 발생 (21.11.09)
		* iOS 14.0 에서 버그 수정 완료. `UIListContentConfiguration`
		* iOS 13.0 에서는 그대로 놔둠
	- [x] Header height 예시와 맞게 조정 (55), Footer (0) (21.11.09)
	- [x] Content가 없을 때, "추가 텍스트 없음" 으로 표시 (21.11.12)
* NavigationBar
	- [x] NavigationBar에서 LargeTitle, searchBar 구현
		- [x] LargetTitle 적용
			* `largeTitleDisplayMode = .always`로 설정했으나, 초기화면에서는 적용이 되지 않았음. (21.11.09)
			* [iOS14 이후, 해결방법](https://stackoverflow.com/questions/64005273/ios14-navigationitem-largetitledisplaymode-always-not-work)
			* iOS14 이후에는 `sizeToFit()`을 사용하고, 이전에는 `.always`를 그대로 적용했다. (21.11.09)
		- [x] 메모 개수를 Title로 설정 (21.11.10)
		- [x] 100개가 넘어갈 경우, 3자리마다 콤마 (21.11.10)
			* 🧹Int extension에 구현 

* 메모 Title

* Realm 연동
  - [x] realm 모델 생성 (21.11.08)
  - [x] table과 realm 모델 연동 (21.11.08)
  - [x] 🧹 RealmQuery 파일에서 Realm에 대한 모든 처리가 이뤄지도록 분리함 (21.11.10)
* 메모 삭제
  - [x] Swipe로 삭제 (21.11.09)
  - [x] 삭제 되기 전에 삭제 여부 확인 (21.11.10)
* 메모 고정
  - [x] Swipe로 고정
  	* `leadingSwipeAcitonsConfigurationForRowAt` 프로토콜 메서드에서 `UISwipeActionConfiguration, UISwipeAcitonsConfiguration`를 활용해 구현. (21.11.10)
  	* 🧹List(fixed, unfixed)를 선택하는 메서드를 따로 구현해서 범용성을 높임( leading, trailing) (21.11.10)
  - [x] 최신순으로 정렬, 최대 5개까지 고정가능 (21.11.10)
  - [x] `PIN` 개수 5개 이내로 유지, 아닐시 경고 Alert (21.11.10)
  - [x] `PIN` Icon, 상태에 따라서 다르게 설정 (21.11.11)
* 메모 날짜 포멧
  - [x] 오늘 작성한 메모 -> 시간만 표시 (21.11.08)
  - [x] 이번주 작성한 메모 -> 요일만 표시 (21.11.08)
  - [x] 그 외 -> 모든 시간기록 표시 (21.11.08)
  - [x] 🧹 Extension을 활용해서 `toString()`메서드안에 케이스별 formatter 구현 (21.11.08)

## 검색 기능

- [x] 검색을 했을 때, 고정된 메모와 메모가 분류된 채로 결과가 나오게 구현 (21.11.11)
- [x] 검색한 키워드를 고정했을 때, 일반적인 고정하는 상황과 마찬가지로 동작하게 구현 (21.11.11)
- [x] 검색한 결과의 개수가 섹션마다 Header로 표시되도록 구현 (21.11.11)
- [x] 검색한 결과에 키워드를 하이라이트 (21.11.11)
	* 🧹 UILabel의 특정한 문자열을 하이라이트 해주는 Extesion (21.11.11)
	* 🕷 검색 후에, section 0 row 0의 title이 highlight되는 버그가 있다.
		- [x] isFiltering의 분기를 나누어서, 필터링중이 아닐 때에는 nohighlight처리를 하도록 수정. (21.11.11)
- [x] 스크롤을 하거나 검색버튼을 누르면 키보드가 내려감 (21.11.11)

## 작성 / 수정 화면
- [x] 진입 화면에 따라서, backbutton title이 다름 (21.11.12)
- [x] share, 완료버튼 생성 (21.11.12)
	* `naviagtionItem.rightBarButtonItems`에 추가.
	* 편집상태가 시작될 때, 추가되도록 수정 (21.11.12)
- [x] 전체 텍스트를 제목, 내용으로 나눠서 저장
	* 완료, 편집상태가 끝, 백버튼액션, 제스쳐로 이전화면 모두 popView로 하고 `viewWillDisappear()`일 때, 저장하도록 설정 (21.11.12)
	* `component(["\n"])`->`removeFirst()`로 제목을 추출
	* 나머지를 `reduce()`로 합침, 나눠진 목록마다 사이에 개행문자 삽입
- [x] `수정`일 때에는, 해당 메모의 정보를 불러와서 수정할 수 있게 함. (21.11.12)
	* RealmQuery에 edit함수 추가
- [x] `추가`일 때에는, 빈 메모를 생성 (21.11.12)
- [x] 공유버튼 누르면 텍스트 저장 (21.11.12)

## 기능 녹화
* iPhone 8, iPhone 13 Pro Max로 녹화영상
* 최소 10개의 메모 등록 후 녹화, README.md에 첨부