# PhotosApp

๐ท PhotoLibrary์ Web์ ์ด๋ฏธ์ง๋ฅผ Collection์ผ๋ก ๋ณด์ฌ์ฃผ๊ณ , Local ์ ์ฅ ๋ฑ์ ๊ธฐ๋ฅ์ ์ฐ์ตํ๋ ํ๋ก์ ํธ 

๐ฑ Developer : Lollo ๐ฉ๐ปโ๐ป , ์ญ์จ ๐ง๐ปโ๐ป



## Step 1 : Random Color CollectionView ์ ์ (3/22)

### ๊ตฌํ ๋ด์ฉ ๐ฑ

- ๋ฌด์์ ์์์ ๋ฐฐ๊ฒฝ์ ๊ฐ์ง 40๊ฐ์ cell์ ์์ฑํ๊ณ  ์ธ๋ก ์คํฌ๋กค Collection์ ๋ํ๋๋ค.

<img width="250" src="https://user-images.githubusercontent.com/52390975/111978184-fcc9fe80-8b46-11eb-9b65-ad75f21e9217.png">



### Today's ํ์ต๊ฑฐ๋ฆฌ ๐

##### 1. `CollectionView` ์ `CollecionViewCell` ์ ๋ํ ํ์ต.

- CollectionView๋ ViewController์ Outlet์ผ๋ก ์์ฑํ์ผ๋ฉฐ, ๊ด๋ จ ์ต์ ์ค์ ์ ์ฝ๋๋ก ๊ตฌ์ฑํ์๋ค.

- CollectionViewCell์ Customํ ์ํค๊ธฐ ์ํด CustomCollectionViewCell ํ์ผ์ ์์ฑํ๊ณ  CollectionView์ DataSource์์ ํด๋น CustomCell์ reusableCell๋ก ์ฌ์ฉํ์๋ค.

##### 2. `CollectionView`์ `TableView`์ ๊ณตํต์ ๊ณผ ์ฐจ์ด์ ์ ๋ํ ํ์ต

- `๊ณตํต์ `
  - `DataSource`์ `Delegate` ํ๋กํ ์ฝ์ ์ด์ฉํ๋ค.
  - `DataSource`๋ ๋ฐ์ดํฐ ์ ๋ณด, ์์ฑ์ ์ค์ ํ  ์ ์์ผ๋ฉฐ, `Delegate`๋ ํ๋ฉด์์ ๋ณด์ฌ์ง๋ ๋ฐ์ดํฐ๋ฅผ ๊ด๋ฆฌํ๋ค.
- `์ฐจ์ด์ `
  - ๊ฐ์ฅ ํฐ ์ฐจ์ด๋ CollectionView์ Custom Layout์ ์ ์ฉํ  ์ ์๋ค๋ ๊ฒ์ด๋ค.
  - ๋ ์ด์์์ ๋ด๋นํ๋ ํ๋กํ ์ฝ์ `UICollectionViewDelegateFlowLayout`๋ก, ์ด ํ๋กํ ์ฝ์ ๋ฉ์๋์ธ `collectionView(:layout:sizeForItemAt:)`์ ์ฌ์ฉํ์ฌ cell์ ํฌ๊ธฐ๋ฅผ ์ค์ ํ์๋ค. 

##### 3. ๋๋ค ์ปฌ๋ฌ ์ค์ ํ๊ธฐ - `drand48()`

   - `drand48()`์ UIColor์ rgba ์ด๋์๋ผ์ด์ ๋ฅผ ์ฌ์ฉํ์ฌ ๋๋ค ์์์ ์ถ์ถํ๋ค.
   - `drand48()`์ [0.0, 1.0] ์ฌ์ด์ ๋์๋ฅผ Double๋ก ๋ฆฌํดํ๋ malloc ํจ์๋ค.


##### 4. ์ง ํ๋ก๊ทธ๋๋ฐ์ ๊ฒฝํํ๊ณ  `Driver`์ `Navigator`๊ฐ ๋๋ ์ฐ์ต

- ์๋ก์ ํ๋ฉด์ ๋ณด๋ฉฐ ๊ฐ์ด ์กฐ์จํ๊ณ  ํ์ตํด ๋์๊ฐ๋ค.

