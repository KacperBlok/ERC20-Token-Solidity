# KBMasterToken (KBMT)  
# Zdecentralizowany token ERC-20

## 📋 Podstawowe informacje

- **Nazwa:** KBMasterToken
- **Symbol:** KBMT
- **Decimals:** 18
- **Total Supply:** 10,000,000 KBMT (immutable)
- **Standard:** ERC-20
- **Wersja Solidity:** ^0.8.19

## 🎯 Cel kontraktu

KBMasterToken to w pełni zdecentralizowany token ERC-20 zaprojektowany z myślą o maksymalnym bezpieczeństwie i braku centralnej kontroli. Kontrakt eliminuje możliwości manipulacji przez administratorów, gwarantując stałą podaż tokenów i umożliwiając pełną decentralizację.

### Kluczowe cechy:

- **Immutable Variables**: Po deploymencie, zmienne takie jak `totalSupply` są niezmienne.
- **Brak funkcji administratorskich**: Brak zmiennych takich jak `owner` oraz uprawnień administracyjnych.
- **Brak mint/burn**: Niemożność dodrukowywania ani niszczenia tokenów.
- **Decentralizowana dystrybucja**: Tokeny są dystrybuowane w sposób zdecentralizowany, z 1% dla deployera i 99% przechowywanymi w kontrakcie.

## 📊 Dystrybucja tokenów

| Adres         | Procent | Ilość tokenów | Opis                       |
|---------------|---------|---------------|----------------------------|
| **Deployer**  | 1%      | 100,000 KBMT  | Minimalna ilość dla twórcy  |
| **Kontrakt**  | 99%     | 9,900,000 KBMT | Dostępne dla społeczności  |

## 🔧 Funkcje kontraktu

### Standardowe funkcje ERC-20

#### `balanceOf(address account) → uint256`
Zwraca saldo tokenów określonego konta.

#### `transfer(address to, uint256 amount) → bool`
Transferuje tokeny z konta nadawcy do odbiorcy.

#### `approve(address spender, uint256 amount) → bool`
Pozwala innemu adresowi na wydanie określonej ilości tokenów z konta właściciela.

#### `allowance(address owner, address spender) → uint256`
Sprawdza ile tokenów może wydać adres `spender` z konta właściciela.

#### `transferFrom(address from, address to, uint256 amount) → bool`
Transferuje tokeny między kontami. Wymaga wcześniejszego zatwierdzenia przez właściciela konta.

### Dodatkowe funkcje bezpieczeństwa

#### `increaseAllowance(address spender, uint256 addedValue) → bool`
Zwiększa allowance o określoną wartość, zapewniając bezpieczeństwo w operacjach.

#### `decreaseAllowance(address spender, uint256 subtractedValue) → bool`
Zmniejsza allowance o określoną wartość, zabezpieczając przed przypadkowym przekroczeniem limitu.

### Funkcje związane z kontraktem

#### `getContractBalance() → uint256`
Zwraca ilość tokenów przechowywanych na kontrakcie.

#### `withdrawFromContract(address to, uint256 amount) → bool`
Pozwala każdemu użytkownikowi wypłacić tokeny z kontraktu. **Brak ograniczeń** – pełna decentralizacja.

#### `checkContractBalance() → uint256`
Sprawdza saldo kontraktu i emituje event informujący o stanie.

#### `getTokenInfo() → (string, string, uint8, uint256)`
Zwraca podstawowe informacje o tokenie: nazwę, symbol, liczbę miejsc po przecinku i całkowitą podaż.

#### `isSecureContract() → bool`
Potwierdza, że kontrakt spełnia wysokie standardy bezpieczeństwa.

## 📡 Events

### Standardowe ERC-20 Events
- `Transfer(address indexed from, address indexed to, uint256 value)`
- `Approval(address indexed owner, address indexed spender, uint256 value)`

### Dodatkowe Events
- `TokensDeployed(address indexed deployer, uint256 totalSupply)`
- `TokensWithdrawn(address indexed to, uint256 amount)`
- `ContractBalanceChecked(uint256 balance)`

## 🚀 Deployment

### Parametry konstruktora
Konstruktor nie wymaga żadnych parametrów.

### Po deploymencie:
- Deployer otrzymuje: 100,000 KBMT (1% podaży)
- Kontrakt przechowuje: 9,900,000 KBMT (99% podaży)

## 💡 Przykłady użycia

### Sprawdzenie salda konta

```solidity
uint256 balance = token.balanceOf(userAddress);
```

### Transfer tokenów

```solidity
token.transfer(recipientAddress, 1000 * 10**18); // 1000 KBMT
```

### Wypłata z kontraktu

```solidity
token.withdrawFromContract(myAddress, 500 * 10**18); // 500 KBMT
```

### Sprawdzenie salda kontraktu

```solidity
uint256 contractTokens = token.getContractBalance();
```

## ⚠️ Ważne uwagi

### Ochrona przed Rug Pull
Ze względu na brak uprawnień administratorskich i fakt, że deployer posiada tylko 1% tokenów, kontrakt jest odporny na rug pull. Cała reszta tokenów (99%) jest przechowywana w kontrakcie, co zapewnia pełną decentralizację i transparentność. Żadne pojedyncze konto nie może kontrolować całkowitej podaży.

### Brak możliwości manipulacji podaży
TotalSupply jest immutable, brak funkcji mint/burn.

### Decentralizowany dostęp
Każdy może wypłacać tokeny z kontraktu bez ograniczeń.

### Transparentność
Kod jest otwarty, a wszystkie operacje są monitorowane za pomocą eventów.

## 🔍 Weryfikacja bezpieczeństwa

### Checklist bezpieczeństwa
- [x] Brak funkcji mint/burn
- [x] Immutable totalSupply
- [x] Brak funkcji administratorskich
- [x] Brak możliwości zamrażania kont
- [x] Standardowe zabezpieczenia ERC-20
- [x] Protection przed overflow (Solidity 0.8+)
- [x] Proper event emissions
- [x] Sprawdzanie zero address
- [x] Decentralizowana dystrybucja

## 📝 Licencja

MIT License

## 🎓 Zastosowanie w pracy magisterskiej

Ten kontrakt stanowi przykład:
- Implementacji standardu ERC-20
- Bezpiecznego projektowania smart contractów
- Decentralizacji w blockchain
- Eliminacji single point of failure
- Immutable design patterns
- Trustless protocols

Kontrakt pokazuje różnicę między tradycyjnymi tokenami (z centralną kontrolą) a prawdziwie zdecentralizowanymi tokenami, gdzie społeczność ma pełną kontrolę nad aktywami.
