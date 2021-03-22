# PhotosApp



📱 Developer : Lollo 👩🏻‍💻 , 잭슨 🧑🏻‍💻



## Step 1 : Random Color CollectionView 제작 

#### 2021.03.22 

### Todays' 학습거리 📚

##### 1. `CollectionView` 와 `CollecionViewCell` 에 대한 학습.

- CollectionView는 ViewController에 Outlet으로 생성했으며, 관련 옵션 설정을 코드로 구성하였다.

- CollectionViewCell을 Custom화 시키기 위해 CustomCollectionViewCell 파일을 생성하고 CollectionView의 DataSource에서 해당 CustomCell을 reusableCell로 사용하였다.

##### 2. `CollectionView`와 `TableView`의 공통점과 차이점에 대한 학습
- `공통점`
   - DataSource와 Delegate 프로토콜을 이용한다.
   - DataSource는 데이터 정보, 속성을 설정할 수 있으며, Delegate는 화면에서 보여지는 데이터를 관리한다.
- `차이점`
   - 가장 큰 차이는 CollectionView엔 Custom Layout을 적용할 수 있다는 것이다.
   - 레이아웃을 담당하는 프로토콜은 UICollectionViewDelegateFlowLayout로, 이 프로토콜의 메소드인 collectionView(:layout:sizeForItemAt:)을 사용하여 cell의 크기를 설정하였다. 

##### 3. 랜덤 컬러 설정하기 - `drand48()`
   - drand48()와 UIColor의 rgba 이니셜라이저를 사용하여 랜덤 색상을 추출했다.
   - drand48()은 [0.0, 1.0] 사이의 난수를 Double로 리턴하는 malloc 함수다.


##### 4. 짝 프로그래밍을 경험하고 `Driver`와 `Navigator`가 되는 연습

- 서로의 화면을 보며 같이 조율하고 학습해 나아갔다.

##### 5. Git 협업에 대한 추가 학습. `Revert` , `Stash` , `Merge` , `PR`, `Review` ,etc ...

- 상대방의 코드를 pull, merge 하는 과정에서 많은 충돌이 있었고, 이 상황에서 다양한 대처법을 학습했다.

<img width="300" src="https://user-images.githubusercontent.com/52390975/111978184-fcc9fe80-8b46-11eb-9b65-ad75f21e9217.png">
