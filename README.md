# PhotosApp



📱 Developer : Lollo 👩🏻‍💻 , 잭슨 🧑🏻‍💻



## Step 1 : Random Color CollectionView 제작 

#### 2021.03.22 

### 구현 내용 📱

- 무작위 색상의 배경을 가진 40개의 cell을 생성하고 세로 스크롤 Collection에 나타냈다.

<img width="300" src="https://user-images.githubusercontent.com/52390975/111978184-fcc9fe80-8b46-11eb-9b65-ad75f21e9217.png">



### Today's 학습거리 📚

##### 1. `CollectionView` 와 `CollecionViewCell` 에 대한 학습.

- CollectionView는 ViewController에 Outlet으로 생성했으며, 관련 옵션 설정을 코드로 구성하였다.

- CollectionViewCell을 Custom화 시키기 위해 CustomCollectionViewCell 파일을 생성하고 CollectionView의 DataSource에서 해당 CustomCell을 reusableCell로 사용하였다.

##### 2. `CollectionView`와 `TableView`의 공통점과 차이점에 대한 학습

- `공통점`
  - `DataSource`와 `Delegate` 프로토콜을 이용한다.
  - `DataSource`는 데이터 정보, 속성을 설정할 수 있으며, `Delegate`는 화면에서 보여지는 데이터를 관리한다.
- `차이점`
  - 가장 큰 차이는 CollectionView엔 Custom Layout을 적용할 수 있다는 것이다.
  - 레이아웃을 담당하는 프로토콜은 `UICollectionViewDelegateFlowLayout`로, 이 프로토콜의 메소드인 `collectionView(:layout:sizeForItemAt:)`을 사용하여 cell의 크기를 설정하였다. 

##### 3. 랜덤 컬러 설정하기 - `drand48()`

   - `drand48()`와 UIColor의 rgba 이니셜라이저를 사용하여 랜덤 색상을 추출했다.
   - `drand48()`은 [0.0, 1.0] 사이의 난수를 Double로 리턴하는 malloc 함수다.


##### 4. 짝 프로그래밍을 경험하고 `Driver`와 `Navigator`가 되는 연습

- 서로의 화면을 보며 같이 조율하고 학습해 나아갔다.

##### 5. Git 협업에 대한 추가 학습. `Revert` , `Stash` , `Merge` , `PR`, `Review` ,etc ...

- 상대방의 코드를 pull, merge 하는 과정에서 많은 충돌이 있었고, 이 상황에서 다양한 대처법을 학습했다.

<br>

<br>

## Step 2 : CollectionView에 PhotoLibrary 항목 표시

#### 2021.03.23

### 구현 내용 📱

- PhotoLibrary의 콘텐츠 목록을 불러와서 표시하도록 구현
- PhotoLibrary에 변화가 생길 시 수정 사항을 반영하여 목록을 업데이트하도록 구현

<img width="300" src="https://user-images.githubusercontent.com/72188416/112140569-80ebb700-8c17-11eb-91e8-257a981e12b2.gif">

<br>

### Today's 학습거리 📚

1. **`PhotoKit`을 통한 PhotoLibrary 연동 학습**

   **주요 클래스**: `PHAsset`, `PHAssetCollection`, `PHCollectionList`, `PHCollection`, `PHFetchResult`, `PHImageManager`

   - `PHAsset`과 `PHCachingImageManager`를 통해 PhotoLibrary에서 asset을 불러오고 thumbnail 이미지로 변환하여 cell에 적용하였다.

   - `PHAssets`는 하나의 메타데이터를 가져온다. 메타데이터 옵션을 설정해서 image,video,audio 등등 중 하나의 속성값을 뽑아올 수 있다. `fetchAssets` 함수를 이용한다. 

     ```swift
     let photoAssets = PHAsset.fetchAssets(in: allContents, options: .none)
     ```

   -  `PHImageManager` 는 `PHAssets`의 메타데이터 정보를 관리한다. 일반적으로 `PHAssets`의 썸네일 이미지를 가져올 수 있으며, 사이즈를 재정의 할 수 있다.

   -  `PHCachingImageManager`은 `PHImageManager`의 하위 클래스이며 대부분의 속성을 그대로 가져온다. 차이점은 한번에 여러 `PHAssets`를 가져오거나 관리를 할 수 있다.

   - 이때, `PHImageRequestOption `객체를 통해 size 등의 옵션을 설정할 수 있다. 이 프로젝트에서는 resizeMode를 설정하여 이미지가 원하는 사이즈대로 표시될 수 있게 했다.

   - `PHAssetCollection`을 통해 assetCollection 패치 시, UserPhotoLibrary의 다양한 앨범들을 불러와 보았다. `PHAssetCollection`을 통해 스마트앨범/일반 앨범을 불러오고, subType을 설정하여 앨범의 세부 타입(ex, 전체, 즐겨찾기, 셀카, 등등)을 선택해서 가져올 수 있다. `fetchAssetCollections` 함수를 이용한다.

     ```swift
     let smartAlbumCollection = PHAssetCollection.fetchAssetCollections(with: .smartAlbum, subtype: .any, options: .none)
     ```

2. **`PHPhotoLibraryChangeObserver` 프로토콜을 통한 옵저버 패턴 학습**

   - PhotoKit에서 옵저버를 어떻게 등록하고 동작을 관찰할 수 있는 지 알게 되었다.
   - `PHPhotoLibraryChangeObserver`에는 실시간으로 **PHAssets**의 변화를 감지하는 옵져버가 구성되어 있다.
   - 변화 감지 시 작동되는 `photoLibraryDidChange(:PHChange)` 메소드의 changeInstance에서 필요한 정보를 추출하여 View에 적용하는 방식을 학습했다.

3. **`performBatchUpdates`를 통한 `CollectionView` 업데이트**

   - CollectionView가 제공하는 **insert/delete/reload/move** 기능을 통해 View를 효율적으로 업데이트하였다. 