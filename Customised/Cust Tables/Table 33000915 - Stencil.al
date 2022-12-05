table 33000915 Stencil
{
    DataCaptionFields = "No.", Description, Status, "Fixed Asset no";
    DrillDownPageID = "Stencil List";
    LookupPageID = "Stencil List";
    DataClassification = CustomerContent;

    fields
    {
        field(1; "No."; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(2; Description; Code[50])
        {
            DataClassification = CustomerContent;
        }
        field(3; Status; Option)
        {
            OptionMembers = ,InPO,Active,Closed,Damaged;
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin

                FixedAssetGrec.Reset;
                FixedAssetGrec.SetRange(FixedAssetGrec."No.", "Fixed Asset no");
                FixedAssetGrec.SetFilter(FixedAssetGrec."Location Code", 'DAMAGE');
                if FixedAssetGrec.FindFirst then
                    Status := Status::Damaged
                else begin
                    PL.SetFilter(PL.Type, 'FIXED ASSET');
                    PL.SetRange(PL."No.", "Fixed Asset no");
                    if PL.FindFirst then begin
                        ;
                        //   IF PL."Quantity Received" >0 THEN
                        //     Status:=Status::Active
                        //  ELSE
                        //    Status:=Status::InPO;
                    end;
                end;
                Modify;
            end;
        }
        field(4; "Fixed Asset no"; Code[20])
        {
            TableRelation = "Fixed Asset"."No.";
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                FixedAssetGrec.Reset;
                FixedAssetGrec.SetRange(FixedAssetGrec."No.", "Fixed Asset no");
                if FixedAssetGrec.FindFirst then
                    Description := FixedAssetGrec.Description;
            end;
        }
    }

    keys
    {
        key(Key1; "No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert();
    begin
        StencilGRec.Reset;
        if StencilGRec.FindLast then
            "No." := IncStr(StencilGRec."No.")
        else
            "No." := 'STENCIL0001';
    end;

    var
        //NoSeriesMgt: Codeunit NoSeriesManagement;
        FixedAssetGrec: Record "Fixed Asset";
        StencilGRec: Record Stencil;
        PL: Record "Purchase Line";
}

