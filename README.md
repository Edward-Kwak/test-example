# test_example

### Riverpod based test code example

<br>


# Run Test

### 테스트 수행

```cmd 
flutter test test/crud_test.dart
```


```cmd 
flutter test test/home_page_test.dart
```

<br>


### 통합 테스트

#### 아래 명령어 실행시, 디바이스를 지정하여 통합 테스트 수행.

#### 디바이스에서 앱이 ***쇽쇽쇽*** 하고 실행됨.

```cmd 
flutter test integration_test/note_app_integration_test.dart
```


```cmd 
flutter test integration_test/fail_test.dart
```

<br>


### 시뮬레이터에서 테스트

* 아래 명령어로 디바이스 이름 검색하여, -d "디바이스 명" 옵션으로 디바이스 지정 테스트 수행.
* ```cmd
  flutter devices
  ```


* 예) "iPhone 12 mini" 시뮬레이터 실행 후, 아래 명령어로 테스트 수행.
* ```cmd
  flutter test -d "iPhone 12 mini" integration_test/note_app_integration_test.dart
  ```