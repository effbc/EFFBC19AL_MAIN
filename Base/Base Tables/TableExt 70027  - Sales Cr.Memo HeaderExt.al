tableextension 70027 SalesCrMemoHeaderExt extends "Sales Cr.Memo Header"
{
    fields
    {
        field(60000; "Amount to Customer"; Decimal)
        {
            //DataClassification = CustomerContent;
            FieldClass = FlowField;
            CalcFormula = Sum("Sales Cr.Memo Line"."Amount To Customer" WHERE("Document No." = FIELD("No.")));
        }
        field(80020; "Dimension Corrected"; Boolean)
        {
            Description = 'added  by sujani for Dimension issue clearance (B2B Assistance)';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(80021; "OLD Dim Set ID"; Integer)
        {
            Description = 'added  by sujani for Dimension issue clearance (B2B Assistance)';
            Editable = false;
            TableRelation = "Dimension Set Entry Backup2"."Dimension Set ID" WHERE("Dimension Set ID" = FIELD("OLD Dim Set ID"));
            DataClassification = CustomerContent;


        }
        field(95402; "Transport Method1"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(95404; "Form No.1"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(95408; "Description1"; Text[200])
        {
            DataClassification = CustomerContent;
        }
        field(95409; "Description 21"; Text[250])
        {
            DataClassification = CustomerContent;
        }
    }

    var
        DuplicateIRNErr: Label 'Duplicate IRN.';
        NoActiveIRNErr: Label 'No active IRN found.';
        GetIRNFailedTxt: Label 'Unable to Get IRN, Please try after some time.';


}

