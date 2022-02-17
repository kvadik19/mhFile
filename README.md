# mhFile
>В системе существует небольшой по объему файл, который, допустим, зовется "file.txt" (имя может быть изменено по желанию претендента). Содержимое файла может меняться в любой момент. Необходимо написать объект, который в любой момент времени отдавал бы содержимое файла. Задача творческая, решение должно быть прозрачным и красивым для использования другими программистами.
### Файлы
**fwatch.pl** - скрипт для демонстрации работы модуля

**Filescope.pm** - объект, выполняющий задачу
### Filescope
Методы:
#### $spydog = Filescope->new( filename => $filename )
Создает экземпляр объекта. Обязательный параметр - имя отслеживаемого файла. При создании объекта, файл открывается для чтения и создается соответствующий дескриптор
#### $spydog->content
Возвращает содержимое указанного файла
#### $spydog->size
Возвращает размер файла
#### $spydog->close
Закрывает дескриптор файла и убивает объект (вызывается метод DESTROY)
### Алгоритм
При инициализации объекта собирается статистика файла, а его содержимое сохраняется внутри объекта. При вызове метода **content** запрашивается статистика отслеживаемого файла и, при изменении его modify time, файл перезагружается в кэш-переменную объекта. Если файл не изменялся с последнего вызова метода, возвращается ранее сохраненное содержимое кэша.

Максимальная актуальность получаемого содержимого файла составляет 1 сек.

