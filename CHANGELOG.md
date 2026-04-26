# Changelog

## Unreleased

### Breaking
- Минимальная версия iOS поднята с 13 до **15**. Все ветки `#available(iOS 15, *)` и обращения к `UIApplication.shared.windows` удалены.
- `SkyConfiguration.toogleSortType()` переименован в `toggleSortType()`. Старое имя удалено без алиаса.
- `Log.Parameter.value: Any?` заменён на `Log.Parameter.valueString: String?` — конвертация `Any` теперь происходит **один раз** в инициализаторе. Публичный `init(key:value:)` сигнатуру не меняет.
- CocoaPods больше не поддерживается (удалён `SkyLogger.podspec`). Установка только через Swift Package Manager.

### Fixed
- `ShakeDetectManager` — swizzling переписан на каноничный within-class. Теперь корректно вызывает оригинальную реализацию `UIWindow.motionEnded(_:with:)`, не ломая чужие shake-обработчики в приложении-клиенте. Защита от повторного swizzling'а.
- `Logger.skyPrint` теперь **сохраняет** лог в общий список (попадает в UI и шаринг), как обещано в README. Раньше только печатал в Xcode.
- Лишняя пустая ячейка в фильтре категорий списка логов (`numberOfItemsInSection` возвращал `count + 1`).
- `SkyResponseData.fullURL` теперь строится через `URLComponents` — правильное percent-encoding query-параметров, нет ручного склеивания строк.

### Performance
- `Log.message: Any?` заменено на `messageString: String?` — стрингификация через `Mirror` происходит один раз в `init`, а не при каждом отображении/поиске/шаринге.
- Добавлен `lazy var searchableLowercasedString` в `Log` — поиск по тексту переиспользует уже подготовленную строку, lowercase'ит иголку один раз вне цикла.

### API
- `Log` теперь `Hashable` (раньше только `Equatable`). Можно складывать в `Set` и использовать как ключ в `Dictionary`.
- `Logger` получил `private init()` — снаружи нельзя создать второй инстанс.
- `SkyConfiguration.shared` теперь `private(set)`. Обновление через `SkyConfiguration.setShared(_:)`.
- `Logger.appVersion` и `Logger.additionalInfoParameters` синхронизированы через concurrent `DispatchQueue` с барьером на запись.

### Cleanup
- Удалены ~250 строк локальной копии библиотеки `Hue` — реально использовался только `UIColor(hex:)`. Заменён на минимальный собственный helper в `Extensions/UIColor+Hex.swift`.
- Удалены неиспользуемые `removeSubview`/`removeSubviews`/`reAddSubviews` из `UIView` extension.
- Удалён неиспользуемый протокол `SkyBaseViewProtocol`, не реализовывавшийся в `SkyBaseView`.
- Удалено `: TextOutputStream` conformance у `SkyFileManager` (не использовалось как stream).
- Удалён неиспользуемый `Log.Kind.index`.
- `Log.Kind.==` сжат с 38 строк до 11 через tuple-pattern.
- `Log.id` теперь генерится через `UUID().uuidString` вместо самописного `makeRandomString`.
- `getDeviceIdentifier` в `SkyStringHandler` ужат до 7 строк через `withMemoryRebound` + `String(cString:)`.
- Дата в логах форматируется через статические `DateFormatter` (`"dd.MM HH:mm"` для логов, `"dd.MM.yyyy"` для шапки шаринга), а не вручную через `Calendar.component`.
- `Notification.Name("new.log.added")` → `"sky.logger.new.log.added"` (защита от коллизий имён).
- Удалён лишний префикс модуля `SkyLogger.SkyResponseData.Key` в `SkyStringHandler`.
- Удалены ~45 строк закомментированных `convenience init` в `Log.swift`.
