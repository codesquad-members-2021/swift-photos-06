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

   - `PHImageManager` 는 `PHAssets`의 메타데이터 정보를 관리한다. 일반적으로 `PHAssets`의 썸네일 이미지를 가져올 수 있으며, 사이즈를 재정의 할 수 있다.

   - `PHCachingImageManager`은 `PHImageManager`의 하위 클래스이며 대부분의 속성을 그대로 가져온다. 차이점은 한번에 여러 `PHAssets`를 가져오거나 관리를 할 수 있다.

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

---

## Step 3-1 : JSON파일에서 Image를 ControllerView에 보여주기



#### 2021.03.24

### 구현 내용 📱

- JSON 정보를 가져와 데이터를 분리하고 필요한 이미지 정보를 ControllerView에서 보여준다.
- Async방식을 이용하여 정보를 가져올 때마다 View에서 해당 이미지를 보여준다. 
- 코드를 이용하여 + 버튼을 눌렀을 때 Modal로 DoodleView를 보여준다.



### Today's 학습거리 📚

1. JSON 데이터에 대해 학습 및 필요한 정보를 파싱하는 방법을 이해

   - `JSON` 이란 ?

     - **J**ava**S**cript **O**bject **N**otion 으로 데이터를 전송하고 저장하기에 사용되는 LightWeight DATA 포맷.

     - JavaScript에서 객체를 만들 때 사용되는 표현식.

     - 사람과 기계가 모두 사용하기 편하여서 XML보다 더 많이 사용되는 추세이다.

     - Example of `JSON` vs `XML`

       - `JSON`

       - ```Json
         ...
         {
           "CODESQUAD_IOS_Team6": 
           {
             "member": [
               {
                 "name": "Lollo",
                 "like": "Cake"
               },
               {
                 "name": "Jackson",
                 "like": "Pasta"
               }
             ]
           }
         }
         ...
         ```

         

       - `XML`

       - ```xml
         ...
         <CODESQUAD_IOS_Team6>
           <member>
             <name>Lollo</name>
             <like>Cake</like>      
           </member>
           <member>
             <name>Jackson</name>
             <like>Pasta</like>
           </member>
         </CODESQUAD_IOS_Team6>
         ...
         ```

     - JSON 정보를 파싱하여서 원하는 정보를 얻는 방법을 학습하고 적용시켜 보았다.

     - ```swift
       let data = try String(contentsOf: jsonPath).data(using: .utf8)
       let json = try JSONSerialization.jsonObject(with: data!, options: [[]]) as? [[String: Any]]
                   self.jsonData = json
       ```

     - 파싱한 정보를 저장하여 후에 사용될 ImageDownloader에 보낼 수 있는 방법을 공부했다.

       

       

2. `DispatchQueue`에 대해 학습하고 `Sync`와 `Async` 옵션을 이용하여 해당 URL에서 이미지를 다운받는다.

   - DispatchQueue는 `main` Thread 와 `global` Thread가 존재하며 일반적으로 `IOS 화면` 을 담당하는 쓰레드는 `main`

   - Sync와 Async 옵션은 각각 동기와 비동기이며 해당 함수, 클로져가 완료될 때까지 기다릴지 안 기다릴지를 정한다.

   - Image Caching을 이용하여 화면에 나타날 모든 이미지를 다운받을 때까지 기다리지 않고 받은 즉시 화면에 보여주도록 작업하였다.

     - 장점 : 사용자 접근성 향상

   - `URLSession` 를 이용하여 해당 데이터를 받아오는 학습을 하였다.

   - ```swift
     let task = URLSession.shared.dataTask(with: imageURL) { (data, response, error) in
         guard data != nil, error == nil else {
         DispatchQueue.main.async {
           completionHandler(nil, false)
         }
         return
       }
         let image = UIImage(data: data!)
         self.cachedImages[imageURL] = image
                     
         DispatchQueue.main.async {
         completionHandler(image, true)
       }
     }
     
     ```

     

3. *+* 버튼을 생성하고 누를시 DoodleViewController가 나오게 작업하였다.

   - storyboard에서 작업하지 않고, viewController에서 BtnAction을 이용하여서 뷰가 등장하게 작업하였다.

   - ```swift
     @IBAction func addBtnTouched(_ sender: Any) {
     
             let toDoodleVC = UINavigationController(rootViewController: DoodleViewController())
             present(toDoodleVC, animated: true)
             
         }
     ```

   - 요구사항에 맞는 옵션을 바꾸었다.

     

4. `MVC` 패턴에 대한 추가 학습    

   - 스텝 2까지에 대한 모델을 MVC에 맞게 그룹화 진행작업을 하였다.
   - `Model` = PHAssets, ImageManager, ImageDownloader, ImageInfoStorage
   - `View` = PhotoViewCell, Main.StoryBoard
   - `Controller` = ViewController
   - `MVC` 패턴으로 나누면서 컨트롤러의 과한 책임을 맡기지 않도록 작업하였다.



<img src = "https://user-images.githubusercontent.com/52390975/112326069-8d474100-8cf7-11eb-9303-ee338433ae43.gif" width = 200>



## Step 3-2 : 다운받은 Image를 DoodlesView에서 보여주기



#### 2021.03.25

