# Description
 
 This app performs simple word analysis, based on a provided set of rules, on user supplied text input. 

The app is divided into two sections:

+ Stemming Section: This allows users to input a list of words (separated by blank spaces), performs stemming on the words, and displays the stemmed words in a table along with the frequency of each stem being identified as the root of the user input.

+ History Section: This displays a history of the processed stemmed words, including how many times each stem has been recognized as the root of a user-input word."

 
 Follows MVVM architecture, written by using UIKit and custom persistance component. 

 ## Stemming algorithm

 The word processor algorithm emulates [stemming algorithm](https://en.wikipedia.org/wiki/Stemming#:~:text=Stemming%20algorithms%20attempt%20to%20minimize,universe%22%20to%20%22univers%22) , " by reducing inflected words, user input words, to their root form—generally". 
 
For the sake of simplicity in this code challenge, the stemming algorithm has been streamlined to follow theses suffix rules: 


 1. The following are common suffixes in the language, remove the suffix to find the root word -
 + “L”
 + “LZ”
 + “EVM” ○ “ZQ”

 2. These suffixes require adding back letters to determine the root word -
 + remove “PZL” add “A”
 + remove “PZL” add “AZ”
 + remove “EZL” add “R”

 Example: 

| User's input word  | Stem word               | Explanation                                                                   |
| -------------------|-------------------------|-------------------------------------------------------------------------------|
| IHFULZ      		 | IHFUL       			   | Applied the "L" remove suffix rule                                            |
| UZCUZLZVKDKEPZL    | UZCUZLZVKDKEA           | Applied the remove-add back suffix, Removing "PZL" suffix and adding back "A" suffix |
| MZV                | MZV                     | No Rule applied                                                               |

  ## Architecture

  MVVM,  Model - View - View Model attached to the the [Dependency Inversion Principle](https://en.wikipedia.org/wiki/Dependency_inversion_principle).

 ## Technologies
 + UIKit + IB (.storyboard)
 + A custom storage component, [JsonDataStorage.swift](https://github.com/FlyRicardo/FarmersFridgeCodeChallenge/blob/master/FarmersFridgeCodeChallenge/Storage/JsonDataStorage.swift) is designed to persist the calculated stemmed words in a local JSON file

 ## Requirements

- Swift 5.10+
- iOS 17.4+
- Xcode 15.3+

 ## Setup

1. Switch to `master` branch 
2. Download the repository 
```
git clone https://github.com/FlyRicardo/FarmersFridgeCodeChallenge.git
```
3. Go to `FarmersFridgeCodeChallenge` inner folder
4. Open `FarmersFridgeCodeChallenge.xcworkspace`, compile and run


 ### Screenshots

| Stemming Section   | History Section |
| ------------------ | --------------- |
|![StemmingSection](https://github.com/FlyRicardo/FarmersFridgeCodeChallenge/assets/7501209/bd091812-f8a9-49a0-b64c-3883e6edf965) |![HistorySection](https://github.com/FlyRicardo/FarmersFridgeCodeChallenge/assets/7501209/e6de717e-0b8b-4ac2-9daa-137e020814dc)|
