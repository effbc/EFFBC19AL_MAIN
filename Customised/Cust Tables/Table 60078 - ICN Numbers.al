table 60078 "ICN Numbers"
{
    // version POAU

    LookupPageID = "ICN Numbers";
    DataClassification = CustomerContent;

    fields
    {
        field(1; "ICN No."; Code[20])
        {
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                if "ICN No." <> xRec."ICN No." then begin
                    PurchaseSetup.Get;
                    NoSeriesMgt.TestManual(PurchaseSetup."ICN Nos.");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; Description; Text[30])
        {
            DataClassification = CustomerContent;
        }
        field(3; "No. Series"; Code[10])
        {
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(4; "Created Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(5; "Last Modified Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(6; "Indent Status"; Option)
        {
            OptionCaption = 'Indent,Enquiry,Offer,Order,Cancel,Closed';
            OptionMembers = Indent,Enquiry,Offer,"Order",Cancel,Closed;
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "ICN No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert();
    begin
        if "ICN No." = '' then begin
            PurchaseSetup.Get;
            PurchaseSetup.TestField("ICN Nos.");
            NoSeriesMgt.InitSeries(PurchaseSetup."ICN Nos.", xRec."No. Series", 0D, "ICN No.", "No. Series");
        end;
        "Created Date" := Today;
    end;

    trigger OnModify();
    begin
        "Last Modified Date" := Today;
    end;

    var
        PurchaseSetup: Record "Purchases & Payables Setup";
        NoSeriesMgt: Codeunit 396;
}

