// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $BusinessProfilesTable extends BusinessProfiles
    with TableInfo<$BusinessProfilesTable, BusinessProfile> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BusinessProfilesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _legalNameMeta = const VerificationMeta(
    'legalName',
  );
  @override
  late final GeneratedColumn<String> legalName = GeneratedColumn<String>(
    'legal_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _tradeNameMeta = const VerificationMeta(
    'tradeName',
  );
  @override
  late final GeneratedColumn<String> tradeName = GeneratedColumn<String>(
    'trade_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _kvkNumberMeta = const VerificationMeta(
    'kvkNumber',
  );
  @override
  late final GeneratedColumn<String> kvkNumber = GeneratedColumn<String>(
    'kvk_number',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _vatIdMeta = const VerificationMeta('vatId');
  @override
  late final GeneratedColumn<String> vatId = GeneratedColumn<String>(
    'vat_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _jpBusinessNumberMeta = const VerificationMeta(
    'jpBusinessNumber',
  );
  @override
  late final GeneratedColumn<String> jpBusinessNumber = GeneratedColumn<String>(
    'jp_business_number',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _addressLine1Meta = const VerificationMeta(
    'addressLine1',
  );
  @override
  late final GeneratedColumn<String> addressLine1 = GeneratedColumn<String>(
    'address_line1',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _addressLine2Meta = const VerificationMeta(
    'addressLine2',
  );
  @override
  late final GeneratedColumn<String> addressLine2 = GeneratedColumn<String>(
    'address_line2',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _postalCodeMeta = const VerificationMeta(
    'postalCode',
  );
  @override
  late final GeneratedColumn<String> postalCode = GeneratedColumn<String>(
    'postal_code',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _cityMeta = const VerificationMeta('city');
  @override
  late final GeneratedColumn<String> city = GeneratedColumn<String>(
    'city',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _countryMeta = const VerificationMeta(
    'country',
  );
  @override
  late final GeneratedColumn<String> country = GeneratedColumn<String>(
    'country',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('Japan'),
  );
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
    'email',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _phoneMeta = const VerificationMeta('phone');
  @override
  late final GeneratedColumn<String> phone = GeneratedColumn<String>(
    'phone',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _ibanMeta = const VerificationMeta('iban');
  @override
  late final GeneratedColumn<String> iban = GeneratedColumn<String>(
    'iban',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _bicMeta = const VerificationMeta('bic');
  @override
  late final GeneratedColumn<String> bic = GeneratedColumn<String>(
    'bic',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _bankNameMeta = const VerificationMeta(
    'bankName',
  );
  @override
  late final GeneratedColumn<String> bankName = GeneratedColumn<String>(
    'bank_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _defaultCurrencyMeta = const VerificationMeta(
    'defaultCurrency',
  );
  @override
  late final GeneratedColumn<String> defaultCurrency = GeneratedColumn<String>(
    'default_currency',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('EUR'),
  );
  static const VerificationMeta _defaultLanguageMeta = const VerificationMeta(
    'defaultLanguage',
  );
  @override
  late final GeneratedColumn<String> defaultLanguage = GeneratedColumn<String>(
    'default_language',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('en'),
  );
  static const VerificationMeta _invoiceNumberPrefixMeta =
      const VerificationMeta('invoiceNumberPrefix');
  @override
  late final GeneratedColumn<String> invoiceNumberPrefix =
      GeneratedColumn<String>(
        'invoice_number_prefix',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: const Constant('INV'),
      );
  static const VerificationMeta _nextInvoiceSeqMeta = const VerificationMeta(
    'nextInvoiceSeq',
  );
  @override
  late final GeneratedColumn<int> nextInvoiceSeq = GeneratedColumn<int>(
    'next_invoice_seq',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _logoPathMeta = const VerificationMeta(
    'logoPath',
  );
  @override
  late final GeneratedColumn<String> logoPath = GeneratedColumn<String>(
    'logo_path',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _signaturePathMeta = const VerificationMeta(
    'signaturePath',
  );
  @override
  late final GeneratedColumn<String> signaturePath = GeneratedColumn<String>(
    'signature_path',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _defaultHourlyRateMeta = const VerificationMeta(
    'defaultHourlyRate',
  );
  @override
  late final GeneratedColumn<double> defaultHourlyRate =
      GeneratedColumn<double>(
        'default_hourly_rate',
        aliasedName,
        false,
        type: DriftSqlType.double,
        requiredDuringInsert: false,
        defaultValue: const Constant(0),
      );
  static const VerificationMeta _eurToJpyRateMeta = const VerificationMeta(
    'eurToJpyRate',
  );
  @override
  late final GeneratedColumn<double> eurToJpyRate = GeneratedColumn<double>(
    'eur_to_jpy_rate',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(160),
  );
  static const VerificationMeta _themeModeMeta = const VerificationMeta(
    'themeMode',
  );
  @override
  late final GeneratedColumn<String> themeMode = GeneratedColumn<String>(
    'theme_mode',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('system'),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    legalName,
    tradeName,
    kvkNumber,
    vatId,
    jpBusinessNumber,
    addressLine1,
    addressLine2,
    postalCode,
    city,
    country,
    email,
    phone,
    iban,
    bic,
    bankName,
    defaultCurrency,
    defaultLanguage,
    invoiceNumberPrefix,
    nextInvoiceSeq,
    logoPath,
    signaturePath,
    defaultHourlyRate,
    eurToJpyRate,
    themeMode,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'business_profiles';
  @override
  VerificationContext validateIntegrity(
    Insertable<BusinessProfile> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('legal_name')) {
      context.handle(
        _legalNameMeta,
        legalName.isAcceptableOrUnknown(data['legal_name']!, _legalNameMeta),
      );
    }
    if (data.containsKey('trade_name')) {
      context.handle(
        _tradeNameMeta,
        tradeName.isAcceptableOrUnknown(data['trade_name']!, _tradeNameMeta),
      );
    }
    if (data.containsKey('kvk_number')) {
      context.handle(
        _kvkNumberMeta,
        kvkNumber.isAcceptableOrUnknown(data['kvk_number']!, _kvkNumberMeta),
      );
    }
    if (data.containsKey('vat_id')) {
      context.handle(
        _vatIdMeta,
        vatId.isAcceptableOrUnknown(data['vat_id']!, _vatIdMeta),
      );
    }
    if (data.containsKey('jp_business_number')) {
      context.handle(
        _jpBusinessNumberMeta,
        jpBusinessNumber.isAcceptableOrUnknown(
          data['jp_business_number']!,
          _jpBusinessNumberMeta,
        ),
      );
    }
    if (data.containsKey('address_line1')) {
      context.handle(
        _addressLine1Meta,
        addressLine1.isAcceptableOrUnknown(
          data['address_line1']!,
          _addressLine1Meta,
        ),
      );
    }
    if (data.containsKey('address_line2')) {
      context.handle(
        _addressLine2Meta,
        addressLine2.isAcceptableOrUnknown(
          data['address_line2']!,
          _addressLine2Meta,
        ),
      );
    }
    if (data.containsKey('postal_code')) {
      context.handle(
        _postalCodeMeta,
        postalCode.isAcceptableOrUnknown(data['postal_code']!, _postalCodeMeta),
      );
    }
    if (data.containsKey('city')) {
      context.handle(
        _cityMeta,
        city.isAcceptableOrUnknown(data['city']!, _cityMeta),
      );
    }
    if (data.containsKey('country')) {
      context.handle(
        _countryMeta,
        country.isAcceptableOrUnknown(data['country']!, _countryMeta),
      );
    }
    if (data.containsKey('email')) {
      context.handle(
        _emailMeta,
        email.isAcceptableOrUnknown(data['email']!, _emailMeta),
      );
    }
    if (data.containsKey('phone')) {
      context.handle(
        _phoneMeta,
        phone.isAcceptableOrUnknown(data['phone']!, _phoneMeta),
      );
    }
    if (data.containsKey('iban')) {
      context.handle(
        _ibanMeta,
        iban.isAcceptableOrUnknown(data['iban']!, _ibanMeta),
      );
    }
    if (data.containsKey('bic')) {
      context.handle(
        _bicMeta,
        bic.isAcceptableOrUnknown(data['bic']!, _bicMeta),
      );
    }
    if (data.containsKey('bank_name')) {
      context.handle(
        _bankNameMeta,
        bankName.isAcceptableOrUnknown(data['bank_name']!, _bankNameMeta),
      );
    }
    if (data.containsKey('default_currency')) {
      context.handle(
        _defaultCurrencyMeta,
        defaultCurrency.isAcceptableOrUnknown(
          data['default_currency']!,
          _defaultCurrencyMeta,
        ),
      );
    }
    if (data.containsKey('default_language')) {
      context.handle(
        _defaultLanguageMeta,
        defaultLanguage.isAcceptableOrUnknown(
          data['default_language']!,
          _defaultLanguageMeta,
        ),
      );
    }
    if (data.containsKey('invoice_number_prefix')) {
      context.handle(
        _invoiceNumberPrefixMeta,
        invoiceNumberPrefix.isAcceptableOrUnknown(
          data['invoice_number_prefix']!,
          _invoiceNumberPrefixMeta,
        ),
      );
    }
    if (data.containsKey('next_invoice_seq')) {
      context.handle(
        _nextInvoiceSeqMeta,
        nextInvoiceSeq.isAcceptableOrUnknown(
          data['next_invoice_seq']!,
          _nextInvoiceSeqMeta,
        ),
      );
    }
    if (data.containsKey('logo_path')) {
      context.handle(
        _logoPathMeta,
        logoPath.isAcceptableOrUnknown(data['logo_path']!, _logoPathMeta),
      );
    }
    if (data.containsKey('signature_path')) {
      context.handle(
        _signaturePathMeta,
        signaturePath.isAcceptableOrUnknown(
          data['signature_path']!,
          _signaturePathMeta,
        ),
      );
    }
    if (data.containsKey('default_hourly_rate')) {
      context.handle(
        _defaultHourlyRateMeta,
        defaultHourlyRate.isAcceptableOrUnknown(
          data['default_hourly_rate']!,
          _defaultHourlyRateMeta,
        ),
      );
    }
    if (data.containsKey('eur_to_jpy_rate')) {
      context.handle(
        _eurToJpyRateMeta,
        eurToJpyRate.isAcceptableOrUnknown(
          data['eur_to_jpy_rate']!,
          _eurToJpyRateMeta,
        ),
      );
    }
    if (data.containsKey('theme_mode')) {
      context.handle(
        _themeModeMeta,
        themeMode.isAcceptableOrUnknown(data['theme_mode']!, _themeModeMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  BusinessProfile map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BusinessProfile(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      legalName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}legal_name'],
      )!,
      tradeName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}trade_name'],
      )!,
      kvkNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}kvk_number'],
      )!,
      vatId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}vat_id'],
      )!,
      jpBusinessNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}jp_business_number'],
      )!,
      addressLine1: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}address_line1'],
      )!,
      addressLine2: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}address_line2'],
      )!,
      postalCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}postal_code'],
      )!,
      city: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}city'],
      )!,
      country: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}country'],
      )!,
      email: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}email'],
      )!,
      phone: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}phone'],
      )!,
      iban: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}iban'],
      )!,
      bic: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}bic'],
      )!,
      bankName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}bank_name'],
      )!,
      defaultCurrency: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}default_currency'],
      )!,
      defaultLanguage: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}default_language'],
      )!,
      invoiceNumberPrefix: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}invoice_number_prefix'],
      )!,
      nextInvoiceSeq: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}next_invoice_seq'],
      )!,
      logoPath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}logo_path'],
      ),
      signaturePath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}signature_path'],
      ),
      defaultHourlyRate: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}default_hourly_rate'],
      )!,
      eurToJpyRate: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}eur_to_jpy_rate'],
      )!,
      themeMode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}theme_mode'],
      )!,
    );
  }

  @override
  $BusinessProfilesTable createAlias(String alias) {
    return $BusinessProfilesTable(attachedDatabase, alias);
  }
}

class BusinessProfile extends DataClass implements Insertable<BusinessProfile> {
  final String id;
  final String legalName;
  final String tradeName;
  final String kvkNumber;
  final String vatId;
  final String jpBusinessNumber;
  final String addressLine1;
  final String addressLine2;
  final String postalCode;
  final String city;
  final String country;
  final String email;
  final String phone;
  final String iban;
  final String bic;
  final String bankName;
  final String defaultCurrency;
  final String defaultLanguage;
  final String invoiceNumberPrefix;
  final int nextInvoiceSeq;
  final String? logoPath;
  final String? signaturePath;
  final double defaultHourlyRate;

  /// EUR→JPY rate used to convert profit for the Japanese income-tax estimate
  /// (dashboard set-aside + annual report). A planning figure, edited in Settings.
  final double eurToJpyRate;

