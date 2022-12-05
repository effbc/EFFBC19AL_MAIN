page 60000 "Form Tracking"
{
    // version B2B1.0,Rev01

    Editable = false;
    PageType = List;
    SourceTable = "Form Tracking";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Control1102152000)
            {
                ShowCaption = false;
                field("Form Code"; Rec."Form Code")
                {
                    ApplicationArea = All;
                }
                field("Form No."; Rec."Form No.")
                {
                    ApplicationArea = All;
                }
                field(State; Rec.State)
                {
                    ApplicationArea = All;
                }
                field("Document Type"; Rec."Document Type")
                {
                    ApplicationArea = All;
                }
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                }
                field("Vendor / Customer No."; Rec."Vendor / Customer No.")
                {
                    ApplicationArea = All;
                }
                field("Invoice Base Amount"; Rec."Invoice Base Amount")
                {
                    ApplicationArea = All;
                }
                field("Sales Tax Base Amount"; Rec."Sales Tax Base Amount")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                }
                field("Sales Tax Amount"; Rec."Sales Tax Amount")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("&Release Forms")
            {
                Caption = '&Release Forms';
                Image = ReleaseDoc;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction();
                var
                    //TaxFormsDetails: Record 13757;//B2BUpg
                    FormTracking: Record "Form Tracking";
                    Text001: Label 'Do you want to release the Form?';
                begin
                    IF NOT CONFIRM(Text001, FALSE) THEN
                        EXIT;
                    Rec.TESTFIELD(Status, Rec.Status::Open);
                    Rec.TESTFIELD(Type, Rec.Type::Purchase);
                    Rec.TESTFIELD("Form No.");
                    FormTracking.SETRANGE("Form No.", Rec."Form No.");
                    IF FormTracking.FINDFIRST THEN
                        REPEAT
                            FormTracking.Status := FormTracking.Status::Released;
                            FormTracking.MODIFY;
                        UNTIL FormTracking.NEXT = 0;
                    CurrPage.UPDATE;

                    //TaxFormsDetails.SETRANGE("Vendor No.","Vendor / Customer No."); B2B Commented
                    /* TaxFormsDetails.SETRANGE(Rec."Form Code", Rec."Form Code");
                     TaxFormsDetails.SETRANGE(Rec."Form No.", Rec."Form No.");
                     IF TaxFormsDetails.FINDFIRST THEN BEGIN
                         TaxFormsDetails.Issued := TRUE;
                         TaxFormsDetails.MODIFY;
                     END;*/
                end;
            }
        }
    }
}

