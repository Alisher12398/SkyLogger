# SkyLogger
Библиотека для удобной записи и просмотра различных логов: принтов, ответа сервера, сообщений системы и кастомных сообщений.

# Скриншоты
<img src="https://user-images.githubusercontent.com/25239480/146808503-6e33d4d1-e92c-471b-8a42-ce7de0a27f31.png" width="300">
<img src="https://user-images.githubusercontent.com/25239480/146808558-e1f43d96-e476-42e7-9196-339c4a04affc.png" width="300">

# Описание

Библиотека предоставляет возможность записывать логи и просматривать их общий список, а так же делиться ими. Возможность делиться логами помогает в отладке и нахождении багов у тестировщиков или сотрудников, а возможность просмотра логов (без Xcode) в любой момент упрощает выявление ошибок.

Лог состоит из: названия файла и функции откуда произошел вызов, сообщения (опционально), массива параметров ключ-значение (опционально), времени вызова, категории лога.
Возможные категории:  
• Print (обычный print)  
• API (ответ сервера)  
• Error (сообщение об ошибке)  
• System (сообщение от системы)  
• Analytics / Debug (аналитика и дебаггинг)    
• Custom (кастомные, с отдельным ключом)  

В списке логов можно включить фильтрацию по категории.

При нажатии на лог можно увидеть его детальную информацию, копировать текст.

Есть возможность поделиться текстовым файлом со списком логов.

# CocoaPods
```ruby
pod 'SkyLogger', :git => "https://github.com/Alisher12398/SkyLogger"
```

# Использование

### Основные команды

#### Конфигурация логгера в AppDelegate/SceneDelegate.
SkyCustomization пока не имеет параметров. Будут добавлены в будущем.
```swift
Logger.setup(appVersion: String, customization: SkyCustomization)
```


#### Запись лога.  
Из UIViewController или UIView доступна быстрая команда:
```swift
log(Log)
```
Из других файлов:
```swift
Logger.log(Log)
```


__Создание лога.__  
Есть множество convenience init для удобного и быстрого создания лога.
```swift
Log.init(logKind: Log.Kind, message: CustomStringConvertible?, parameters: [Log.Parameter]?, customKey: CustomKey?)
```


#### Быстрая команда замена для обычного Swift.print(). Создает лог с типом .print и введённым сообщением.  
Из UIViewController или UIView доступна быстрая команда:  
```swift
skyPrint(Any)
```  
Из других файлов:
```swift
Logger.skyPrint(Any)
```


#### Отобразить список логов. 
```swift
Logger.presentLogList(navigationController: UINavigationController?)
```

print("Swift.print: \(testClass)")
Logger.skyPrint(testClass)
Logger.skyPrint(Logger.convertObjectToString(testClass))

Вот и всё необходимое🙃


### Дополнительные команды

#### Получить список логов в виде UIActivityViewController. Если не хотите использвать presentLogList().
```swift
Logger.getLogListShareViewController()
```


#### Поделиться файлом с логами
```swift
Logger.shareLogList(presentingViewController: UIViewController?)
```


#### Предпочтительно передавать объект через Parameters. Но если есть необходимость через Message, то для преобразования объекта в протокол CustomStringConvertible, можно использовать.
```swift
Logger.convertObjectToString(Any)
```


### Пример в UIViewController
```swift
log(.init(kind: .system, message: "Test message", parameters: .init(key: "Test parameter", value: "Test parameter value")))
skyPrint("Test print message")
Logger.presentLogList(navigationController: navigationController)
```
