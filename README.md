# 📱 Flutter Meeting App

Flutter ile geliştirilen bu mobil uygulama, kullanıcıların Firebase Authentication ile giriş yapmasını sağlar ve Jitsi Meet entegrasyonu sayesinde uygulama içinden görüntülü toplantılar gerçekleştirmelerine olanak tanır. Ayrıca Firestore üzerinden toplantı verileri yönetilir.

## 🚀 Özellikler

- 🔐 **Firebase Authentication**
  - Kullanıcı girişi ve kayıt işlemleri
- ☁️ **Cloud Firestore**
  - Toplantı bilgileri Firestore veritabanında saklanır
- 📞 **Jitsi Meet Entegrasyonu**
  - Kullanıcılar uygulamadan çıkmadan video toplantı başlatabilir
- 🎯 **Toplantı Organizasyonu**
  - Organizatörler özel oda adıyla toplantı başlatabilir

## 🧰 Kullanılan Teknolojiler

- Flutter SDK
- Firebase (Authentication & Firestore)
- Jitsi Meet SDK (`jitsi_meet_wrapper`)

## 🖼️ Ekran Görüntüleri

| Ana Sayfa | Chat Ekranı | Toplantı Ekranı |
|-------------|------------------|-----------|
| ![Login](https://github.com/user-attachments/assets/7c619853-126b-4d74-88bb-8011f6a21716) | ![Meeting](https://github.com/user-attachments/assets/045d083f-2793-4362-9ee7-82f9072a33c2) | ![Dashboard](https://github.com/user-attachments/assets/688934ed-b69d-4665-8c2e-f4dd159c9755) |

## 🛠️ Kurulum

1. Bu repoyu klonlayın:
   ```bash
   git clone https://github.com/kullanici_adi/flutter-meeting-app.git
   cd flutter-meeting-app
   flutter pub get
