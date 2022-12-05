page 33000278 Assay
{
    // version QC1.1

    PageType = Document;
    SourceTable = "Assay Header";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("No."; Rec."No.")
                {
                    AssistEdit = true;
                    ApplicationArea = All;

                    trigger OnAssistEdit();
                    begin
                        IF Rec.AssistEdit(xRec) THEN
                            CurrPage.UPDATE;
                    end;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Sampling Plan Code"; Rec."Sampling Plan Code")
                {
                    ApplicationArea = All;
                }
                field("Inspection Group Code"; Rec."Inspection Group Code")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
            }
            part(Control1000000010; "Assay Subform")
            {
                SubPageLink = "Assay No." = FIELD("No.");
                ApplicationArea = All;
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord();
    begin
        _OnAfterGetCurrRecord;
    end;

    trigger OnNewRecord(BelowxRec: Boolean);
    begin
        _OnAfterGetCurrRecord;
    end;


    local procedure _OnAfterGetCurrRecord();
    begin
        xRec := Rec;
        Rec.SETRANGE("No.");
    end;
}