##### 5. Git ํ์์ ๋ํ ์ถ๊ฐ ํ์ต. `Revert` , `Stash` , `Merge` , `PR`, `Review` ,etc ...

- ์๋๋ฐฉ์ ์ฝ๋๋ฅผ pull, merge ํ๋ ๊ณผ์ ์์ ๋ง์ ์ถฉ๋์ด ์์๊ณ , ์ด ์ํฉ์์ ๋ค์ํ ๋์ฒ๋ฒ์ ํ์ตํ๋ค.

<br>

<br>

## Step 2 : CollectionView์ PhotoLibrary ํญ๋ชฉ ํ์ (3/23)

### ๊ตฌํ ๋ด์ฉ ๐ฑ

- PhotoLibrary์ ์ฝํ์ธ  ๋ชฉ๋ก์ ๋ถ๋ฌ์์ ํ์ํ๋๋ก ๊ตฌํ
- PhotoLibrary์ ๋ณํ๊ฐ ์๊ธธ ์ ์์  ์ฌํญ์ ๋ฐ์ํ์ฌ ๋ชฉ๋ก์ ์๋ฐ์ดํธํ๋๋ก ๊ตฌํ

<img width="250" src="https://user-images.githubusercontent.com/72188416/112140569-80ebb700-8c17-11eb-91e8-257a981e12b2.gif">

<br>

### Today's ํ์ต๊ฑฐ๋ฆฌ ๐

1. **`PhotoKit`์ ํตํ PhotoLibrary ์ฐ๋ ํ์ต**

   **์ฃผ์ ํด๋์ค**: `PHAsset`, `PHAssetCollection`, `PHCollectionList`, `PHCollection`, `PHFetchResult`, `PHImageManager`

   - `PHAsset`๊ณผ `PHCachingImageManager`๋ฅผ ํตํด PhotoLibrary์์ asset์ ๋ถ๋ฌ์ค๊ณ  thumbnail ์ด๋ฏธ์ง๋ก ๋ณํํ์ฌ cell์ ์ ์ฉํ์๋ค.

   - `PHAssets`๋ ํ๋์ ๋ฉํ๋ฐ์ดํฐ๋ฅผ ๊ฐ์ ธ์จ๋ค. ๋ฉํ๋ฐ์ดํฐ ์ต์์ ์ค์ ํด์ image,video,audio ๋ฑ๋ฑ ์ค ํ๋์ ์์ฑ๊ฐ์ ๋ฝ์์ฌ ์ ์๋ค. `fetchAssets` ํจ์๋ฅผ ์ด์ฉํ๋ค. 

     ```swift
     let photoAssets = PHAsset.fetchAssets(in: allContents, options: .none)
     ```

   - `PHImageManager` ๋ `PHAssets`์ ๋ฉํ๋ฐ์ดํฐ ์ ๋ณด๋ฅผ ๊ด๋ฆฌํ๋ค. ์ผ๋ฐ์ ์ผ๋ก `PHAssets`์ ์ธ๋ค์ผ ์ด๋ฏธ์ง๋ฅผ ๊ฐ์ ธ์ฌ ์ ์์ผ๋ฉฐ, ์ฌ์ด์ฆ๋ฅผ ์ฌ์ ์ ํ  ์ ์๋ค.

   - `PHCachingImageManager`์ `PHImageManager`์ ํ์ ํด๋์ค์ด๋ฉฐ ๋๋ถ๋ถ์ ์์ฑ์ ๊ทธ๋๋ก ๊ฐ์ ธ์จ๋ค. ์ฐจ์ด์ ์ ํ๋ฒ์ ์ฌ๋ฌ `PHAssets`๋ฅผ ๊ฐ์ ธ์ค๊ฑฐ๋ ๊ด๋ฆฌ๋ฅผ ํ  ์ ์๋ค.

   - ์ด๋, `PHImageRequestOption `๊ฐ์ฒด๋ฅผ ํตํด size ๋ฑ์ ์ต์์ ์ค์ ํ  ์ ์๋ค. ์ด ํ๋ก์ ํธ์์๋ resizeMode๋ฅผ ์ค์ ํ์ฌ ์ด๋ฏธ์ง๊ฐ ์ํ๋ ์ฌ์ด์ฆ๋๋ก ํ์๋  ์ ์๊ฒ ํ๋ค.

   - `PHAssetCollection`์ ํตํด assetCollection ํจ์น ์, UserPhotoLibrary์ ๋ค์ํ ์จ๋ฒ๋ค์ ๋ถ๋ฌ์ ๋ณด์๋ค. `PHAssetCollection`์ ํตํด ์ค๋งํธ์จ๋ฒ/์ผ๋ฐ ์จ๋ฒ์ ๋ถ๋ฌ์ค๊ณ , subType์ ์ค์ ํ์ฌ ์จ๋ฒ์ ์ธ๋ถ ํ์(ex, ์ ์ฒด, ์ฆ๊ฒจ์ฐพ๊ธฐ, ์์นด, ๋ฑ๋ฑ)์ ์ ํํด์ ๊ฐ์ ธ์ฌ ์ ์๋ค. `fetchAssetCollections` ํจ์๋ฅผ ์ด์ฉํ๋ค.

     ```swift
     let smartAlbumCollection = PHAssetCollection.fetchAssetCollections(with: .smartAlbum, subtype: .any, options: .none)
     ```

