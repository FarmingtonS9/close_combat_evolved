package soldier

// Cood feature idea: Have soldiers earn money
// US Mid-Late WW2 Ranks
// [Link](https://veteran-voices.com/wp-content/uploads/2018/11/wwii-us-army-rank-insignia.pdf)
USEnlistedRank :: enum {
    Private,
    PrivateFirstClass,
}

USNCO :: enum {
    Corporal,
    Sergeant,
    StaffSergeant,
    TechnicalSergeant,
    FirstSergeant,
    MasterSergeant,
}

USWarrantOfficers :: enum {
    WarrantOfficer,
    FlightOfficer,
    ChiefWarrantOfficer,
}

USCommissionedOfficers :: enum {
    SecondLieutenant,
    FirstLieutenant,
    Captain,
    Major,
    LieutenantColonel,
    Colonel,
    BrigadierGeneral,
    MajorGeneral,
    LieutenantGeneral,
    General,
    GeneralOfArmy,
}

// Wehrmacht Ranks
// [Link](https://www.wehrmacht.es/en/content/6-rank-wehrmacht)

WehrEnlisted :: enum {
    // Grenadier
    Private,
    // Obergrenadier
    LanceCorporal,
    // Gefreiter
    Corporal,
    // Obergefreiter
    SeniorCorporal,
    // Stabsgefreiter
    AdminCorporal,
    // Stabsgefreiter
    CaboMayor,
}

WehrNCO :: enum {
    // Unteroffizier
    Sergeant,
    // Unterfeldwebel
    StaffSergeant,
    // Feldwebel
    SergeantFirstClass,
    // Oberfeldwebel
    MasterSergeant,
    //Stabsfeldwebel
    SergeantMajor,
}

WehrOfficer :: enum {
    // Leutnant
    SecondLieutenant,
    // Oberleutnant
    FirstLieutenant,
    // Hauptmann
    Captain,
}

WehrFieldOfficer :: enum {
    // Major
    Major,
    // Obersleutnant
    LieutenantColonel,
    // Oberst
    Colonel,
}

WehrGeneral :: enum {
    // Generalmajor
    BrigadierGeneral,
    // Generalleutnant
    MajorGeneral,
    // General
    LieutenantGeneral,
    // Generaloberst
    General,
    //Generalfeldmarshall
    MariscalDeCampo,
}