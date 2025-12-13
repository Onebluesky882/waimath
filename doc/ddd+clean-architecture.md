# Flutter — DDD + Clean Architecture: Step-by-step (ภาษาไทย)

เอกสารนี้จะพาคุณไปรู้จักและลงมือทีละก้าวกับ DDD (Domain-Driven Design) + Clean Architecture ในโปรเจกต์ Flutter จริง โดยออกแบบให้ทำตามแล้ว "บีบตัวเอง" ให้แยกความรับผิดชอบจนชัดเจน

---

## สรุปสั้น ๆ ก่อนเริ่ม

* **จุดประสงค์:** แยก logic ของธุรกิจ (Domain) ออกจากรายละเอียดการปฏิบัติ (Infrastructure) และ UI
* **ผลลัพธ์:** โค้ดอ่านง่าย ทดสอบง่าย เปลี่ยน datasource ได้โดยไม่กระทบธุรกิจ

---

# โครงสร้างโปรเจกต์ (แนะนำ)

```
lib/
 ├── core/                      # โค้ดที่ใช้ร่วมกันทั้งแอป (errors, utils, usecases base)
 ├── features/
 │    └── booking/              # ตัวอย่าง feature 'booking' (bounded context)
 │         ├── domain/
 │         │     ├── entities/
 │         │     ├── value_objects/
 │         │     ├── repositories/
 │         │     └── services/
 │         ├── application/
 │         │     ├── usecases/
 │         │     └── dtos/
 │         └── infrastructure/
 │               ├── datasources/
 │               ├── repositories_impl/
 │               └── models/
 └── presentation/
       ├── pages/
       ├── widgets/
       └── state_management/    # Riverpod / Bloc / Provider
```

---

# Step-by-step พร้อมคำอธิบายของแต่ละส่วน

## 1) Domain (หัวใจของ DDD)

**หน้าที่:** เก็บกฎธุรกิจทั้งหมด — สิ่งที่ไม่เปลี่ยนบ่อยแม้จะเปลี่ยน datasource หรือ UI

### ส่วนย่อยสำคัญ

* **Entities** — อ็อบเจกต์หลักของโดเมน มี identity (เช่น `Booking`, `User`) และพฤติกรรมที่เกี่ยวข้อง
* **Value Objects (VO)** — ค่าที่แทนคุณสมบัติและมีการ validate (เช่น `EmailAddress`, `Money`, `BookingDate`) — immutable
* **Repositories (interfaces)** — นิยามการกระทำออกนอกโดเมน เช่น `BookingRepository` แต่ *ไม่* บอกว่าจะใช้ HTTP หรือ DB
* **Domain Services** — ใช้เมื่อ logic เกี่ยวข้องกับหลาย entity หรือไม่เหมาะกับ method ใน entity

**กฎสำคัญที่ต้องบีบตัวเอง:**

* ทุกไฟล์ใน `domain/` ห้าม import Flutter, http, Dio, Firebase หรือ library ของ infra
* Domain ต้องเป็น pure Dart — ทดสอบได้ง่าย

**ตัวอย่าง Value Object (Dart)**

```dart
class EmailAddress {
  final String value;
  EmailAddress(this.value) {
    if (!RegExp(r"^[^@]+@[^@]+\.[^@]+$").hasMatch(value)) {
      throw ArgumentError('Invalid email');
    }
  }
}
```

**ตัวอย่าง Entity (Dart)**

```dart
class Booking {
  final String id; // identity
  final DateTime date;
  final String customerId;

  Booking({required this.id, required this.date, required this.customerId});

  bool canCancel(DateTime now) => date.isAfter(now);
}
```

---

## 2) Application (Use Cases)

**หน้าที่:** เป็นชั้นที่รับคำสั่งจาก UI แล้วสั่ง Domain ทำงาน (transaction script แบบสะอาด)

* **UseCases** — แต่ละ use case เป็น class/fn เดียว เช่น `BookAppointment`, `CancelBooking`, `GetBookingsForUser`
* **DTOs/Params** — โครงข้อมูลที่ use case รับเข้า/ส่งออก (ไม่ใช่ model ของ infra)

**หลักการ:** UseCase พึ่งพา repository interfaces (จาก domain) และ return result (Either<Failure, Success>)

**ตัวอย่าง UseCase (pseudo)**

```dart
class BookAppointment {
  final BookingRepository repo;
  BookAppointment(this.repo);

  Future<Either<Failure, Booking>> call(BookParams params) async {
    // validate params, call repo.create(), apply domain rules
  }
}
```

---

## 3) Infrastructure

**หน้าที่:** ให้ implementation ของ repository, datasource, model สำหรับการติดต่อภายนอก (HTTP, DB, local storage)

* **Datasources** — ที่ติดต่อ API หรือ Local DB (เช่น `BookingRemoteDataSource`)
* **Models** — DTOs ที่ map จาก/ไป JSON (เช่น `BookingModel.fromJson()`)
* **RepositoryImpl** — แปลง model ↔ entity และใช้งาน datasource

**หลักการสำคัญ:** ชั้นนี้เท่านั้นที่ import library ภายนอก เช่น dio, hive, firebase