2. **`PHPhotoLibraryChangeObserver` ํ๋กํ ์ฝ์ ํตํ ์ต์ ๋ฒ ํจํด ํ์ต**

   - PhotoKit์์ ์ต์ ๋ฒ๋ฅผ ์ด๋ป๊ฒ ๋ฑ๋กํ๊ณ  ๋์์ ๊ด์ฐฐํ  ์ ์๋ ์ง ์๊ฒ ๋์๋ค.
   - `PHPhotoLibraryChangeObserver`์๋ ์ค์๊ฐ์ผ๋ก **PHAssets**์ ๋ณํ๋ฅผ ๊ฐ์งํ๋ ์ต์ ธ๋ฒ๊ฐ ๊ตฌ์ฑ๋์ด ์๋ค.
   - ๋ณํ ๊ฐ์ง ์ ์๋๋๋ `photoLibraryDidChange(:PHChange)` ๋ฉ์๋์ changeInstance์์ ํ์ํ ์ ๋ณด๋ฅผ ์ถ์ถํ์ฌ View์ ์ ์ฉํ๋ ๋ฐฉ์์ ํ์ตํ๋ค.

3. **`performBatchUpdates`๋ฅผ ํตํ `CollectionView` ์๋ฐ์ดํธ**

   - CollectionView๊ฐ ์ ๊ณตํ๋ **insert/delete/reload/move** ๊ธฐ๋ฅ์ ํตํด View๋ฅผ ํจ์จ์ ์ผ๋ก ์๋ฐ์ดํธํ์๋ค. 
   
     

## Step 3-1 : JSON ํ์ฑ, Modal view ๋์ฐ๊ธฐ (3/24)

### ๊ตฌํ ๋ด์ฉ ๐ฑ

- JSON ์ ๋ณด๋ฅผ ๊ฐ์ ธ์ ๋ฐ์ดํฐ๋ฅผ ๋ถ๋ฆฌํ๊ณ  ํ์ํ ์ด๋ฏธ์ง ์ ๋ณด๋ฅผ ControllerView์์ ๋ณด์ฌ์ค๋ค.
- Async๋ฐฉ์์ ์ด์ฉํ์ฌ ์ ๋ณด๋ฅผ ๊ฐ์ ธ์ฌ ๋๋ง๋ค View์์ ํด๋น ์ด๋ฏธ์ง๋ฅผ ๋ณด์ฌ์ค๋ค. 
- ์ฝ๋๋ฅผ ์ด์ฉํ์ฌ + ๋ฒํผ์ ๋๋ ์ ๋ Modal๋ก DoodleView๋ฅผ ๋ณด์ฌ์ค๋ค.

<img src = "https://user-images.githubusercontent.com/52390975/112326069-8d474100-8cf7-11eb-9303-ee338433ae43.gif" width = 250>



### Today's ํ์ต๊ฑฐ๋ฆฌ ๐

