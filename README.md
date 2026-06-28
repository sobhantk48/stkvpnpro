# STK VPN Pro

**کلاینت قدرتمند VPN با پشتیبانی sing-box**

## ویژگی‌ها

✨ **ویژگی‌های اصلی:**
- 🚀 اتصال سریع و آسان به VPN
- 🔐 رمزنگاری قوی و امن
- 📊 نمایش آمار ترافیک و مدت اتصال
- ⚙️ پروفایل‌های قابل سفارشی
- 🎨 رابط کاربری زیبا و رزپانسیو
- 📱 پشتیبانی کامل Android و iOS
- 🌙 حالت شب خودکار
- 🔔 اطلاعات‌رسانی در زمان واقعی

## نیازمندی‌ها

- Flutter >= 3.19.0
- Dart >= 3.3.0
- Android 5.0+ یا iOS 11+

## نصب و راه‌اندازی

### 1. کپی کردن مخزن
```bash
git clone https://github.com/sobhantk48/stkvpnpro.git
cd stkvpnpro
```

### 2. نصب وابستگی‌ها
```bash
flutter pub get
```

### 3. راه‌اندازی برای Android
```bash
flutter run -d android
```

### 4. راه‌اندازی برای iOS
```bash
flutter run -d ios
```

## ساختار پروژه

```
lib/
├── main.dart                 # نقطه ورود اپلیکیشن
├── core/
│   └── core_supervisor.dart  # سرویس راه‌اندازی
├── services/
│   └── native_service.dart   # ارتباط با کد native
├── providers/
│   └── vpn_provider.dart     # مدیریت وضعیت VPN
├── ui/
│   └── dashboard.dart        # صفحه داشبورد
└── ...
```

## تنظیمات

### Android (`android/app/build.gradle`)
```gradle
android {
    compileSdkVersion 34
    defaultConfig {
        minSdkVersion 21
        targetSdkVersion 34
    }
}
```

### iOS (`ios/Podfile`)
```ruby
post_install do |installer|
  installer.pods_project.targets.each do |target|
    flutter_additional_ios_build_settings(target)
  end
end
```

## توسعه

### اضافه کردن پروفایل جدید
```dart
final vpnProvider = Provider.of<VPNProvider>(context, listen: false);
await vpnProvider.saveProfile('MyProfile', configJson);
```

### اتصال به VPN
```dart
await vpnProvider.connect('MyProfile');
```

### قطع اتصال
```dart
await vpnProvider.disconnect();
```

## تست

```bash
flutter test
```

## خرطوم عمومی

برای گزارش باگ‌ها یا درخواست ویژگی‌های جدید، یک Issue باز کنید.

## مجوز

این پروژه تحت مجوز MIT منتشر شده است. جزئیات بیشتر را در فایل `LICENSE` ببینید.

## نویسندگان

- **Sobhan TK** - مجری اصلی - [@sobhantk48](https://github.com/sobhantk48)

---

**تاریخ آخرین به‌روزرسانی:** 2026-06-28  
**نسخه فعلی:** 1.0.38+3
