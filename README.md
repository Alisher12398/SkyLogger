# SkyLogger
Логгер для записи ответов сервера, системы и кастомных сообщений.

Лог состоит из: файла и метода откуда произошел вызов, сообщения (опционально), массива параметров ключ-значение (опционально), времени вызова, категории.
Категории: Api, обычный Print, Error, System, Custom (с кастомных ключом).
В списке логов можно включить фильтрацию по категории.

При нажатии на лог можно увидеть его детальную информацию, выделить и копировать текст.

Есть возможность поделиться текстовым файлом со списком логов.

# CocoaPods

pod 'SkyLogger', :git => "https://github.com/Alisher12398/SkyLogger"

# Список логов

Logger.present(nc: UINavigationController?)


# Скриншоты

![image](https://user-images.githubusercontent.com/25239480/146808503-6e33d4d1-e92c-471b-8a42-ce7de0a27f31.png)
![image](https://user-images.githubusercontent.com/25239480/146808558-e1f43d96-e476-42e7-9196-339c4a04affc.png)