1. JSON ๋ฐ์ดํฐ์ ๋ํด ํ์ต ๋ฐ ํ์ํ ์ ๋ณด๋ฅผ ํ์ฑํ๋ ๋ฐฉ๋ฒ์ ์ดํด

   - `JSON` ์ด๋ ?

     - **J**ava**S**cript **O**bject **N**otion ์ผ๋ก ๋ฐ์ดํฐ๋ฅผ ์ ์กํ๊ณ  ์ ์ฅํ๊ธฐ์ ์ฌ์ฉ๋๋ LightWeight DATA ํฌ๋งท.

     - JavaScript์์ ๊ฐ์ฒด๋ฅผ ๋ง๋ค ๋ ์ฌ์ฉ๋๋ ํํ์.

     - ์ฌ๋๊ณผ ๊ธฐ๊ณ๊ฐ ๋ชจ๋ ์ฌ์ฉํ๊ธฐ ํธํ์ฌ์ XML๋ณด๋ค ๋ ๋ง์ด ์ฌ์ฉ๋๋ ์ถ์ธ์ด๋ค.

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

     - JSON ์ ๋ณด๋ฅผ ํ์ฑํ์ฌ์ ์ํ๋ ์ ๋ณด๋ฅผ ์ป๋ ๋ฐฉ๋ฒ์ ํ์ตํ๊ณ  ์ ์ฉ์์ผ ๋ณด์๋ค.

     - ```swift
       let data = try String(contentsOf: jsonPath).data(using: .utf8)
       let json = try JSONSerialization.jsonObject(with: data!, options: [[]]) as? [[String: Any]]
                   self.jsonData = json
       ```

     - ํ์ฑํ ์ ๋ณด๋ฅผ ์ ์ฅํ์ฌ ํ์ ์ฌ์ฉ๋  ImageDownloader์ ๋ณด๋ผ ์ ์๋ ๋ฐฉ๋ฒ์ ๊ณต๋ถํ๋ค.

       

       

2. `DispatchQueue`์ ๋ํด ํ์ตํ๊ณ  `Sync`์ `Async` ์ต์์ ์ด์ฉํ์ฌ ํด๋น URL์์ ์ด๋ฏธ์ง๋ฅผ ๋ค์ด๋ฐ๋๋ค.

   - DispatchQueue๋ `main` Thread ์ `global` Thread๊ฐ ์กด์ฌํ๋ฉฐ ์ผ๋ฐ์ ์ผ๋ก `IOS ํ๋ฉด` ์ ๋ด๋นํ๋ ์ฐ๋ ๋๋ `main`

   - Sync์ Async ์ต์์ ๊ฐ๊ฐ ๋๊ธฐ์ ๋น๋๊ธฐ์ด๋ฉฐ ํด๋น ํจ์, ํด๋ก์ ธ๊ฐ ์๋ฃ๋  ๋๊น์ง ๊ธฐ๋ค๋ฆด์ง ์ ๊ธฐ๋ค๋ฆด์ง๋ฅผ ์ ํ๋ค.

   - Image Caching์ ์ด์ฉํ์ฌ ํ๋ฉด์ ๋ํ๋  ๋ชจ๋  ์ด๋ฏธ์ง๋ฅผ ๋ค์ด๋ฐ์ ๋๊น์ง ๊ธฐ๋ค๋ฆฌ์ง ์๊ณ  ๋ฐ์ ์ฆ์ ํ๋ฉด์ ๋ณด์ฌ์ฃผ๋๋ก ์์ํ์๋ค.

     - ์ฅ์  : ์ฌ์ฉ์ ์ ๊ทผ์ฑ ํฅ์

   - `URLSession` ๋ฅผ ์ด์ฉํ์ฌ ํด๋น ๋ฐ์ดํฐ๋ฅผ ๋ฐ์์ค๋ ํ์ต์ ํ์๋ค.

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

     

3. *+* ๋ฒํผ์ ์์ฑํ๊ณ  ๋๋ฅผ์ DoodleViewController๊ฐ ๋์ค๊ฒ ์์ํ์๋ค.

   - storyboard์์ ์์ํ์ง ์๊ณ , viewController์์ BtnAction์ ์ด์ฉํ์ฌ์ ๋ทฐ๊ฐ ๋ฑ์ฅํ๊ฒ ์์ํ์๋ค.

   - ```swift
     @IBAction func addBtnTouched(_ sender: Any) {
     
             let toDoodleVC = UINavigationController(rootViewController: DoodleViewController())
             present(toDoodleVC, animated: true)
             
         }
     ```

   - ์๊ตฌ์ฌํญ์ ๋ง๋ ์ต์์ ๋ฐ๊พธ์๋ค.

     