**ตัวอย่าง RepositoryImpl (pseudo)**

```dart
class BookingRepositoryImpl implements BookingRepository {
  final BookingRemoteDataSource remote;
  BookingRepositoryImpl(this.remote);

  @override
  Future<Either<Failure, Booking>> createBooking(Booking booking) async {
    final model = BookingModel.fromEntity(booking);
    final json = await remote.postBooking(model);
    return Right(BookingModel.fromJson(json).toEntity());
  }
}
```

---

## 4) Presentation (UI)

**หน้าที่:** รับ input จากผู้ใช้, แสดงผล และเรียก UseCase

* UI ต้องรู้จัก **เฉพาะ** Entities และ UseCases (หรือ DTOs ของ application) — ห้าม import RepositoryImpl/Model/Datasource
* State management: Riverpod / Bloc / Provider (เลือกตัวเดียวแล้วใช้ให้เป็น)

**ตัวอย่าง:** View (Widget) จะ call `context.read(bookAppointmentProvider).call(params)`

---

# 5) วิธีบีบตัวเองให้ทำตามกฎ (Constraints enforcement)

### ✔ 1 — Architectural folder + code review checklist

* ใช้ PR template ที่มี checklist เช่น `Domain has no infra imports`, `UseCase tests exist`

### ✔ 2 — Lint rules / analyzer

เพิ่มใน `analysis_options.yaml` ข้อกฏตัวอย่าง:

```yaml
analyzer:
  exclude:
    - '**/*.g.dart'
linter:
  rules:
    - avoid_web_libraries_in_flutter
    - no_runtime_type_to_string
```

(คุณสามารถเขียน custom lint ได้ ถ้าต้องการตรวจ `import` ของ domain)

### ✔ 3 — Enforce by package separation (ถ้าโปรเจกต์โต)

แยกเป็น packages: `domain`, `application`, `infrastructure`, `presentation` จะบังคับ circular deps ได้ชัด

### ✔ 4 — DI เพื่อบังคับ dependency graph

ตัวอย่างแนวทาง (GetIt / Riverpod):

* ลงทะเบียน `RepositoryImpl` ใน DI แต่ UI จะได้แค่ UseCase/Repository interface ผ่าน provider

**ตัวอย่าง GetIt (pseudo):**

```dart
final getIt = GetIt.instance;

void setup() {
  // infra
  getIt.registerLazySingleton<BookingRemoteDataSource>(() => BookingRemoteDataSourceImpl());
  getIt.registerLazySingleton<BookingRepository>(() => BookingRepositoryImpl(getIt()));
  // application
  getIt.registerFactory(() => BookAppointment(getIt()));
}
```

UI จะไม่รู้จัก BookingRepositoryImpl — แค่ขอ `BookAppointment`

### ✔ 5 — Code reviews + PR templates

ให้ reviewer ตรวจว่า:

* Domain ไม่มีการ import infra
* UseCase ไม่ใช้งาน Flutter widgets
* Presentation ไม่ import models/datasource

---

# ตัวอย่าง flow เต็ม (Booking)

1. ผู้ใช้กดปุ่มจองใน UI → UI สร้าง `BookParams` แล้วเรียก `BookAppointment`
2. `BookAppointment` ตรวจสอบ validation (หรือใช้ VO) → เรียก `BookingRepository.createBooking`
3. `BookingRepositoryImpl` แปลง entity → model → datasource.post
4. Datasource ใช้ Dio ส่ง POST -> ได้ JSON
5. RepositoryImpl แปลง JSON → entity แล้วส่งกลับให้ UseCase
6. UseCase return success/failure ให้ UI

---

# Tips ปฏิบัติ

* **เริ่มจาก domain ก่อน**: เขียน entity + value objects + repository interfaces ให้เสร็จ แล้วเขียน tests
* **เขียน unit tests สำหรับ domain/usecases ก่อน implementation infra**
* **หนึ่ง use case = หนึ่ง file/class** — ทำให้อ่านง่ายและ mock ได้ง่าย
* **อย่ารีบสร้าง Model/JSON ก่อน** — ถ้าทำ จะกลายเป็น anemic domain

---

# Checklist ก่อน merge PR (สั้นๆ)

* [ ] Domain ไม่มี import ของ infra (http, dio, firebase)
* [ ] ทุก business rule อยู่ใน domain (VO/Entity/Service)
* [ ] UseCase มีความรับผิดชอบเดียว
* [ ] Presentation ไม่ import models/datasource
* [ ] DI ถูกตั้งค่าใน entrypoint

---

# ต่อจากนี้ ผมช่วยอะไรได้บ้าง?

* สร้าง starter template โปรเจกต์ (พร้อมตัวอย่าง feature `booking`) — จะได้โค้ดตัวอย่างทั้ง 4 ชั้น
* เขียน unit tests ตัวอย่างสำหรับ Domain/UseCase
* สร้าง `analysis_options.yaml` starter และ PR template

บอกผมได้เลยว่าต้องการแบบไหน: `starter template` หรือ `unit test example` หรือ `analysis_options + PR template` — ผมจะสร้างให้ทันทีครับ 🙌
