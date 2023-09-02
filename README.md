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
```
pod 'SkyLogger', :git => "https://github.com/Alisher12398/SkyLogger"
```

# Использование
## Основные команды
__Конфигурация логгера в AppDelegate/SceneDelegate__
SkyCustomization пока не имеет параметров. Будут добавлены в будущем.
```
Logger.setup(appVersion: String, customization: SkyCustomization)
```

__Запись лога__
Из UIViewController или UIView доступна быстрая команда:
```
log(Log)
```
Из других файлов:
```
Logger.log(Log)
```

__Создание лога__
Есть множество convenience init для удобного и быстрого создания лога.
```
Log.init(logKind: Log.Kind, message: CustomStringConvertible?, parameters: [Log.Parameter]?, customKey: CustomKey?)
```

__Быстрая команда замена для обычного Swift.print(). Создает лог с типом .print и введённым сообщением__
Из UIViewController или UIView доступна быстрая команда:
```
skyPrint(Any)
```
Из других файлов:
```
Logger.skyPrint(Any)
```

__Отобразить список логов__
```
Logger.presentLogList(navigationController: UINavigationController?)
```

Вот и всё необходимое🙃

## Дополнительные команды

__Получить список логов в виде UIActivityViewController. Если не хотите использвать presentLogList()__
```
Logger.getLogListShareViewController()
```

__Поделиться файлом с логами__
```
Logger.shareLogList(presentingViewController: UIViewController?)
```

__Предпочтительно передавать объект через Parameters. Но если есть необходимость через Message, то для преобразования объекта в протокол CustomStringConvertible, можно использовать__
```
Logger.convertObjectToString(Any)
```

## Пример в UIViewController
```
log(.init(kind: .system, message: "Test message", parameters: .init(key: "Test parameter", value: "Test parameter value")))
skyPrint("Test print message")
Logger.presentLogList(navigationController: navigationController)
```