4. `MVC` ํจํด์ ๋ํ ์ถ๊ฐ ํ์ต    

   - ์คํ 2๊น์ง์ ๋ํ ๋ชจ๋ธ์ MVC์ ๋ง๊ฒ ๊ทธ๋ฃนํ ์งํ์์์ ํ์๋ค.
   - `Model` = PHAssets, ImageManager, ImageDownloader, ImageInfoStorage
   - `View` = PhotoViewCell, Main.StoryBoard
   - `Controller` = ViewController
   - `MVC` ํจํด์ผ๋ก ๋๋๋ฉด์ ์ปจํธ๋กค๋ฌ์ ๊ณผํ ์ฑ์์ ๋งก๊ธฐ์ง ์๋๋ก ์์ํ์๋ค.



## Step 3-2 : URL์ Image๋ฅผ Modal view์์ ๋ณด์ฌ์ฃผ๊ธฐ (3/25)

### ๊ตฌํ ๋ด์ฉ ๐ฑ

- DoodleViews๋ฅผ StoryBoard ์ด์ฉ ์์ด Code๋ก ๊ตฌํ.
- ์๋ก ๋ค๋ฅธ DispatchQueue๋ฅผ ์ด์ฉํ์ฌ ๋ค์ด๋ฐ๋ ํ์ ๋ณด์ฌ์ฃผ๋ ํ๋ฅผ Asyncํ๊ฒ ์์

<img src = https://user-images.githubusercontent.com/52390975/112632344-5b5ee780-8e7b-11eb-8396-4f3cccee1424.gif width = 250>



### Today's ํ์ต๊ฑฐ๋ฆฌ ๐

 1. DoodleViews๋ฅผ StoryBoard ์ด์ฉ ์์ด DoodleViewsController์์ Code๋ก ๊ตฌํ

    - `CollectionView`๋ฅผ ์ฝ๋๋ก ์์ฑํ๊ธฐ ์ํด `UICollectionViewFlowLayout`๋ก ์ต์ ๋ฐ ๊ตฌํํ๋ค.

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

   - `CollectionView`์ ๊ทธ ์์ ๋ค์ด๊ฐ ๊ฐ Cell, ๊ทธ๋ฆฌ๊ณ  ImageViews๋ค์ ์ฝ๋๋ก `AutoLayout` ์ค์ ํด์ฃผ๋ ๋ฐฉ๋ฒ์ ๋ฐฐ์ ๋ค.

   - `Navigation Bar Item`๋ ํน์ ์์น์๋ง ์์ฑํ  ์ ์๋ค๋ ์ ๊ณผ dismiss()๋ฅผ ํตํด View์ ์ ํ์ด ๊ฐ๋ฅํ ์ ์ ๋ฐฐ์ ๋ค.

   

2. ์์ JSON์์ ํ์ฑํ `URL`์์ ์น ์ด๋ฏธ์ง๋ฅผ ๋ถ๋ฌ์ฌ ๋, ๋ค์ค Queue ๋ฐ async ๋ฐฉ์์ ํ์ฉ (***2021.03.28 ์์ **)

<img src = https://user-images.githubusercontent.com/72188416/112753997-14a4f500-9015-11eb-83ca-3c6d26d003c3.jpeg width = 900>