- ### 구현 내용 📱

  - DoodleViews를 StoryBoard 이용 없이 Code로 구현.
  - 서로 다른 DispatchQueue를 이용하여 다운받는 큐와 보여주는 큐를 Async하게 작업

  

  ### Today's 학습거리 📚

 1. DoodleViews를 StoryBoard 이용 없이 DoodleViewsController에서 Code로 구현

    - `CollectionView`를 코드로 생성하기 위해 `UICollectionViewFlowLayout`로 옵션 및 구현했다.

   - ```swift
       lazy private var doodlesCollectionView : UICollectionView = {
              let layout = UICollectionViewFlowLayout()
               layout.scrollDirection = .vertical
               let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
               cv.translatesAutoresizingMaskIntoConstraints = false
               cv.register(ImgViewCell.self, forCellWithReuseIdentifier: cellID)
               return cv
           }()
       ```

   - `CollectionView`와 그 안에 들어갈 각 Cell, 그리고 ImageViews들을 코드로 `AutoLayout` 설정해주는 방법을 배웠다.

   - `Navigation Bar Item`는 특정위치에만 생성할 수 있다는 점과 dismiss()를 통해 View의 전환이 가능한 점을 배웠다.

   

2. `URL`을 통한 Images를 저장하고 저장된 Images를 View에 보여주는 작업을 Async하게 구현

   - `ImageManager`를 통해 전날 작업한 JSON파일을 통해 작업하는 ImageDownload 그리고, DownLoad한 이미지를 콜렉션 뷰에 보여주는 작업을 공부하였다. 

     - 각각의 주소에 해당하는 이미지를 다운받는 함수

     - ```swift
       private func startDownloading() {
             imageURLs.forEach { (url) in
                   backGroundDownloadingQueue.async {
                       self.downloader.downloadImage(imageURL: url, completionHandler: { (_) in },
                                                     placeholderImage: UIImage())
                   }
               }
           }
       ```

     - 다운받은 이미지를 해당 Cell에 전송하는 방법으로 `Notification`을 활용하여 즉각적으로 보내게 하였다.

     - ```swift
       NotificationCenter.default.addObserver(self,
                                                      selector: #selector(didImageDownloadDone(_:)),
                                                      name: ImageManager.NotiKeys.imageDownloadDone,
                                                      object: imgManager)
       ```

     - `DispatchQueue`에 대한 `Asyn`에 고찰

       - 일반적으로는 각각의 주소에 해당하는 이미지를 다운받도록 한다. 하지만 다음과 같은 상황에 대비를 해야한다.

         - 모든 데이터가 다운받기 전까지 이미지 뷰를 보여주는 함수가 실행되지 않는다.
         - 이미지를 보여주는 것이 순차적이라 스크롤 뷰를 내렸을 때 나오는 셀에 대한 이미지가 아직 보여지지 않는다.

       - 따라서 모든 뷰를 순차적으로 이미지를 받게하고, `dequeueReusableCell` 에 해당하는 새로운 Cell이 보여주었을 때를 대비하여 즉각적인 이미지를 보여주는 각각의 쓰레드를 생성하여 Asyn하게 작업하도록 하였다.

       - ```swift
         imageDownloadQueue = DispatchQueue.init(label: "imageDownload")
         backGroundDownloadingQueue = DispatchQueue.init(label: "backgroundImageDownload")
         ```

   

   <img src = https://user-images.githubusercontent.com/52390975/112632344-5b5ee780-8e7b-11eb-8396-4f3cccee1424.gif width = 200>

   

   ## Step 3-3 : Image를 저장하기

   

#### 2021.03.26

 - ### 구현 내용 📱

   - Image를 길게 눌러서 저장하기.
   - 저장 시 알림메시지 나오기 및 앨범 갱신.

     

 ### Today's 학습거리 📚

 1. `UILongPressGestureRecognizer` 를 사용하여 해당 셀을 클릭함에 따라 UIMenuItem이 나오도록 학습하였다.

    - ```swift
      let menuController = UIMenuController.shared
      let save = UIMenuItem(title: "Save", action: #selector(saveImageAtCell))	
      ```

    - 선택한 Cell의 Image를 Local Library에 넣는 방법은 `UIImageWriteToSavedPhotosAlbum` 를 사용하였다.

    - ```swift
      UIImageWriteToSavedPhotosAlbum(cellImage, self, #selector(imageSaveAlert(_:didFinishSavingWithError:contextInfo:)), nil)
      ```

 2. `Save` Btn을 이용하여 저장할 시, 저장이 되었는지를 알려주는 기능이 필요하다고 의논하였다.

    - 이유 : DoodlesView에와 LocalAlbumView가 서로 다르기에 실제로 저장되었는지는 View전환을 통해서만 확인이 가능
      - **사용성 편의 증진!!**

    - `UIAlertController` 을 이용하여 사용자에게 저장 완료 돼었음을 알려줌

    - ```swift
      let ac = UIAlertController(title: "저장 성공!", message: "잘 하셨습니다.", preferredStyle: .alert)
      ac.addAction(UIAlertAction(title: "네", style: .default))
      present(ac, animated: true)
      ```

 3. DoodlesView에서 저장한 Images를 LocalAlbumView에서 확인하기.

    - **문제점 발생** : 저장된 Image가 LocalAlbumView에서 보여지지 않는 현상발견😢

      - 이유 : `modalPresentationStyle` 의 `formSheet`가 default인 상황. 이에 따라 생명주기를 두 Views 모두 공유하게 돼었음. (Modal은 `temporary mode` 의 의미를 가진다.)
      - 해결책 : `modalPresentationStyle` 를 .fullScreen 으로 변경함. 뷰 스택에 서로 다른 views가 생김

    - LocalAlbumView에서 `ViewWillAppear()`를 통해 갱신된 데이터로 `CollectionView`를 보여준다.

    - ```swift
      override func viewWillAppear(_ animated: Bool) {
              super.viewWillAppear(animated)        
              self.collectionView.reloadData()
          }
      ```

        <img src = https://user-images.githubusercontent.com/52390975/112632471-834e4b00-8e7b-11eb-8aa5-29045b828893.gif width = 200>
