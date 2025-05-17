# NoteX

Небольшое Flutter‑приложение для ведения заметок.  
Служит демонстрацией **Clean Architecture** + **Drift** + **Riverpod**  
и ориентировано на высокую расширяемость, модульность и кроссплатформенность.

---

## 🚀 Как запустить

```bash
flutter pub get
flutter pub run build_runner build
flutter run
````

> **Проверено:** Android, Web, Windows
> *iOS* / *macOS* требуют учётной записи разработчика (пока не подключено).

---

## 📦 Используемые пакеты

| Область             | Пакет                                                                                  |
| ------------------- | -------------------------------------------------------------------------------------- |
| State-management    | [`flutter_riverpod`](https://pub.dev/packages/flutter_riverpod)                        |
| Локальное хранилище | [`drift`](https://drift.simonbinder.eu/) (`sqlite` / `indexedDB`)                      |
| DI                  | Riverpod‑провайдеры                                                                    |
| Генерация моделей   | [`dart_mappable`](https://pub.dev/packages/dart_mappable)                              |
| Форматирование дат  | [`intl`](https://pub.dev/packages/intl), [`timeago`](https://pub.dev/packages/timeago) |
| Утилиты коллекций   | [`collection`](https://pub.dev/packages/collection)                                    |
| Ключ‑значения       | [`shared_preferences`](https://pub.dev/packages/shared_preferences)                    |

---

## 🧱 Архитектура

В основе лежит **Clean Architecture**, разделённая по фичам и слоям:

```
lib/
├── core/           # общие модули и типы
├── di/             # DI-провайдеры
├── settings/       # простая feature
└── notes/          # основная feature
    ├── domain/     # сущности и абстракции репозиториев
    ├── app/        # use-case'ы, валидация, типы
    ├── data/       # Drift-DAO, модели, реализация репозитория
    └── presentation/
        ├── list/   # виджеты списка (NoteTile, SliverGroupedList …)
        ├── viewmodel/   # StateNotifier'ы и State-объекты
        └── …       # экраны: список, форма, настройки
```

---

## ✨ Особенности

* **Поиск** — с подсветкой совпадений.
* **Сортировка** — по дате создания, обновления, алфавиту. Заголовки группируются (A, Б, Сегодня…).
* **Пагинация** — по 100 заметок за раз, поддерживает бесконечную прокрутку.
* **Удаление с Undo** — кнопка отката через SnackBar.
* **Тема оформления** — системная / светлая / тёмная.
* **Кроссплатформенность** — SQLite (Android, Windows), IndexedDB (Web).

---

## ⚙️ Генерация кода

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

Сгенерируются:

* `*.mapper.dart` — модели `dart_mappable`
* `*.g.dart` — drift‑схемы, DAO

---

### 🧪 Запуск тестов

```bash
flutter test
```

<p>
  <img src="docs/screenshots/test_results.png" width="260">
</p>

---

## 🛠️ Debug‑функция: генерация фейковых заметок

| Действие                                 | Результат                                                                                                          |
| ---------------------------------------- | ------------------------------------------------------------------------------------------------------------------ |
| **Долгое нажатие** на иконку ⚙️ в AppBar | Появляется диалог с предложением сгенерировать случайные заметки (через [`faker`](https://pub.dev/packages/faker)) |

📎 Используется метод `NotesListViewModel.generateFake(count)`
→ доступен только в **debug‑сборках**.

---

## 📌 Примечание

Это учебный проект, но архитектура и качество кода позволяют использовать его как основу для продакшн-приложений: UI независим от платформы, тесты покрывают ключевые ветки логики, а DI и слой app разделяют бизнес-логику и инфраструктуру.
