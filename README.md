# SkyLogger
Библиотека для удобной записи и просмотра различных логов: принтов, ответа сервера, сообщений системы и кастомных сообщений.

# Скриншоты
<img src="Screenshots/sky-logger-screen-1.png" width="300">

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

В списке логов можно включить фильтрацию по категории и поиск по тексту.

При нажатии на лог можно увидеть его детальную информацию, копировать текст.

Есть возможность поделиться текстовым файлом со списком логов.

# Требования
iOS 15+, Swift 5.9+.

# Установка

## Swift Package Manager
В Xcode: **File → Add Packages…** и добавить URL репозитория. Либо в `Package.swift`:

```swift
.package(url: "https://github.com/Alisher12398/SkyLogger", branch: "develop")
```

# Основные команды

#### Конфигурация логгера в AppDelegate/SceneDelegate.

```swift
let configuration = SkyConfiguration(sortType: .newOnTop, shakeToPresent: true)
Logger.setup(appVersion: "2.0", configuration: configuration)
```

`shakeToPresent: true` включает открытие списка логов по встряхиванию устройства.

#### Запись лога.

```swift
/// Глобальная функция (доступна везде в модуле, импортирующем SkyLogger):
log(Log)

/// Эквивалент:
Logger.log(Log)

/// Короткие формы без явного создания Log:
Logger.log(kind: .system, message: "Test", parameters: .init(key: "k", value: "v"))
```

#### Создание объекта Log.

```swift
public init(
    kind: Log.Kind,
    message: Any? = nil,
    parameters: [Log.Parameter] = [],
    customKey: CustomKey? = nil,
    file: String = #file,
    function: String = #function,
    line: Int = #line
)
```

`message: Any?` принимает любой объект — он стрингифицируется один раз на момент создания (через `CustomStringConvertible`, либо через `Mirror` для классов/структур без него).

#### Быстрая команда замена для обычного Swift.print().

```swift
skyPrint(Any)            // глобальная
Logger.skyPrint(Any)     // эквивалент
```

Создаёт лог типа `.print` и **сохраняет его** в общий список (попадает в UI и в шаринг).

#### Отобразить список логов.

```swift
Logger.presentLogList(presentingViewController: UIViewController?)
```

Если передать `nil`, текущий видимый VC будет найден автоматически.

#### Дополнительная информация для шаринга

```swift
Logger.setAdditionalInfo([
    .init(key: "User ID", value: "12345"),
    .init(key: "Build", value: "release"),
])
```

Эти параметры включаются в шапку текстового файла при шаринге всех логов.

### Пример в UIViewController
```swift
log(.init(kind: .system, message: "Test message",
          parameters: .init(key: "Test parameter", value: "Test parameter value")))
skyPrint("Print test message")
Logger.presentLogList(presentingViewController: self)
```

## Дополнительные команды

##### Получить `UIActivityViewController` с файлом логов
```swift
Logger.generateLogListShareViewController()
```

##### Поделиться файлом со всеми логами
```swift
Logger.shareLogList(presentingViewController: UIViewController?)
```

##### Поделиться одним логом
```swift
Logger.shareLog(log: Log, presentingViewController: UIViewController?)
```

##### Получить URL текстового файла с логами
```swift
Logger.getTextFile()
```

##### Глобальный выключатель
```swift
Logger.isEnabled = false
```