- 2๊ฐ์ง ๊ฒฝ๋ก๋ก ์ด๋ฏธ์ง๋ฅผ ๋ค์ด๋ก๋ํ๋๋ก ๊ตฌํํ์๋ค. 

  1. **cell ์์ฑ ์์ ์ ๋ค์ด๋ก๋**
     - `DataSource delegate`์ ๋ฉ์๋ `collectionView(cellForItemAt indexPath:)`๋ฅผ ํตํด ์คํฌ๋กค ์์น์ cell๋ค์ด ์์ฑ๋  ๋, ์์ง ํด๋น cell์ ์ด๋ฏธ์ง๊ฐ ๋ค์ด๋ก๋๋ ์ด๋ ฅ์ด ์๋ค๋ฉด download task๋ฅผ ์์ฑํ๊ณ , concurrent queue์ ์ถ๊ฐํ๋๋ก ํ๋ค.
     - asyncํ๊ฒ ๋ค์ด๋ก๋ ํ, ์๋ฃ๋๋ฉด Notification์ ๋ณด๋ด๋๋ก ํ๋ค. Noti๋ฅผ ํตํด reload ์์ ์ ์๋ ค์ฃผ์ด ๋ค์ ์คํฌ๋กค์ ํ์ง ์๋๋ผ๋ ์ํํ ๋ก๋๊ฐ ๊ฐ๋ฅํ๋๋ก ํ๋ค. 
     - VC์์ Noti๋ฅผ ๋ฐ์ผ๋ฉด, `OperationQueue.main`์ cell์ reloadํ๋ task๋ฅผ ์ถ๊ฐํ๋๋ก ํ๋ค. ์ด๋ concurrent queue๋ฅผ ์ฌ์ฉํ๋ฉด view ํ์ ์ ๋ฐ๋ฆผ ํ์์ด ์ผ์ด๋๋ฏ๋ก serial queue๋ฅผ ์ฌ์ฉํ๋ค.
  2. **background์์ ๋ค์ด๋ก๋**
     - `DoodleViewController`์ viewDidLoad ์์ ์ ImageManager์ ๋ฉ์๋ `startDownloadingAtBackground()`๋ฅผ ํตํด ๋ชจ๋  URL์ ์ด๋ฏธ์ง ๋ค์ด๋ก๋ task๋ฅผ concurrent queue์ ์ถ๊ฐํ๋๋ก ํ๋ค.
     - cell ์์ฑ ์์๋ง ๋ค์ด๋ก๋๋ฅผ ์งํํ๋ฉด ์คํฌ๋กค ์ ์ด๋ฏธ์ง์ ์ํํ ์๊ธ์ ์ ์ฝ์ด ์๊ธฐ๋ฏ๋ก, ์์ง ๋๋ฌํ์ง ์์ indexpath์ ๋ํด์๋ ๋ฏธ๋ฆฌ ๋ค์ด๋ก๋๋ฅผ ์งํํ๊ณ  ์บ์ฑํ์ฌ ์ ์ฅํด๋๋๋ก ํ๋ค. 

