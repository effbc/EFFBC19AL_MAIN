table 60011 "Competitor's Master"
{
    // version B2B1.0

    LookupPageID = "Competitor's Master";
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Code"; Code[20])
        {
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                if Code <> xRec.Code then begin
                    RMSetup.Get;
                    NoSeriesMgt.TestManual(RMSetup."Product Competetors");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; "Competitor's Name"; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(8; "No. Series"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(51; "Competitor's Name 2"; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(52; "Competitor's Address"; Text[30])
        {
            DataClassification = CustomerContent;
        }
        field(53; "Competitor's Address 2"; Text[30])
        {
            DataClassification = CustomerContent;
        }
        field(54; City; Text[30])
        {
            DataClassification = CustomerContent;

            trigger OnLookup();
            begin
                /*PostCode.LookUpCity(City,"Post Code",TRUE);*///B2B

            end;

            trigger OnValidate();
            begin
                PostCode.ValidateCity(City, "Post Code", County, "Country Code", true);
            end;
        }
        field(55; "Competitor's Contact"; Text[30])
        {
            DataClassification = CustomerContent;
        }
        field(56; "Post Code"; Code[20])
        {
            TableRelation = "Post Code";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
            DataClassification = CustomerContent;

            trigger OnLookup();
            begin
                /*PostCode.LookUpPostCode(City,"Post Code",TRUE);*///B2B

            end;

            trigger OnValidate();
            begin
                PostCode.ValidatePostCode(City, "Post Code", County, "Country Code", true);
            end;
        }
        field(57; County; Text[30])
        {
            DataClassification = CustomerContent;
        }
        field(58; "Country Code"; Code[10])
        {
            TableRelation = "Country/Region";
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                if CountryCode.Get("Country Code") then
                    County := CountryCode.Name;
            end;
        }
        field(59; State; Code[10])
        {
            TableRelation = State;
            DataClassification = CustomerContent;
        }
        field(60; "Phone No."; Text[30])
        {
            Caption = 'Phone No.';
            DataClassification = CustomerContent;
        }
        field(61; "Telex No."; Text[20])
        {
            Caption = 'Telex No.';
            DataClassification = CustomerContent;
        }
        field(62; "Fax No."; Text[30])
        {
            Caption = 'Fax No.';
            DataClassification = CustomerContent;
        }
        field(63; "E-Mail"; Text[80])
        {
            Caption = 'E-Mail';
            DataClassification = CustomerContent;
        }
        field(64; "Home Page"; Text[80])
        {
            Caption = 'Home Page';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Code")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert();
    begin
        if Code = '' then begin
            RMSetup.Get;
            RMSetup.TestField(RMSetup."Product Competetors");
            NoSeriesMgt.InitSeries(RMSetup."Product Competetors", xRec."No. Series", 0D, Code, "No. Series");
        end;
    end;

    trigger OnRename();
    begin
        Error(Text003, TableCaption);
    end;

    var
        NoSeriesMgt: Codeunit 396;
        RMSetup: Record "Marketing Setup";
        PostCode: Record "Post Code";
        CountryCode: Record "Country/Region";
        Text003: Label 'You cannot rename a %1.';


    procedure AssistEdit(OldProductCompetitor: Record "Competitor's Master"): Boolean;
    var
        NoSeriesMgt: Codeunit 396;
        ProductCompetitor: Record "Competitor's Master";
        "RM Setup": Record "Marketing Setup";
    begin
        ProductCompetitor := Rec;
        "RM Setup".Get;
        "RM Setup".TestField("RM Setup"."Product Competetors");
        if NoSeriesMgt.SelectSeries("RM Setup"."Product Competetors", OldProductCompetitor."No. Series", ProductCompetitor."No. Series") then begin
            "RM Setup".Get;
            "RM Setup".TestField("RM Setup"."Product Competetors");
            NoSeriesMgt.SetSeries(ProductCompetitor.Code);
            Rec := ProductCompetitor;
            exit(true);
        end;
    end;


    procedure OpenAttachments();
    var
        Attachment: Record Attachments;
    begin
        Attachment.Reset;
        Attachment.SetRange("Table ID", DATABASE::"Competitor's Master");
        Attachment.SetRange("Document No.", Code);
        //Attachment.SETRANGE("Document Type","Product Type");

        PAGE.Run(PAGE::"ESPL Attachments", Attachment);
    end;
}