  /// App theme preference: 'system' | 'light' | 'dark'.
  final String themeMode;
  const BusinessProfile({
    required this.id,
    required this.legalName,
    required this.tradeName,
    required this.kvkNumber,
    required this.vatId,
    required this.jpBusinessNumber,
    required this.addressLine1,
    required this.addressLine2,
    required this.postalCode,
    required this.city,
    required this.country,
    required this.email,
    required this.phone,
    required this.iban,
    required this.bic,
    required this.bankName,
    required this.defaultCurrency,
    required this.defaultLanguage,
    required this.invoiceNumberPrefix,
    required this.nextInvoiceSeq,
    this.logoPath,
    this.signaturePath,
    required this.defaultHourlyRate,
    required this.eurToJpyRate,
    required this.themeMode,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['legal_name'] = Variable<String>(legalName);
    map['trade_name'] = Variable<String>(tradeName);
    map['kvk_number'] = Variable<String>(kvkNumber);
    map['vat_id'] = Variable<String>(vatId);
    map['jp_business_number'] = Variable<String>(jpBusinessNumber);
    map['address_line1'] = Variable<String>(addressLine1);
    map['address_line2'] = Variable<String>(addressLine2);
    map['postal_code'] = Variable<String>(postalCode);
    map['city'] = Variable<String>(city);
    map['country'] = Variable<String>(country);
    map['email'] = Variable<String>(email);
    map['phone'] = Variable<String>(phone);
    map['iban'] = Variable<String>(iban);
    map['bic'] = Variable<String>(bic);
    map['bank_name'] = Variable<String>(bankName);
    map['default_currency'] = Variable<String>(defaultCurrency);
    map['default_language'] = Variable<String>(defaultLanguage);
    map['invoice_number_prefix'] = Variable<String>(invoiceNumberPrefix);
    map['next_invoice_seq'] = Variable<int>(nextInvoiceSeq);
    if (!nullToAbsent || logoPath != null) {
      map['logo_path'] = Variable<String>(logoPath);
    }
    if (!nullToAbsent || signaturePath != null) {
      map['signature_path'] = Variable<String>(signaturePath);
    }
    map['default_hourly_rate'] = Variable<double>(defaultHourlyRate);
    map['eur_to_jpy_rate'] = Variable<double>(eurToJpyRate);
    map['theme_mode'] = Variable<String>(themeMode);
    return map;
  }

  BusinessProfilesCompanion toCompanion(bool nullToAbsent) {
    return BusinessProfilesCompanion(
      id: Value(id),
      legalName: Value(legalName),
      tradeName: Value(tradeName),
      kvkNumber: Value(kvkNumber),
      vatId: Value(vatId),
      jpBusinessNumber: Value(jpBusinessNumber),
      addressLine1: Value(addressLine1),
      addressLine2: Value(addressLine2),
      postalCode: Value(postalCode),
      city: Value(city),
      country: Value(country),
      email: Value(email),
      phone: Value(phone),
      iban: Value(iban),
      bic: Value(bic),
      bankName: Value(bankName),
      defaultCurrency: Value(defaultCurrency),
      defaultLanguage: Value(defaultLanguage),
      invoiceNumberPrefix: Value(invoiceNumberPrefix),
      nextInvoiceSeq: Value(nextInvoiceSeq),
      logoPath: logoPath == null && nullToAbsent
          ? const Value.absent()
          : Value(logoPath),
      signaturePath: signaturePath == null && nullToAbsent
          ? const Value.absent()
          : Value(signaturePath),
      defaultHourlyRate: Value(defaultHourlyRate),
      eurToJpyRate: Value(eurToJpyRate),
      themeMode: Value(themeMode),
    );
  }

  factory BusinessProfile.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BusinessProfile(
      id: serializer.fromJson<String>(json['id']),
      legalName: serializer.fromJson<String>(json['legalName']),
      tradeName: serializer.fromJson<String>(json['tradeName']),
      kvkNumber: serializer.fromJson<String>(json['kvkNumber']),
      vatId: serializer.fromJson<String>(json['vatId']),
      jpBusinessNumber: serializer.fromJson<String>(json['jpBusinessNumber']),
      addressLine1: serializer.fromJson<String>(json['addressLine1']),
      addressLine2: serializer.fromJson<String>(json['addressLine2']),
      postalCode: serializer.fromJson<String>(json['postalCode']),
      city: serializer.fromJson<String>(json['city']),
      country: serializer.fromJson<String>(json['country']),
      email: serializer.fromJson<String>(json['email']),
      phone: serializer.fromJson<String>(json['phone']),
      iban: serializer.fromJson<String>(json['iban']),
      bic: serializer.fromJson<String>(json['bic']),
      bankName: serializer.fromJson<String>(json['bankName']),
      defaultCurrency: serializer.fromJson<String>(json['defaultCurrency']),
      defaultLanguage: serializer.fromJson<String>(json['defaultLanguage']),
      invoiceNumberPrefix: serializer.fromJson<String>(
        json['invoiceNumberPrefix'],
      ),
      nextInvoiceSeq: serializer.fromJson<int>(json['nextInvoiceSeq']),
      logoPath: serializer.fromJson<String?>(json['logoPath']),
      signaturePath: serializer.fromJson<String?>(json['signaturePath']),
      defaultHourlyRate: serializer.fromJson<double>(json['defaultHourlyRate']),
      eurToJpyRate: serializer.fromJson<double>(json['eurToJpyRate']),
      themeMode: serializer.fromJson<String>(json['themeMode']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'legalName': serializer.toJson<String>(legalName),
      'tradeName': serializer.toJson<String>(tradeName),
      'kvkNumber': serializer.toJson<String>(kvkNumber),
      'vatId': serializer.toJson<String>(vatId),
      'jpBusinessNumber': serializer.toJson<String>(jpBusinessNumber),
      'addressLine1': serializer.toJson<String>(addressLine1),
      'addressLine2': serializer.toJson<String>(addressLine2),
      'postalCode': serializer.toJson<String>(postalCode),
      'city': serializer.toJson<String>(city),
      'country': serializer.toJson<String>(country),
      'email': serializer.toJson<String>(email),
      'phone': serializer.toJson<String>(phone),
      'iban': serializer.toJson<String>(iban),
      'bic': serializer.toJson<String>(bic),
      'bankName': serializer.toJson<String>(bankName),
      'defaultCurrency': serializer.toJson<String>(defaultCurrency),
      'defaultLanguage': serializer.toJson<String>(defaultLanguage),
      'invoiceNumberPrefix': serializer.toJson<String>(invoiceNumberPrefix),
      'nextInvoiceSeq': serializer.toJson<int>(nextInvoiceSeq),
      'logoPath': serializer.toJson<String?>(logoPath),
      'signaturePath': serializer.toJson<String?>(signaturePath),
      'defaultHourlyRate': serializer.toJson<double>(defaultHourlyRate),
      'eurToJpyRate': serializer.toJson<double>(eurToJpyRate),
      'themeMode': serializer.toJson<String>(themeMode),
    };
  }

  BusinessProfile copyWith({
    String? id,
    String? legalName,
    String? tradeName,
    String? kvkNumber,
    String? vatId,
    String? jpBusinessNumber,
    String? addressLine1,
    String? addressLine2,
    String? postalCode,
    String? city,
    String? country,
    String? email,
    String? phone,
    String? iban,
    String? bic,
    String? bankName,
    String? defaultCurrency,
    String? defaultLanguage,
    String? invoiceNumberPrefix,
    int? nextInvoiceSeq,
    Value<String?> logoPath = const Value.absent(),
    Value<String?> signaturePath = const Value.absent(),
    double? defaultHourlyRate,
    double? eurToJpyRate,
    String? themeMode,
  }) => BusinessProfile(
    id: id ?? this.id,
    legalName: legalName ?? this.legalName,
    tradeName: tradeName ?? this.tradeName,
    kvkNumber: kvkNumber ?? this.kvkNumber,
    vatId: vatId ?? this.vatId,
    jpBusinessNumber: jpBusinessNumber ?? this.jpBusinessNumber,
    addressLine1: addressLine1 ?? this.addressLine1,
    addressLine2: addressLine2 ?? this.addressLine2,
    postalCode: postalCode ?? this.postalCode,
    city: city ?? this.city,
    country: country ?? this.country,
    email: email ?? this.email,
    phone: phone ?? this.phone,
    iban: iban ?? this.iban,
    bic: bic ?? this.bic,
    bankName: bankName ?? this.bankName,
    defaultCurrency: defaultCurrency ?? this.defaultCurrency,
    defaultLanguage: defaultLanguage ?? this.defaultLanguage,
    invoiceNumberPrefix: invoiceNumberPrefix ?? this.invoiceNumberPrefix,
    nextInvoiceSeq: nextInvoiceSeq ?? this.nextInvoiceSeq,
    logoPath: logoPath.present ? logoPath.value : this.logoPath,
    signaturePath: signaturePath.present
        ? signaturePath.value
        : this.signaturePath,
    defaultHourlyRate: defaultHourlyRate ?? this.defaultHourlyRate,
    eurToJpyRate: eurToJpyRate ?? this.eurToJpyRate,
    themeMode: themeMode ?? this.themeMode,
  );
  BusinessProfile copyWithCompanion(BusinessProfilesCompanion data) {
    return BusinessProfile(
      id: data.id.present ? data.id.value : this.id,
      legalName: data.legalName.present ? data.legalName.value : this.legalName,
      tradeName: data.tradeName.present ? data.tradeName.value : this.tradeName,
      kvkNumber: data.kvkNumber.present ? data.kvkNumber.value : this.kvkNumber,
      vatId: data.vatId.present ? data.vatId.value : this.vatId,
      jpBusinessNumber: data.jpBusinessNumber.present
          ? data.jpBusinessNumber.value
          : this.jpBusinessNumber,
      addressLine1: data.addressLine1.present
          ? data.addressLine1.value
          : this.addressLine1,
      addressLine2: data.addressLine2.present
          ? data.addressLine2.value
          : this.addressLine2,
      postalCode: data.postalCode.present
          ? data.postalCode.value
          : this.postalCode,
      city: data.city.present ? data.city.value : this.city,
      country: data.country.present ? data.country.value : this.country,
      email: data.email.present ? data.email.value : this.email,
      phone: data.phone.present ? data.phone.value : this.phone,
      iban: data.iban.present ? data.iban.value : this.iban,
      bic: data.bic.present ? data.bic.value : this.bic,
      bankName: data.bankName.present ? data.bankName.value : this.bankName,
      defaultCurrency: data.defaultCurrency.present
          ? data.defaultCurrency.value
          : this.defaultCurrency,
      defaultLanguage: data.defaultLanguage.present
          ? data.defaultLanguage.value
          : this.defaultLanguage,
      invoiceNumberPrefix: data.invoiceNumberPrefix.present
          ? data.invoiceNumberPrefix.value
          : this.invoiceNumberPrefix,
      nextInvoiceSeq: data.nextInvoiceSeq.present
          ? data.nextInvoiceSeq.value
          : this.nextInvoiceSeq,
      logoPath: data.logoPath.present ? data.logoPath.value : this.logoPath,
      signaturePath: data.signaturePath.present
          ? data.signaturePath.value
          : this.signaturePath,
      defaultHourlyRate: data.defaultHourlyRate.present
          ? data.defaultHourlyRate.value
          : this.defaultHourlyRate,
      eurToJpyRate: data.eurToJpyRate.present
          ? data.eurToJpyRate.value
          : this.eurToJpyRate,
      themeMode: data.themeMode.present ? data.themeMode.value : this.themeMode,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BusinessProfile(')
          ..write('id: $id, ')
          ..write('legalName: $legalName, ')
          ..write('tradeName: $tradeName, ')
          ..write('kvkNumber: $kvkNumber, ')
          ..write('vatId: $vatId, ')
          ..write('jpBusinessNumber: $jpBusinessNumber, ')
          ..write('addressLine1: $addressLine1, ')
          ..write('addressLine2: $addressLine2, ')
          ..write('postalCode: $postalCode, ')
          ..write('city: $city, ')
          ..write('country: $country, ')
          ..write('email: $email, ')
          ..write('phone: $phone, ')
          ..write('iban: $iban, ')
          ..write('bic: $bic, ')
          ..write('bankName: $bankName, ')
          ..write('defaultCurrency: $defaultCurrency, ')
          ..write('defaultLanguage: $defaultLanguage, ')
          ..write('invoiceNumberPrefix: $invoiceNumberPrefix, ')
          ..write('nextInvoiceSeq: $nextInvoiceSeq, ')
          ..write('logoPath: $logoPath, ')
          ..write('signaturePath: $signaturePath, ')
          ..write('defaultHourlyRate: $defaultHourlyRate, ')
          ..write('eurToJpyRate: $eurToJpyRate, ')
          ..write('themeMode: $themeMode')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
    id,
    legalName,
    tradeName,
    kvkNumber,
    vatId,
    jpBusinessNumber,
    addressLine1,
    addressLine2,
    postalCode,
    city,
    country,
    email,
    phone,
    iban,
    bic,
    bankName,
    defaultCurrency,
    defaultLanguage,
    invoiceNumberPrefix,
    nextInvoiceSeq,
    logoPath,
    signaturePath,
    defaultHourlyRate,
    eurToJpyRate,
    themeMode,
  ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BusinessProfile &&
          other.id == this.id &&
          other.legalName == this.legalName &&
          other.tradeName == this.tradeName &&
          other.kvkNumber == this.kvkNumber &&
          other.vatId == this.vatId &&
          other.jpBusinessNumber == this.jpBusinessNumber &&
          other.addressLine1 == this.addressLine1 &&
          other.addressLine2 == this.addressLine2 &&
          other.postalCode == this.postalCode &&
          other.city == this.city &&
          other.country == this.country &&
          other.email == this.email &&
          other.phone == this.phone &&
          other.iban == this.iban &&
          other.bic == this.bic &&
          other.bankName == this.bankName &&
          other.defaultCurrency == this.defaultCurrency &&
          other.defaultLanguage == this.defaultLanguage &&
          other.invoiceNumberPrefix == this.invoiceNumberPrefix &&
          other.nextInvoiceSeq == this.nextInvoiceSeq &&
          other.logoPath == this.logoPath &&
          other.signaturePath == this.signaturePath &&
          other.defaultHourlyRate == this.defaultHourlyRate &&
          other.eurToJpyRate == this.eurToJpyRate &&
          other.themeMode == this.themeMode);
}

class BusinessProfilesCompanion extends UpdateCompanion<BusinessProfile> {
  final Value<String> id;
  final Value<String> legalName;
  final Value<String> tradeName;
  final Value<String> kvkNumber;
  final Value<String> vatId;
  final Value<String> jpBusinessNumber;
  final Value<String> addressLine1;
  final Value<String> addressLine2;
  final Value<String> postalCode;
  final Value<String> city;
  final Value<String> country;
  final Value<String> email;
  final Value<String> phone;
  final Value<String> iban;
  final Value<String> bic;
  final Value<String> bankName;
  final Value<String> defaultCurrency;
  final Value<String> defaultLanguage;
  final Value<String> invoiceNumberPrefix;
  final Value<int> nextInvoiceSeq;
  final Value<String?> logoPath;
  final Value<String?> signaturePath;
  final Value<double> defaultHourlyRate;
  final Value<double> eurToJpyRate;
  final Value<String> themeMode;
  final Value<int> rowid;
  const BusinessProfilesCompanion({
    this.id = const Value.absent(),
    this.legalName = const Value.absent(),
    this.tradeName = const Value.absent(),
    this.kvkNumber = const Value.absent(),
    this.vatId = const Value.absent(),
    this.jpBusinessNumber = const Value.absent(),
    this.addressLine1 = const Value.absent(),
    this.addressLine2 = const Value.absent(),
    this.postalCode = const Value.absent(),
    this.city = const Value.absent(),
    this.country = const Value.absent(),
    this.email = const Value.absent(),
    this.phone = const Value.absent(),
    this.iban = const Value.absent(),
    this.bic = const Value.absent(),
    this.bankName = const Value.absent(),
    this.defaultCurrency = const Value.absent(),
    this.defaultLanguage = const Value.absent(),
    this.invoiceNumberPrefix = const Value.absent(),
    this.nextInvoiceSeq = const Value.absent(),
    this.logoPath = const Value.absent(),
    this.signaturePath = const Value.absent(),
    this.defaultHourlyRate = const Value.absent(),
    this.eurToJpyRate = const Value.absent(),
    this.themeMode = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  BusinessProfilesCompanion.insert({
    required String id,
    this.legalName = const Value.absent(),
    this.tradeName = const Value.absent(),
    this.kvkNumber = const Value.absent(),
    this.vatId = const Value.absent(),
    this.jpBusinessNumber = const Value.absent(),
    this.addressLine1 = const Value.absent(),
    this.addressLine2 = const Value.absent(),
    this.postalCode = const Value.absent(),
    this.city = const Value.absent(),
    this.country = const Value.absent(),
    this.email = const Value.absent(),
    this.phone = const Value.absent(),
    this.iban = const Value.absent(),
    this.bic = const Value.absent(),
    this.bankName = const Value.absent(),
    this.defaultCurrency = const Value.absent(),
    this.defaultLanguage = const Value.absent(),
    this.invoiceNumberPrefix = const Value.absent(),
    this.nextInvoiceSeq = const Value.absent(),
    this.logoPath = const Value.absent(),
    this.signaturePath = const Value.absent(),
    this.defaultHourlyRate = const Value.absent(),
    this.eurToJpyRate = const Value.absent(),
    this.themeMode = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id);
  static Insertable<BusinessProfile> custom({
    Expression<String>? id,
    Expression<String>? legalName,
    Expression<String>? tradeName,
    Expression<String>? kvkNumber,
    Expression<String>? vatId,
    Expression<String>? jpBusinessNumber,
    Expression<String>? addressLine1,
    Expression<String>? addressLine2,
    Expression<String>? postalCode,
    Expression<String>? city,
    Expression<String>? country,
    Expression<String>? email,
    Expression<String>? phone,
    Expression<String>? iban,
    Expression<String>? bic,
    Expression<String>? bankName,
    Expression<String>? defaultCurrency,
    Expression<String>? defaultLanguage,
    Expression<String>? invoiceNumberPrefix,
    Expression<int>? nextInvoiceSeq,
    Expression<String>? logoPath,
    Expression<String>? signaturePath,
    Expression<double>? defaultHourlyRate,
    Expression<double>? eurToJpyRate,
    Expression<String>? themeMode,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (legalName != null) 'legal_name': legalName,
      if (tradeName != null) 'trade_name': tradeName,
      if (kvkNumber != null) 'kvk_number': kvkNumber,
      if (vatId != null) 'vat_id': vatId,
      if (jpBusinessNumber != null) 'jp_business_number': jpBusinessNumber,
      if (addressLine1 != null) 'address_line1': addressLine1,
      if (addressLine2 != null) 'address_line2': addressLine2,
      if (postalCode != null) 'postal_code': postalCode,
      if (city != null) 'city': city,
      if (country != null) 'country': country,
      if (email != null) 'email': email,
      if (phone != null) 'phone': phone,
      if (iban != null) 'iban': iban,
      if (bic != null) 'bic': bic,
      if (bankName != null) 'bank_name': bankName,
      if (defaultCurrency != null) 'default_currency': defaultCurrency,
      if (defaultLanguage != null) 'default_language': defaultLanguage,
      if (invoiceNumberPrefix != null)
        'invoice_number_prefix': invoiceNumberPrefix,
      if (nextInvoiceSeq != null) 'next_invoice_seq': nextInvoiceSeq,
      if (logoPath != null) 'logo_path': logoPath,
      if (signaturePath != null) 'signature_path': signaturePath,
      if (defaultHourlyRate != null) 'default_hourly_rate': defaultHourlyRate,
      if (eurToJpyRate != null) 'eur_to_jpy_rate': eurToJpyRate,
      if (themeMode != null) 'theme_mode': themeMode,
      if (rowid != null) 'rowid': rowid,
    });
  }

  BusinessProfilesCompanion copyWith({
    Value<String>? id,
    Value<String>? legalName,
    Value<String>? tradeName,
    Value<String>? kvkNumber,
    Value<String>? vatId,
    Value<String>? jpBusinessNumber,
    Value<String>? addressLine1,
    Value<String>? addressLine2,
    Value<String>? postalCode,
    Value<String>? city,
    Value<String>? country,
    Value<String>? email,
    Value<String>? phone,
    Value<String>? iban,
    Value<String>? bic,
    Value<String>? bankName,
    Value<String>? defaultCurrency,
    Value<String>? defaultLanguage,
    Value<String>? invoiceNumberPrefix,
    Value<int>? nextInvoiceSeq,
    Value<String?>? logoPath,
    Value<String?>? signaturePath,
    Value<double>? defaultHourlyRate,
    Value<double>? eurToJpyRate,
    Value<String>? themeMode,
    Value<int>? rowid,
  }) {
    return BusinessProfilesCompanion(
      id: id ?? this.id,
      legalName: legalName ?? this.legalName,
      tradeName: tradeName ?? this.tradeName,
      kvkNumber: kvkNumber ?? this.kvkNumber,
      vatId: vatId ?? this.vatId,
      jpBusinessNumber: jpBusinessNumber ?? this.jpBusinessNumber,
      addressLine1: addressLine1 ?? this.addressLine1,
      addressLine2: addressLine2 ?? this.addressLine2,
      postalCode: postalCode ?? this.postalCode,
      city: city ?? this.city,
      country: country ?? this.country,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      iban: iban ?? this.iban,
      bic: bic ?? this.bic,
      bankName: bankName ?? this.bankName,
      defaultCurrency: defaultCurrency ?? this.defaultCurrency,
      defaultLanguage: defaultLanguage ?? this.defaultLanguage,
      invoiceNumberPrefix: invoiceNumberPrefix ?? this.invoiceNumberPrefix,
      nextInvoiceSeq: nextInvoiceSeq ?? this.nextInvoiceSeq,
      logoPath: logoPath ?? this.logoPath,
      signaturePath: signaturePath ?? this.signaturePath,
      defaultHourlyRate: defaultHourlyRate ?? this.defaultHourlyRate,
      eurToJpyRate: eurToJpyRate ?? this.eurToJpyRate,
      themeMode: themeMode ?? this.themeMode,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (legalName.present) {
      map['legal_name'] = Variable<String>(legalName.value);
    }
    if (tradeName.present) {
      map['trade_name'] = Variable<String>(tradeName.value);
    }
    if (kvkNumber.present) {
      map['kvk_number'] = Variable<String>(kvkNumber.value);
    }
    if (vatId.present) {
      map['vat_id'] = Variable<String>(vatId.value);
    }
    if (jpBusinessNumber.present) {
      map['jp_business_number'] = Variable<String>(jpBusinessNumber.value);
    }
    if (addressLine1.present) {
      map['address_line1'] = Variable<String>(addressLine1.value);
    }
    if (addressLine2.present) {
      map['address_line2'] = Variable<String>(addressLine2.value);
    }
    if (postalCode.present) {
      map['postal_code'] = Variable<String>(postalCode.value);
    }
    if (city.present) {
      map['city'] = Variable<String>(city.value);
    }
    if (country.present) {
      map['country'] = Variable<String>(country.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (phone.present) {
      map['phone'] = Variable<String>(phone.value);
    }
    if (iban.present) {
      map['iban'] = Variable<String>(iban.value);
    }
    if (bic.present) {
      map['bic'] = Variable<String>(bic.value);
    }
    if (bankName.present) {
      map['bank_name'] = Variable<String>(bankName.value);
    }
    if (defaultCurrency.present) {
      map['default_currency'] = Variable<String>(defaultCurrency.value);
    }
    if (defaultLanguage.present) {
      map['default_language'] = Variable<String>(defaultLanguage.value);
    }
    if (invoiceNumberPrefix.present) {
      map['invoice_number_prefix'] = Variable<String>(
        invoiceNumberPrefix.value,
      );
    }
    if (nextInvoiceSeq.present) {
      map['next_invoice_seq'] = Variable<int>(nextInvoiceSeq.value);
    }
    if (logoPath.present) {
      map['logo_path'] = Variable<String>(logoPath.value);
    }
    if (signaturePath.present) {
      map['signature_path'] = Variable<String>(signaturePath.value);
    }
    if (defaultHourlyRate.present) {
      map['default_hourly_rate'] = Variable<double>(defaultHourlyRate.value);
    }
    if (eurToJpyRate.present) {
      map['eur_to_jpy_rate'] = Variable<double>(eurToJpyRate.value);
    }
    if (themeMode.present) {
      map['theme_mode'] = Variable<String>(themeMode.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BusinessProfilesCompanion(')
          ..write('id: $id, ')
          ..write('legalName: $legalName, ')
          ..write('tradeName: $tradeName, ')
          ..write('kvkNumber: $kvkNumber, ')
          ..write('vatId: $vatId, ')
          ..write('jpBusinessNumber: $jpBusinessNumber, ')
          ..write('addressLine1: $addressLine1, ')
          ..write('addressLine2: $addressLine2, ')
          ..write('postalCode: $postalCode, ')
          ..write('city: $city, ')
          ..write('country: $country, ')
          ..write('email: $email, ')
          ..write('phone: $phone, ')
          ..write('iban: $iban, ')
          ..write('bic: $bic, ')
          ..write('bankName: $bankName, ')
          ..write('defaultCurrency: $defaultCurrency, ')
          ..write('defaultLanguage: $defaultLanguage, ')
          ..write('invoiceNumberPrefix: $invoiceNumberPrefix, ')
          ..write('nextInvoiceSeq: $nextInvoiceSeq, ')
          ..write('logoPath: $logoPath, ')
          ..write('signaturePath: $signaturePath, ')
          ..write('defaultHourlyRate: $defaultHourlyRate, ')
          ..write('eurToJpyRate: $eurToJpyRate, ')
          ..write('themeMode: $themeMode, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ClientsTable extends Clients with TableInfo<$ClientsTable, Client> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ClientsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _contactNameMeta = const VerificationMeta(
    'contactName',
  );
  @override
  late final GeneratedColumn<String> contactName = GeneratedColumn<String>(
    'contact_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _vatIdMeta = const VerificationMeta('vatId');
  @override
  late final GeneratedColumn<String> vatId = GeneratedColumn<String>(
    'vat_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _addressLine1Meta = const VerificationMeta(
    'addressLine1',
  );
  @override
  late final GeneratedColumn<String> addressLine1 = GeneratedColumn<String>(
    'address_line1',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _addressLine2Meta = const VerificationMeta(
    'addressLine2',
  );
  @override
  late final GeneratedColumn<String> addressLine2 = GeneratedColumn<String>(
    'address_line2',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _postalCodeMeta = const VerificationMeta(
    'postalCode',
  );
  @override
  late final GeneratedColumn<String> postalCode = GeneratedColumn<String>(
    'postal_code',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _cityMeta = const VerificationMeta('city');
  @override
  late final GeneratedColumn<String> city = GeneratedColumn<String>(
    'city',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _countryMeta = const VerificationMeta(
    'country',
  );
  @override
  late final GeneratedColumn<String> country = GeneratedColumn<String>(
    'country',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('Netherlands'),
  );
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
    'email',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _defaultCurrencyMeta = const VerificationMeta(
    'defaultCurrency',
  );
  @override
  late final GeneratedColumn<String> defaultCurrency = GeneratedColumn<String>(
    'default_currency',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('EUR'),
  );
  static const VerificationMeta _languageMeta = const VerificationMeta(
    'language',
  );
  @override
  late final GeneratedColumn<String> language = GeneratedColumn<String>(
    'language',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('nl'),
  );
  static const VerificationMeta _defaultVatTreatmentMeta =
      const VerificationMeta('defaultVatTreatment');
  @override
  late final GeneratedColumn<String> defaultVatTreatment =
      GeneratedColumn<String>(
        'default_vat_treatment',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: const Constant('reverseChargeEu'),
      );
  static const VerificationMeta _defaultHourlyRateMeta = const VerificationMeta(
    'defaultHourlyRate',
  );
  @override
  late final GeneratedColumn<double> defaultHourlyRate =
      GeneratedColumn<double>(
        'default_hourly_rate',
        aliasedName,
        true,
        type: DriftSqlType.double,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _paymentTermDaysMeta = const VerificationMeta(
    'paymentTermDays',
  );
  @override
  late final GeneratedColumn<int> paymentTermDays = GeneratedColumn<int>(
    'payment_term_days',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(30),
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _archivedMeta = const VerificationMeta(
    'archived',
  );
  @override
  late final GeneratedColumn<bool> archived = GeneratedColumn<bool>(
    'archived',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("archived" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    contactName,
    vatId,
    addressLine1,
    addressLine2,
    postalCode,
    city,
    country,
    email,
    defaultCurrency,
    language,
    defaultVatTreatment,
    defaultHourlyRate,
    paymentTermDays,
    notes,
    archived,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'clients';
  @override
  VerificationContext validateIntegrity(
    Insertable<Client> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('contact_name')) {
      context.handle(
        _contactNameMeta,
        contactName.isAcceptableOrUnknown(
          data['contact_name']!,
          _contactNameMeta,
        ),
      );
    }
    if (data.containsKey('vat_id')) {
      context.handle(
        _vatIdMeta,
        vatId.isAcceptableOrUnknown(data['vat_id']!, _vatIdMeta),
      );
    }
    if (data.containsKey('address_line1')) {
      context.handle(
        _addressLine1Meta,
        addressLine1.isAcceptableOrUnknown(
          data['address_line1']!,
          _addressLine1Meta,
        ),
      );
    }
    if (data.containsKey('address_line2')) {
      context.handle(
        _addressLine2Meta,
        addressLine2.isAcceptableOrUnknown(
          data['address_line2']!,
          _addressLine2Meta,
        ),
      );
    }
    if (data.containsKey('postal_code')) {
      context.handle(
        _postalCodeMeta,
        postalCode.isAcceptableOrUnknown(data['postal_code']!, _postalCodeMeta),
      );
    }
    if (data.containsKey('city')) {
      context.handle(
        _cityMeta,
        city.isAcceptableOrUnknown(data['city']!, _cityMeta),
      );
    }
    if (data.containsKey('country')) {
      context.handle(
        _countryMeta,
        country.isAcceptableOrUnknown(data['country']!, _countryMeta),
      );
    }
    if (data.containsKey('email')) {
      context.handle(
        _emailMeta,
        email.isAcceptableOrUnknown(data['email']!, _emailMeta),
      );
    }
    if (data.containsKey('default_currency')) {
      context.handle(
        _defaultCurrencyMeta,
        defaultCurrency.isAcceptableOrUnknown(
          data['default_currency']!,
          _defaultCurrencyMeta,
        ),
      );
    }
    if (data.containsKey('language')) {
      context.handle(
        _languageMeta,
        language.isAcceptableOrUnknown(data['language']!, _languageMeta),
      );
    }
    if (data.containsKey('default_vat_treatment')) {
      context.handle(
        _defaultVatTreatmentMeta,
        defaultVatTreatment.isAcceptableOrUnknown(
          data['default_vat_treatment']!,
          _defaultVatTreatmentMeta,
        ),
      );
    }
    if (data.containsKey('default_hourly_rate')) {
      context.handle(
        _defaultHourlyRateMeta,
        defaultHourlyRate.isAcceptableOrUnknown(
          data['default_hourly_rate']!,
          _defaultHourlyRateMeta,
        ),
      );
    }
    if (data.containsKey('payment_term_days')) {
      context.handle(
        _paymentTermDaysMeta,
        paymentTermDays.isAcceptableOrUnknown(
          data['payment_term_days']!,
          _paymentTermDaysMeta,
        ),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('archived')) {
      context.handle(
        _archivedMeta,
        archived.isAcceptableOrUnknown(data['archived']!, _archivedMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Client map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Client(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      contactName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}contact_name'],
      )!,
      vatId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}vat_id'],
      )!,
      addressLine1: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}address_line1'],
      )!,
      addressLine2: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}address_line2'],
      )!,
      postalCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}postal_code'],
      )!,
      city: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}city'],
      )!,
      country: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}country'],
      )!,
      email: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}email'],
      )!,
      defaultCurrency: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}default_currency'],
      )!,
      language: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}language'],
      )!,
      defaultVatTreatment: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}default_vat_treatment'],
      )!,
      defaultHourlyRate: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}default_hourly_rate'],
      ),
      paymentTermDays: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}payment_term_days'],
      )!,
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      )!,
      archived: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}archived'],
      )!,
    );
  }

  @override
  $ClientsTable createAlias(String alias) {
    return $ClientsTable(attachedDatabase, alias);
  }
}

class Client extends DataClass implements Insertable<Client> {
  final String id;
  final String name;
  final String contactName;
  final String vatId;
  final String addressLine1;
  final String addressLine2;
  final String postalCode;
  final String city;
  final String country;
  final String email;
  final String defaultCurrency;

  /// Preferred language for invoices/reports sent to this client.
  final String language;

