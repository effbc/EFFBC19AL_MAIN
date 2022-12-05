pageextension 70170 ResourceCardExt extends "Resource Card"
{
    layout
    {
        modify("Post Code")
        {
            CaptionML = ENU = 'Post Code/City';
        }

        addafter("Base Unit of Measure")
        {
            field(Department; Rec.Department)
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {

        modify(Statistics)
        {
            Promoted = true;
        }
        /* modify(Prices)
        {
            Promoted = true;
        } */
        modify("Ledger E&ntries")
        {
            Promoted = true;
        }
        modify("Resource Statistics")
        {
            Promoted = true;
        }
        modify("Resource Usage")
        {
            Promoted = true;
        }
        modify("Resource - Cost Breakdown")
        {
            Promoted = true;
        }

    }

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec."User Id" := USERID;
    end;



}

