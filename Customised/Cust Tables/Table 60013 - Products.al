table 60013 Products
{
    // version B2B1.0

    LookupPageID = "Product List";
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Code"; Code[20])
        {
            NotBlank = true;
            TableRelation = Item;
            DataClassification = CustomerContent;
        }
        field(2; "Product Type"; Option)
        {
            OptionMembers = "Data Logger","Display Board";
            DataClassification = CustomerContent;
        }
        field(3; Description; Text[70])
        {
            DataClassification = CustomerContent;
        }
        field(4; Technology; Text[70])
        {
            DataClassification = CustomerContent;
        }
        field(5; "Key Features"; Text[70])
        {
            DataClassification = CustomerContent;
        }
        field(6; "Launched Year"; Text[10])
        {
            DataClassification = CustomerContent;
        }
        field(7; Segment; Code[20])
        {
            TableRelation = "Segment Header";
            DataClassification = CustomerContent;
        }
        field(8; Price; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(9; "Software Code"; Code[20])
        {
            TableRelation = CFormlist.vendor;
            DataClassification = CustomerContent;
        }
        field(10; "No. Series"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(11; "Tools Used"; Text[70])
        {
            DataClassification = CustomerContent;
        }
        field(12; Benefits; Text[70])
        {
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


    procedure AssistEdit(OldProduct: Record Products): Boolean;
    var
        "RM Setup": Record "Marketing Setup";
        Products: Record Products;
    // NoSeriesMgt: Codeunit 396;
    begin
        /*
        WITH Products DO BEGIN
          Products := Rec;
          "RM Setup".GET;
          "RM Setup".TESTFIELD("Product ID");
          IF NoSeriesMgt.SelectSeries("RM Setup"."Product ID",OldProduct."No. Series","No. Series") THEN BEGIN
            "RM Setup".GET;
            "RM Setup".TESTFIELD("RM Setup"."Product ID");
            NoSeriesMgt.SetSeries(Code);
            Rec := Products;
            EXIT(TRUE);
          END;
        END;
        */

    end;


    procedure OpenAttachments();
    var
        Attachment: Record Attachments;
    begin
        Attachment.Reset;
        Attachment.SetRange("Table ID", DATABASE::Products);
        Attachment.SetRange("Document No.", Code);
        Attachment.SetRange("Document Type", "Product Type");

        PAGE.Run(PAGE::"ESPL Attachments", Attachment);
    end;
}

