# motoko-app

# Sanat Galerisi Uygulaması

Bu proje, sanat eserlerinin yönetimi için yazılmış bir akıllı sözleşmedir. Akıllı sözleşme, sanat eserleri hakkında çeşitli işlemleri yapmanıza olanak tanır, örneğin eser oluşturma, okuma, güncelleme ve silme işlemleri. Her sanat eseri, bir kimlik (ID) ile tanımlanır ve veritabanında saklanır.

## Özellikler

- **Eser Oluşturma**: Yeni bir sanat eseri oluşturabilirsiniz.
- **Eser Okuma**: Bir sanat eserinin bilgilerini sorgulayabilirsiniz.
- **Eser Güncelleme**: Mevcut bir sanat eserinin bilgilerini güncelleyebilirsiniz.
- **Eser Silme**: Mevcut bir sanat eserini silebilirsiniz.
- **Sergi Geçmişi**: Eserlerin sergilendiği yerler ve tarihler saklanabilir.

## Türler

- **EserId**: Sanat eserinin benzersiz kimliği. `Nat32` türündedir.
- **Eser**: Sanat eserinin tüm bilgilerini kapsayan veri yapısı.
  - `title`: Eserin başlığı.
  - `artist`: Sanatçının adı.
  - `category`: Eserin kategorisi (`#Resim`, `#Heykel`, `#DijitalSanat`, `#Fotograf`).
  - `creationYear`: Eserin yaratılma yılı.
  - `isExhibited`: Eserin sergilenip sergilenmediği bilgisi.
  - `exhibitionHistory`: Eserin sergilenmiş olduğu yerler ve tarihlerin listesi.

## Uygulama Durumu

- **nextEserId**: Bir sonraki kullanılabilir sanat eseri kimliği.
- **eserler**: Sanat eserlerinin saklandığı veritabanı. Eserler, `Trie` veri yapısında saklanır.

## Fonksiyonlar

### 1. `create(eser: Eser) -> async EserId`
Yeni bir sanat eseri oluşturur ve ona benzersiz bir kimlik atar.

#### Parametreler
- `eser`: Yeni oluşturulacak sanat eserinin bilgilerini içeren `Eser` veri yapısı.

#### Dönen Değer
- Yeni sanat eserinin kimliği (`EserId`).

### 2. `read(eserId: EserId) -> async ?Eser`
Verilen `EserId` ile sanat eserinin bilgilerini sorgular.

#### Parametreler
- `eserId`: Sorgulamak istediğiniz sanat eserinin kimliği.

#### Dönen Değer
- Eğer eser varsa, `Eser` tipi, yoksa `null`.

### 3. `update(eserId: EserId, eser: Eser) -> async Bool`
Belirtilen sanat eserinin bilgilerini günceller.

#### Parametreler
- `eserId`: Güncellenmek istenen sanat eserinin kimliği.
- `eser`: Yeni sanat eseri bilgileri.

#### Dönen Değer
- `true` Eğer eser güncellenirse, `false` eğer eser bulunmazsa.

### 4. `delete(eserId: EserId) -> async Bool`
Belirtilen sanat eserini veritabanından siler.

#### Parametreler
- `eserId`: Silinmek istenen sanat eserinin kimliği.

#### Dönen Değer
- `true` Eğer eser başarıyla silinirse, `false` eğer eser bulunmazsa.