  /// Default VAT treatment name (see VatTreatment enum).
  final String defaultVatTreatment;
  final double? defaultHourlyRate;
  final int paymentTermDays;
  final String notes;
  final bool archived;
  const Client({
    required this.id,
    required this.name,
    required this.contactName,
    required this.vatId,
    required this.addressLine1,
    required this.addressLine2,
    required this.postalCode,
    required this.city,
    required this.country,
    required this.email,
    required this.defaultCurrency,
    required this.language,
    required this.defaultVatTreatment,
    this.defaultHourlyRate,
    required this.paymentTermDays,
    required this.notes,
    required this.archived,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['contact_name'] = Variable<String>(contactName);
    map['vat_id'] = Variable<String>(vatId);
    map['address_line1'] = Variable<String>(addressLine1);
    map['address_line2'] = Variable<String>(addressLine2);
    map['postal_code'] = Variable<String>(postalCode);
    map['city'] = Variable<String>(city);
    map['country'] = Variable<String>(country);
    map['email'] = Variable<String>(email);
    map['default_currency'] = Variable<String>(defaultCurrency);
    map['language'] = Variable<String>(language);
    map['default_vat_treatment'] = Variable<String>(defaultVatTreatment);
    if (!nullToAbsent || defaultHourlyRate != null) {
      map['default_hourly_rate'] = Variable<double>(defaultHourlyRate);
    }
    map['payment_term_days'] = Variable<int>(paymentTermDays);
    map['notes'] = Variable<String>(notes);
    map['archived'] = Variable<bool>(archived);
    return map;
  }

  ClientsCompanion toCompanion(bool nullToAbsent) {
    return ClientsCompanion(
      id: Value(id),
      name: Value(name),
      contactName: Value(contactName),
      vatId: Value(vatId),
      addressLine1: Value(addressLine1),
      addressLine2: Value(addressLine2),
      postalCode: Value(postalCode),
      city: Value(city),
      country: Value(country),
      email: Value(email),
      defaultCurrency: Value(defaultCurrency),
      language: Value(language),
      defaultVatTreatment: Value(defaultVatTreatment),
      defaultHourlyRate: defaultHourlyRate == null && nullToAbsent
          ? const Value.absent()
          : Value(defaultHourlyRate),
      paymentTermDays: Value(paymentTermDays),
      notes: Value(notes),
      archived: Value(archived),
    );
  }

  factory Client.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Client(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      contactName: serializer.fromJson<String>(json['contactName']),
      vatId: serializer.fromJson<String>(json['vatId']),
      addressLine1: serializer.fromJson<String>(json['addressLine1']),
      addressLine2: serializer.fromJson<String>(json['addressLine2']),
      postalCode: serializer.fromJson<String>(json['postalCode']),
      city: serializer.fromJson<String>(json['city']),
      country: serializer.fromJson<String>(json['country']),
      email: serializer.fromJson<String>(json['email']),
      defaultCurrency: serializer.fromJson<String>(json['defaultCurrency']),
      language: serializer.fromJson<String>(json['language']),
      defaultVatTreatment: serializer.fromJson<String>(
        json['defaultVatTreatment'],
      ),
      defaultHourlyRate: serializer.fromJson<double?>(
        json['defaultHourlyRate'],
      ),
      paymentTermDays: serializer.fromJson<int>(json['paymentTermDays']),
      notes: serializer.fromJson<String>(json['notes']),
      archived: serializer.fromJson<bool>(json['archived']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'contactName': serializer.toJson<String>(contactName),
      'vatId': serializer.toJson<String>(vatId),
      'addressLine1': serializer.toJson<String>(addressLine1),
      'addressLine2': serializer.toJson<String>(addressLine2),
      'postalCode': serializer.toJson<String>(postalCode),
      'city': serializer.toJson<String>(city),
      'country': serializer.toJson<String>(country),
      'email': serializer.toJson<String>(email),
      'defaultCurrency': serializer.toJson<String>(defaultCurrency),
      'language': serializer.toJson<String>(language),
      'defaultVatTreatment': serializer.toJson<String>(defaultVatTreatment),
      'defaultHourlyRate': serializer.toJson<double?>(defaultHourlyRate),
      'paymentTermDays': serializer.toJson<int>(paymentTermDays),
      'notes': serializer.toJson<String>(notes),
      'archived': serializer.toJson<bool>(archived),
    };
  }

  Client copyWith({
    String? id,
    String? name,
    String? contactName,
    String? vatId,
    String? addressLine1,
    String? addressLine2,
    String? postalCode,
    String? city,
    String? country,
    String? email,
    String? defaultCurrency,
    String? language,
    String? defaultVatTreatment,
    Value<double?> defaultHourlyRate = const Value.absent(),
    int? paymentTermDays,
    String? notes,
    bool? archived,
  }) => Client(
    id: id ?? this.id,
    name: name ?? this.name,
    contactName: contactName ?? this.contactName,
    vatId: vatId ?? this.vatId,
    addressLine1: addressLine1 ?? this.addressLine1,
    addressLine2: addressLine2 ?? this.addressLine2,
    postalCode: postalCode ?? this.postalCode,
    city: city ?? this.city,
    country: country ?? this.country,
    email: email ?? this.email,
    defaultCurrency: defaultCurrency ?? this.defaultCurrency,
    language: language ?? this.language,
    defaultVatTreatment: defaultVatTreatment ?? this.defaultVatTreatment,
    defaultHourlyRate: defaultHourlyRate.present
        ? defaultHourlyRate.value
        : this.defaultHourlyRate,
    paymentTermDays: paymentTermDays ?? this.paymentTermDays,
    notes: notes ?? this.notes,
    archived: archived ?? this.archived,
  );
  Client copyWithCompanion(ClientsCompanion data) {
    return Client(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      contactName: data.contactName.present
          ? data.contactName.value
          : this.contactName,
      vatId: data.vatId.present ? data.vatId.value : this.vatId,
      addressLine1: data.addressLine1.present
          ? data.addressLine1.value
          : this.addressLine1,
      addressLine2: data.addressLine2.present
          ? data.addressLine2.value
          : this.addressLine2,
      postalCode: data.postalCode.present
          ? data.postalCode.value
          : this.postalCode,
      city: data.city.present ? data.city.value : this.city,
      country: data.country.present ? data.country.value : this.country,
      email: data.email.present ? data.email.value : this.email,
      defaultCurrency: data.defaultCurrency.present
          ? data.defaultCurrency.value
          : this.defaultCurrency,
      language: data.language.present ? data.language.value : this.language,
      defaultVatTreatment: data.defaultVatTreatment.present
          ? data.defaultVatTreatment.value
          : this.defaultVatTreatment,
      defaultHourlyRate: data.defaultHourlyRate.present
          ? data.defaultHourlyRate.value
          : this.defaultHourlyRate,
      paymentTermDays: data.paymentTermDays.present
          ? data.paymentTermDays.value
          : this.paymentTermDays,
      notes: data.notes.present ? data.notes.value : this.notes,
      archived: data.archived.present ? data.archived.value : this.archived,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Client(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('contactName: $contactName, ')
          ..write('vatId: $vatId, ')
          ..write('addressLine1: $addressLine1, ')
          ..write('addressLine2: $addressLine2, ')
          ..write('postalCode: $postalCode, ')
          ..write('city: $city, ')
          ..write('country: $country, ')
          ..write('email: $email, ')
          ..write('defaultCurrency: $defaultCurrency, ')
          ..write('language: $language, ')
          ..write('defaultVatTreatment: $defaultVatTreatment, ')
          ..write('defaultHourlyRate: $defaultHourlyRate, ')
          ..write('paymentTermDays: $paymentTermDays, ')
          ..write('notes: $notes, ')
          ..write('archived: $archived')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    contactName,
    vatId,
    addressLine1,
    addressLine2,
    postalCode,
    city,
    country,
    email,
    defaultCurrency,
    language,
    defaultVatTreatment,
    defaultHourlyRate,
    paymentTermDays,
    notes,
    archived,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Client &&
          other.id == this.id &&
          other.name == this.name &&
          other.contactName == this.contactName &&
          other.vatId == this.vatId &&
          other.addressLine1 == this.addressLine1 &&
          other.addressLine2 == this.addressLine2 &&
          other.postalCode == this.postalCode &&
          other.city == this.city &&
          other.country == this.country &&
          other.email == this.email &&
          other.defaultCurrency == this.defaultCurrency &&
          other.language == this.language &&
          other.defaultVatTreatment == this.defaultVatTreatment &&
          other.defaultHourlyRate == this.defaultHourlyRate &&
          other.paymentTermDays == this.paymentTermDays &&
          other.notes == this.notes &&
          other.archived == this.archived);
}

class ClientsCompanion extends UpdateCompanion<Client> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> contactName;
  final Value<String> vatId;
  final Value<String> addressLine1;
  final Value<String> addressLine2;
  final Value<String> postalCode;
  final Value<String> city;
  final Value<String> country;
  final Value<String> email;
  final Value<String> defaultCurrency;
  final Value<String> language;
  final Value<String> defaultVatTreatment;
  final Value<double?> defaultHourlyRate;
  final Value<int> paymentTermDays;
  final Value<String> notes;
  final Value<bool> archived;
  final Value<int> rowid;
  const ClientsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.contactName = const Value.absent(),
    this.vatId = const Value.absent(),
    this.addressLine1 = const Value.absent(),
    this.addressLine2 = const Value.absent(),
    this.postalCode = const Value.absent(),
    this.city = const Value.absent(),
    this.country = const Value.absent(),
    this.email = const Value.absent(),
    this.defaultCurrency = const Value.absent(),
    this.language = const Value.absent(),
    this.defaultVatTreatment = const Value.absent(),
    this.defaultHourlyRate = const Value.absent(),
    this.paymentTermDays = const Value.absent(),
    this.notes = const Value.absent(),
    this.archived = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ClientsCompanion.insert({
    required String id,
    required String name,
    this.contactName = const Value.absent(),
    this.vatId = const Value.absent(),
    this.addressLine1 = const Value.absent(),
    this.addressLine2 = const Value.absent(),
    this.postalCode = const Value.absent(),
    this.city = const Value.absent(),
    this.country = const Value.absent(),
    this.email = const Value.absent(),
    this.defaultCurrency = const Value.absent(),
    this.language = const Value.absent(),
    this.defaultVatTreatment = const Value.absent(),
    this.defaultHourlyRate = const Value.absent(),
    this.paymentTermDays = const Value.absent(),
    this.notes = const Value.absent(),
    this.archived = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name);
  static Insertable<Client> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? contactName,
    Expression<String>? vatId,
    Expression<String>? addressLine1,
    Expression<String>? addressLine2,
    Expression<String>? postalCode,
    Expression<String>? city,
    Expression<String>? country,
    Expression<String>? email,
    Expression<String>? defaultCurrency,
    Expression<String>? language,
    Expression<String>? defaultVatTreatment,
    Expression<double>? defaultHourlyRate,
    Expression<int>? paymentTermDays,
    Expression<String>? notes,
    Expression<bool>? archived,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (contactName != null) 'contact_name': contactName,
      if (vatId != null) 'vat_id': vatId,
      if (addressLine1 != null) 'address_line1': addressLine1,
      if (addressLine2 != null) 'address_line2': addressLine2,
      if (postalCode != null) 'postal_code': postalCode,
      if (city != null) 'city': city,
      if (country != null) 'country': country,
      if (email != null) 'email': email,
      if (defaultCurrency != null) 'default_currency': defaultCurrency,
      if (language != null) 'language': language,
      if (defaultVatTreatment != null)
        'default_vat_treatment': defaultVatTreatment,
      if (defaultHourlyRate != null) 'default_hourly_rate': defaultHourlyRate,
      if (paymentTermDays != null) 'payment_term_days': paymentTermDays,
      if (notes != null) 'notes': notes,
      if (archived != null) 'archived': archived,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ClientsCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<String>? contactName,
    Value<String>? vatId,
    Value<String>? addressLine1,
    Value<String>? addressLine2,
    Value<String>? postalCode,
    Value<String>? city,
    Value<String>? country,
    Value<String>? email,
    Value<String>? defaultCurrency,
    Value<String>? language,
    Value<String>? defaultVatTreatment,
    Value<double?>? defaultHourlyRate,
    Value<int>? paymentTermDays,
    Value<String>? notes,
    Value<bool>? archived,
    Value<int>? rowid,
  }) {
    return ClientsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      contactName: contactName ?? this.contactName,
      vatId: vatId ?? this.vatId,
      addressLine1: addressLine1 ?? this.addressLine1,
      addressLine2: addressLine2 ?? this.addressLine2,
      postalCode: postalCode ?? this.postalCode,
      city: city ?? this.city,
      country: country ?? this.country,
      email: email ?? this.email,
      defaultCurrency: defaultCurrency ?? this.defaultCurrency,
      language: language ?? this.language,
      defaultVatTreatment: defaultVatTreatment ?? this.defaultVatTreatment,
      defaultHourlyRate: defaultHourlyRate ?? this.defaultHourlyRate,
      paymentTermDays: paymentTermDays ?? this.paymentTermDays,
      notes: notes ?? this.notes,
      archived: archived ?? this.archived,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (contactName.present) {
      map['contact_name'] = Variable<String>(contactName.value);
    }
    if (vatId.present) {
      map['vat_id'] = Variable<String>(vatId.value);
    }
    if (addressLine1.present) {
      map['address_line1'] = Variable<String>(addressLine1.value);
    }
    if (addressLine2.present) {
      map['address_line2'] = Variable<String>(addressLine2.value);
    }
    if (postalCode.present) {
      map['postal_code'] = Variable<String>(postalCode.value);
    }
    if (city.present) {
      map['city'] = Variable<String>(city.value);
    }
    if (country.present) {
      map['country'] = Variable<String>(country.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (defaultCurrency.present) {
      map['default_currency'] = Variable<String>(defaultCurrency.value);
    }
    if (language.present) {
      map['language'] = Variable<String>(language.value);
    }
    if (defaultVatTreatment.present) {
      map['default_vat_treatment'] = Variable<String>(
        defaultVatTreatment.value,
      );
    }
    if (defaultHourlyRate.present) {
      map['default_hourly_rate'] = Variable<double>(defaultHourlyRate.value);
    }
    if (paymentTermDays.present) {
      map['payment_term_days'] = Variable<int>(paymentTermDays.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (archived.present) {
      map['archived'] = Variable<bool>(archived.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ClientsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('contactName: $contactName, ')
          ..write('vatId: $vatId, ')
          ..write('addressLine1: $addressLine1, ')
          ..write('addressLine2: $addressLine2, ')
          ..write('postalCode: $postalCode, ')
          ..write('city: $city, ')
          ..write('country: $country, ')
          ..write('email: $email, ')
          ..write('defaultCurrency: $defaultCurrency, ')
          ..write('language: $language, ')
          ..write('defaultVatTreatment: $defaultVatTreatment, ')
          ..write('defaultHourlyRate: $defaultHourlyRate, ')
          ..write('paymentTermDays: $paymentTermDays, ')
          ..write('notes: $notes, ')
          ..write('archived: $archived, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ProjectsTable extends Projects with TableInfo<$ProjectsTable, Project> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProjectsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _clientIdMeta = const VerificationMeta(
    'clientId',
  );
  @override
  late final GeneratedColumn<String> clientId = GeneratedColumn<String>(
    'client_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES clients (id)',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _hourlyRateMeta = const VerificationMeta(
    'hourlyRate',
  );
  @override
  late final GeneratedColumn<double> hourlyRate = GeneratedColumn<double>(
    'hourly_rate',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _currencyMeta = const VerificationMeta(
    'currency',
  );
  @override
  late final GeneratedColumn<String> currency = GeneratedColumn<String>(
    'currency',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _activeMeta = const VerificationMeta('active');
  @override
  late final GeneratedColumn<bool> active = GeneratedColumn<bool>(
    'active',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("active" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    clientId,
    name,
    hourlyRate,
    currency,
    active,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'projects';
  @override
  VerificationContext validateIntegrity(
    Insertable<Project> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('client_id')) {
      context.handle(
        _clientIdMeta,
        clientId.isAcceptableOrUnknown(data['client_id']!, _clientIdMeta),
      );
    } else if (isInserting) {
      context.missing(_clientIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('hourly_rate')) {
      context.handle(
        _hourlyRateMeta,
        hourlyRate.isAcceptableOrUnknown(data['hourly_rate']!, _hourlyRateMeta),
      );
    }
    if (data.containsKey('currency')) {
      context.handle(
        _currencyMeta,
        currency.isAcceptableOrUnknown(data['currency']!, _currencyMeta),
      );
    }
    if (data.containsKey('active')) {
      context.handle(
        _activeMeta,
        active.isAcceptableOrUnknown(data['active']!, _activeMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Project map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Project(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      clientId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}client_id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      hourlyRate: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}hourly_rate'],
      ),
      currency: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}currency'],
      ),
      active: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}active'],
      )!,
    );
  }

  @override
  $ProjectsTable createAlias(String alias) {
    return $ProjectsTable(attachedDatabase, alias);
  }
}

class Project extends DataClass implements Insertable<Project> {
  final String id;
  final String clientId;
  final String name;
  final double? hourlyRate;
  final String? currency;
  final bool active;
  const Project({
    required this.id,
    required this.clientId,
    required this.name,
    this.hourlyRate,
    this.currency,
    required this.active,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['client_id'] = Variable<String>(clientId);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || hourlyRate != null) {
      map['hourly_rate'] = Variable<double>(hourlyRate);
    }
    if (!nullToAbsent || currency != null) {
      map['currency'] = Variable<String>(currency);
    }
    map['active'] = Variable<bool>(active);
    return map;
  }

  ProjectsCompanion toCompanion(bool nullToAbsent) {
    return ProjectsCompanion(
      id: Value(id),
      clientId: Value(clientId),
      name: Value(name),
      hourlyRate: hourlyRate == null && nullToAbsent
          ? const Value.absent()
          : Value(hourlyRate),
      currency: currency == null && nullToAbsent
          ? const Value.absent()
          : Value(currency),
      active: Value(active),
    );
  }

  factory Project.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Project(
      id: serializer.fromJson<String>(json['id']),
      clientId: serializer.fromJson<String>(json['clientId']),
      name: serializer.fromJson<String>(json['name']),
      hourlyRate: serializer.fromJson<double?>(json['hourlyRate']),
      currency: serializer.fromJson<String?>(json['currency']),
      active: serializer.fromJson<bool>(json['active']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'clientId': serializer.toJson<String>(clientId),
      'name': serializer.toJson<String>(name),
      'hourlyRate': serializer.toJson<double?>(hourlyRate),
      'currency': serializer.toJson<String?>(currency),
      'active': serializer.toJson<bool>(active),
    };
  }

  Project copyWith({
    String? id,
    String? clientId,
    String? name,
    Value<double?> hourlyRate = const Value.absent(),
    Value<String?> currency = const Value.absent(),
    bool? active,
  }) => Project(
    id: id ?? this.id,
    clientId: clientId ?? this.clientId,
    name: name ?? this.name,
    hourlyRate: hourlyRate.present ? hourlyRate.value : this.hourlyRate,
    currency: currency.present ? currency.value : this.currency,
    active: active ?? this.active,
  );
  Project copyWithCompanion(ProjectsCompanion data) {
    return Project(
      id: data.id.present ? data.id.value : this.id,
      clientId: data.clientId.present ? data.clientId.value : this.clientId,
      name: data.name.present ? data.name.value : this.name,
      hourlyRate: data.hourlyRate.present
          ? data.hourlyRate.value
          : this.hourlyRate,
      currency: data.currency.present ? data.currency.value : this.currency,
      active: data.active.present ? data.active.value : this.active,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Project(')
          ..write('id: $id, ')
          ..write('clientId: $clientId, ')
          ..write('name: $name, ')
          ..write('hourlyRate: $hourlyRate, ')
          ..write('currency: $currency, ')
          ..write('active: $active')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, clientId, name, hourlyRate, currency, active);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Project &&
          other.id == this.id &&
          other.clientId == this.clientId &&
          other.name == this.name &&
          other.hourlyRate == this.hourlyRate &&
          other.currency == this.currency &&
          other.active == this.active);
}

class ProjectsCompanion extends UpdateCompanion<Project> {
  final Value<String> id;
  final Value<String> clientId;
  final Value<String> name;
  final Value<double?> hourlyRate;
  final Value<String?> currency;
  final Value<bool> active;
  final Value<int> rowid;
  const ProjectsCompanion({
    this.id = const Value.absent(),
    this.clientId = const Value.absent(),
    this.name = const Value.absent(),
    this.hourlyRate = const Value.absent(),
    this.currency = const Value.absent(),
    this.active = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ProjectsCompanion.insert({
    required String id,
    required String clientId,
    required String name,
    this.hourlyRate = const Value.absent(),
    this.currency = const Value.absent(),
    this.active = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       clientId = Value(clientId),
       name = Value(name);
  static Insertable<Project> custom({
    Expression<String>? id,
    Expression<String>? clientId,
    Expression<String>? name,
    Expression<double>? hourlyRate,
    Expression<String>? currency,
    Expression<bool>? active,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (clientId != null) 'client_id': clientId,
      if (name != null) 'name': name,
      if (hourlyRate != null) 'hourly_rate': hourlyRate,
      if (currency != null) 'currency': currency,
      if (active != null) 'active': active,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ProjectsCompanion copyWith({
    Value<String>? id,
    Value<String>? clientId,
    Value<String>? name,
    Value<double?>? hourlyRate,
    Value<String?>? currency,
    Value<bool>? active,
    Value<int>? rowid,
  }) {
    return ProjectsCompanion(
      id: id ?? this.id,
      clientId: clientId ?? this.clientId,
      name: name ?? this.name,
      hourlyRate: hourlyRate ?? this.hourlyRate,
      currency: currency ?? this.currency,
      active: active ?? this.active,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (clientId.present) {
      map['client_id'] = Variable<String>(clientId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (hourlyRate.present) {
      map['hourly_rate'] = Variable<double>(hourlyRate.value);
    }
    if (currency.present) {
      map['currency'] = Variable<String>(currency.value);
    }
    if (active.present) {
      map['active'] = Variable<bool>(active.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProjectsCompanion(')
          ..write('id: $id, ')
          ..write('clientId: $clientId, ')
          ..write('name: $name, ')
          ..write('hourlyRate: $hourlyRate, ')
          ..write('currency: $currency, ')
          ..write('active: $active, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $InvoicesTable extends Invoices with TableInfo<$InvoicesTable, Invoice> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $InvoicesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _numberMeta = const VerificationMeta('number');
  @override
  late final GeneratedColumn<String> number = GeneratedColumn<String>(
    'number',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _clientIdMeta = const VerificationMeta(
    'clientId',
  );
  @override
  late final GeneratedColumn<String> clientId = GeneratedColumn<String>(
    'client_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES clients (id)',
    ),
  );
  static const VerificationMeta _issueDateMeta = const VerificationMeta(
    'issueDate',
  );
  @override
  late final GeneratedColumn<DateTime> issueDate = GeneratedColumn<DateTime>(
    'issue_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dueDateMeta = const VerificationMeta(
    'dueDate',
  );
  @override
  late final GeneratedColumn<DateTime> dueDate = GeneratedColumn<DateTime>(
    'due_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _currencyMeta = const VerificationMeta(
    'currency',
  );
  @override
  late final GeneratedColumn<String> currency = GeneratedColumn<String>(
    'currency',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('EUR'),
  );
  static const VerificationMeta _languageMeta = const VerificationMeta(
    'language',
  );
  @override
  late final GeneratedColumn<String> language = GeneratedColumn<String>(
    'language',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('nl'),
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('draft'),
  );
  static const VerificationMeta _purchaseOrderMeta = const VerificationMeta(
    'purchaseOrder',
  );
  @override
  late final GeneratedColumn<String> purchaseOrder = GeneratedColumn<String>(
    'purchase_order',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _subtotalMinorMeta = const VerificationMeta(
    'subtotalMinor',
  );
  @override
  late final GeneratedColumn<int> subtotalMinor = GeneratedColumn<int>(
    'subtotal_minor',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _taxMinorMeta = const VerificationMeta(
    'taxMinor',
  );
  @override
  late final GeneratedColumn<int> taxMinor = GeneratedColumn<int>(
    'tax_minor',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _totalMinorMeta = const VerificationMeta(
    'totalMinor',
  );
  @override
  late final GeneratedColumn<int> totalMinor = GeneratedColumn<int>(
    'total_minor',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _paidDateMeta = const VerificationMeta(
    'paidDate',
  );
  @override
  late final GeneratedColumn<DateTime> paidDate = GeneratedColumn<DateTime>(
    'paid_date',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    number,
    clientId,
    issueDate,
    dueDate,
    currency,
    language,
    status,
    purchaseOrder,
    notes,
    subtotalMinor,
    taxMinor,
    totalMinor,
    paidDate,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'invoices';
  @override
  VerificationContext validateIntegrity(
    Insertable<Invoice> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('number')) {
      context.handle(
        _numberMeta,
        number.isAcceptableOrUnknown(data['number']!, _numberMeta),
      );
    } else if (isInserting) {
      context.missing(_numberMeta);
    }
    if (data.containsKey('client_id')) {
      context.handle(
        _clientIdMeta,
        clientId.isAcceptableOrUnknown(data['client_id']!, _clientIdMeta),
      );
    } else if (isInserting) {
      context.missing(_clientIdMeta);
    }
    if (data.containsKey('issue_date')) {
      context.handle(
        _issueDateMeta,
        issueDate.isAcceptableOrUnknown(data['issue_date']!, _issueDateMeta),
      );
    } else if (isInserting) {
      context.missing(_issueDateMeta);
    }
    if (data.containsKey('due_date')) {
      context.handle(
        _dueDateMeta,
        dueDate.isAcceptableOrUnknown(data['due_date']!, _dueDateMeta),
      );
    } else if (isInserting) {
      context.missing(_dueDateMeta);
    }
    if (data.containsKey('currency')) {
      context.handle(
        _currencyMeta,
        currency.isAcceptableOrUnknown(data['currency']!, _currencyMeta),
      );
    }
    if (data.containsKey('language')) {
      context.handle(
        _languageMeta,
        language.isAcceptableOrUnknown(data['language']!, _languageMeta),
      );
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    if (data.containsKey('purchase_order')) {
      context.handle(
        _purchaseOrderMeta,
        purchaseOrder.isAcceptableOrUnknown(
          data['purchase_order']!,
          _purchaseOrderMeta,
        ),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('subtotal_minor')) {
      context.handle(
        _subtotalMinorMeta,
        subtotalMinor.isAcceptableOrUnknown(
          data['subtotal_minor']!,
          _subtotalMinorMeta,
        ),
      );
    }
    if (data.containsKey('tax_minor')) {
      context.handle(
        _taxMinorMeta,
        taxMinor.isAcceptableOrUnknown(data['tax_minor']!, _taxMinorMeta),
      );
    }
    if (data.containsKey('total_minor')) {
      context.handle(
        _totalMinorMeta,
        totalMinor.isAcceptableOrUnknown(data['total_minor']!, _totalMinorMeta),
      );
    }
    if (data.containsKey('paid_date')) {
      context.handle(
        _paidDateMeta,
        paidDate.isAcceptableOrUnknown(data['paid_date']!, _paidDateMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Invoice map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Invoice(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      number: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}number'],
      )!,
      clientId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}client_id'],
      )!,
      issueDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}issue_date'],
      )!,
      dueDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}due_date'],
      )!,
      currency: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}currency'],
      )!,
      language: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}language'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      purchaseOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}purchase_order'],
      )!,
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      )!,
      subtotalMinor: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}subtotal_minor'],
      )!,
      taxMinor: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}tax_minor'],
      )!,
      totalMinor: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}total_minor'],
      )!,
      paidDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}paid_date'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $InvoicesTable createAlias(String alias) {
    return $InvoicesTable(attachedDatabase, alias);
  }
}

class Invoice extends DataClass implements Insertable<Invoice> {
  final String id;
  final String number;
  final String clientId;
  final DateTime issueDate;
  final DateTime dueDate;
  final String currency;
  final String language;
  final String status;
  final String purchaseOrder;
  final String notes;
  final int subtotalMinor;
  final int taxMinor;
  final int totalMinor;
  final DateTime? paidDate;
  final DateTime createdAt;
  const Invoice({
    required this.id,
    required this.number,
    required this.clientId,
    required this.issueDate,
    required this.dueDate,
    required this.currency,
    required this.language,
    required this.status,
    required this.purchaseOrder,
    required this.notes,
    required this.subtotalMinor,
    required this.taxMinor,
    required this.totalMinor,
    this.paidDate,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['number'] = Variable<String>(number);
    map['client_id'] = Variable<String>(clientId);
    map['issue_date'] = Variable<DateTime>(issueDate);
    map['due_date'] = Variable<DateTime>(dueDate);
    map['currency'] = Variable<String>(currency);
    map['language'] = Variable<String>(language);
    map['status'] = Variable<String>(status);
    map['purchase_order'] = Variable<String>(purchaseOrder);
    map['notes'] = Variable<String>(notes);
    map['subtotal_minor'] = Variable<int>(subtotalMinor);
    map['tax_minor'] = Variable<int>(taxMinor);
    map['total_minor'] = Variable<int>(totalMinor);
    if (!nullToAbsent || paidDate != null) {
      map['paid_date'] = Variable<DateTime>(paidDate);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  InvoicesCompanion toCompanion(bool nullToAbsent) {
    return InvoicesCompanion(
      id: Value(id),
      number: Value(number),
      clientId: Value(clientId),
      issueDate: Value(issueDate),
      dueDate: Value(dueDate),
      currency: Value(currency),
      language: Value(language),
      status: Value(status),
      purchaseOrder: Value(purchaseOrder),
      notes: Value(notes),
      subtotalMinor: Value(subtotalMinor),
      taxMinor: Value(taxMinor),
      totalMinor: Value(totalMinor),
      paidDate: paidDate == null && nullToAbsent
          ? const Value.absent()
          : Value(paidDate),
      createdAt: Value(createdAt),
    );
  }

  factory Invoice.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Invoice(
      id: serializer.fromJson<String>(json['id']),
      number: serializer.fromJson<String>(json['number']),
      clientId: serializer.fromJson<String>(json['clientId']),
      issueDate: serializer.fromJson<DateTime>(json['issueDate']),
      dueDate: serializer.fromJson<DateTime>(json['dueDate']),
      currency: serializer.fromJson<String>(json['currency']),
      language: serializer.fromJson<String>(json['language']),
      status: serializer.fromJson<String>(json['status']),
      purchaseOrder: serializer.fromJson<String>(json['purchaseOrder']),
      notes: serializer.fromJson<String>(json['notes']),
      subtotalMinor: serializer.fromJson<int>(json['subtotalMinor']),
      taxMinor: serializer.fromJson<int>(json['taxMinor']),
      totalMinor: serializer.fromJson<int>(json['totalMinor']),
      paidDate: serializer.fromJson<DateTime?>(json['paidDate']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'number': serializer.toJson<String>(number),
      'clientId': serializer.toJson<String>(clientId),
      'issueDate': serializer.toJson<DateTime>(issueDate),
      'dueDate': serializer.toJson<DateTime>(dueDate),
      'currency': serializer.toJson<String>(currency),
      'language': serializer.toJson<String>(language),
      'status': serializer.toJson<String>(status),
      'purchaseOrder': serializer.toJson<String>(purchaseOrder),
      'notes': serializer.toJson<String>(notes),
      'subtotalMinor': serializer.toJson<int>(subtotalMinor),
      'taxMinor': serializer.toJson<int>(taxMinor),
      'totalMinor': serializer.toJson<int>(totalMinor),
      'paidDate': serializer.toJson<DateTime?>(paidDate),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Invoice copyWith({
    String? id,
    String? number,
    String? clientId,
    DateTime? issueDate,
    DateTime? dueDate,
    String? currency,
    String? language,
    String? status,
    String? purchaseOrder,
    String? notes,
    int? subtotalMinor,
    int? taxMinor,
    int? totalMinor,
    Value<DateTime?> paidDate = const Value.absent(),
    DateTime? createdAt,
  }) => Invoice(
    id: id ?? this.id,
    number: number ?? this.number,
    clientId: clientId ?? this.clientId,
    issueDate: issueDate ?? this.issueDate,
    dueDate: dueDate ?? this.dueDate,
    currency: currency ?? this.currency,
    language: language ?? this.language,
    status: status ?? this.status,
    purchaseOrder: purchaseOrder ?? this.purchaseOrder,
    notes: notes ?? this.notes,
    subtotalMinor: subtotalMinor ?? this.subtotalMinor,
    taxMinor: taxMinor ?? this.taxMinor,
    totalMinor: totalMinor ?? this.totalMinor,
    paidDate: paidDate.present ? paidDate.value : this.paidDate,
    createdAt: createdAt ?? this.createdAt,
  );
  Invoice copyWithCompanion(InvoicesCompanion data) {
    return Invoice(
      id: data.id.present ? data.id.value : this.id,
      number: data.number.present ? data.number.value : this.number,
      clientId: data.clientId.present ? data.clientId.value : this.clientId,
      issueDate: data.issueDate.present ? data.issueDate.value : this.issueDate,
      dueDate: data.dueDate.present ? data.dueDate.value : this.dueDate,
      currency: data.currency.present ? data.currency.value : this.currency,
      language: data.language.present ? data.language.value : this.language,
      status: data.status.present ? data.status.value : this.status,
      purchaseOrder: data.purchaseOrder.present
          ? data.purchaseOrder.value
          : this.purchaseOrder,
      notes: data.notes.present ? data.notes.value : this.notes,
      subtotalMinor: data.subtotalMinor.present
          ? data.subtotalMinor.value
          : this.subtotalMinor,
      taxMinor: data.taxMinor.present ? data.taxMinor.value : this.taxMinor,
      totalMinor: data.totalMinor.present
          ? data.totalMinor.value
          : this.totalMinor,
      paidDate: data.paidDate.present ? data.paidDate.value : this.paidDate,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Invoice(')
          ..write('id: $id, ')
          ..write('number: $number, ')
          ..write('clientId: $clientId, ')
          ..write('issueDate: $issueDate, ')
          ..write('dueDate: $dueDate, ')
          ..write('currency: $currency, ')
          ..write('language: $language, ')
          ..write('status: $status, ')
          ..write('purchaseOrder: $purchaseOrder, ')
          ..write('notes: $notes, ')
          ..write('subtotalMinor: $subtotalMinor, ')
          ..write('taxMinor: $taxMinor, ')
          ..write('totalMinor: $totalMinor, ')
          ..write('paidDate: $paidDate, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    number,
    clientId,
    issueDate,
    dueDate,
    currency,
    language,
    status,
    purchaseOrder,
    notes,
    subtotalMinor,
    taxMinor,
    totalMinor,
    paidDate,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Invoice &&
          other.id == this.id &&
          other.number == this.number &&
          other.clientId == this.clientId &&
          other.issueDate == this.issueDate &&
          other.dueDate == this.dueDate &&
          other.currency == this.currency &&
          other.language == this.language &&
          other.status == this.status &&
          other.purchaseOrder == this.purchaseOrder &&
          other.notes == this.notes &&
          other.subtotalMinor == this.subtotalMinor &&
          other.taxMinor == this.taxMinor &&
          other.totalMinor == this.totalMinor &&
          other.paidDate == this.paidDate &&
          other.createdAt == this.createdAt);
}

class InvoicesCompanion extends UpdateCompanion<Invoice> {
  final Value<String> id;
  final Value<String> number;
  final Value<String> clientId;
  final Value<DateTime> issueDate;
  final Value<DateTime> dueDate;
  final Value<String> currency;
  final Value<String> language;
  final Value<String> status;
  final Value<String> purchaseOrder;
  final Value<String> notes;
  final Value<int> subtotalMinor;
  final Value<int> taxMinor;
  final Value<int> totalMinor;
  final Value<DateTime?> paidDate;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const InvoicesCompanion({
    this.id = const Value.absent(),
    this.number = const Value.absent(),
    this.clientId = const Value.absent(),
    this.issueDate = const Value.absent(),
    this.dueDate = const Value.absent(),
    this.currency = const Value.absent(),
    this.language = const Value.absent(),
    this.status = const Value.absent(),
    this.purchaseOrder = const Value.absent(),
    this.notes = const Value.absent(),
    this.subtotalMinor = const Value.absent(),
    this.taxMinor = const Value.absent(),
    this.totalMinor = const Value.absent(),
    this.paidDate = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  InvoicesCompanion.insert({
    required String id,
    required String number,
    required String clientId,
    required DateTime issueDate,
    required DateTime dueDate,
    this.currency = const Value.absent(),
    this.language = const Value.absent(),
    this.status = const Value.absent(),
    this.purchaseOrder = const Value.absent(),
    this.notes = const Value.absent(),
    this.subtotalMinor = const Value.absent(),
    this.taxMinor = const Value.absent(),
    this.totalMinor = const Value.absent(),
    this.paidDate = const Value.absent(),
    required DateTime createdAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       number = Value(number),
       clientId = Value(clientId),
       issueDate = Value(issueDate),
       dueDate = Value(dueDate),
       createdAt = Value(createdAt);
  static Insertable<Invoice> custom({
    Expression<String>? id,
    Expression<String>? number,
    Expression<String>? clientId,
    Expression<DateTime>? issueDate,
    Expression<DateTime>? dueDate,
    Expression<String>? currency,
    Expression<String>? language,
    Expression<String>? status,
    Expression<String>? purchaseOrder,
    Expression<String>? notes,
    Expression<int>? subtotalMinor,
    Expression<int>? taxMinor,
    Expression<int>? totalMinor,
    Expression<DateTime>? paidDate,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (number != null) 'number': number,
      if (clientId != null) 'client_id': clientId,
      if (issueDate != null) 'issue_date': issueDate,
      if (dueDate != null) 'due_date': dueDate,
      if (currency != null) 'currency': currency,
      if (language != null) 'language': language,
      if (status != null) 'status': status,
      if (purchaseOrder != null) 'purchase_order': purchaseOrder,
      if (notes != null) 'notes': notes,
      if (subtotalMinor != null) 'subtotal_minor': subtotalMinor,
      if (taxMinor != null) 'tax_minor': taxMinor,
      if (totalMinor != null) 'total_minor': totalMinor,
      if (paidDate != null) 'paid_date': paidDate,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  InvoicesCompanion copyWith({
    Value<String>? id,
    Value<String>? number,
    Value<String>? clientId,
    Value<DateTime>? issueDate,
    Value<DateTime>? dueDate,
    Value<String>? currency,
    Value<String>? language,
    Value<String>? status,
    Value<String>? purchaseOrder,
    Value<String>? notes,
    Value<int>? subtotalMinor,
    Value<int>? taxMinor,
    Value<int>? totalMinor,
    Value<DateTime?>? paidDate,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return InvoicesCompanion(
      id: id ?? this.id,
      number: number ?? this.number,
      clientId: clientId ?? this.clientId,
      issueDate: issueDate ?? this.issueDate,
      dueDate: dueDate ?? this.dueDate,
      currency: currency ?? this.currency,
      language: language ?? this.language,
      status: status ?? this.status,
      purchaseOrder: purchaseOrder ?? this.purchaseOrder,
      notes: notes ?? this.notes,
      subtotalMinor: subtotalMinor ?? this.subtotalMinor,
      taxMinor: taxMinor ?? this.taxMinor,
      totalMinor: totalMinor ?? this.totalMinor,
      paidDate: paidDate ?? this.paidDate,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (number.present) {
      map['number'] = Variable<String>(number.value);
    }
    if (clientId.present) {
      map['client_id'] = Variable<String>(clientId.value);
    }
    if (issueDate.present) {
      map['issue_date'] = Variable<DateTime>(issueDate.value);
    }
    if (dueDate.present) {
      map['due_date'] = Variable<DateTime>(dueDate.value);
    }
    if (currency.present) {
      map['currency'] = Variable<String>(currency.value);
    }
    if (language.present) {
      map['language'] = Variable<String>(language.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (purchaseOrder.present) {
      map['purchase_order'] = Variable<String>(purchaseOrder.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (subtotalMinor.present) {
      map['subtotal_minor'] = Variable<int>(subtotalMinor.value);
    }
    if (taxMinor.present) {
      map['tax_minor'] = Variable<int>(taxMinor.value);
    }
    if (totalMinor.present) {
      map['total_minor'] = Variable<int>(totalMinor.value);
    }
    if (paidDate.present) {
      map['paid_date'] = Variable<DateTime>(paidDate.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('InvoicesCompanion(')
          ..write('id: $id, ')
          ..write('number: $number, ')
          ..write('clientId: $clientId, ')
          ..write('issueDate: $issueDate, ')
          ..write('dueDate: $dueDate, ')
          ..write('currency: $currency, ')
          ..write('language: $language, ')
          ..write('status: $status, ')
          ..write('purchaseOrder: $purchaseOrder, ')
          ..write('notes: $notes, ')
          ..write('subtotalMinor: $subtotalMinor, ')
          ..write('taxMinor: $taxMinor, ')
          ..write('totalMinor: $totalMinor, ')
          ..write('paidDate: $paidDate, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $TimeEntriesTable extends TimeEntries
    with TableInfo<$TimeEntriesTable, TimeEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TimeEntriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _clientIdMeta = const VerificationMeta(
    'clientId',
  );
  @override
  late final GeneratedColumn<String> clientId = GeneratedColumn<String>(
    'client_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES clients (id)',
    ),
  );
  static const VerificationMeta _projectIdMeta = const VerificationMeta(
    'projectId',
  );
  @override
  late final GeneratedColumn<String> projectId = GeneratedColumn<String>(
    'project_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES projects (id)',
    ),
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _minutesMeta = const VerificationMeta(
    'minutes',
  );
  @override
  late final GeneratedColumn<int> minutes = GeneratedColumn<int>(
    'minutes',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _billableMeta = const VerificationMeta(
    'billable',
  );
  @override
  late final GeneratedColumn<bool> billable = GeneratedColumn<bool>(
    'billable',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("billable" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _roundingMeta = const VerificationMeta(
    'rounding',
  );
  @override
  late final GeneratedColumn<String> rounding = GeneratedColumn<String>(
    'rounding',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('none'),
  );
  static const VerificationMeta _invoiceIdMeta = const VerificationMeta(
    'invoiceId',
  );
  @override
  late final GeneratedColumn<String> invoiceId = GeneratedColumn<String>(
    'invoice_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES invoices (id)',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    clientId,
    projectId,
    date,
    minutes,
    description,
    billable,
    rounding,
    invoiceId,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'time_entries';
  @override
  VerificationContext validateIntegrity(
    Insertable<TimeEntry> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('client_id')) {
      context.handle(
        _clientIdMeta,
        clientId.isAcceptableOrUnknown(data['client_id']!, _clientIdMeta),
      );
    } else if (isInserting) {
      context.missing(_clientIdMeta);
    }
    if (data.containsKey('project_id')) {
      context.handle(
        _projectIdMeta,
        projectId.isAcceptableOrUnknown(data['project_id']!, _projectIdMeta),
      );
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('minutes')) {
      context.handle(
        _minutesMeta,
        minutes.isAcceptableOrUnknown(data['minutes']!, _minutesMeta),
      );
    } else if (isInserting) {
      context.missing(_minutesMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('billable')) {
      context.handle(
        _billableMeta,
        billable.isAcceptableOrUnknown(data['billable']!, _billableMeta),
      );
    }
    if (data.containsKey('rounding')) {
      context.handle(
        _roundingMeta,
        rounding.isAcceptableOrUnknown(data['rounding']!, _roundingMeta),
      );
    }
    if (data.containsKey('invoice_id')) {
      context.handle(
        _invoiceIdMeta,
        invoiceId.isAcceptableOrUnknown(data['invoice_id']!, _invoiceIdMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TimeEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TimeEntry(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      clientId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}client_id'],
      )!,
      projectId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}project_id'],
      ),
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date'],
      )!,
      minutes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}minutes'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      )!,
      billable: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}billable'],
      )!,
      rounding: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}rounding'],
      )!,
      invoiceId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}invoice_id'],
      ),
    );
  }

  @override
  $TimeEntriesTable createAlias(String alias) {
    return $TimeEntriesTable(attachedDatabase, alias);
  }
}

class TimeEntry extends DataClass implements Insertable<TimeEntry> {
  final String id;
  final String clientId;
  final String? projectId;
  final DateTime date;
  final int minutes;
  final String description;
  final bool billable;
  final String rounding;

  /// Set once this entry has been placed on an invoice.
  final String? invoiceId;
  const TimeEntry({
    required this.id,
    required this.clientId,
    this.projectId,
    required this.date,
    required this.minutes,
    required this.description,
    required this.billable,
    required this.rounding,
    this.invoiceId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['client_id'] = Variable<String>(clientId);
    if (!nullToAbsent || projectId != null) {
      map['project_id'] = Variable<String>(projectId);
    }
    map['date'] = Variable<DateTime>(date);
    map['minutes'] = Variable<int>(minutes);
    map['description'] = Variable<String>(description);
    map['billable'] = Variable<bool>(billable);
    map['rounding'] = Variable<String>(rounding);
    if (!nullToAbsent || invoiceId != null) {
      map['invoice_id'] = Variable<String>(invoiceId);
    }
    return map;
  }

  TimeEntriesCompanion toCompanion(bool nullToAbsent) {
    return TimeEntriesCompanion(
      id: Value(id),
      clientId: Value(clientId),
      projectId: projectId == null && nullToAbsent
          ? const Value.absent()
          : Value(projectId),
      date: Value(date),
      minutes: Value(minutes),
      description: Value(description),
      billable: Value(billable),
      rounding: Value(rounding),
      invoiceId: invoiceId == null && nullToAbsent
          ? const Value.absent()
          : Value(invoiceId),
    );
  }

  factory TimeEntry.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TimeEntry(
      id: serializer.fromJson<String>(json['id']),
      clientId: serializer.fromJson<String>(json['clientId']),
      projectId: serializer.fromJson<String?>(json['projectId']),
      date: serializer.fromJson<DateTime>(json['date']),
      minutes: serializer.fromJson<int>(json['minutes']),
      description: serializer.fromJson<String>(json['description']),
      billable: serializer.fromJson<bool>(json['billable']),
      rounding: serializer.fromJson<String>(json['rounding']),
      invoiceId: serializer.fromJson<String?>(json['invoiceId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'clientId': serializer.toJson<String>(clientId),
      'projectId': serializer.toJson<String?>(projectId),
      'date': serializer.toJson<DateTime>(date),
      'minutes': serializer.toJson<int>(minutes),
      'description': serializer.toJson<String>(description),
      'billable': serializer.toJson<bool>(billable),
      'rounding': serializer.toJson<String>(rounding),
      'invoiceId': serializer.toJson<String?>(invoiceId),
    };
  }

  TimeEntry copyWith({
    String? id,
    String? clientId,
    Value<String?> projectId = const Value.absent(),
    DateTime? date,
    int? minutes,
    String? description,
    bool? billable,
    String? rounding,
    Value<String?> invoiceId = const Value.absent(),
  }) => TimeEntry(
    id: id ?? this.id,
    clientId: clientId ?? this.clientId,
    projectId: projectId.present ? projectId.value : this.projectId,
    date: date ?? this.date,
    minutes: minutes ?? this.minutes,
    description: description ?? this.description,
    billable: billable ?? this.billable,
    rounding: rounding ?? this.rounding,
    invoiceId: invoiceId.present ? invoiceId.value : this.invoiceId,
  );
  TimeEntry copyWithCompanion(TimeEntriesCompanion data) {
    return TimeEntry(
      id: data.id.present ? data.id.value : this.id,
      clientId: data.clientId.present ? data.clientId.value : this.clientId,
      projectId: data.projectId.present ? data.projectId.value : this.projectId,
      date: data.date.present ? data.date.value : this.date,
      minutes: data.minutes.present ? data.minutes.value : this.minutes,
      description: data.description.present
          ? data.description.value
          : this.description,
      billable: data.billable.present ? data.billable.value : this.billable,
      rounding: data.rounding.present ? data.rounding.value : this.rounding,
      invoiceId: data.invoiceId.present ? data.invoiceId.value : this.invoiceId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TimeEntry(')
          ..write('id: $id, ')
          ..write('clientId: $clientId, ')
          ..write('projectId: $projectId, ')
          ..write('date: $date, ')
          ..write('minutes: $minutes, ')
          ..write('description: $description, ')
          ..write('billable: $billable, ')
          ..write('rounding: $rounding, ')
          ..write('invoiceId: $invoiceId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    clientId,
    projectId,
    date,
    minutes,
    description,
    billable,
    rounding,
    invoiceId,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TimeEntry &&
          other.id == this.id &&
          other.clientId == this.clientId &&
          other.projectId == this.projectId &&
          other.date == this.date &&
          other.minutes == this.minutes &&
          other.description == this.description &&
          other.billable == this.billable &&
          other.rounding == this.rounding &&
          other.invoiceId == this.invoiceId);
}

class TimeEntriesCompanion extends UpdateCompanion<TimeEntry> {
  final Value<String> id;
  final Value<String> clientId;
  final Value<String?> projectId;
  final Value<DateTime> date;
  final Value<int> minutes;
  final Value<String> description;
  final Value<bool> billable;
  final Value<String> rounding;
  final Value<String?> invoiceId;
  final Value<int> rowid;
  const TimeEntriesCompanion({
    this.id = const Value.absent(),
    this.clientId = const Value.absent(),
    this.projectId = const Value.absent(),
    this.date = const Value.absent(),
    this.minutes = const Value.absent(),
    this.description = const Value.absent(),
    this.billable = const Value.absent(),
    this.rounding = const Value.absent(),
    this.invoiceId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TimeEntriesCompanion.insert({
    required String id,
    required String clientId,
    this.projectId = const Value.absent(),
    required DateTime date,
    required int minutes,
    this.description = const Value.absent(),
    this.billable = const Value.absent(),
    this.rounding = const Value.absent(),
    this.invoiceId = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       clientId = Value(clientId),
       date = Value(date),
       minutes = Value(minutes);
  static Insertable<TimeEntry> custom({
    Expression<String>? id,
    Expression<String>? clientId,
    Expression<String>? projectId,
    Expression<DateTime>? date,
    Expression<int>? minutes,
    Expression<String>? description,
    Expression<bool>? billable,
    Expression<String>? rounding,
    Expression<String>? invoiceId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (clientId != null) 'client_id': clientId,
      if (projectId != null) 'project_id': projectId,
      if (date != null) 'date': date,
      if (minutes != null) 'minutes': minutes,
      if (description != null) 'description': description,
      if (billable != null) 'billable': billable,
      if (rounding != null) 'rounding': rounding,
      if (invoiceId != null) 'invoice_id': invoiceId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TimeEntriesCompanion copyWith({
    Value<String>? id,
    Value<String>? clientId,
    Value<String?>? projectId,
    Value<DateTime>? date,
    Value<int>? minutes,
    Value<String>? description,
    Value<bool>? billable,
    Value<String>? rounding,
    Value<String?>? invoiceId,
    Value<int>? rowid,
  }) {
    return TimeEntriesCompanion(
      id: id ?? this.id,
      clientId: clientId ?? this.clientId,
      projectId: projectId ?? this.projectId,
      date: date ?? this.date,
      minutes: minutes ?? this.minutes,
      description: description ?? this.description,
      billable: billable ?? this.billable,
      rounding: rounding ?? this.rounding,
      invoiceId: invoiceId ?? this.invoiceId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (clientId.present) {
      map['client_id'] = Variable<String>(clientId.value);
    }
    if (projectId.present) {
      map['project_id'] = Variable<String>(projectId.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (minutes.present) {
      map['minutes'] = Variable<int>(minutes.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (billable.present) {
      map['billable'] = Variable<bool>(billable.value);
    }
    if (rounding.present) {
      map['rounding'] = Variable<String>(rounding.value);
    }
    if (invoiceId.present) {
      map['invoice_id'] = Variable<String>(invoiceId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TimeEntriesCompanion(')
          ..write('id: $id, ')
          ..write('clientId: $clientId, ')
          ..write('projectId: $projectId, ')
          ..write('date: $date, ')
          ..write('minutes: $minutes, ')
          ..write('description: $description, ')
          ..write('billable: $billable, ')
          ..write('rounding: $rounding, ')
          ..write('invoiceId: $invoiceId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ExpensesTable extends Expenses with TableInfo<$ExpensesTable, Expense> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ExpensesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _categoryMeta = const VerificationMeta(
    'category',
  );
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
    'category',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('general'),
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _amountMinorMeta = const VerificationMeta(
    'amountMinor',
  );
  @override
  late final GeneratedColumn<int> amountMinor = GeneratedColumn<int>(
    'amount_minor',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _vatMinorMeta = const VerificationMeta(
    'vatMinor',
  );
  @override
  late final GeneratedColumn<int> vatMinor = GeneratedColumn<int>(
    'vat_minor',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _currencyMeta = const VerificationMeta(
    'currency',
  );
  @override
  late final GeneratedColumn<String> currency = GeneratedColumn<String>(
    'currency',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('JPY'),
  );
  static const VerificationMeta _deductibleMeta = const VerificationMeta(
    'deductible',
  );
  @override
  late final GeneratedColumn<bool> deductible = GeneratedColumn<bool>(
    'deductible',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("deductible" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _businessUsePercentMeta =
      const VerificationMeta('businessUsePercent');
  @override
  late final GeneratedColumn<int> businessUsePercent = GeneratedColumn<int>(
    'business_use_percent',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(100),
  );
  static const VerificationMeta _receiptPathMeta = const VerificationMeta(
    'receiptPath',
  );
  @override
  late final GeneratedColumn<String> receiptPath = GeneratedColumn<String>(
    'receipt_path',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _receiptImageMeta = const VerificationMeta(
    'receiptImage',
  );
  @override
  late final GeneratedColumn<Uint8List> receiptImage =
      GeneratedColumn<Uint8List>(
        'receipt_image',
        aliasedName,
        true,
        type: DriftSqlType.blob,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _receiptMimeMeta = const VerificationMeta(
    'receiptMime',
  );
  @override
  late final GeneratedColumn<String> receiptMime = GeneratedColumn<String>(
    'receipt_mime',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    date,
    category,
    description,
    amountMinor,
    vatMinor,
    currency,
    deductible,
    businessUsePercent,
    receiptPath,
    receiptImage,
    receiptMime,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'expenses';
  @override
  VerificationContext validateIntegrity(
    Insertable<Expense> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('category')) {
      context.handle(
        _categoryMeta,
        category.isAcceptableOrUnknown(data['category']!, _categoryMeta),
      );
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('amount_minor')) {
      context.handle(
        _amountMinorMeta,
        amountMinor.isAcceptableOrUnknown(
          data['amount_minor']!,
          _amountMinorMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_amountMinorMeta);
    }
    if (data.containsKey('vat_minor')) {
      context.handle(
        _vatMinorMeta,
        vatMinor.isAcceptableOrUnknown(data['vat_minor']!, _vatMinorMeta),
      );
    }
    if (data.containsKey('currency')) {
      context.handle(
        _currencyMeta,
        currency.isAcceptableOrUnknown(data['currency']!, _currencyMeta),
      );
    }
    if (data.containsKey('deductible')) {
      context.handle(
        _deductibleMeta,
        deductible.isAcceptableOrUnknown(data['deductible']!, _deductibleMeta),
      );
    }
    if (data.containsKey('business_use_percent')) {
      context.handle(
        _businessUsePercentMeta,
        businessUsePercent.isAcceptableOrUnknown(
          data['business_use_percent']!,
          _businessUsePercentMeta,
        ),
      );
    }
    if (data.containsKey('receipt_path')) {
      context.handle(
        _receiptPathMeta,
        receiptPath.isAcceptableOrUnknown(
          data['receipt_path']!,
          _receiptPathMeta,
        ),
      );
    }
    if (data.containsKey('receipt_image')) {
      context.handle(
        _receiptImageMeta,
        receiptImage.isAcceptableOrUnknown(
          data['receipt_image']!,
          _receiptImageMeta,
        ),
      );
    }
    if (data.containsKey('receipt_mime')) {
      context.handle(
        _receiptMimeMeta,
        receiptMime.isAcceptableOrUnknown(
          data['receipt_mime']!,
          _receiptMimeMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Expense map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Expense(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date'],
      )!,
      category: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      )!,
      amountMinor: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}amount_minor'],
      )!,
      vatMinor: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}vat_minor'],
      )!,
      currency: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}currency'],
      )!,
      deductible: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}deductible'],
      )!,
      businessUsePercent: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}business_use_percent'],
      )!,
      receiptPath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}receipt_path'],
      ),
      receiptImage: attachedDatabase.typeMapping.read(
        DriftSqlType.blob,
        data['${effectivePrefix}receipt_image'],
      ),
      receiptMime: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}receipt_mime'],
      ),
    );
  }

  @override
  $ExpensesTable createAlias(String alias) {
    return $ExpensesTable(attachedDatabase, alias);
  }
}

class Expense extends DataClass implements Insertable<Expense> {
  final String id;
  final DateTime date;
  final String category;
  final String description;
  final int amountMinor;
  final int vatMinor;
  final String currency;
  final bool deductible;

  /// Business-use percentage for 家事按分 (home/personal apportionment).
  /// 100 = fully business. Deductible amount = amountMinor * pct / 100.
  final int businessUsePercent;
  final String? receiptPath;

  /// Attached receipt image bytes (compressed JPEG/PNG). Stored in-DB so the
  /// whole ledger stays a single portable file and works identically on web
  /// (OPFS) and Android — see receipt_image.dart for the capture/compress path.
  final Uint8List? receiptImage;
  final String? receiptMime;
  const Expense({
    required this.id,
    required this.date,
    required this.category,
    required this.description,
    required this.amountMinor,
    required this.vatMinor,
    required this.currency,
    required this.deductible,
    required this.businessUsePercent,
    this.receiptPath,
    this.receiptImage,
    this.receiptMime,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['date'] = Variable<DateTime>(date);
    map['category'] = Variable<String>(category);
    map['description'] = Variable<String>(description);
    map['amount_minor'] = Variable<int>(amountMinor);
    map['vat_minor'] = Variable<int>(vatMinor);
    map['currency'] = Variable<String>(currency);
    map['deductible'] = Variable<bool>(deductible);
    map['business_use_percent'] = Variable<int>(businessUsePercent);
    if (!nullToAbsent || receiptPath != null) {
      map['receipt_path'] = Variable<String>(receiptPath);
    }
    if (!nullToAbsent || receiptImage != null) {
      map['receipt_image'] = Variable<Uint8List>(receiptImage);
    }
    if (!nullToAbsent || receiptMime != null) {
      map['receipt_mime'] = Variable<String>(receiptMime);
    }
    return map;
  }

  ExpensesCompanion toCompanion(bool nullToAbsent) {
    return ExpensesCompanion(
      id: Value(id),
      date: Value(date),
      category: Value(category),
      description: Value(description),
      amountMinor: Value(amountMinor),
      vatMinor: Value(vatMinor),
      currency: Value(currency),
      deductible: Value(deductible),
      businessUsePercent: Value(businessUsePercent),
      receiptPath: receiptPath == null && nullToAbsent
          ? const Value.absent()
          : Value(receiptPath),
      receiptImage: receiptImage == null && nullToAbsent
          ? const Value.absent()
          : Value(receiptImage),
      receiptMime: receiptMime == null && nullToAbsent
          ? const Value.absent()
          : Value(receiptMime),
    );
  }

  factory Expense.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Expense(
      id: serializer.fromJson<String>(json['id']),
      date: serializer.fromJson<DateTime>(json['date']),
      category: serializer.fromJson<String>(json['category']),
      description: serializer.fromJson<String>(json['description']),
      amountMinor: serializer.fromJson<int>(json['amountMinor']),
      vatMinor: serializer.fromJson<int>(json['vatMinor']),
      currency: serializer.fromJson<String>(json['currency']),
      deductible: serializer.fromJson<bool>(json['deductible']),
      businessUsePercent: serializer.fromJson<int>(json['businessUsePercent']),
      receiptPath: serializer.fromJson<String?>(json['receiptPath']),
      receiptImage: serializer.fromJson<Uint8List?>(json['receiptImage']),
      receiptMime: serializer.fromJson<String?>(json['receiptMime']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'date': serializer.toJson<DateTime>(date),
      'category': serializer.toJson<String>(category),
      'description': serializer.toJson<String>(description),
      'amountMinor': serializer.toJson<int>(amountMinor),
      'vatMinor': serializer.toJson<int>(vatMinor),
      'currency': serializer.toJson<String>(currency),
      'deductible': serializer.toJson<bool>(deductible),
      'businessUsePercent': serializer.toJson<int>(businessUsePercent),
      'receiptPath': serializer.toJson<String?>(receiptPath),
      'receiptImage': serializer.toJson<Uint8List?>(receiptImage),
      'receiptMime': serializer.toJson<String?>(receiptMime),
    };
  }

  Expense copyWith({
    String? id,
    DateTime? date,
    String? category,
    String? description,
    int? amountMinor,
    int? vatMinor,
    String? currency,
    bool? deductible,
    int? businessUsePercent,
    Value<String?> receiptPath = const Value.absent(),
    Value<Uint8List?> receiptImage = const Value.absent(),
    Value<String?> receiptMime = const Value.absent(),
  }) => Expense(
    id: id ?? this.id,
    date: date ?? this.date,
    category: category ?? this.category,
    description: description ?? this.description,
    amountMinor: amountMinor ?? this.amountMinor,
    vatMinor: vatMinor ?? this.vatMinor,
    currency: currency ?? this.currency,
    deductible: deductible ?? this.deductible,
    businessUsePercent: businessUsePercent ?? this.businessUsePercent,
    receiptPath: receiptPath.present ? receiptPath.value : this.receiptPath,
    receiptImage: receiptImage.present ? receiptImage.value : this.receiptImage,
    receiptMime: receiptMime.present ? receiptMime.value : this.receiptMime,
  );
  Expense copyWithCompanion(ExpensesCompanion data) {
    return Expense(
      id: data.id.present ? data.id.value : this.id,
      date: data.date.present ? data.date.value : this.date,
      category: data.category.present ? data.category.value : this.category,
      description: data.description.present
          ? data.description.value
          : this.description,
      amountMinor: data.amountMinor.present
          ? data.amountMinor.value
          : this.amountMinor,
      vatMinor: data.vatMinor.present ? data.vatMinor.value : this.vatMinor,
      currency: data.currency.present ? data.currency.value : this.currency,
      deductible: data.deductible.present
          ? data.deductible.value
          : this.deductible,
      businessUsePercent: data.businessUsePercent.present
          ? data.businessUsePercent.value
          : this.businessUsePercent,
      receiptPath: data.receiptPath.present
          ? data.receiptPath.value
          : this.receiptPath,
      receiptImage: data.receiptImage.present
          ? data.receiptImage.value
          : this.receiptImage,
      receiptMime: data.receiptMime.present
          ? data.receiptMime.value
          : this.receiptMime,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Expense(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('category: $category, ')
          ..write('description: $description, ')
          ..write('amountMinor: $amountMinor, ')
          ..write('vatMinor: $vatMinor, ')
          ..write('currency: $currency, ')
          ..write('deductible: $deductible, ')
          ..write('businessUsePercent: $businessUsePercent, ')
          ..write('receiptPath: $receiptPath, ')
          ..write('receiptImage: $receiptImage, ')
          ..write('receiptMime: $receiptMime')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    date,
    category,
    description,
    amountMinor,
    vatMinor,
    currency,
    deductible,
    businessUsePercent,
    receiptPath,
    $driftBlobEquality.hash(receiptImage),
    receiptMime,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Expense &&
          other.id == this.id &&
          other.date == this.date &&
          other.category == this.category &&
          other.description == this.description &&
          other.amountMinor == this.amountMinor &&
          other.vatMinor == this.vatMinor &&
          other.currency == this.currency &&
          other.deductible == this.deductible &&
          other.businessUsePercent == this.businessUsePercent &&
          other.receiptPath == this.receiptPath &&
          $driftBlobEquality.equals(other.receiptImage, this.receiptImage) &&
          other.receiptMime == this.receiptMime);
}

class ExpensesCompanion extends UpdateCompanion<Expense> {
  final Value<String> id;
  final Value<DateTime> date;
  final Value<String> category;
  final Value<String> description;
  final Value<int> amountMinor;
  final Value<int> vatMinor;
  final Value<String> currency;
  final Value<bool> deductible;
  final Value<int> businessUsePercent;
  final Value<String?> receiptPath;
  final Value<Uint8List?> receiptImage;
  final Value<String?> receiptMime;
  final Value<int> rowid;
  const ExpensesCompanion({
    this.id = const Value.absent(),
    this.date = const Value.absent(),
    this.category = const Value.absent(),
    this.description = const Value.absent(),
    this.amountMinor = const Value.absent(),
    this.vatMinor = const Value.absent(),
    this.currency = const Value.absent(),
    this.deductible = const Value.absent(),
    this.businessUsePercent = const Value.absent(),
    this.receiptPath = const Value.absent(),
    this.receiptImage = const Value.absent(),
    this.receiptMime = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ExpensesCompanion.insert({
    required String id,
    required DateTime date,
    this.category = const Value.absent(),
    this.description = const Value.absent(),
    required int amountMinor,
    this.vatMinor = const Value.absent(),
    this.currency = const Value.absent(),
    this.deductible = const Value.absent(),
    this.businessUsePercent = const Value.absent(),
    this.receiptPath = const Value.absent(),
    this.receiptImage = const Value.absent(),
    this.receiptMime = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       date = Value(date),
       amountMinor = Value(amountMinor);
  static Insertable<Expense> custom({
    Expression<String>? id,
    Expression<DateTime>? date,
    Expression<String>? category,
    Expression<String>? description,
    Expression<int>? amountMinor,
    Expression<int>? vatMinor,
    Expression<String>? currency,
    Expression<bool>? deductible,
    Expression<int>? businessUsePercent,
    Expression<String>? receiptPath,
    Expression<Uint8List>? receiptImage,
    Expression<String>? receiptMime,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (date != null) 'date': date,
      if (category != null) 'category': category,
      if (description != null) 'description': description,
      if (amountMinor != null) 'amount_minor': amountMinor,
      if (vatMinor != null) 'vat_minor': vatMinor,
      if (currency != null) 'currency': currency,
      if (deductible != null) 'deductible': deductible,
      if (businessUsePercent != null)
        'business_use_percent': businessUsePercent,
      if (receiptPath != null) 'receipt_path': receiptPath,
      if (receiptImage != null) 'receipt_image': receiptImage,
      if (receiptMime != null) 'receipt_mime': receiptMime,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ExpensesCompanion copyWith({
    Value<String>? id,
    Value<DateTime>? date,
    Value<String>? category,
    Value<String>? description,
    Value<int>? amountMinor,
    Value<int>? vatMinor,
    Value<String>? currency,
    Value<bool>? deductible,
    Value<int>? businessUsePercent,
    Value<String?>? receiptPath,
    Value<Uint8List?>? receiptImage,
    Value<String?>? receiptMime,
    Value<int>? rowid,
  }) {
    return ExpensesCompanion(
      id: id ?? this.id,
      date: date ?? this.date,
      category: category ?? this.category,
      description: description ?? this.description,
      amountMinor: amountMinor ?? this.amountMinor,
      vatMinor: vatMinor ?? this.vatMinor,
      currency: currency ?? this.currency,
      deductible: deductible ?? this.deductible,
      businessUsePercent: businessUsePercent ?? this.businessUsePercent,
      receiptPath: receiptPath ?? this.receiptPath,
      receiptImage: receiptImage ?? this.receiptImage,
      receiptMime: receiptMime ?? this.receiptMime,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (amountMinor.present) {
      map['amount_minor'] = Variable<int>(amountMinor.value);
    }
    if (vatMinor.present) {
      map['vat_minor'] = Variable<int>(vatMinor.value);
    }
    if (currency.present) {
      map['currency'] = Variable<String>(currency.value);
    }
    if (deductible.present) {
      map['deductible'] = Variable<bool>(deductible.value);
    }
    if (businessUsePercent.present) {
      map['business_use_percent'] = Variable<int>(businessUsePercent.value);
    }
    if (receiptPath.present) {
      map['receipt_path'] = Variable<String>(receiptPath.value);
    }
    if (receiptImage.present) {
      map['receipt_image'] = Variable<Uint8List>(receiptImage.value);
    }
    if (receiptMime.present) {
      map['receipt_mime'] = Variable<String>(receiptMime.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ExpensesCompanion(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('category: $category, ')
          ..write('description: $description, ')
          ..write('amountMinor: $amountMinor, ')
          ..write('vatMinor: $vatMinor, ')
          ..write('currency: $currency, ')
          ..write('deductible: $deductible, ')
          ..write('businessUsePercent: $businessUsePercent, ')
          ..write('receiptPath: $receiptPath, ')
          ..write('receiptImage: $receiptImage, ')
          ..write('receiptMime: $receiptMime, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $InvoiceLinesTable extends InvoiceLines
    with TableInfo<$InvoiceLinesTable, InvoiceLine> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $InvoiceLinesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _invoiceIdMeta = const VerificationMeta(
    'invoiceId',
  );
  @override
  late final GeneratedColumn<String> invoiceId = GeneratedColumn<String>(
    'invoice_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES invoices (id)',
    ),
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _quantityMeta = const VerificationMeta(
    'quantity',
  );
  @override
  late final GeneratedColumn<double> quantity = GeneratedColumn<double>(
    'quantity',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _unitMeta = const VerificationMeta('unit');
  @override
  late final GeneratedColumn<String> unit = GeneratedColumn<String>(
    'unit',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('hours'),
  );
  static const VerificationMeta _unitPriceMinorMeta = const VerificationMeta(
    'unitPriceMinor',
  );
  @override
  late final GeneratedColumn<int> unitPriceMinor = GeneratedColumn<int>(
    'unit_price_minor',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _vatTreatmentMeta = const VerificationMeta(
    'vatTreatment',
  );
  @override
  late final GeneratedColumn<String> vatTreatment = GeneratedColumn<String>(
    'vat_treatment',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('reverseChargeEu'),
  );
  static const VerificationMeta _sortOrderMeta = const VerificationMeta(
    'sortOrder',
  );
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
    'sort_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    invoiceId,
    description,
    quantity,
    unit,
    unitPriceMinor,
    vatTreatment,
    sortOrder,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'invoice_lines';
  @override
  VerificationContext validateIntegrity(
    Insertable<InvoiceLine> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('invoice_id')) {
      context.handle(
        _invoiceIdMeta,
        invoiceId.isAcceptableOrUnknown(data['invoice_id']!, _invoiceIdMeta),
      );
    } else if (isInserting) {
      context.missing(_invoiceIdMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('quantity')) {
      context.handle(
        _quantityMeta,
        quantity.isAcceptableOrUnknown(data['quantity']!, _quantityMeta),
      );
    }
    if (data.containsKey('unit')) {
      context.handle(
        _unitMeta,
        unit.isAcceptableOrUnknown(data['unit']!, _unitMeta),
      );
    }
    if (data.containsKey('unit_price_minor')) {
      context.handle(
        _unitPriceMinorMeta,
        unitPriceMinor.isAcceptableOrUnknown(
          data['unit_price_minor']!,
          _unitPriceMinorMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_unitPriceMinorMeta);
    }
    if (data.containsKey('vat_treatment')) {
      context.handle(
        _vatTreatmentMeta,
        vatTreatment.isAcceptableOrUnknown(
          data['vat_treatment']!,
          _vatTreatmentMeta,
        ),
      );
    }
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  InvoiceLine map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return InvoiceLine(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      invoiceId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}invoice_id'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      )!,
      quantity: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}quantity'],
      )!,
      unit: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}unit'],
      )!,
      unitPriceMinor: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}unit_price_minor'],
      )!,
      vatTreatment: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}vat_treatment'],
      )!,
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      )!,
    );
  }

  @override
  $InvoiceLinesTable createAlias(String alias) {
    return $InvoiceLinesTable(attachedDatabase, alias);
  }
}

class InvoiceLine extends DataClass implements Insertable<InvoiceLine> {
  final String id;
  final String invoiceId;
  final String description;
  final double quantity;
  final String unit;
  final int unitPriceMinor;
  final String vatTreatment;
  final int sortOrder;
  const InvoiceLine({
    required this.id,
    required this.invoiceId,
    required this.description,
    required this.quantity,
    required this.unit,
    required this.unitPriceMinor,
    required this.vatTreatment,
    required this.sortOrder,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['invoice_id'] = Variable<String>(invoiceId);
    map['description'] = Variable<String>(description);
    map['quantity'] = Variable<double>(quantity);
    map['unit'] = Variable<String>(unit);
    map['unit_price_minor'] = Variable<int>(unitPriceMinor);
    map['vat_treatment'] = Variable<String>(vatTreatment);
    map['sort_order'] = Variable<int>(sortOrder);
    return map;
  }

  InvoiceLinesCompanion toCompanion(bool nullToAbsent) {
    return InvoiceLinesCompanion(
      id: Value(id),
      invoiceId: Value(invoiceId),
      description: Value(description),
      quantity: Value(quantity),
      unit: Value(unit),
      unitPriceMinor: Value(unitPriceMinor),
      vatTreatment: Value(vatTreatment),
      sortOrder: Value(sortOrder),
    );
  }

  factory InvoiceLine.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return InvoiceLine(
      id: serializer.fromJson<String>(json['id']),
      invoiceId: serializer.fromJson<String>(json['invoiceId']),
      description: serializer.fromJson<String>(json['description']),
      quantity: serializer.fromJson<double>(json['quantity']),
      unit: serializer.fromJson<String>(json['unit']),
      unitPriceMinor: serializer.fromJson<int>(json['unitPriceMinor']),
      vatTreatment: serializer.fromJson<String>(json['vatTreatment']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'invoiceId': serializer.toJson<String>(invoiceId),
      'description': serializer.toJson<String>(description),
      'quantity': serializer.toJson<double>(quantity),
      'unit': serializer.toJson<String>(unit),
      'unitPriceMinor': serializer.toJson<int>(unitPriceMinor),
      'vatTreatment': serializer.toJson<String>(vatTreatment),
      'sortOrder': serializer.toJson<int>(sortOrder),
    };
  }

  InvoiceLine copyWith({
    String? id,
    String? invoiceId,
    String? description,
    double? quantity,
    String? unit,
    int? unitPriceMinor,
    String? vatTreatment,
    int? sortOrder,
  }) => InvoiceLine(
    id: id ?? this.id,
    invoiceId: invoiceId ?? this.invoiceId,
    description: description ?? this.description,
    quantity: quantity ?? this.quantity,
    unit: unit ?? this.unit,
    unitPriceMinor: unitPriceMinor ?? this.unitPriceMinor,
    vatTreatment: vatTreatment ?? this.vatTreatment,
    sortOrder: sortOrder ?? this.sortOrder,
  );
  InvoiceLine copyWithCompanion(InvoiceLinesCompanion data) {
    return InvoiceLine(
      id: data.id.present ? data.id.value : this.id,
      invoiceId: data.invoiceId.present ? data.invoiceId.value : this.invoiceId,
      description: data.description.present
          ? data.description.value
          : this.description,
      quantity: data.quantity.present ? data.quantity.value : this.quantity,
      unit: data.unit.present ? data.unit.value : this.unit,
      unitPriceMinor: data.unitPriceMinor.present
          ? data.unitPriceMinor.value
          : this.unitPriceMinor,
      vatTreatment: data.vatTreatment.present
          ? data.vatTreatment.value
          : this.vatTreatment,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
    );
  }

  @override
  String toString() {
    return (StringBuffer('InvoiceLine(')
          ..write('id: $id, ')
          ..write('invoiceId: $invoiceId, ')
          ..write('description: $description, ')
          ..write('quantity: $quantity, ')
          ..write('unit: $unit, ')
          ..write('unitPriceMinor: $unitPriceMinor, ')
          ..write('vatTreatment: $vatTreatment, ')
          ..write('sortOrder: $sortOrder')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    invoiceId,
    description,
    quantity,
    unit,
    unitPriceMinor,
    vatTreatment,
    sortOrder,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is InvoiceLine &&
          other.id == this.id &&
          other.invoiceId == this.invoiceId &&
          other.description == this.description &&
          other.quantity == this.quantity &&
          other.unit == this.unit &&
          other.unitPriceMinor == this.unitPriceMinor &&
          other.vatTreatment == this.vatTreatment &&
          other.sortOrder == this.sortOrder);
}

class InvoiceLinesCompanion extends UpdateCompanion<InvoiceLine> {
  final Value<String> id;
  final Value<String> invoiceId;
  final Value<String> description;
  final Value<double> quantity;
  final Value<String> unit;
  final Value<int> unitPriceMinor;
  final Value<String> vatTreatment;
  final Value<int> sortOrder;
  final Value<int> rowid;
  const InvoiceLinesCompanion({
    this.id = const Value.absent(),
    this.invoiceId = const Value.absent(),
    this.description = const Value.absent(),
    this.quantity = const Value.absent(),
    this.unit = const Value.absent(),
    this.unitPriceMinor = const Value.absent(),
    this.vatTreatment = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  InvoiceLinesCompanion.insert({
    required String id,
    required String invoiceId,
    required String description,
    this.quantity = const Value.absent(),
    this.unit = const Value.absent(),
    required int unitPriceMinor,
    this.vatTreatment = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       invoiceId = Value(invoiceId),
       description = Value(description),
       unitPriceMinor = Value(unitPriceMinor);
  static Insertable<InvoiceLine> custom({
    Expression<String>? id,
    Expression<String>? invoiceId,
    Expression<String>? description,
    Expression<double>? quantity,
    Expression<String>? unit,
    Expression<int>? unitPriceMinor,
    Expression<String>? vatTreatment,
    Expression<int>? sortOrder,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (invoiceId != null) 'invoice_id': invoiceId,
      if (description != null) 'description': description,
      if (quantity != null) 'quantity': quantity,
      if (unit != null) 'unit': unit,
      if (unitPriceMinor != null) 'unit_price_minor': unitPriceMinor,
      if (vatTreatment != null) 'vat_treatment': vatTreatment,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (rowid != null) 'rowid': rowid,
    });
  }

  InvoiceLinesCompanion copyWith({
    Value<String>? id,
    Value<String>? invoiceId,
    Value<String>? description,
    Value<double>? quantity,
    Value<String>? unit,
    Value<int>? unitPriceMinor,
    Value<String>? vatTreatment,
    Value<int>? sortOrder,
    Value<int>? rowid,
  }) {
    return InvoiceLinesCompanion(
      id: id ?? this.id,
      invoiceId: invoiceId ?? this.invoiceId,
      description: description ?? this.description,
      quantity: quantity ?? this.quantity,
      unit: unit ?? this.unit,
      unitPriceMinor: unitPriceMinor ?? this.unitPriceMinor,
      vatTreatment: vatTreatment ?? this.vatTreatment,
      sortOrder: sortOrder ?? this.sortOrder,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (invoiceId.present) {
      map['invoice_id'] = Variable<String>(invoiceId.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (quantity.present) {
      map['quantity'] = Variable<double>(quantity.value);
    }
    if (unit.present) {
      map['unit'] = Variable<String>(unit.value);
    }
    if (unitPriceMinor.present) {
      map['unit_price_minor'] = Variable<int>(unitPriceMinor.value);
    }
    if (vatTreatment.present) {
      map['vat_treatment'] = Variable<String>(vatTreatment.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('InvoiceLinesCompanion(')
          ..write('id: $id, ')
          ..write('invoiceId: $invoiceId, ')
          ..write('description: $description, ')
          ..write('quantity: $quantity, ')
          ..write('unit: $unit, ')
          ..write('unitPriceMinor: $unitPriceMinor, ')
          ..write('vatTreatment: $vatTreatment, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AssetsTable extends Assets with TableInfo<$AssetsTable, Asset> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AssetsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _acquisitionDateMeta = const VerificationMeta(
    'acquisitionDate',
  );
  @override
  late final GeneratedColumn<DateTime> acquisitionDate =
      GeneratedColumn<DateTime>(
        'acquisition_date',
        aliasedName,
        false,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _costMinorMeta = const VerificationMeta(
    'costMinor',
  );
  @override
  late final GeneratedColumn<int> costMinor = GeneratedColumn<int>(
    'cost_minor',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _currencyMeta = const VerificationMeta(
    'currency',
  );
  @override
  late final GeneratedColumn<String> currency = GeneratedColumn<String>(
    'currency',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('JPY'),
  );
  static const VerificationMeta _methodMeta = const VerificationMeta('method');
  @override
  late final GeneratedColumn<String> method = GeneratedColumn<String>(
    'method',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('straightLine'),
  );
  static const VerificationMeta _usefulLifeYearsMeta = const VerificationMeta(
    'usefulLifeYears',
  );
  @override
  late final GeneratedColumn<int> usefulLifeYears = GeneratedColumn<int>(
    'useful_life_years',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(4),
  );
  static const VerificationMeta _businessUsePercentMeta =
      const VerificationMeta('businessUsePercent');
  @override
  late final GeneratedColumn<int> businessUsePercent = GeneratedColumn<int>(
    'business_use_percent',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(100),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    description,
    acquisitionDate,
    costMinor,
    currency,
    method,
    usefulLifeYears,
    businessUsePercent,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'assets';
  @override
  VerificationContext validateIntegrity(
    Insertable<Asset> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('acquisition_date')) {
      context.handle(
        _acquisitionDateMeta,
        acquisitionDate.isAcceptableOrUnknown(
          data['acquisition_date']!,
          _acquisitionDateMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_acquisitionDateMeta);
    }
    if (data.containsKey('cost_minor')) {
      context.handle(
        _costMinorMeta,
        costMinor.isAcceptableOrUnknown(data['cost_minor']!, _costMinorMeta),
      );
    } else if (isInserting) {
      context.missing(_costMinorMeta);
    }
    if (data.containsKey('currency')) {
      context.handle(
        _currencyMeta,
        currency.isAcceptableOrUnknown(data['currency']!, _currencyMeta),
      );
    }
    if (data.containsKey('method')) {
      context.handle(
        _methodMeta,
        method.isAcceptableOrUnknown(data['method']!, _methodMeta),
      );
    }
    if (data.containsKey('useful_life_years')) {
      context.handle(
        _usefulLifeYearsMeta,
        usefulLifeYears.isAcceptableOrUnknown(
          data['useful_life_years']!,
          _usefulLifeYearsMeta,
        ),
      );
    }
    if (data.containsKey('business_use_percent')) {
      context.handle(
        _businessUsePercentMeta,
        businessUsePercent.isAcceptableOrUnknown(
          data['business_use_percent']!,
          _businessUsePercentMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Asset map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Asset(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      )!,
      acquisitionDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}acquisition_date'],
      )!,
      costMinor: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}cost_minor'],
      )!,
      currency: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}currency'],
      )!,
      method: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}method'],
      )!,
      usefulLifeYears: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}useful_life_years'],
      )!,
      businessUsePercent: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}business_use_percent'],
      )!,
    );
  }

  @override
  $AssetsTable createAlias(String alias) {
    return $AssetsTable(attachedDatabase, alias);
  }
}

class Asset extends DataClass implements Insertable<Asset> {
  final String id;
  final String description;
  final DateTime acquisitionDate;
  final int costMinor;
  final String currency;

  /// 'fullExpense' (少額特例), 'lumpThreeYear' (一括償却), 'straightLine' (定額法).
  final String method;
  final int usefulLifeYears;
  final int businessUsePercent;
  const Asset({
    required this.id,
    required this.description,
    required this.acquisitionDate,
    required this.costMinor,
    required this.currency,
    required this.method,
    required this.usefulLifeYears,
    required this.businessUsePercent,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['description'] = Variable<String>(description);
    map['acquisition_date'] = Variable<DateTime>(acquisitionDate);
    map['cost_minor'] = Variable<int>(costMinor);
    map['currency'] = Variable<String>(currency);
    map['method'] = Variable<String>(method);
    map['useful_life_years'] = Variable<int>(usefulLifeYears);
    map['business_use_percent'] = Variable<int>(businessUsePercent);
    return map;
  }

  AssetsCompanion toCompanion(bool nullToAbsent) {
    return AssetsCompanion(
      id: Value(id),
      description: Value(description),
      acquisitionDate: Value(acquisitionDate),
      costMinor: Value(costMinor),
      currency: Value(currency),
      method: Value(method),
      usefulLifeYears: Value(usefulLifeYears),
      businessUsePercent: Value(businessUsePercent),
    );
  }

  factory Asset.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Asset(
      id: serializer.fromJson<String>(json['id']),
      description: serializer.fromJson<String>(json['description']),
      acquisitionDate: serializer.fromJson<DateTime>(json['acquisitionDate']),
      costMinor: serializer.fromJson<int>(json['costMinor']),
      currency: serializer.fromJson<String>(json['currency']),
      method: serializer.fromJson<String>(json['method']),
      usefulLifeYears: serializer.fromJson<int>(json['usefulLifeYears']),
      businessUsePercent: serializer.fromJson<int>(json['businessUsePercent']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'description': serializer.toJson<String>(description),
      'acquisitionDate': serializer.toJson<DateTime>(acquisitionDate),
      'costMinor': serializer.toJson<int>(costMinor),
      'currency': serializer.toJson<String>(currency),
      'method': serializer.toJson<String>(method),
      'usefulLifeYears': serializer.toJson<int>(usefulLifeYears),
      'businessUsePercent': serializer.toJson<int>(businessUsePercent),
    };
  }

  Asset copyWith({
    String? id,
    String? description,
    DateTime? acquisitionDate,
    int? costMinor,
    String? currency,
    String? method,
    int? usefulLifeYears,
    int? businessUsePercent,
  }) => Asset(
    id: id ?? this.id,
    description: description ?? this.description,
    acquisitionDate: acquisitionDate ?? this.acquisitionDate,
    costMinor: costMinor ?? this.costMinor,
    currency: currency ?? this.currency,
    method: method ?? this.method,
    usefulLifeYears: usefulLifeYears ?? this.usefulLifeYears,
    businessUsePercent: businessUsePercent ?? this.businessUsePercent,
  );
  Asset copyWithCompanion(AssetsCompanion data) {
    return Asset(
      id: data.id.present ? data.id.value : this.id,
      description: data.description.present
          ? data.description.value
          : this.description,
      acquisitionDate: data.acquisitionDate.present
          ? data.acquisitionDate.value
          : this.acquisitionDate,
      costMinor: data.costMinor.present ? data.costMinor.value : this.costMinor,
      currency: data.currency.present ? data.currency.value : this.currency,
      method: data.method.present ? data.method.value : this.method,
      usefulLifeYears: data.usefulLifeYears.present
          ? data.usefulLifeYears.value
          : this.usefulLifeYears,
      businessUsePercent: data.businessUsePercent.present
          ? data.businessUsePercent.value
          : this.businessUsePercent,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Asset(')
          ..write('id: $id, ')
          ..write('description: $description, ')
          ..write('acquisitionDate: $acquisitionDate, ')
          ..write('costMinor: $costMinor, ')
          ..write('currency: $currency, ')
          ..write('method: $method, ')
          ..write('usefulLifeYears: $usefulLifeYears, ')
          ..write('businessUsePercent: $businessUsePercent')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    description,
    acquisitionDate,
    costMinor,
    currency,
    method,
    usefulLifeYears,
    businessUsePercent,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Asset &&
          other.id == this.id &&
          other.description == this.description &&
          other.acquisitionDate == this.acquisitionDate &&
          other.costMinor == this.costMinor &&
          other.currency == this.currency &&
          other.method == this.method &&
          other.usefulLifeYears == this.usefulLifeYears &&
          other.businessUsePercent == this.businessUsePercent);
}

class AssetsCompanion extends UpdateCompanion<Asset> {
  final Value<String> id;
  final Value<String> description;
  final Value<DateTime> acquisitionDate;
  final Value<int> costMinor;
  final Value<String> currency;
  final Value<String> method;
  final Value<int> usefulLifeYears;
  final Value<int> businessUsePercent;
  final Value<int> rowid;
  const AssetsCompanion({
    this.id = const Value.absent(),
    this.description = const Value.absent(),
    this.acquisitionDate = const Value.absent(),
    this.costMinor = const Value.absent(),
    this.currency = const Value.absent(),
    this.method = const Value.absent(),
    this.usefulLifeYears = const Value.absent(),
    this.businessUsePercent = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AssetsCompanion.insert({
    required String id,
    this.description = const Value.absent(),
    required DateTime acquisitionDate,
    required int costMinor,
    this.currency = const Value.absent(),
    this.method = const Value.absent(),
    this.usefulLifeYears = const Value.absent(),
    this.businessUsePercent = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       acquisitionDate = Value(acquisitionDate),
       costMinor = Value(costMinor);
  static Insertable<Asset> custom({
    Expression<String>? id,
    Expression<String>? description,
    Expression<DateTime>? acquisitionDate,
    Expression<int>? costMinor,
    Expression<String>? currency,
    Expression<String>? method,
    Expression<int>? usefulLifeYears,
    Expression<int>? businessUsePercent,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (description != null) 'description': description,
      if (acquisitionDate != null) 'acquisition_date': acquisitionDate,
      if (costMinor != null) 'cost_minor': costMinor,
      if (currency != null) 'currency': currency,
      if (method != null) 'method': method,
      if (usefulLifeYears != null) 'useful_life_years': usefulLifeYears,
      if (businessUsePercent != null)
        'business_use_percent': businessUsePercent,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AssetsCompanion copyWith({
    Value<String>? id,
    Value<String>? description,
    Value<DateTime>? acquisitionDate,
    Value<int>? costMinor,
    Value<String>? currency,
    Value<String>? method,
    Value<int>? usefulLifeYears,
    Value<int>? businessUsePercent,
    Value<int>? rowid,
  }) {
    return AssetsCompanion(
      id: id ?? this.id,
      description: description ?? this.description,
      acquisitionDate: acquisitionDate ?? this.acquisitionDate,
      costMinor: costMinor ?? this.costMinor,
      currency: currency ?? this.currency,
      method: method ?? this.method,
      usefulLifeYears: usefulLifeYears ?? this.usefulLifeYears,
      businessUsePercent: businessUsePercent ?? this.businessUsePercent,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (acquisitionDate.present) {
      map['acquisition_date'] = Variable<DateTime>(acquisitionDate.value);
    }
    if (costMinor.present) {
      map['cost_minor'] = Variable<int>(costMinor.value);
    }
    if (currency.present) {
      map['currency'] = Variable<String>(currency.value);
    }
    if (method.present) {
      map['method'] = Variable<String>(method.value);
    }
    if (usefulLifeYears.present) {
      map['useful_life_years'] = Variable<int>(usefulLifeYears.value);
    }
    if (businessUsePercent.present) {
      map['business_use_percent'] = Variable<int>(businessUsePercent.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AssetsCompanion(')
          ..write('id: $id, ')
          ..write('description: $description, ')
          ..write('acquisitionDate: $acquisitionDate, ')
          ..write('costMinor: $costMinor, ')
          ..write('currency: $currency, ')
          ..write('method: $method, ')
          ..write('usefulLifeYears: $usefulLifeYears, ')
          ..write('businessUsePercent: $businessUsePercent, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $BusinessProfilesTable businessProfiles = $BusinessProfilesTable(
    this,
  );
  late final $ClientsTable clients = $ClientsTable(this);
  late final $ProjectsTable projects = $ProjectsTable(this);
  late final $InvoicesTable invoices = $InvoicesTable(this);
  late final $TimeEntriesTable timeEntries = $TimeEntriesTable(this);
  late final $ExpensesTable expenses = $ExpensesTable(this);
  late final $InvoiceLinesTable invoiceLines = $InvoiceLinesTable(this);
  late final $AssetsTable assets = $AssetsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    businessProfiles,
    clients,
    projects,
    invoices,
    timeEntries,
    expenses,
    invoiceLines,
    assets,
  ];
}

typedef $$BusinessProfilesTableCreateCompanionBuilder =
    BusinessProfilesCompanion Function({
      required String id,
      Value<String> legalName,
      Value<String> tradeName,
      Value<String> kvkNumber,
      Value<String> vatId,
      Value<String> jpBusinessNumber,
      Value<String> addressLine1,
      Value<String> addressLine2,
      Value<String> postalCode,
      Value<String> city,
      Value<String> country,
      Value<String> email,
      Value<String> phone,
      Value<String> iban,
      Value<String> bic,
      Value<String> bankName,
      Value<String> defaultCurrency,
      Value<String> defaultLanguage,
      Value<String> invoiceNumberPrefix,
      Value<int> nextInvoiceSeq,
      Value<String?> logoPath,
      Value<String?> signaturePath,
      Value<double> defaultHourlyRate,
      Value<double> eurToJpyRate,
      Value<String> themeMode,
      Value<int> rowid,
    });
typedef $$BusinessProfilesTableUpdateCompanionBuilder =
    BusinessProfilesCompanion Function({
      Value<String> id,
      Value<String> legalName,
      Value<String> tradeName,
      Value<String> kvkNumber,
      Value<String> vatId,
      Value<String> jpBusinessNumber,
      Value<String> addressLine1,
      Value<String> addressLine2,
      Value<String> postalCode,
      Value<String> city,
      Value<String> country,
      Value<String> email,
      Value<String> phone,
      Value<String> iban,
      Value<String> bic,
      Value<String> bankName,
      Value<String> defaultCurrency,
      Value<String> defaultLanguage,
      Value<String> invoiceNumberPrefix,
      Value<int> nextInvoiceSeq,
      Value<String?> logoPath,
      Value<String?> signaturePath,
      Value<double> defaultHourlyRate,
      Value<double> eurToJpyRate,
      Value<String> themeMode,
      Value<int> rowid,
    });

class $$BusinessProfilesTableFilterComposer
    extends Composer<_$AppDatabase, $BusinessProfilesTable> {
  $$BusinessProfilesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get legalName => $composableBuilder(
    column: $table.legalName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get tradeName => $composableBuilder(
    column: $table.tradeName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get kvkNumber => $composableBuilder(
    column: $table.kvkNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get vatId => $composableBuilder(
    column: $table.vatId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get jpBusinessNumber => $composableBuilder(
    column: $table.jpBusinessNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get addressLine1 => $composableBuilder(
    column: $table.addressLine1,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get addressLine2 => $composableBuilder(
    column: $table.addressLine2,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get postalCode => $composableBuilder(
    column: $table.postalCode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get city => $composableBuilder(
    column: $table.city,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get country => $composableBuilder(
    column: $table.country,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get iban => $composableBuilder(
    column: $table.iban,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get bic => $composableBuilder(
    column: $table.bic,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get bankName => $composableBuilder(
    column: $table.bankName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get defaultCurrency => $composableBuilder(
    column: $table.defaultCurrency,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get defaultLanguage => $composableBuilder(
    column: $table.defaultLanguage,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get invoiceNumberPrefix => $composableBuilder(
    column: $table.invoiceNumberPrefix,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get nextInvoiceSeq => $composableBuilder(
    column: $table.nextInvoiceSeq,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get logoPath => $composableBuilder(
    column: $table.logoPath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get signaturePath => $composableBuilder(
    column: $table.signaturePath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get defaultHourlyRate => $composableBuilder(
    column: $table.defaultHourlyRate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get eurToJpyRate => $composableBuilder(
    column: $table.eurToJpyRate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get themeMode => $composableBuilder(
    column: $table.themeMode,
    builder: (column) => ColumnFilters(column),
  );
}

class $$BusinessProfilesTableOrderingComposer
    extends Composer<_$AppDatabase, $BusinessProfilesTable> {
  $$BusinessProfilesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get legalName => $composableBuilder(
    column: $table.legalName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tradeName => $composableBuilder(
    column: $table.tradeName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get kvkNumber => $composableBuilder(
    column: $table.kvkNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get vatId => $composableBuilder(
    column: $table.vatId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get jpBusinessNumber => $composableBuilder(
    column: $table.jpBusinessNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get addressLine1 => $composableBuilder(
    column: $table.addressLine1,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get addressLine2 => $composableBuilder(
    column: $table.addressLine2,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get postalCode => $composableBuilder(
    column: $table.postalCode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get city => $composableBuilder(
    column: $table.city,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get country => $composableBuilder(
    column: $table.country,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get iban => $composableBuilder(
    column: $table.iban,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get bic => $composableBuilder(
    column: $table.bic,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get bankName => $composableBuilder(
    column: $table.bankName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get defaultCurrency => $composableBuilder(
    column: $table.defaultCurrency,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get defaultLanguage => $composableBuilder(
    column: $table.defaultLanguage,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get invoiceNumberPrefix => $composableBuilder(
    column: $table.invoiceNumberPrefix,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get nextInvoiceSeq => $composableBuilder(
    column: $table.nextInvoiceSeq,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get logoPath => $composableBuilder(
    column: $table.logoPath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get signaturePath => $composableBuilder(
    column: $table.signaturePath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get defaultHourlyRate => $composableBuilder(
    column: $table.defaultHourlyRate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get eurToJpyRate => $composableBuilder(
    column: $table.eurToJpyRate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get themeMode => $composableBuilder(
    column: $table.themeMode,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$BusinessProfilesTableAnnotationComposer
    extends Composer<_$AppDatabase, $BusinessProfilesTable> {
  $$BusinessProfilesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get legalName =>
      $composableBuilder(column: $table.legalName, builder: (column) => column);

  GeneratedColumn<String> get tradeName =>
      $composableBuilder(column: $table.tradeName, builder: (column) => column);

  GeneratedColumn<String> get kvkNumber =>
      $composableBuilder(column: $table.kvkNumber, builder: (column) => column);

  GeneratedColumn<String> get vatId =>
      $composableBuilder(column: $table.vatId, builder: (column) => column);

  GeneratedColumn<String> get jpBusinessNumber => $composableBuilder(
    column: $table.jpBusinessNumber,
    builder: (column) => column,
  );

  GeneratedColumn<String> get addressLine1 => $composableBuilder(
    column: $table.addressLine1,
    builder: (column) => column,
  );

  GeneratedColumn<String> get addressLine2 => $composableBuilder(
    column: $table.addressLine2,
    builder: (column) => column,
  );

  GeneratedColumn<String> get postalCode => $composableBuilder(
    column: $table.postalCode,
    builder: (column) => column,
  );

  GeneratedColumn<String> get city =>
      $composableBuilder(column: $table.city, builder: (column) => column);

  GeneratedColumn<String> get country =>
      $composableBuilder(column: $table.country, builder: (column) => column);

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<String> get phone =>
      $composableBuilder(column: $table.phone, builder: (column) => column);

  GeneratedColumn<String> get iban =>
      $composableBuilder(column: $table.iban, builder: (column) => column);

  GeneratedColumn<String> get bic =>
      $composableBuilder(column: $table.bic, builder: (column) => column);

  GeneratedColumn<String> get bankName =>
      $composableBuilder(column: $table.bankName, builder: (column) => column);

  GeneratedColumn<String> get defaultCurrency => $composableBuilder(
    column: $table.defaultCurrency,
    builder: (column) => column,
  );

  GeneratedColumn<String> get defaultLanguage => $composableBuilder(
    column: $table.defaultLanguage,
    builder: (column) => column,
  );

  GeneratedColumn<String> get invoiceNumberPrefix => $composableBuilder(
    column: $table.invoiceNumberPrefix,
    builder: (column) => column,
  );

  GeneratedColumn<int> get nextInvoiceSeq => $composableBuilder(
    column: $table.nextInvoiceSeq,
    builder: (column) => column,
  );

  GeneratedColumn<String> get logoPath =>
      $composableBuilder(column: $table.logoPath, builder: (column) => column);

  GeneratedColumn<String> get signaturePath => $composableBuilder(
    column: $table.signaturePath,
    builder: (column) => column,
  );

  GeneratedColumn<double> get defaultHourlyRate => $composableBuilder(
    column: $table.defaultHourlyRate,
    builder: (column) => column,
  );

  GeneratedColumn<double> get eurToJpyRate => $composableBuilder(
    column: $table.eurToJpyRate,
    builder: (column) => column,
  );

  GeneratedColumn<String> get themeMode =>
      $composableBuilder(column: $table.themeMode, builder: (column) => column);
}

class $$BusinessProfilesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $BusinessProfilesTable,
          BusinessProfile,
          $$BusinessProfilesTableFilterComposer,
          $$BusinessProfilesTableOrderingComposer,
          $$BusinessProfilesTableAnnotationComposer,
          $$BusinessProfilesTableCreateCompanionBuilder,
          $$BusinessProfilesTableUpdateCompanionBuilder,
          (
            BusinessProfile,
            BaseReferences<
              _$AppDatabase,
              $BusinessProfilesTable,
              BusinessProfile
            >,
          ),
          BusinessProfile,
          PrefetchHooks Function()
        > {
  $$BusinessProfilesTableTableManager(
    _$AppDatabase db,
    $BusinessProfilesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BusinessProfilesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BusinessProfilesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BusinessProfilesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> legalName = const Value.absent(),
                Value<String> tradeName = const Value.absent(),
                Value<String> kvkNumber = const Value.absent(),
                Value<String> vatId = const Value.absent(),
                Value<String> jpBusinessNumber = const Value.absent(),
                Value<String> addressLine1 = const Value.absent(),
                Value<String> addressLine2 = const Value.absent(),
                Value<String> postalCode = const Value.absent(),
                Value<String> city = const Value.absent(),
                Value<String> country = const Value.absent(),
                Value<String> email = const Value.absent(),
                Value<String> phone = const Value.absent(),
                Value<String> iban = const Value.absent(),
                Value<String> bic = const Value.absent(),
                Value<String> bankName = const Value.absent(),
                Value<String> defaultCurrency = const Value.absent(),
                Value<String> defaultLanguage = const Value.absent(),
                Value<String> invoiceNumberPrefix = const Value.absent(),
                Value<int> nextInvoiceSeq = const Value.absent(),
                Value<String?> logoPath = const Value.absent(),
                Value<String?> signaturePath = const Value.absent(),
                Value<double> defaultHourlyRate = const Value.absent(),
                Value<double> eurToJpyRate = const Value.absent(),
                Value<String> themeMode = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => BusinessProfilesCompanion(
                id: id,
                legalName: legalName,
                tradeName: tradeName,
                kvkNumber: kvkNumber,
                vatId: vatId,
                jpBusinessNumber: jpBusinessNumber,
                addressLine1: addressLine1,
                addressLine2: addressLine2,
                postalCode: postalCode,
                city: city,
                country: country,
                email: email,
                phone: phone,
                iban: iban,
                bic: bic,
                bankName: bankName,
                defaultCurrency: defaultCurrency,
                defaultLanguage: defaultLanguage,
                invoiceNumberPrefix: invoiceNumberPrefix,
                nextInvoiceSeq: nextInvoiceSeq,
                logoPath: logoPath,
                signaturePath: signaturePath,
                defaultHourlyRate: defaultHourlyRate,
                eurToJpyRate: eurToJpyRate,
                themeMode: themeMode,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                Value<String> legalName = const Value.absent(),
                Value<String> tradeName = const Value.absent(),
                Value<String> kvkNumber = const Value.absent(),
                Value<String> vatId = const Value.absent(),
                Value<String> jpBusinessNumber = const Value.absent(),
                Value<String> addressLine1 = const Value.absent(),
                Value<String> addressLine2 = const Value.absent(),
                Value<String> postalCode = const Value.absent(),
                Value<String> city = const Value.absent(),
                Value<String> country = const Value.absent(),
                Value<String> email = const Value.absent(),
                Value<String> phone = const Value.absent(),
                Value<String> iban = const Value.absent(),
                Value<String> bic = const Value.absent(),
                Value<String> bankName = const Value.absent(),
                Value<String> defaultCurrency = const Value.absent(),
                Value<String> defaultLanguage = const Value.absent(),
                Value<String> invoiceNumberPrefix = const Value.absent(),
                Value<int> nextInvoiceSeq = const Value.absent(),
                Value<String?> logoPath = const Value.absent(),
                Value<String?> signaturePath = const Value.absent(),
                Value<double> defaultHourlyRate = const Value.absent(),
                Value<double> eurToJpyRate = const Value.absent(),
                Value<String> themeMode = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => BusinessProfilesCompanion.insert(
                id: id,
                legalName: legalName,
                tradeName: tradeName,
                kvkNumber: kvkNumber,
                vatId: vatId,
                jpBusinessNumber: jpBusinessNumber,
                addressLine1: addressLine1,
                addressLine2: addressLine2,
                postalCode: postalCode,
                city: city,
                country: country,
                email: email,
                phone: phone,
                iban: iban,
                bic: bic,
                bankName: bankName,
                defaultCurrency: defaultCurrency,
                defaultLanguage: defaultLanguage,
                invoiceNumberPrefix: invoiceNumberPrefix,
                nextInvoiceSeq: nextInvoiceSeq,
                logoPath: logoPath,
                signaturePath: signaturePath,
                defaultHourlyRate: defaultHourlyRate,
                eurToJpyRate: eurToJpyRate,
                themeMode: themeMode,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$BusinessProfilesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $BusinessProfilesTable,
      BusinessProfile,
      $$BusinessProfilesTableFilterComposer,
      $$BusinessProfilesTableOrderingComposer,
      $$BusinessProfilesTableAnnotationComposer,
      $$BusinessProfilesTableCreateCompanionBuilder,
      $$BusinessProfilesTableUpdateCompanionBuilder,
      (
        BusinessProfile,
        BaseReferences<_$AppDatabase, $BusinessProfilesTable, BusinessProfile>,
      ),
      BusinessProfile,
      PrefetchHooks Function()
    >;
typedef $$ClientsTableCreateCompanionBuilder =
    ClientsCompanion Function({
      required String id,
      required String name,
      Value<String> contactName,
      Value<String> vatId,
      Value<String> addressLine1,
      Value<String> addressLine2,
      Value<String> postalCode,
      Value<String> city,
      Value<String> country,
      Value<String> email,
      Value<String> defaultCurrency,
      Value<String> language,
      Value<String> defaultVatTreatment,
      Value<double?> defaultHourlyRate,
      Value<int> paymentTermDays,
      Value<String> notes,
      Value<bool> archived,
      Value<int> rowid,
    });
typedef $$ClientsTableUpdateCompanionBuilder =
    ClientsCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<String> contactName,
      Value<String> vatId,
      Value<String> addressLine1,
      Value<String> addressLine2,
      Value<String> postalCode,
      Value<String> city,
      Value<String> country,
      Value<String> email,
      Value<String> defaultCurrency,
      Value<String> language,
      Value<String> defaultVatTreatment,
      Value<double?> defaultHourlyRate,
      Value<int> paymentTermDays,
      Value<String> notes,
      Value<bool> archived,
      Value<int> rowid,
    });

final class $$ClientsTableReferences
    extends BaseReferences<_$AppDatabase, $ClientsTable, Client> {
  $$ClientsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$ProjectsTable, List<Project>> _projectsRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.projects,
    aliasName: 'clients__id__projects__client_id',
  );

  $$ProjectsTableProcessedTableManager get projectsRefs {
    final manager = $$ProjectsTableTableManager(
      $_db,
      $_db.projects,
    ).filter((f) => f.clientId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_projectsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$InvoicesTable, List<Invoice>> _invoicesRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.invoices,
    aliasName: 'clients__id__invoices__client_id',
  );

  $$InvoicesTableProcessedTableManager get invoicesRefs {
    final manager = $$InvoicesTableTableManager(
      $_db,
      $_db.invoices,
    ).filter((f) => f.clientId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_invoicesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$TimeEntriesTable, List<TimeEntry>>
  _timeEntriesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.timeEntries,
    aliasName: 'clients__id__time_entries__client_id',
  );

  $$TimeEntriesTableProcessedTableManager get timeEntriesRefs {
    final manager = $$TimeEntriesTableTableManager(
      $_db,
      $_db.timeEntries,
    ).filter((f) => f.clientId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_timeEntriesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$ClientsTableFilterComposer
    extends Composer<_$AppDatabase, $ClientsTable> {
  $$ClientsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get contactName => $composableBuilder(
    column: $table.contactName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get vatId => $composableBuilder(
    column: $table.vatId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get addressLine1 => $composableBuilder(
    column: $table.addressLine1,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get addressLine2 => $composableBuilder(
    column: $table.addressLine2,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get postalCode => $composableBuilder(
    column: $table.postalCode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get city => $composableBuilder(
    column: $table.city,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get country => $composableBuilder(
    column: $table.country,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get defaultCurrency => $composableBuilder(
    column: $table.defaultCurrency,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get language => $composableBuilder(
    column: $table.language,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get defaultVatTreatment => $composableBuilder(
    column: $table.defaultVatTreatment,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get defaultHourlyRate => $composableBuilder(
    column: $table.defaultHourlyRate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get paymentTermDays => $composableBuilder(
    column: $table.paymentTermDays,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get archived => $composableBuilder(
    column: $table.archived,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> projectsRefs(
    Expression<bool> Function($$ProjectsTableFilterComposer f) f,
  ) {
    final $$ProjectsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.projects,
      getReferencedColumn: (t) => t.clientId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProjectsTableFilterComposer(
            $db: $db,
            $table: $db.projects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> invoicesRefs(
    Expression<bool> Function($$InvoicesTableFilterComposer f) f,
  ) {
    final $$InvoicesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.invoices,
      getReferencedColumn: (t) => t.clientId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InvoicesTableFilterComposer(
            $db: $db,
            $table: $db.invoices,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> timeEntriesRefs(
    Expression<bool> Function($$TimeEntriesTableFilterComposer f) f,
  ) {
    final $$TimeEntriesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.timeEntries,
      getReferencedColumn: (t) => t.clientId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TimeEntriesTableFilterComposer(
            $db: $db,
            $table: $db.timeEntries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ClientsTableOrderingComposer
    extends Composer<_$AppDatabase, $ClientsTable> {
  $$ClientsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get contactName => $composableBuilder(
    column: $table.contactName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get vatId => $composableBuilder(
    column: $table.vatId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get addressLine1 => $composableBuilder(
    column: $table.addressLine1,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get addressLine2 => $composableBuilder(
    column: $table.addressLine2,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get postalCode => $composableBuilder(
    column: $table.postalCode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get city => $composableBuilder(
    column: $table.city,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get country => $composableBuilder(
    column: $table.country,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get defaultCurrency => $composableBuilder(
    column: $table.defaultCurrency,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get language => $composableBuilder(
    column: $table.language,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get defaultVatTreatment => $composableBuilder(
    column: $table.defaultVatTreatment,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get defaultHourlyRate => $composableBuilder(
    column: $table.defaultHourlyRate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get paymentTermDays => $composableBuilder(
    column: $table.paymentTermDays,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get archived => $composableBuilder(
    column: $table.archived,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ClientsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ClientsTable> {
  $$ClientsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get contactName => $composableBuilder(
    column: $table.contactName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get vatId =>
      $composableBuilder(column: $table.vatId, builder: (column) => column);

  GeneratedColumn<String> get addressLine1 => $composableBuilder(
    column: $table.addressLine1,
    builder: (column) => column,
  );

  GeneratedColumn<String> get addressLine2 => $composableBuilder(
    column: $table.addressLine2,
    builder: (column) => column,
  );

  GeneratedColumn<String> get postalCode => $composableBuilder(
    column: $table.postalCode,
    builder: (column) => column,
  );

  GeneratedColumn<String> get city =>
      $composableBuilder(column: $table.city, builder: (column) => column);

  GeneratedColumn<String> get country =>
      $composableBuilder(column: $table.country, builder: (column) => column);

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<String> get defaultCurrency => $composableBuilder(
    column: $table.defaultCurrency,
    builder: (column) => column,
  );

  GeneratedColumn<String> get language =>
      $composableBuilder(column: $table.language, builder: (column) => column);

  GeneratedColumn<String> get defaultVatTreatment => $composableBuilder(
    column: $table.defaultVatTreatment,
    builder: (column) => column,
  );

  GeneratedColumn<double> get defaultHourlyRate => $composableBuilder(
    column: $table.defaultHourlyRate,
    builder: (column) => column,
  );

  GeneratedColumn<int> get paymentTermDays => $composableBuilder(
    column: $table.paymentTermDays,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<bool> get archived =>
      $composableBuilder(column: $table.archived, builder: (column) => column);

  Expression<T> projectsRefs<T extends Object>(
    Expression<T> Function($$ProjectsTableAnnotationComposer a) f,
  ) {
    final $$ProjectsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.projects,
      getReferencedColumn: (t) => t.clientId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProjectsTableAnnotationComposer(
            $db: $db,
            $table: $db.projects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> invoicesRefs<T extends Object>(
    Expression<T> Function($$InvoicesTableAnnotationComposer a) f,
  ) {
    final $$InvoicesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.invoices,
      getReferencedColumn: (t) => t.clientId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InvoicesTableAnnotationComposer(
            $db: $db,
            $table: $db.invoices,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> timeEntriesRefs<T extends Object>(
    Expression<T> Function($$TimeEntriesTableAnnotationComposer a) f,
  ) {
    final $$TimeEntriesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.timeEntries,
      getReferencedColumn: (t) => t.clientId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TimeEntriesTableAnnotationComposer(
            $db: $db,
            $table: $db.timeEntries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ClientsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ClientsTable,
          Client,
          $$ClientsTableFilterComposer,
          $$ClientsTableOrderingComposer,
          $$ClientsTableAnnotationComposer,
          $$ClientsTableCreateCompanionBuilder,
          $$ClientsTableUpdateCompanionBuilder,
          (Client, $$ClientsTableReferences),
          Client,
          PrefetchHooks Function({
            bool projectsRefs,
            bool invoicesRefs,
            bool timeEntriesRefs,
          })
        > {
  $$ClientsTableTableManager(_$AppDatabase db, $ClientsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ClientsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ClientsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ClientsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> contactName = const Value.absent(),
                Value<String> vatId = const Value.absent(),
                Value<String> addressLine1 = const Value.absent(),
                Value<String> addressLine2 = const Value.absent(),
                Value<String> postalCode = const Value.absent(),
                Value<String> city = const Value.absent(),
                Value<String> country = const Value.absent(),
                Value<String> email = const Value.absent(),
                Value<String> defaultCurrency = const Value.absent(),
                Value<String> language = const Value.absent(),
                Value<String> defaultVatTreatment = const Value.absent(),
                Value<double?> defaultHourlyRate = const Value.absent(),
                Value<int> paymentTermDays = const Value.absent(),
                Value<String> notes = const Value.absent(),
                Value<bool> archived = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ClientsCompanion(
                id: id,
                name: name,
                contactName: contactName,
                vatId: vatId,
                addressLine1: addressLine1,
                addressLine2: addressLine2,
                postalCode: postalCode,
                city: city,
                country: country,
                email: email,
                defaultCurrency: defaultCurrency,
                language: language,
                defaultVatTreatment: defaultVatTreatment,
                defaultHourlyRate: defaultHourlyRate,
                paymentTermDays: paymentTermDays,
                notes: notes,
                archived: archived,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                Value<String> contactName = const Value.absent(),
                Value<String> vatId = const Value.absent(),
                Value<String> addressLine1 = const Value.absent(),
                Value<String> addressLine2 = const Value.absent(),
                Value<String> postalCode = const Value.absent(),
                Value<String> city = const Value.absent(),
                Value<String> country = const Value.absent(),
                Value<String> email = const Value.absent(),
                Value<String> defaultCurrency = const Value.absent(),
                Value<String> language = const Value.absent(),
                Value<String> defaultVatTreatment = const Value.absent(),
                Value<double?> defaultHourlyRate = const Value.absent(),
                Value<int> paymentTermDays = const Value.absent(),
                Value<String> notes = const Value.absent(),
                Value<bool> archived = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ClientsCompanion.insert(
                id: id,
                name: name,
                contactName: contactName,
                vatId: vatId,
                addressLine1: addressLine1,
                addressLine2: addressLine2,
                postalCode: postalCode,
                city: city,
                country: country,
                email: email,
                defaultCurrency: defaultCurrency,
                language: language,
                defaultVatTreatment: defaultVatTreatment,
                defaultHourlyRate: defaultHourlyRate,
                paymentTermDays: paymentTermDays,
                notes: notes,
                archived: archived,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ClientsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                projectsRefs = false,
                invoicesRefs = false,
                timeEntriesRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (projectsRefs) db.projects,
                    if (invoicesRefs) db.invoices,
                    if (timeEntriesRefs) db.timeEntries,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (projectsRefs)
                        await $_getPrefetchedData<
                          Client,
                          $ClientsTable,
                          Project
                        >(
                          currentTable: table,
                          referencedTable: $$ClientsTableReferences
                              ._projectsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ClientsTableReferences(
                                db,
                                table,
                                p0,
                              ).projectsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.clientId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (invoicesRefs)
                        await $_getPrefetchedData<
                          Client,
                          $ClientsTable,
                          Invoice
                        >(
                          currentTable: table,
                          referencedTable: $$ClientsTableReferences
                              ._invoicesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ClientsTableReferences(
                                db,
                                table,
                                p0,
                              ).invoicesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.clientId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (timeEntriesRefs)
                        await $_getPrefetchedData<
                          Client,
                          $ClientsTable,
                          TimeEntry
                        >(
                          currentTable: table,
                          referencedTable: $$ClientsTableReferences
                              ._timeEntriesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ClientsTableReferences(
                                db,
                                table,
                                p0,
                              ).timeEntriesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.clientId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$ClientsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ClientsTable,
      Client,
      $$ClientsTableFilterComposer,
      $$ClientsTableOrderingComposer,
      $$ClientsTableAnnotationComposer,
      $$ClientsTableCreateCompanionBuilder,
      $$ClientsTableUpdateCompanionBuilder,
      (Client, $$ClientsTableReferences),
      Client,
      PrefetchHooks Function({
        bool projectsRefs,
        bool invoicesRefs,
        bool timeEntriesRefs,
      })
    >;
typedef $$ProjectsTableCreateCompanionBuilder =
    ProjectsCompanion Function({
      required String id,
      required String clientId,
      required String name,
      Value<double?> hourlyRate,
      Value<String?> currency,
      Value<bool> active,
      Value<int> rowid,
    });
typedef $$ProjectsTableUpdateCompanionBuilder =
    ProjectsCompanion Function({
      Value<String> id,
      Value<String> clientId,
      Value<String> name,
      Value<double?> hourlyRate,
      Value<String?> currency,
      Value<bool> active,
      Value<int> rowid,
    });

final class $$ProjectsTableReferences
    extends BaseReferences<_$AppDatabase, $ProjectsTable, Project> {
  $$ProjectsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ClientsTable _clientIdTable(_$AppDatabase db) =>
      db.clients.createAlias('projects__client_id__clients__id');

  $$ClientsTableProcessedTableManager get clientId {
    final $_column = $_itemColumn<String>('client_id')!;

    final manager = $$ClientsTableTableManager(
      $_db,
      $_db.clients,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_clientIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$TimeEntriesTable, List<TimeEntry>>
  _timeEntriesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.timeEntries,
    aliasName: 'projects__id__time_entries__project_id',
  );

  $$TimeEntriesTableProcessedTableManager get timeEntriesRefs {
    final manager = $$TimeEntriesTableTableManager(
      $_db,
      $_db.timeEntries,
    ).filter((f) => f.projectId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_timeEntriesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$ProjectsTableFilterComposer
    extends Composer<_$AppDatabase, $ProjectsTable> {
  $$ProjectsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get hourlyRate => $composableBuilder(
    column: $table.hourlyRate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get currency => $composableBuilder(
    column: $table.currency,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get active => $composableBuilder(
    column: $table.active,
    builder: (column) => ColumnFilters(column),
  );

  $$ClientsTableFilterComposer get clientId {
    final $$ClientsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.clientId,
      referencedTable: $db.clients,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ClientsTableFilterComposer(
            $db: $db,
            $table: $db.clients,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> timeEntriesRefs(
    Expression<bool> Function($$TimeEntriesTableFilterComposer f) f,
  ) {
    final $$TimeEntriesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.timeEntries,
      getReferencedColumn: (t) => t.projectId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TimeEntriesTableFilterComposer(
            $db: $db,
            $table: $db.timeEntries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ProjectsTableOrderingComposer
    extends Composer<_$AppDatabase, $ProjectsTable> {
  $$ProjectsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get hourlyRate => $composableBuilder(
    column: $table.hourlyRate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get currency => $composableBuilder(
    column: $table.currency,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get active => $composableBuilder(
    column: $table.active,
    builder: (column) => ColumnOrderings(column),
  );

  $$ClientsTableOrderingComposer get clientId {
    final $$ClientsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.clientId,
      referencedTable: $db.clients,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ClientsTableOrderingComposer(
            $db: $db,
            $table: $db.clients,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ProjectsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ProjectsTable> {
  $$ProjectsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<double> get hourlyRate => $composableBuilder(
    column: $table.hourlyRate,
    builder: (column) => column,
  );

  GeneratedColumn<String> get currency =>
      $composableBuilder(column: $table.currency, builder: (column) => column);

  GeneratedColumn<bool> get active =>
      $composableBuilder(column: $table.active, builder: (column) => column);

  $$ClientsTableAnnotationComposer get clientId {
    final $$ClientsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.clientId,
      referencedTable: $db.clients,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ClientsTableAnnotationComposer(
            $db: $db,
            $table: $db.clients,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> timeEntriesRefs<T extends Object>(
    Expression<T> Function($$TimeEntriesTableAnnotationComposer a) f,
  ) {
    final $$TimeEntriesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.timeEntries,
      getReferencedColumn: (t) => t.projectId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TimeEntriesTableAnnotationComposer(
            $db: $db,
            $table: $db.timeEntries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ProjectsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ProjectsTable,
          Project,
          $$ProjectsTableFilterComposer,
          $$ProjectsTableOrderingComposer,
          $$ProjectsTableAnnotationComposer,
          $$ProjectsTableCreateCompanionBuilder,
          $$ProjectsTableUpdateCompanionBuilder,
          (Project, $$ProjectsTableReferences),
          Project,
          PrefetchHooks Function({bool clientId, bool timeEntriesRefs})
        > {
  $$ProjectsTableTableManager(_$AppDatabase db, $ProjectsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ProjectsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ProjectsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ProjectsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> clientId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<double?> hourlyRate = const Value.absent(),
                Value<String?> currency = const Value.absent(),
                Value<bool> active = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ProjectsCompanion(
                id: id,
                clientId: clientId,
                name: name,
                hourlyRate: hourlyRate,
                currency: currency,
                active: active,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String clientId,
                required String name,
                Value<double?> hourlyRate = const Value.absent(),
                Value<String?> currency = const Value.absent(),
                Value<bool> active = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ProjectsCompanion.insert(
                id: id,
                clientId: clientId,
                name: name,
                hourlyRate: hourlyRate,
                currency: currency,
                active: active,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ProjectsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({clientId = false, timeEntriesRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (timeEntriesRefs) db.timeEntries],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (clientId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.clientId,
                                referencedTable: $$ProjectsTableReferences
                                    ._clientIdTable(db),
                                referencedColumn: $$ProjectsTableReferences
                                    ._clientIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (timeEntriesRefs)
                    await $_getPrefetchedData<
                      Project,
                      $ProjectsTable,
                      TimeEntry
                    >(
                      currentTable: table,
                      referencedTable: $$ProjectsTableReferences
                          ._timeEntriesRefsTable(db),
                      managerFromTypedResult: (p0) => $$ProjectsTableReferences(
                        db,
                        table,
                        p0,
                      ).timeEntriesRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.projectId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$ProjectsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ProjectsTable,
      Project,
      $$ProjectsTableFilterComposer,
      $$ProjectsTableOrderingComposer,
      $$ProjectsTableAnnotationComposer,
      $$ProjectsTableCreateCompanionBuilder,
      $$ProjectsTableUpdateCompanionBuilder,
      (Project, $$ProjectsTableReferences),
      Project,
      PrefetchHooks Function({bool clientId, bool timeEntriesRefs})
    >;
typedef $$InvoicesTableCreateCompanionBuilder =
    InvoicesCompanion Function({
      required String id,
      required String number,
      required String clientId,
      required DateTime issueDate,
      required DateTime dueDate,
      Value<String> currency,
      Value<String> language,
      Value<String> status,
      Value<String> purchaseOrder,
      Value<String> notes,
      Value<int> subtotalMinor,
      Value<int> taxMinor,
      Value<int> totalMinor,
      Value<DateTime?> paidDate,
      required DateTime createdAt,
      Value<int> rowid,
    });
typedef $$InvoicesTableUpdateCompanionBuilder =
    InvoicesCompanion Function({
      Value<String> id,
      Value<String> number,
      Value<String> clientId,
      Value<DateTime> issueDate,
      Value<DateTime> dueDate,
      Value<String> currency,
      Value<String> language,
      Value<String> status,
      Value<String> purchaseOrder,
      Value<String> notes,
      Value<int> subtotalMinor,
      Value<int> taxMinor,
      Value<int> totalMinor,
      Value<DateTime?> paidDate,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

final class $$InvoicesTableReferences
    extends BaseReferences<_$AppDatabase, $InvoicesTable, Invoice> {
  $$InvoicesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ClientsTable _clientIdTable(_$AppDatabase db) =>
      db.clients.createAlias('invoices__client_id__clients__id');

  $$ClientsTableProcessedTableManager get clientId {
    final $_column = $_itemColumn<String>('client_id')!;

    final manager = $$ClientsTableTableManager(
      $_db,
      $_db.clients,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_clientIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$TimeEntriesTable, List<TimeEntry>>
  _timeEntriesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.timeEntries,
    aliasName: 'invoices__id__time_entries__invoice_id',
  );

  $$TimeEntriesTableProcessedTableManager get timeEntriesRefs {
    final manager = $$TimeEntriesTableTableManager(
      $_db,
      $_db.timeEntries,
    ).filter((f) => f.invoiceId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_timeEntriesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$InvoiceLinesTable, List<InvoiceLine>>
  _invoiceLinesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.invoiceLines,
    aliasName: 'invoices__id__invoice_lines__invoice_id',
  );

  $$InvoiceLinesTableProcessedTableManager get invoiceLinesRefs {
    final manager = $$InvoiceLinesTableTableManager(
      $_db,
      $_db.invoiceLines,
    ).filter((f) => f.invoiceId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_invoiceLinesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$InvoicesTableFilterComposer
    extends Composer<_$AppDatabase, $InvoicesTable> {
  $$InvoicesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get number => $composableBuilder(
    column: $table.number,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get issueDate => $composableBuilder(
    column: $table.issueDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get dueDate => $composableBuilder(
    column: $table.dueDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get currency => $composableBuilder(
    column: $table.currency,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get language => $composableBuilder(
    column: $table.language,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get purchaseOrder => $composableBuilder(
    column: $table.purchaseOrder,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get subtotalMinor => $composableBuilder(
    column: $table.subtotalMinor,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get taxMinor => $composableBuilder(
    column: $table.taxMinor,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get totalMinor => $composableBuilder(
    column: $table.totalMinor,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get paidDate => $composableBuilder(
    column: $table.paidDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$ClientsTableFilterComposer get clientId {
    final $$ClientsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.clientId,
      referencedTable: $db.clients,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ClientsTableFilterComposer(
            $db: $db,
            $table: $db.clients,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> timeEntriesRefs(
    Expression<bool> Function($$TimeEntriesTableFilterComposer f) f,
  ) {
    final $$TimeEntriesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.timeEntries,
      getReferencedColumn: (t) => t.invoiceId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TimeEntriesTableFilterComposer(
            $db: $db,
            $table: $db.timeEntries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> invoiceLinesRefs(
    Expression<bool> Function($$InvoiceLinesTableFilterComposer f) f,
  ) {
    final $$InvoiceLinesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.invoiceLines,
      getReferencedColumn: (t) => t.invoiceId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InvoiceLinesTableFilterComposer(
            $db: $db,
            $table: $db.invoiceLines,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$InvoicesTableOrderingComposer
    extends Composer<_$AppDatabase, $InvoicesTable> {
  $$InvoicesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get number => $composableBuilder(
    column: $table.number,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get issueDate => $composableBuilder(
    column: $table.issueDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get dueDate => $composableBuilder(
    column: $table.dueDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get currency => $composableBuilder(
    column: $table.currency,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get language => $composableBuilder(
    column: $table.language,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get purchaseOrder => $composableBuilder(
    column: $table.purchaseOrder,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get subtotalMinor => $composableBuilder(
    column: $table.subtotalMinor,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get taxMinor => $composableBuilder(
    column: $table.taxMinor,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get totalMinor => $composableBuilder(
    column: $table.totalMinor,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get paidDate => $composableBuilder(
    column: $table.paidDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$ClientsTableOrderingComposer get clientId {
    final $$ClientsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.clientId,
      referencedTable: $db.clients,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ClientsTableOrderingComposer(
            $db: $db,
            $table: $db.clients,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$InvoicesTableAnnotationComposer
    extends Composer<_$AppDatabase, $InvoicesTable> {
  $$InvoicesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get number =>
      $composableBuilder(column: $table.number, builder: (column) => column);

  GeneratedColumn<DateTime> get issueDate =>
      $composableBuilder(column: $table.issueDate, builder: (column) => column);

  GeneratedColumn<DateTime> get dueDate =>
      $composableBuilder(column: $table.dueDate, builder: (column) => column);

  GeneratedColumn<String> get currency =>
      $composableBuilder(column: $table.currency, builder: (column) => column);

  GeneratedColumn<String> get language =>
      $composableBuilder(column: $table.language, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get purchaseOrder => $composableBuilder(
    column: $table.purchaseOrder,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<int> get subtotalMinor => $composableBuilder(
    column: $table.subtotalMinor,
    builder: (column) => column,
  );

  GeneratedColumn<int> get taxMinor =>
      $composableBuilder(column: $table.taxMinor, builder: (column) => column);

  GeneratedColumn<int> get totalMinor => $composableBuilder(
    column: $table.totalMinor,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get paidDate =>
      $composableBuilder(column: $table.paidDate, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$ClientsTableAnnotationComposer get clientId {
    final $$ClientsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.clientId,
      referencedTable: $db.clients,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ClientsTableAnnotationComposer(
            $db: $db,
            $table: $db.clients,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> timeEntriesRefs<T extends Object>(
    Expression<T> Function($$TimeEntriesTableAnnotationComposer a) f,
  ) {
    final $$TimeEntriesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.timeEntries,
      getReferencedColumn: (t) => t.invoiceId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TimeEntriesTableAnnotationComposer(
            $db: $db,
            $table: $db.timeEntries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> invoiceLinesRefs<T extends Object>(
    Expression<T> Function($$InvoiceLinesTableAnnotationComposer a) f,
  ) {
    final $$InvoiceLinesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.invoiceLines,
      getReferencedColumn: (t) => t.invoiceId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InvoiceLinesTableAnnotationComposer(
            $db: $db,
            $table: $db.invoiceLines,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$InvoicesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $InvoicesTable,
          Invoice,
          $$InvoicesTableFilterComposer,
          $$InvoicesTableOrderingComposer,
          $$InvoicesTableAnnotationComposer,
          $$InvoicesTableCreateCompanionBuilder,
          $$InvoicesTableUpdateCompanionBuilder,
          (Invoice, $$InvoicesTableReferences),
          Invoice,
          PrefetchHooks Function({
            bool clientId,
            bool timeEntriesRefs,
            bool invoiceLinesRefs,
          })
        > {
  $$InvoicesTableTableManager(_$AppDatabase db, $InvoicesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$InvoicesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$InvoicesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$InvoicesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> number = const Value.absent(),
                Value<String> clientId = const Value.absent(),
                Value<DateTime> issueDate = const Value.absent(),
                Value<DateTime> dueDate = const Value.absent(),
                Value<String> currency = const Value.absent(),
                Value<String> language = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String> purchaseOrder = const Value.absent(),
                Value<String> notes = const Value.absent(),
                Value<int> subtotalMinor = const Value.absent(),
                Value<int> taxMinor = const Value.absent(),
                Value<int> totalMinor = const Value.absent(),
                Value<DateTime?> paidDate = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => InvoicesCompanion(
                id: id,
                number: number,
                clientId: clientId,
                issueDate: issueDate,
                dueDate: dueDate,
                currency: currency,
                language: language,
                status: status,
                purchaseOrder: purchaseOrder,
                notes: notes,
                subtotalMinor: subtotalMinor,
                taxMinor: taxMinor,
                totalMinor: totalMinor,
                paidDate: paidDate,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String number,
                required String clientId,
                required DateTime issueDate,
                required DateTime dueDate,
                Value<String> currency = const Value.absent(),
                Value<String> language = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String> purchaseOrder = const Value.absent(),
                Value<String> notes = const Value.absent(),
                Value<int> subtotalMinor = const Value.absent(),
                Value<int> taxMinor = const Value.absent(),
                Value<int> totalMinor = const Value.absent(),
                Value<DateTime?> paidDate = const Value.absent(),
                required DateTime createdAt,
                Value<int> rowid = const Value.absent(),
              }) => InvoicesCompanion.insert(
                id: id,
                number: number,
                clientId: clientId,
                issueDate: issueDate,
                dueDate: dueDate,
                currency: currency,
                language: language,
                status: status,
                purchaseOrder: purchaseOrder,
                notes: notes,
                subtotalMinor: subtotalMinor,
                taxMinor: taxMinor,
                totalMinor: totalMinor,
                paidDate: paidDate,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$InvoicesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                clientId = false,
                timeEntriesRefs = false,
                invoiceLinesRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (timeEntriesRefs) db.timeEntries,
                    if (invoiceLinesRefs) db.invoiceLines,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (clientId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.clientId,
                                    referencedTable: $$InvoicesTableReferences
                                        ._clientIdTable(db),
                                    referencedColumn: $$InvoicesTableReferences
                                        ._clientIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (timeEntriesRefs)
                        await $_getPrefetchedData<
                          Invoice,
                          $InvoicesTable,
                          TimeEntry
                        >(
                          currentTable: table,
                          referencedTable: $$InvoicesTableReferences
                              ._timeEntriesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$InvoicesTableReferences(
                                db,
                                table,
                                p0,
                              ).timeEntriesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.invoiceId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (invoiceLinesRefs)
                        await $_getPrefetchedData<
                          Invoice,
                          $InvoicesTable,
                          InvoiceLine
                        >(
                          currentTable: table,
                          referencedTable: $$InvoicesTableReferences
                              ._invoiceLinesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$InvoicesTableReferences(
                                db,
                                table,
                                p0,
                              ).invoiceLinesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.invoiceId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$InvoicesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $InvoicesTable,
      Invoice,
      $$InvoicesTableFilterComposer,
      $$InvoicesTableOrderingComposer,
      $$InvoicesTableAnnotationComposer,
      $$InvoicesTableCreateCompanionBuilder,
      $$InvoicesTableUpdateCompanionBuilder,
      (Invoice, $$InvoicesTableReferences),
      Invoice,
      PrefetchHooks Function({
        bool clientId,
        bool timeEntriesRefs,
        bool invoiceLinesRefs,
      })
    >;
typedef $$TimeEntriesTableCreateCompanionBuilder =
    TimeEntriesCompanion Function({
      required String id,
      required String clientId,
      Value<String?> projectId,
      required DateTime date,
      required int minutes,
      Value<String> description,
      Value<bool> billable,
      Value<String> rounding,
      Value<String?> invoiceId,
      Value<int> rowid,
    });
typedef $$TimeEntriesTableUpdateCompanionBuilder =
    TimeEntriesCompanion Function({
      Value<String> id,
      Value<String> clientId,
      Value<String?> projectId,
      Value<DateTime> date,
      Value<int> minutes,
      Value<String> description,
      Value<bool> billable,
      Value<String> rounding,
      Value<String?> invoiceId,
      Value<int> rowid,
    });

final class $$TimeEntriesTableReferences
    extends BaseReferences<_$AppDatabase, $TimeEntriesTable, TimeEntry> {
  $$TimeEntriesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ClientsTable _clientIdTable(_$AppDatabase db) =>
      db.clients.createAlias('time_entries__client_id__clients__id');

  $$ClientsTableProcessedTableManager get clientId {
    final $_column = $_itemColumn<String>('client_id')!;

    final manager = $$ClientsTableTableManager(
      $_db,
      $_db.clients,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_clientIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $ProjectsTable _projectIdTable(_$AppDatabase db) =>
      db.projects.createAlias('time_entries__project_id__projects__id');

  $$ProjectsTableProcessedTableManager? get projectId {
    final $_column = $_itemColumn<String>('project_id');
    if ($_column == null) return null;
    final manager = $$ProjectsTableTableManager(
      $_db,
      $_db.projects,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_projectIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $InvoicesTable _invoiceIdTable(_$AppDatabase db) =>
      db.invoices.createAlias('time_entries__invoice_id__invoices__id');

  $$InvoicesTableProcessedTableManager? get invoiceId {
    final $_column = $_itemColumn<String>('invoice_id');
    if ($_column == null) return null;
    final manager = $$InvoicesTableTableManager(
      $_db,
      $_db.invoices,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_invoiceIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$TimeEntriesTableFilterComposer
    extends Composer<_$AppDatabase, $TimeEntriesTable> {
  $$TimeEntriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get minutes => $composableBuilder(
    column: $table.minutes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get billable => $composableBuilder(
    column: $table.billable,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get rounding => $composableBuilder(
    column: $table.rounding,
    builder: (column) => ColumnFilters(column),
  );

  $$ClientsTableFilterComposer get clientId {
    final $$ClientsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.clientId,
      referencedTable: $db.clients,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ClientsTableFilterComposer(
            $db: $db,
            $table: $db.clients,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ProjectsTableFilterComposer get projectId {
    final $$ProjectsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.projectId,
      referencedTable: $db.projects,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProjectsTableFilterComposer(
            $db: $db,
            $table: $db.projects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$InvoicesTableFilterComposer get invoiceId {
    final $$InvoicesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.invoiceId,
      referencedTable: $db.invoices,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InvoicesTableFilterComposer(
            $db: $db,
            $table: $db.invoices,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TimeEntriesTableOrderingComposer
    extends Composer<_$AppDatabase, $TimeEntriesTable> {
  $$TimeEntriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get minutes => $composableBuilder(
    column: $table.minutes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get billable => $composableBuilder(
    column: $table.billable,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get rounding => $composableBuilder(
    column: $table.rounding,
    builder: (column) => ColumnOrderings(column),
  );

  $$ClientsTableOrderingComposer get clientId {
    final $$ClientsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.clientId,
      referencedTable: $db.clients,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ClientsTableOrderingComposer(
            $db: $db,
            $table: $db.clients,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ProjectsTableOrderingComposer get projectId {
    final $$ProjectsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.projectId,
      referencedTable: $db.projects,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProjectsTableOrderingComposer(
            $db: $db,
            $table: $db.projects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$InvoicesTableOrderingComposer get invoiceId {
    final $$InvoicesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.invoiceId,
      referencedTable: $db.invoices,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InvoicesTableOrderingComposer(
            $db: $db,
            $table: $db.invoices,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TimeEntriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $TimeEntriesTable> {
  $$TimeEntriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<int> get minutes =>
      $composableBuilder(column: $table.minutes, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get billable =>
      $composableBuilder(column: $table.billable, builder: (column) => column);

  GeneratedColumn<String> get rounding =>
      $composableBuilder(column: $table.rounding, builder: (column) => column);

  $$ClientsTableAnnotationComposer get clientId {
    final $$ClientsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.clientId,
      referencedTable: $db.clients,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ClientsTableAnnotationComposer(
            $db: $db,
            $table: $db.clients,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ProjectsTableAnnotationComposer get projectId {
    final $$ProjectsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.projectId,
      referencedTable: $db.projects,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProjectsTableAnnotationComposer(
            $db: $db,
            $table: $db.projects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$InvoicesTableAnnotationComposer get invoiceId {
    final $$InvoicesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.invoiceId,
      referencedTable: $db.invoices,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InvoicesTableAnnotationComposer(
            $db: $db,
            $table: $db.invoices,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TimeEntriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TimeEntriesTable,
          TimeEntry,
          $$TimeEntriesTableFilterComposer,
          $$TimeEntriesTableOrderingComposer,
          $$TimeEntriesTableAnnotationComposer,
          $$TimeEntriesTableCreateCompanionBuilder,
          $$TimeEntriesTableUpdateCompanionBuilder,
          (TimeEntry, $$TimeEntriesTableReferences),
          TimeEntry,
          PrefetchHooks Function({
            bool clientId,
            bool projectId,
            bool invoiceId,
          })
        > {
  $$TimeEntriesTableTableManager(_$AppDatabase db, $TimeEntriesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TimeEntriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TimeEntriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TimeEntriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> clientId = const Value.absent(),
                Value<String?> projectId = const Value.absent(),
                Value<DateTime> date = const Value.absent(),
                Value<int> minutes = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<bool> billable = const Value.absent(),
                Value<String> rounding = const Value.absent(),
                Value<String?> invoiceId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TimeEntriesCompanion(
                id: id,
                clientId: clientId,
                projectId: projectId,
                date: date,
                minutes: minutes,
                description: description,
                billable: billable,
                rounding: rounding,
                invoiceId: invoiceId,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String clientId,
                Value<String?> projectId = const Value.absent(),
                required DateTime date,
                required int minutes,
                Value<String> description = const Value.absent(),
                Value<bool> billable = const Value.absent(),
                Value<String> rounding = const Value.absent(),
                Value<String?> invoiceId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TimeEntriesCompanion.insert(
                id: id,
                clientId: clientId,
                projectId: projectId,
                date: date,
                minutes: minutes,
                description: description,
                billable: billable,
                rounding: rounding,
                invoiceId: invoiceId,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$TimeEntriesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({clientId = false, projectId = false, invoiceId = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (clientId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.clientId,
                                    referencedTable:
                                        $$TimeEntriesTableReferences
                                            ._clientIdTable(db),
                                    referencedColumn:
                                        $$TimeEntriesTableReferences
                                            ._clientIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (projectId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.projectId,
                                    referencedTable:
                                        $$TimeEntriesTableReferences
                                            ._projectIdTable(db),
                                    referencedColumn:
                                        $$TimeEntriesTableReferences
                                            ._projectIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (invoiceId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.invoiceId,
                                    referencedTable:
                                        $$TimeEntriesTableReferences
                                            ._invoiceIdTable(db),
                                    referencedColumn:
                                        $$TimeEntriesTableReferences
                                            ._invoiceIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [];
                  },
                );
              },
        ),
      );
}

typedef $$TimeEntriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TimeEntriesTable,
      TimeEntry,
      $$TimeEntriesTableFilterComposer,
      $$TimeEntriesTableOrderingComposer,
      $$TimeEntriesTableAnnotationComposer,
      $$TimeEntriesTableCreateCompanionBuilder,
      $$TimeEntriesTableUpdateCompanionBuilder,
      (TimeEntry, $$TimeEntriesTableReferences),
      TimeEntry,
      PrefetchHooks Function({bool clientId, bool projectId, bool invoiceId})
    >;
typedef $$ExpensesTableCreateCompanionBuilder =
    ExpensesCompanion Function({
      required String id,
      required DateTime date,
      Value<String> category,
      Value<String> description,
      required int amountMinor,
      Value<int> vatMinor,
      Value<String> currency,
      Value<bool> deductible,
      Value<int> businessUsePercent,
      Value<String?> receiptPath,
      Value<Uint8List?> receiptImage,
      Value<String?> receiptMime,
      Value<int> rowid,
    });
typedef $$ExpensesTableUpdateCompanionBuilder =
    ExpensesCompanion Function({
      Value<String> id,
      Value<DateTime> date,
      Value<String> category,
      Value<String> description,
      Value<int> amountMinor,
      Value<int> vatMinor,
      Value<String> currency,
      Value<bool> deductible,
      Value<int> businessUsePercent,
      Value<String?> receiptPath,
      Value<Uint8List?> receiptImage,
      Value<String?> receiptMime,
      Value<int> rowid,
    });

class $$ExpensesTableFilterComposer
    extends Composer<_$AppDatabase, $ExpensesTable> {
  $$ExpensesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get amountMinor => $composableBuilder(
    column: $table.amountMinor,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get vatMinor => $composableBuilder(
    column: $table.vatMinor,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get currency => $composableBuilder(
    column: $table.currency,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get deductible => $composableBuilder(
    column: $table.deductible,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get businessUsePercent => $composableBuilder(
    column: $table.businessUsePercent,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get receiptPath => $composableBuilder(
    column: $table.receiptPath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<Uint8List> get receiptImage => $composableBuilder(
    column: $table.receiptImage,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get receiptMime => $composableBuilder(
    column: $table.receiptMime,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ExpensesTableOrderingComposer
    extends Composer<_$AppDatabase, $ExpensesTable> {
  $$ExpensesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get amountMinor => $composableBuilder(
    column: $table.amountMinor,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get vatMinor => $composableBuilder(
    column: $table.vatMinor,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get currency => $composableBuilder(
    column: $table.currency,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get deductible => $composableBuilder(
    column: $table.deductible,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get businessUsePercent => $composableBuilder(
    column: $table.businessUsePercent,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get receiptPath => $composableBuilder(
    column: $table.receiptPath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<Uint8List> get receiptImage => $composableBuilder(
    column: $table.receiptImage,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get receiptMime => $composableBuilder(
    column: $table.receiptMime,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ExpensesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ExpensesTable> {
  $$ExpensesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<int> get amountMinor => $composableBuilder(
    column: $table.amountMinor,
    builder: (column) => column,
  );

  GeneratedColumn<int> get vatMinor =>
      $composableBuilder(column: $table.vatMinor, builder: (column) => column);

  GeneratedColumn<String> get currency =>
      $composableBuilder(column: $table.currency, builder: (column) => column);

  GeneratedColumn<bool> get deductible => $composableBuilder(
    column: $table.deductible,
    builder: (column) => column,
  );

  GeneratedColumn<int> get businessUsePercent => $composableBuilder(
    column: $table.businessUsePercent,
    builder: (column) => column,
  );

  GeneratedColumn<String> get receiptPath => $composableBuilder(
    column: $table.receiptPath,
    builder: (column) => column,
  );

  GeneratedColumn<Uint8List> get receiptImage => $composableBuilder(
    column: $table.receiptImage,
    builder: (column) => column,
  );

  GeneratedColumn<String> get receiptMime => $composableBuilder(
    column: $table.receiptMime,
    builder: (column) => column,
  );
}

class $$ExpensesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ExpensesTable,
          Expense,
          $$ExpensesTableFilterComposer,
          $$ExpensesTableOrderingComposer,
          $$ExpensesTableAnnotationComposer,
          $$ExpensesTableCreateCompanionBuilder,
          $$ExpensesTableUpdateCompanionBuilder,
          (Expense, BaseReferences<_$AppDatabase, $ExpensesTable, Expense>),
          Expense,
          PrefetchHooks Function()
        > {
  $$ExpensesTableTableManager(_$AppDatabase db, $ExpensesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ExpensesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ExpensesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ExpensesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> date = const Value.absent(),
                Value<String> category = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<int> amountMinor = const Value.absent(),
                Value<int> vatMinor = const Value.absent(),
                Value<String> currency = const Value.absent(),
                Value<bool> deductible = const Value.absent(),
                Value<int> businessUsePercent = const Value.absent(),
                Value<String?> receiptPath = const Value.absent(),
                Value<Uint8List?> receiptImage = const Value.absent(),
                Value<String?> receiptMime = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ExpensesCompanion(
                id: id,
                date: date,
                category: category,
                description: description,
                amountMinor: amountMinor,
                vatMinor: vatMinor,
                currency: currency,
                deductible: deductible,
                businessUsePercent: businessUsePercent,
                receiptPath: receiptPath,
                receiptImage: receiptImage,
                receiptMime: receiptMime,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required DateTime date,
                Value<String> category = const Value.absent(),
                Value<String> description = const Value.absent(),
                required int amountMinor,
                Value<int> vatMinor = const Value.absent(),
                Value<String> currency = const Value.absent(),
                Value<bool> deductible = const Value.absent(),
                Value<int> businessUsePercent = const Value.absent(),
                Value<String?> receiptPath = const Value.absent(),
                Value<Uint8List?> receiptImage = const Value.absent(),
                Value<String?> receiptMime = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ExpensesCompanion.insert(
                id: id,
                date: date,
                category: category,
                description: description,
                amountMinor: amountMinor,
                vatMinor: vatMinor,
                currency: currency,
                deductible: deductible,
                businessUsePercent: businessUsePercent,
                receiptPath: receiptPath,
                receiptImage: receiptImage,
                receiptMime: receiptMime,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ExpensesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ExpensesTable,
      Expense,
      $$ExpensesTableFilterComposer,
      $$ExpensesTableOrderingComposer,
      $$ExpensesTableAnnotationComposer,
      $$ExpensesTableCreateCompanionBuilder,
      $$ExpensesTableUpdateCompanionBuilder,
      (Expense, BaseReferences<_$AppDatabase, $ExpensesTable, Expense>),
      Expense,
      PrefetchHooks Function()
    >;
typedef $$InvoiceLinesTableCreateCompanionBuilder =
    InvoiceLinesCompanion Function({
      required String id,
      required String invoiceId,
      required String description,
      Value<double> quantity,
      Value<String> unit,
      required int unitPriceMinor,
      Value<String> vatTreatment,
      Value<int> sortOrder,
      Value<int> rowid,
    });
typedef $$InvoiceLinesTableUpdateCompanionBuilder =
    InvoiceLinesCompanion Function({
      Value<String> id,
      Value<String> invoiceId,
      Value<String> description,
      Value<double> quantity,
      Value<String> unit,
      Value<int> unitPriceMinor,
      Value<String> vatTreatment,
      Value<int> sortOrder,
      Value<int> rowid,
    });

final class $$InvoiceLinesTableReferences
    extends BaseReferences<_$AppDatabase, $InvoiceLinesTable, InvoiceLine> {
  $$InvoiceLinesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $InvoicesTable _invoiceIdTable(_$AppDatabase db) =>
      db.invoices.createAlias('invoice_lines__invoice_id__invoices__id');

  $$InvoicesTableProcessedTableManager get invoiceId {
    final $_column = $_itemColumn<String>('invoice_id')!;

    final manager = $$InvoicesTableTableManager(
      $_db,
      $_db.invoices,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_invoiceIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$InvoiceLinesTableFilterComposer
    extends Composer<_$AppDatabase, $InvoiceLinesTable> {
  $$InvoiceLinesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get unit => $composableBuilder(
    column: $table.unit,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get unitPriceMinor => $composableBuilder(
    column: $table.unitPriceMinor,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get vatTreatment => $composableBuilder(
    column: $table.vatTreatment,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnFilters(column),
  );

  $$InvoicesTableFilterComposer get invoiceId {
    final $$InvoicesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.invoiceId,
      referencedTable: $db.invoices,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InvoicesTableFilterComposer(
            $db: $db,
            $table: $db.invoices,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$InvoiceLinesTableOrderingComposer
    extends Composer<_$AppDatabase, $InvoiceLinesTable> {
  $$InvoiceLinesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get unit => $composableBuilder(
    column: $table.unit,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get unitPriceMinor => $composableBuilder(
    column: $table.unitPriceMinor,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get vatTreatment => $composableBuilder(
    column: $table.vatTreatment,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnOrderings(column),
  );

  $$InvoicesTableOrderingComposer get invoiceId {
    final $$InvoicesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.invoiceId,
      referencedTable: $db.invoices,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InvoicesTableOrderingComposer(
            $db: $db,
            $table: $db.invoices,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$InvoiceLinesTableAnnotationComposer
    extends Composer<_$AppDatabase, $InvoiceLinesTable> {
  $$InvoiceLinesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<double> get quantity =>
      $composableBuilder(column: $table.quantity, builder: (column) => column);

  GeneratedColumn<String> get unit =>
      $composableBuilder(column: $table.unit, builder: (column) => column);

  GeneratedColumn<int> get unitPriceMinor => $composableBuilder(
    column: $table.unitPriceMinor,
    builder: (column) => column,
  );

  GeneratedColumn<String> get vatTreatment => $composableBuilder(
    column: $table.vatTreatment,
    builder: (column) => column,
  );

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);

  $$InvoicesTableAnnotationComposer get invoiceId {
    final $$InvoicesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.invoiceId,
      referencedTable: $db.invoices,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InvoicesTableAnnotationComposer(
            $db: $db,
            $table: $db.invoices,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$InvoiceLinesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $InvoiceLinesTable,
          InvoiceLine,
          $$InvoiceLinesTableFilterComposer,
          $$InvoiceLinesTableOrderingComposer,
          $$InvoiceLinesTableAnnotationComposer,
          $$InvoiceLinesTableCreateCompanionBuilder,
          $$InvoiceLinesTableUpdateCompanionBuilder,
          (InvoiceLine, $$InvoiceLinesTableReferences),
          InvoiceLine,
          PrefetchHooks Function({bool invoiceId})
        > {
  $$InvoiceLinesTableTableManager(_$AppDatabase db, $InvoiceLinesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$InvoiceLinesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$InvoiceLinesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$InvoiceLinesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> invoiceId = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<double> quantity = const Value.absent(),
                Value<String> unit = const Value.absent(),
                Value<int> unitPriceMinor = const Value.absent(),
                Value<String> vatTreatment = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => InvoiceLinesCompanion(
                id: id,
                invoiceId: invoiceId,
                description: description,
                quantity: quantity,
                unit: unit,
                unitPriceMinor: unitPriceMinor,
                vatTreatment: vatTreatment,
                sortOrder: sortOrder,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String invoiceId,
                required String description,
                Value<double> quantity = const Value.absent(),
                Value<String> unit = const Value.absent(),
                required int unitPriceMinor,
                Value<String> vatTreatment = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => InvoiceLinesCompanion.insert(
                id: id,
                invoiceId: invoiceId,
                description: description,
                quantity: quantity,
                unit: unit,
                unitPriceMinor: unitPriceMinor,
                vatTreatment: vatTreatment,
                sortOrder: sortOrder,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$InvoiceLinesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({invoiceId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (invoiceId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.invoiceId,
                                referencedTable: $$InvoiceLinesTableReferences
                                    ._invoiceIdTable(db),
                                referencedColumn: $$InvoiceLinesTableReferences
                                    ._invoiceIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$InvoiceLinesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $InvoiceLinesTable,
      InvoiceLine,
      $$InvoiceLinesTableFilterComposer,
      $$InvoiceLinesTableOrderingComposer,
      $$InvoiceLinesTableAnnotationComposer,
      $$InvoiceLinesTableCreateCompanionBuilder,
      $$InvoiceLinesTableUpdateCompanionBuilder,
      (InvoiceLine, $$InvoiceLinesTableReferences),
      InvoiceLine,
      PrefetchHooks Function({bool invoiceId})
    >;
typedef $$AssetsTableCreateCompanionBuilder =
    AssetsCompanion Function({
      required String id,
      Value<String> description,
      required DateTime acquisitionDate,
      required int costMinor,
      Value<String> currency,
      Value<String> method,
      Value<int> usefulLifeYears,
      Value<int> businessUsePercent,
      Value<int> rowid,
    });
typedef $$AssetsTableUpdateCompanionBuilder =
    AssetsCompanion Function({
      Value<String> id,
      Value<String> description,
      Value<DateTime> acquisitionDate,
      Value<int> costMinor,
      Value<String> currency,
      Value<String> method,
      Value<int> usefulLifeYears,
      Value<int> businessUsePercent,
      Value<int> rowid,
    });

class $$AssetsTableFilterComposer
    extends Composer<_$AppDatabase, $AssetsTable> {
  $$AssetsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get acquisitionDate => $composableBuilder(
    column: $table.acquisitionDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get costMinor => $composableBuilder(
    column: $table.costMinor,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get currency => $composableBuilder(
    column: $table.currency,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get method => $composableBuilder(
    column: $table.method,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get usefulLifeYears => $composableBuilder(
    column: $table.usefulLifeYears,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get businessUsePercent => $composableBuilder(
    column: $table.businessUsePercent,
    builder: (column) => ColumnFilters(column),
  );
}

class $$AssetsTableOrderingComposer
    extends Composer<_$AppDatabase, $AssetsTable> {
  $$AssetsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get acquisitionDate => $composableBuilder(
    column: $table.acquisitionDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get costMinor => $composableBuilder(
    column: $table.costMinor,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get currency => $composableBuilder(
    column: $table.currency,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get method => $composableBuilder(
    column: $table.method,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get usefulLifeYears => $composableBuilder(
    column: $table.usefulLifeYears,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get businessUsePercent => $composableBuilder(
    column: $table.businessUsePercent,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AssetsTableAnnotationComposer
    extends Composer<_$AppDatabase, $AssetsTable> {
  $$AssetsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get acquisitionDate => $composableBuilder(
    column: $table.acquisitionDate,
    builder: (column) => column,
  );

  GeneratedColumn<int> get costMinor =>
      $composableBuilder(column: $table.costMinor, builder: (column) => column);

  GeneratedColumn<String> get currency =>
      $composableBuilder(column: $table.currency, builder: (column) => column);

  GeneratedColumn<String> get method =>
      $composableBuilder(column: $table.method, builder: (column) => column);

  GeneratedColumn<int> get usefulLifeYears => $composableBuilder(
    column: $table.usefulLifeYears,
    builder: (column) => column,
  );

  GeneratedColumn<int> get businessUsePercent => $composableBuilder(
    column: $table.businessUsePercent,
    builder: (column) => column,
  );
}

class $$AssetsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AssetsTable,
          Asset,
          $$AssetsTableFilterComposer,
          $$AssetsTableOrderingComposer,
          $$AssetsTableAnnotationComposer,
          $$AssetsTableCreateCompanionBuilder,
          $$AssetsTableUpdateCompanionBuilder,
          (Asset, BaseReferences<_$AppDatabase, $AssetsTable, Asset>),
          Asset,
          PrefetchHooks Function()
        > {
  $$AssetsTableTableManager(_$AppDatabase db, $AssetsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AssetsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AssetsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AssetsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<DateTime> acquisitionDate = const Value.absent(),
                Value<int> costMinor = const Value.absent(),
                Value<String> currency = const Value.absent(),
                Value<String> method = const Value.absent(),
                Value<int> usefulLifeYears = const Value.absent(),
                Value<int> businessUsePercent = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AssetsCompanion(
                id: id,
                description: description,
                acquisitionDate: acquisitionDate,
                costMinor: costMinor,
                currency: currency,
                method: method,
                usefulLifeYears: usefulLifeYears,
                businessUsePercent: businessUsePercent,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                Value<String> description = const Value.absent(),
                required DateTime acquisitionDate,
                required int costMinor,
                Value<String> currency = const Value.absent(),
                Value<String> method = const Value.absent(),
                Value<int> usefulLifeYears = const Value.absent(),
                Value<int> businessUsePercent = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AssetsCompanion.insert(
                id: id,
                description: description,
                acquisitionDate: acquisitionDate,
                costMinor: costMinor,
                currency: currency,
                method: method,
                usefulLifeYears: usefulLifeYears,
                businessUsePercent: businessUsePercent,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$AssetsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AssetsTable,
      Asset,
      $$AssetsTableFilterComposer,
      $$AssetsTableOrderingComposer,
      $$AssetsTableAnnotationComposer,
      $$AssetsTableCreateCompanionBuilder,
      $$AssetsTableUpdateCompanionBuilder,
      (Asset, BaseReferences<_$AppDatabase, $AssetsTable, Asset>),
      Asset,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$BusinessProfilesTableTableManager get businessProfiles =>
      $$BusinessProfilesTableTableManager(_db, _db.businessProfiles);
  $$ClientsTableTableManager get clients =>
      $$ClientsTableTableManager(_db, _db.clients);
  $$ProjectsTableTableManager get projects =>
      $$ProjectsTableTableManager(_db, _db.projects);
  $$InvoicesTableTableManager get invoices =>
      $$InvoicesTableTableManager(_db, _db.invoices);
  $$TimeEntriesTableTableManager get timeEntries =>
      $$TimeEntriesTableTableManager(_db, _db.timeEntries);
  $$ExpensesTableTableManager get expenses =>
      $$ExpensesTableTableManager(_db, _db.expenses);
  $$InvoiceLinesTableTableManager get invoiceLines =>
      $$InvoiceLinesTableTableManager(_db, _db.invoiceLines);
  $$AssetsTableTableManager get assets =>
      $$AssetsTableTableManager(_db, _db.assets);
}
