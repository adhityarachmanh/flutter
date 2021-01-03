/*
module  : GLOBAL SHR
creator : lwx (JS Version)
          adhityarachmanh (dart Version)  
os      : darwin19
created : Thu Dec 17 20:21:01 WIB 2020
product : ARH
version : v1.0
*/

part of '../app.dart';

var constTrue = true,
    constFalse = !constTrue,
    usernameRegEx = new RegExp(r"^[a-z0-9_-]{4,16}$"),
    emailRegEx = new RegExp(r"^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$"),
    phoneRegEx = new RegExp(r"^(^08|^62)(\d{3,4}?){2}\d{3,4}$"),
    myValue = {},
    asciiBitAmt = 8,
    defaultBaseNBitLen = 7,
    storage = new FlutterSecureStorage();
String noSpaceString(value) {
  return value.replaceAll(" ", "");
}

bool isNumber(value) {
  return value is int;
}

int getLength(value) {
  return value.length;
}

bool isString(value) {
  return value is String;
}

bool isFunction(functionToCheck) {
  return functionToCheck is Function;
}

bool isNull(value) {
  return value == null;
}

stringFromCharCode(charCode) {
  return String.fromCharCode(charCode);
}

mathPow(x, exponent) {
  return pow(x, exponent);
}

charAt(String str, int atPos) {
  return str[atPos];
}

charCodeAt(String str, int atPos) {
  return str.codeUnitAt(atPos);
}

arrPush(List src, Object idx) {
  return src.add(idx);
}

genKey(keyType) {
  var aS = 65,
      zE = 91,
      asa = 97,
      ze = 123,
      os = 48,
      oe = 58,
      questionMarks = 63,
      colone = 59,
      numberSigns = 35,
      ampersande = 39,
      leftParenthiss = 40,
      fullStope = 47,
      leftSquareBrackete = 92,
      rightSquareBrackets = 93,
      lowLinee = 96,
      tildee = 127,
      latinAwGraves = 192,
      latinSmallaee = 231,
      key = "",
      suffix = "",
      arrRange = [aS, zE, asa, ze, os, oe],
      i = 0;
  if (keyType == 0) {
    // standard base 64
    suffix = "+/=";
  } else if (keyType == 1) {
    // non standard uri safe base 64
    suffix = "-_."; // standard uri safe using "+-$"
  } else if (keyType == 2) {
    // non standard base 64
    arrRange = [asa, ze, questionMarks, zE, os, colone];
  } else if (keyType == 5) {
    suffix = "!#\$%&";
    arrRange = [
      leftParenthiss,
      leftSquareBrackete,
      rightSquareBrackets,
      tildee
    ];
  } else if (keyType == 7) {
    arrRange = [50, oe, aS, 73, 74, 79, 80, zE];
  } else if (keyType == 9) {
    // key was from server and session specific after successfull login
    arrRange = [];
    key = getSvrKey();
  } else {
    //own base 2 to base 128
    key = "!";
    arrRange = [
      numberSigns,
      ampersande,
      leftParenthiss,
      fullStope,
      os,
      leftSquareBrackete,
      rightSquareBrackets,
      lowLinee,
      asa,
      tildee,
      latinAwGraves,
      latinSmallaee
    ];
  }

  for (var l = arrRange.length; i < l; i += 2) {
    for (var j = arrRange[i], k = arrRange[i + 1]; j < k; j++) {
      key += stringFromCharCode(j);
    }
  }
  return key + suffix;
}

getSvrKey() {
  var tmp = myValue[config.creator];
  return nBitDec(tmp, null, null);
}

nBitDec(source, baseNBitLen, key) {
  //return _bND(baseNBitLen || 6, source, key);
  baseNBitLen = baseNBitLen != null ? baseNBitLen : defaultBaseNBitLen;
  var binData = 0, bitLen = 0, listIng = [];
  key = key != null ? key : genKey(null);

  source.split(new RegExp(r"")).map((v) {
    binData = (binData << baseNBitLen) + key.indexOf(v);

    bitLen += baseNBitLen;
    return bitLen < asciiBitAmt
        ? ""
        : stringFromCharCode((binData >> (bitLen -= asciiBitAmt)) & 0xff);
  }).forEach((d) => listIng.add(d));
  final encResult = listIng.join();
  return encResult;
}

