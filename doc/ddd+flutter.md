มาลองเขียนโค้ด DDD ในรูปแบบ **Flutter ของจริง** กันครับ!

เราจะใช้หลักการ **"Feature-first"** (แยกโฟลเดอร์ตามฟีเจอร์) ซึ่งเป็นท่ามาตรฐานที่โปรเจกต์ใหญ่ๆ นิยมใช้ เพราะหาง่ายและแก้ง่ายครับ

สมมติเราจะทำฟีเจอร์ **"Login"** (เข้าสู่ระบบ)

---

### 1. โครงสร้างโฟลเดอร์ (Folder Structure)

ในโปรเจกต์ Flutter แบบ DDD เราจะไม่กองทุกอย่างรวมกัน แต่จะแบ่งเป็นชั้นๆ แบบนี้ครับ:

```text
lib/
└── features/
    └── auth/                  <-- ชื่อฟีเจอร์ (เช่น Login)
        ├── domain/            <-- ชั้น "หัวใจสำคัญ" (ห้ามมีโค้ด UI หรือ Firebase ที่นี่)
        │   ├── entities/      <-- หน้าตาข้อมูลที่เอาไปใช้จริงในแอป
        │   └── repositories/  <-- สัญญาใจ (Interface) ว่าเราทำอะไรได้บ้าง
        │
        ├── data/              <-- ชั้น "คนงาน" (คุยกับ API, Database)
        │   ├── models/        <-- ตัวแปลงข้อมูลจาก JSON (DTO)
        │   ├── datasources/   <-- ตัวยิง API หรือดึง Local Storage
        │   └── repositories/  <-- คนทำงานจริง (Implement สัญญาจาก Domain)
        │
        └── presentation/      <-- ชั้น "หน้าตา"
            ├── bloc/          <-- ตัวจัดการ State (ผู้จัดการ)
            └── pages/         <-- หน้าจอ UI (พนักงานต้อนรับ)
```

---

### 2. มาดูตัวอย่างโค้ดทีละชั้น (จากในสุดมานอกสุด)

#### **Layer 1: Domain (หัวใจ & กฎธุรกิจ)**

นี่คือส่วนที่บริสุทธิ์ที่สุด มีแค่ภาษา Dart เพียวๆ ไม่มี `import 'package:flutter/...'` เลย

**Entity (`user.dart`):** สิ่งที่แอปฯ เรารู้จัก

```dart
// domain/entities/user.dart
class User {
  final String id;
  final String name;
  final String email;

  User({required this.id, required this.name, required this.email});
}
```

**Repository Interface (`auth_repository.dart`):** สัญญาว่า "เราทำอะไรได้บ้าง" (แต่ยังไม่บอกว่าทำยังไง)

```dart
// domain/repositories/auth_repository.dart
abstract class AuthRepository {
  // สัญญาว่า: ฉัน login ได้นะ แต่จะยิง API หรือเก็บในเครื่อง ฉันยังไม่สน
  Future<User> login(String email, String password);
}
```

---

#### **Layer 2: Data (หลังบ้าน & เครื่องมือ)**

ชั้นนี้จะรู้จักกับ API, JSON และโลกภายนอก

**Model / DTO (`user_model.dart`):** ตัวแปลงร่างจาก JSON เป็น Entity
_DTO = Data Transfer Object (คนส่งของ)_

```dart
// data/models/user_model.dart
import '../../domain/entities/user.dart';

class UserModel extends User {
  UserModel({required String id, required String name, required String email})
      : super(id: id, name: name, email: email);

  // แปลง JSON จาก API มาเป็น Model ของเรา
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['username'], // สมมติ API ส่งมาว่า username แต่ในแอปเราเรียก name
      email: json['email'],
    );
  }
}
```

**Repository Implementation (`auth_repository_impl.dart`):** คนทำงานจริง

```dart
// data/repositories/auth_repository_impl.dart
import '../../domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final RemoteDataSource remoteDataSource; // ตัวยิง API

  AuthRepositoryImpl(this.remoteDataSource);

  @override
  Future<User> login(String email, String password) async {
    // 1. เรียก API
    final userModel = await remoteDataSource.loginUser(email, password);
    // 2. ส่งกลับเป็น User (Entity) ให้ Domain สบายใจ
    return userModel;
  }
}
```

---

#### **Layer 3: Presentation (หน้าร้าน)**

ส่วนนี้คือ Flutter ล้วนๆ (Widgets) และ State Management (เช่น BLoC)

**BLoC / Cubit (`login_cubit.dart`):** ผู้จัดการร้าน

```dart
// presentation/bloc/login_cubit.dart
class LoginCubit extends Cubit<LoginState> {
  final AuthRepository authRepository; // เรียกใช้ Interface จาก Domain เท่านั้น!

  LoginCubit(this.authRepository) : super(LoginInitial());

  void loginClicked(String email, String pass) async {
    emit(LoginLoading()); // บอก UI ว่า "หมุนติ้วๆ อยู่นะ"
    try {
      final user = await authRepository.login(email, pass);
      emit(LoginSuccess(user)); // บอก UI ว่า "เสร็จแล้ว! พาไปหน้าแรกเลย"
    } catch (e) {
      emit(LoginError("พังครับพี่: $e"));
    }
  }
}
```

**UI (`login_page.dart`):** พนักงานต้อนรับ

```dart
// presentation/pages/login_page.dart
ElevatedButton(
  onPressed: () {
    // UI ไม่รู้เรื่อง API รู้แค่ว่าต้องบอกผู้จัดการ (Cubit)
    context.read<LoginCubit>().loginClicked("test@test.com", "1234");
  },
  child: Text("Login"),
)
```

---

### สรุปความเจ๋งของท่านี้ (Why Real App uses DDD?)

1.  **เปลี่ยน API สบายมาก:** วันหนึ่ง Backend เปลี่ยนจาก REST API เป็น GraphQL หรือเปลี่ยน Firebase คุณแก้แค่ที่โฟลเดอร์ `data` เท่านั้น! ... โค้ดที่หน้าจอ (`presentation`) และกฎธุรกิจ (`domain`) **ไม่ต้องแก้สักบรรทัด**
2.  **เทสง่าย:** คุณสามารถเทส `LoginCubit` ได้โดยไม่ต้องต่อเน็ตจริง (แค่จำลอง `AuthRepository` หลอกๆ ขึ้นมา)
3.  **ทำงานหลายคนไม่ตีกัน:**
    - นาย A ทำหน้าจอ (Presentation)
    - นาย B ทำเชื่อมต่อ API (Data)
    - ตกลงกันแค่ที่ Interface (Domain) ก็แยกย้ายกันทำงานได้เลย

### แนะนำ Packages ที่ควรใช้ (Starter Kit)

ถ้าจะเริ่มทำจริง แนะนำให้ศึกษา 4 ตัวนี้ครับ จะช่วยลดการเขียนโค้ดซ้ำๆ ได้เยอะมาก:

1.  **`flutter_bloc`**: จัดการ State (Layer Presentation)
2.  **`freezed`**: ช่วยสร้าง Model/Entity แบบเทพๆ (Layer Domain/Data)
3.  **`get_it` & `injectable`**: ช่วยส่งของ (Dependency Injection) เช่น ส่ง Repository ไปให้ BLoC ใช้ โดยไม่ต้อง `new` เอง
4.  **`dio`**: ตัวยิง API ยอดนิยม (Layer Data)
