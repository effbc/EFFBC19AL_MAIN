tableextension 70100 ServiceItemExt extends "Service Item"
{

    fields
    {

        modify("No.")
        {
            trigger OnAfterValidate()
            begin
                "Creation Date" := Today;
            end;
        }
        field(60001; Territory; Code[20])
        {
            Description = 'B2B';
            Editable = false;
            TableRelation = Territory.Code;
            DataClassification = CustomerContent;
        }
        field(60002; "Installed Location"; Text[70])
        {
            Description = 'B2B';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(60003; "Installation Status"; Text[30])
        {
            Description = 'B2B';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(60004; "Datalogger Version"; Code[20])
        {
            Description = 'B2B';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(60005; Position; Code[20])
        {
            Description = 'B2B';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(60006; "Software Version"; Code[20])
        {
            Description = 'B2B';
            Editable = false;
            TableRelation = CFormlist.Year;
            DataClassification = CustomerContent;
        }
        field(60007; "Power Supply"; Enum PowerSupply)
        {
            Description = 'B2B';
            Editable = false;
            DataClassification = CustomerContent;

        }
        field(60008; "Batch No."; Code[20])
        {
            Description = 'B2B';
            DataClassification = CustomerContent;
        }
        field(60009; "Job No."; Code[20])
        {
            Description = 'B2B';
            Editable = false;
            TableRelation = Job."No.";
            DataClassification = CustomerContent;
        }
        field(60010; "Job Installation Date"; Date)
        {
            Description = 'B2B';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(60011; "Software Code"; Code[20])
        {
            Description = 'B2B';
            Editable = false;
            TableRelation = CFormlist.vendor;
            DataClassification = CustomerContent;
        }
        field(60012; "SO No."; Code[20])
        {
            Description = 'B2B';
            Editable = false;
            TableRelation = "Sales Header"."No.";
            DataClassification = CustomerContent;
        }
        field(60013; "SO Line No."; Integer)
        {
            Description = 'B2B';
            Editable = false;
            TableRelation = "Sales Line"."Line No." WHERE("Document No." = FIELD("SO No."));
            DataClassification = CustomerContent;
        }
        field(60030; "Countrol Section"; Code[10])
        {
            DataClassification = CustomerContent;
        }
        field(60031; "N/W Stand Alone"; Enum "NetWork Stand Alone")
        {
            DataClassification = CustomerContent;

        }
        field(60032; IDNO; Code[10])
        {
            DataClassification = CustomerContent;
        }
        field(60033; "F/W Version"; Code[10])
        {
            DataClassification = CustomerContent;
        }
        field(60034; "S/W Version"; Text[30])
        {
            DataClassification = CustomerContent;
        }
        field(60035; "H/W Process Type"; Text[30])
        {
            DataClassification = CustomerContent;
        }
        field(60036; "Operating Voltage"; Enum "Operating Voltage")
        {
            DataClassification = CustomerContent;

        }
        field(60037; "Supply Giving From"; Text[30])
        {
            DataClassification = CustomerContent;
        }
        field(60038; "Earth Status"; Enum "Earth Status")
        {
            DataClassification = CustomerContent;

        }
        field(60039; "Communication Media"; Enum "Communication Media")
        {
            DataClassification = CustomerContent;

        }
        field(60040; "Warr/AMC/None"; Enum "Warr AMC None")
        {
            DataClassification = CustomerContent;

        }
        field(60041; Zone; Code[10])
        {
            TableRelation = Zone;
            DataClassification = CustomerContent;
        }
        field(60042; Division; Code[10])
        {
            DataClassification = CustomerContent;
            //TableRelation = Table50012.Field1 WHERE(Field2 = FIELD(Zone));
        }
        field(60043; Station; Code[20])
        {
            DataClassification = CustomerContent;
            //TableRelation = Table50013.Field1 WHERE(Field2 = FIELD(Division));
        }
        field(60044; "Creation Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(60045; ITLSNO; Integer)
        {
            TableRelation = "Item Ledger Entry"."Entry No." WHERE("Item No." = FIELD("Item No."),
                                                                   "Variant Code" = FIELD("Variant Code"),
                                                                   "Serial No." = FIELD("Serial No."));
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                ITEMLEDGER.SetFilter(ITEMLEDGER."Entry No.", Format(ITLSNO));
                // MESSAGE(FORMAT(ITEMLEDGER.COUNT));
                if ITEMLEDGER.Find('-') then
                    repeat
                        "Serial No." := ITEMLEDGER."Serial No.";
                    until ITEMLEDGER.Next = 0;
                // MESSAGE(FORMAT(ITEMLEDGER."Serial No."));
            end;
        }
        field(60046; "AMC Order NO"; Code[30])
        {
            TableRelation = "Service Contract Header"."Contract No.";
            DataClassification = CustomerContent;
        }
        field(60047; "Present Location"; Code[80])
        {
            Editable = true;
            DataClassification = CustomerContent;
        }
        field(60048; Valid; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(60049; "WORKING STATUS"; Enum WORKINGSTATUS)
        {
            DataClassification = CustomerContent;

        }
        field(60050; "Changed Location"; Code[10])
        {
            TableRelation = "Dimension Value".Code WHERE("Dimension Code" = CONST('LOCATIONS'));
            DataClassification = CustomerContent;
        }
        field(60051; "ove to Non Moving Location"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(60052; "Get From Non-Moving Location"; Enum "Get From Non-MovingLocation")
        {
            DataClassification = CustomerContent;

        }
        field(60054; Description1; Text[250])
        {
            DataClassification = CustomerContent;
        }
        field(60053; "Variant Code1"; Code[30])
        {
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        /* key(Key7; "Present Location","Item No.","WORKING STATUS")
        {

        } */
    }

    var
        ITEMLEDGER: Record "Item Ledger Entry";

    PROCEDURE "--B2B--"();
    BEGIN
    END;


    PROCEDURE Attachments();
    VAR
        Attachments: Record Attachments;
    BEGIN
        Attachments.Reset;
        Attachments.SetRange("Table ID", DATABASE::"Service Item");
        Attachments.SetRange("Document No.", "No.");
        //Attachments.SETRANGE("Document Type","Document Type");

        PAGE.Run(PAGE::"ESPL Attachments", Attachments);
    END;
}

