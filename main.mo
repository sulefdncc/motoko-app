import List "mo:base/List";
import Option "mo:base/Option";
import Trie "mo:base/Trie";
import Nat32 "mo:base/Nat32";

actor SanatGalerisi {

  /**
   * Türler
   */

  // Sanat eseri kimliği türü
  public type EserId = Nat32;

  // Sanat eseri türü
  public type Eser = {
    title : Text;
    artist : Text;
    category : { #Resim; #Heykel; #DijitalSanat; #Fotograf };
    creationYear : Nat32;
    isExhibited : Bool;
    exhibitionHistory : List.List<Text>; // Sergi detayları (tarih, yer)
  };

  /**
   * Uygulama Durumu
   */

  // Bir sonraki kullanılabilir sanat eseri kimliği
  private stable var nextEserId : EserId = 0;

  // Sanat eserleri veritabanı
  private stable var eserler : Trie.Trie<EserId, Eser> = Trie.empty();

  /**
   * Yüksek Seviye API
   */

  // Sanat eseri oluşturma
  public func create(eser : Eser) : async EserId {
    let eserId = nextEserId;
    nextEserId += 1;
    eserler := Trie.replace(
      eserler,
      key(eserId),
      Nat32.equal,
      ?eser,
    ).0;
    return eserId;
  };

  // Sanat eserini okuma
  public query func read(eserId : EserId) : async ?Eser {
    let result = Trie.find(eserler, key(eserId), Nat32.equal);
    return result;
  };

  // Sanat eserini güncelleme
  public func update(eserId : EserId, eser : Eser) : async Bool {
    let result = Trie.find(eserler, key(eserId), Nat32.equal);
    let exists = Option.isSome(result);
    if (exists) {
      eserler := Trie.replace(
        eserler,
        key(eserId),
        Nat32.equal,
        ?eser,
      ).0;
    };
    return exists;
  };

  // Sanat eserini silme
  public func delete(eserId : EserId) : async Bool {
    let result = Trie.find(eserler, key(eserId), Nat32.equal);
    let exists = Option.isSome(result);
    if (exists) {
      eserler := Trie.replace(
        eserler,
        key(eserId),
        Nat32.equal,
        null,
      ).0;
    };
    return exists;
  };

  /**
   * Yardımcı Fonksiyonlar
   */

  // Sanat eseri kimliği için bir anahtar oluşturma
  private func key(x : EserId) : Trie.Key<EserId> {
    return { hash = x; key = x };
  };

};
