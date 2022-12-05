codeunit 50000 "Correct Dimension Values Cust"
{

    trigger OnRun();
    VAR
        ValueEntry: Record 5802 TEMPORARY;

    begin

        IF ValueEntry.FINDFIRST THEN
            MESSAGE('In Testing %1 ', ValueEntry."Entry No.")
        ELSE
            MESSAGE('not found');
    end;

    procedure ChangeCurrency(Amt: Decimal) AmountText: Text[30]
    var
        I: Integer;
        s: Text;
        j: Integer;
    begin
        AmountText := FORMAT(Amt, 0, '<Precision,0:0><Standard Format,2>');
        FOR I := 1 TO 10 DO BEGIN
            IF STRLEN(AmountText) > (3 * I) THEN BEGIN
                s := INSSTR(AmountText, ',', STRLEN(AmountText) - (3 * I - 1));
                AmountText := s;
            END
            ELSE
                I := 10;

        END;
    end;

    procedure Company(VAR AddrArray: ARRAY[8] OF Text[50]; VAR CompanyInfo: Record "Company Information")
    begin
        FormatAddr(
  AddrArray, CompanyInfo.Name, CompanyInfo."Name 2", '', CompanyInfo.Address, CompanyInfo."Address 2",
  CompanyInfo.City, CompanyInfo."Post Code", CompanyInfo.County, '');
    end;

    procedure FormatAddr(VAR AddrArray: ARRAY[8] OF Text[90]; Name: Text[90]; Name2: Text[90]; Contact: Text[90]; Addr: Text[50]; Addr2: Text[50]; City: Text[50]; PostCode: Code[20]; County: Text[50]; CountryCode: Code[10])
    var
        GLSetup: Record "General Ledger Setup";
        Country: Record "Country/Region";
        InsertText: Integer;
        Index: Integer;
        NameLineNo: Integer;
        Name2LineNo: Integer;
        AddrLineNo: Integer;
        Addr2LineNo: Integer;
        ContLineNo: Integer;
        PostCodeCityLineNo: Integer;
        CountyLineNo: Integer;
        CountryLineNo: Integer;
    begin
        CLEAR(AddrArray);

        IF CountryCode = '' THEN BEGIN
            GLSetup.GET;
            CLEAR(Country);
            Country."Address Format" := GLSetup."Local Address Format";
            Country."Contact Address Format" := GLSetup."Local Cont. Addr. Format";
        END ELSE
            Country.GET(CountryCode);

        CASE Country."Contact Address Format" OF
            Country."Contact Address Format"::First:
                BEGIN
                    NameLineNo := 2;
                    Name2LineNo := 3;
                    ContLineNo := 1;
                    AddrLineNo := 4;
                    Addr2LineNo := 5;
                    PostCodeCityLineNo := 6;
                    CountyLineNo := 7;
                    CountryLineNo := 8;
                END;
            Country."Contact Address Format"::"After Company Name":
                BEGIN
                    NameLineNo := 2;
                    Name2LineNo := 3;
                    ContLineNo := 1;
                    AddrLineNo := 4;
                    Addr2LineNo := 5;
                    PostCodeCityLineNo := 6;
                    CountyLineNo := 7;
                    CountryLineNo := 8;

                    /* NameLineNo := 1;
                                   Name2LineNo := 2;
                                   ContLineNo := 3;
                                   AddrLineNo := 4;
                                   Addr2LineNo := 5;
                                   PostCodeCityLineNo := 6;
                                   CountyLineNo := 7;
                                   CountryLineNo := 8;   */
                END;
            Country."Contact Address Format"::Last:
                BEGIN
                    NameLineNo := 1;
                    Name2LineNo := 2;
                    ContLineNo := 8;
                    AddrLineNo := 3;
                    Addr2LineNo := 4;
                    PostCodeCityLineNo := 5;
                    CountyLineNo := 6;
                    CountryLineNo := 7;
                END;
        END;

        AddrArray[NameLineNo] := Name;
        AddrArray[Name2LineNo] := Name2;
        AddrArray[AddrLineNo] := Addr;
        AddrArray[Addr2LineNo] := Addr2;
        AddrArray[CountyLineNo] := County;
        CASE Country."Address Format" OF
            Country."Address Format"::"Post Code+City",
            Country."Address Format"::"City+County+Post Code",
            Country."Address Format"::"City+Post Code":
                BEGIN
                    AddrArray[ContLineNo] := Contact;
                    GeneratePostCodeCity(AddrArray[PostCodeCityLineNo], AddrArray[CountyLineNo], City, PostCode, County, Country);
                    AddrArray[CountryLineNo] := Country.Name;  //anil comented
                                                               //  AddrArray[CountryLineNo] := "Phone No.";
                    COMPRESSARRAY(AddrArray);
                END;
            Country."Address Format"::"Blank Line+Post Code+City":
                BEGIN
                    IF ContLineNo < PostCodeCityLineNo THEN
                        AddrArray[ContLineNo] := Contact;
                    COMPRESSARRAY(AddrArray);

                    Index := 1;
                    InsertText := 1;
                    REPEAT
                        IF AddrArray[Index] = '' THEN BEGIN
                            CASE InsertText OF
                                2:
                                    GeneratePostCodeCity(AddrArray[Index], AddrArray[Index + 1], City, PostCode, County, Country);
                                3:
                                    AddrArray[Index] := Country.Name;
                                4:
                                    IF ContLineNo > PostCodeCityLineNo THEN
                                        AddrArray[Index] := Contact;
                            END;
                            InsertText := InsertText + 1;
                        END;
                        Index := Index + 1;
                    UNTIL Index = 9;
                END;
        END;
    end;

    procedure GeneratePostCodeCity(VAR PostCodeCityText: Text[90]; VAR CountyText: Text[50]; City: Text[50]; PostCode: Code[20]; County: Text[50]; Country: Record "Country/Region")
    var
        DummyString: Text[100];
        OverMaxStrLen: Integer;
    begin
        DummyString := '';
        OverMaxStrLen := MAXSTRLEN(PostCodeCityText);
        IF OverMaxStrLen < MAXSTRLEN(DummyString) THEN
            OverMaxStrLen += 1;

        CASE Country."Address Format" OF
            Country."Address Format"::"Post Code+City":
                BEGIN
                    IF PostCode <> '' THEN
                        PostCodeCityText := DELSTR(PostCode + ' ' + City, OverMaxStrLen)
                    ELSE
                        PostCodeCityText := City;
                    CountyText := County;
                END;
            Country."Address Format"::"City+County+Post Code":
                BEGIN
                    IF (County <> '') AND (PostCode <> '') THEN
                        PostCodeCityText :=
                          DELSTR(City, MAXSTRLEN(PostCodeCityText) - STRLEN(PostCode) - STRLEN(County) - 3) +
                          ', ' + County + '  ' + PostCode
                    ELSE
                        IF PostCode = '' THEN BEGIN
                            PostCodeCityText := City;
                            CountyText := County;
                        END ELSE
                            IF (County = '') AND (PostCode <> '') THEN
                                PostCodeCityText := DELSTR(City, MAXSTRLEN(PostCodeCityText) - STRLEN(PostCode) - 1) + ', ' + PostCode;
                END;
            Country."Address Format"::"City+Post Code":
                BEGIN
                    IF PostCode <> '' THEN
                        PostCodeCityText := DELSTR(City, MAXSTRLEN(PostCodeCityText) - STRLEN(PostCode) - 1) + ', ' + PostCode
                    ELSE
                        PostCodeCityText := City;
                    CountyText := County;
                END;
            Country."Address Format"::"Blank Line+Post Code+City":
                BEGIN
                    IF PostCode <> '' THEN
                        PostCodeCityText := DELSTR(PostCode + ' ' + City, OverMaxStrLen)
                    ELSE
                        PostCodeCityText := City;
                    CountyText := County;
                END;
        END;

    end;

    procedure PurchHeaderBuyFromtemp(VAR AddrArray: ARRAY[8] OF Text[50]; VAR PurchHeader: Record "Purchase Header")
    begin
        WITH PurchHeader DO
            FormatAddr(
              AddrArray, "Buy-from Vendor Name", "Buy-from Vendor Name 2", '', "Buy-from Address", "Buy-from Address 2",
              "Buy-from City", "Buy-from Post Code", "Buy-from County", "Buy-from Country/Region Code");
    end;

    procedure Location(VAR AddrArray: ARRAY[8] OF Text[50]; VAR LocationLRec: Record 14);
    begin
        WITH LocationLRec DO
            FormatAddr(AddrArray, Name, "Name 2", '', Address, "Address 2", City, "Post Code", County, '');
    end;
}