nBitEnc(source, baseNBitLen, key) {
  baseNBitLen = baseNBitLen != null ? baseNBitLen : defaultBaseNBitLen;
  key = key != null ? key : genKey(null);

  var binData = 0,
      bitLen = 0,
      listIng = [],
      baseNBit = mathPow(2, baseNBitLen) - 1;
  source.split(new RegExp(r"")).map((v) {
    var encResultTmp = "";
    binData = (binData << asciiBitAmt) + charCodeAt(v, 0);
    bitLen += asciiBitAmt;

    while (bitLen >= baseNBitLen) {
      bitLen -= baseNBitLen;
      encResultTmp += key[(binData >> bitLen) & baseNBit];
    }
    return encResultTmp;
  }).forEach((d) => listIng.add(d));

  return bitLen > 0
      ? listIng.join() + key[(binData << (baseNBitLen - bitLen)) & baseNBit]
      : listIng.join();
}

class Global {
  // to compare long lat
  double calculateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }

  getDateInd() {
    // var now = new DateTime.now();
    List hari = [
      "Senin",
      "Selasa",
      "Rabu",
      "Kamis",
      "Jumat",
      "Sabtu",
      "Minggu"
    ];
    List bulan = [
      "Januari",
      "Februari",
      "Maret",
      "April",
      "Mei",
      "Juni",
      "Juli",
      "Agustus",
      "September",
      "Oktober",
      "November",
      "Desember"
    ];
    DateTime basetanggal = new DateTime.now();
    String tanggal = basetanggal.day.toString();
    int _hari = basetanggal.weekday;
    int _bulan = basetanggal.month;
    int _tahun = basetanggal.year;
    String h = hari[_hari - 1];
    String b = bulan[_bulan - 1];
    int t = _tahun < 1000 ? _tahun + 1900 : _tahun;
    return h + ", " + tanggal + " " + b + " " + t.toString();
  }

  rndStr(resultLength, keyType, additionalVarLen) {
    //var i=0, random = Math.random, round = Math.floor, result = '', key = _genKey(keyType || 1), keyLength=key.length;
    var result = "",
        key = genKey(keyType != null ? keyType : 1),
        keyLength = getLength(key);

    for (var i = 0; i < resultLength; i++) {
      try {
        result += key[(new Random().nextDouble() * keyLength).round()];
      } catch (e) {
        result += "";
      }
    }
    return result;
  }

  String uuid() {
    var uuid = Uuid();
    var strUUID = uuid.v4();
    return strUUID;
  }

  enc(source, edType, nBitLen) {
    if (edType == null) {
      return nBitEnc(source, null, null);
    } else {
      return nBitEnc(source, nBitLen != null ? nBitLen : 6,
          isNumber(edType) ? genKey(edType) : edType);
    }
  }

  dec(source, edType, nBitLen) {
    if (edType == null) {
      //default base 128 decrypt
      return nBitDec(source, null, null);
    } else {
      //base 64 uri safe decrypt
      return nBitDec(source, nBitLen != null ? nBitLen : 6,
          isNumber(edType) ? genKey(edType) : edType);
    }
  }

  getToken({String key = "authtoken"}) async {
    String value = await storage.read(key: key);
    return value;
  }

  createToken({Duration duration = const Duration(minutes: 15)}) {
    Map<String, dynamic> data = {
      'uuid': uuid(),
      'expired_time': DateTime.now().subtract(duration)
    };
    var newToken = enc(jsonEncode(data), 1, 6);
    return newToken;
  }

  setToken(token, {String key = "authtoken"}) async {
    await storage.write(key: key, value: token);
  }
}

final global = new Global();
