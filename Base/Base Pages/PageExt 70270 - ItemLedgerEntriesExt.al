pageextension 70270 ItemLedgerEntriesExt extends 38
{

    layout
    {
        modify("Sales Amount (Actual)")
        {
            Visible = false;
        }
        modify("Cost Amount (Actual)")
        {
            Visible = false;
        }
        modify("Cost Amount (Non-Invtbl.)")
        {
            Visible = false;
        }
        addfirst(content)
        {
            field(COUNT; Rec.COUNT)
            {
                ApplicationArea = All;

            }
        }
        addafter("Document No.")
        {
            field("ITL Doc No."; Rec."ITL Doc No.")
            {
                Importance = Standard;
                ApplicationArea = All;
            }
            field("ITL Doc Line No."; Rec."ITL Doc Line No.")
            {
                ApplicationArea = All;

            }
            field(Positive; Rec.Positive)
            {
                ApplicationArea = All;

            }
        }
        addafter("Job Task No.")
        {
            field("User ID"; Rec."User ID")
            {
                Editable = TRUE;
                ApplicationArea = All;
            }
            field("DC Check"; Rec."DC Check")
            {
                ApplicationArea = All;

            }
            field("Source Type"; Rec."Source Type")
            {
                ApplicationArea = All;

            }
            field("MBB Packed Date"; Rec."MBB Packed Date")
            {
                ApplicationArea = All;

            }
            field("MFD Date"; Rec."MFD Date")
            {
                ApplicationArea = All;

            }
            field("Recharge Cycles"; Rec."Recharge Cycles")
            {
                ApplicationArea = All;

            }
            field("Last Invoice Date"; Rec."Last Invoice Date")
            {
                ApplicationArea = All;

            }
            field("Floor Life"; Rec."Floor Life")
            {
                ApplicationArea = All;

            }
            field("MBB Packet Open DateTime"; Rec."MBB Packet Open DateTime")
            {
                ApplicationArea = All;

            }
            field("MBB Packet Close DateTime"; Rec."MBB Packet Close DateTime")
            {
                ApplicationArea = All;

            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    trigger OnOpenPage()
    begin
          IF USERID IN ['EFFTRONICS\ANILKUMAR','EFFTRONICS\GRAVI','EFFTRONICS\DURGAMAHESWARI','EFFTRONICS\B2BOTS'] THEN
            CurrPage.EDITABLE := TRUE
        ELSE
            CurrPage.EDITABLE := FALSE;
    end;

    var
        myInt: Integer;
}