- dictionary๋ฅผ ํ์ฉํ์ฌ ์ด๋ฏธ์ง๋ฅผ ์บ์ฑํ๊ณ , ์งํํ task ์ ๋ณด๋ฅผ ์ ์ฅํ๋๋ก ํ๋ค.

  ```swift
  class ImageDownloader {
    private var cachedImages: [URL: UIImage]
    private var imagesDownloadTasks: [URL: URLSessionDataTask]
    ...
  }
  ```

  - ์ด๋ฅผ ํตํด memory leaking์ ๋ฐฉ์งํ๊ณ , error๊ฐ ์๋ task๊ฐ ๋ฌดํํ ์งํ๋์ง ์๋๋ก ๋ง์ ์ ์์๋ค.
  - ๊ทธ๋ฌ๋ dictionary.subscript.getter / setter ๋ฒ๊ทธ๊ฐ ์ข์ข ๋ฐ์ํ๋ ๋ฌธ์ ๊ฐ ์์๋ค. ([Issue: dictionary.subscript.getter ๋ฌธ์ ](https://github.com/codesquad-members-2021/swift-photos-06/issues/13))
  - dictionary๋ thread-freeํ์ง ์์์, ๋์ ์ ๊ทผ ์ ๋ฌธ์ ๊ฐ ๋ฐ์ํ  ์ ์๋ค๋ ๊ฒ์ ์๊ฒ ๋์๋ค. set ์์ `barrier`๋ฅผ ๊ฑธ๊ณ , get ์์ syncํ๊ฒ ์ฒ๋ฆฌํ๋ ๊ฒ์ผ๋ก issue๋ฅผ ํด๊ฒฐํ  ์ ์์๋ค.



## Step 3-3 : Image๋ฅผ PhotoLibrary์ ์ ์ฅํ๊ธฐ (3/26)

### ๊ตฌํ ๋ด์ฉ ๐ฑ

- Image๋ฅผ ๊ธธ๊ฒ ๋๋ฌ์ ์ ์ฅํ๊ธฐ.
- ์ ์ฅ ์ ์๋ฆผ๋ฉ์์ง ๋์ค๊ธฐ ๋ฐ ์จ๋ฒ ๊ฐฑ์ .

<img src = https://user-images.githubusercontent.com/52390975/112632471-834e4b00-8e7b-11eb-8aa5-29045b828893.gif width = 250>

 ### Today's ํ์ต๊ฑฐ๋ฆฌ ๐

 1. `UILongPressGestureRecognizer` ๋ฅผ ์ฌ์ฉํ์ฌ ํด๋น ์์ ํด๋ฆญํจ์ ๋ฐ๋ผ UIMenuItem์ด ๋์ค๋๋ก ํ์ตํ์๋ค.

    - ```swift
      let menuController = UIMenuController.shared
      let save = UIMenuItem(title: "Save", action: #selector(saveImageAtCell))	
      ```

    - ์ ํํ Cell์ Image๋ฅผ Local Library์ ๋ฃ๋ ๋ฐฉ๋ฒ์ `UIImageWriteToSavedPhotosAlbum` ๋ฅผ ์ฌ์ฉํ์๋ค.

    - ```swift
      UIImageWriteToSavedPhotosAlbum(cellImage, self, #selector(imageSaveAlert(_:didFinishSavingWithError:contextInfo:)), nil)
      ```

 2. `Save` Btn์ ์ด์ฉํ์ฌ ์ ์ฅํ  ์, ์ ์ฅ์ด ๋์๋์ง๋ฅผ ์๋ ค์ฃผ๋ ๊ธฐ๋ฅ์ด ํ์ํ๋ค๊ณ  ์๋ผํ์๋ค.

    - ์ด์  : DoodlesView์์ LocalAlbumView๊ฐ ์๋ก ๋ค๋ฅด๊ธฐ์ ์ค์ ๋ก ์ ์ฅ๋์๋์ง๋ View์ ํ์ ํตํด์๋ง ํ์ธ์ด ๊ฐ๋ฅ
      
    - **์ฌ์ฉ์ฑ ํธ์ ์ฆ์ง!!**
      
    - `UIAlertController` ์ ์ด์ฉํ์ฌ ์ฌ์ฉ์์๊ฒ ์ ์ฅ ์๋ฃ ๋ผ์์์ ์๋ ค์ค

    - ```swift
      let ac = UIAlertController(title: "์ ์ฅ ์ฑ๊ณต!", message: "์ ํ์จ์ต๋๋ค.", preferredStyle: .alert)
      ac.addAction(UIAlertAction(title: "๋ค", style: .default))
      present(ac, animated: true)
      ```

 3. DoodlesView์์ ์ ์ฅํ Images๋ฅผ LocalAlbumView์์ ํ์ธํ๊ธฐ.

    - **๋ฌธ์ ์  ๋ฐ์** : ์ ์ฅ๋ Image๊ฐ LocalAlbumView์์ ๋ณด์ฌ์ง์ง ์๋ ํ์๋ฐ๊ฒฌ๐ข

      - ์ด์  : `modalPresentationStyle` ์ `formSheet`๊ฐ default์ธ ์ํฉ. ์ด์ ๋ฐ๋ผ ์๋ช์ฃผ๊ธฐ๋ฅผ ๋ Views ๋ชจ๋ ๊ณต์ ํ๊ฒ ๋ผ์์. (Modal์ `temporary mode` ์ ์๋ฏธ๋ฅผ ๊ฐ์ง๋ค.)
      - ํด๊ฒฐ์ฑ : `modalPresentationStyle` ๋ฅผ .fullScreen ์ผ๋ก ๋ณ๊ฒฝํจ. ๋ทฐ ์คํ์ ์๋ก ๋ค๋ฅธ views๊ฐ ์๊น

    - LocalAlbumView์์ `ViewWillAppear()`๋ฅผ ํตํด ๊ฐฑ์ ๋ ๋ฐ์ดํฐ๋ก `CollectionView`๋ฅผ ๋ณด์ฌ์ค๋ค.

    - ```swift
      override func viewWillAppear(_ animated: Bool) {
              super.viewWillAppear(animated)        
              self.collectionView.reloadData()
          }
      ```

