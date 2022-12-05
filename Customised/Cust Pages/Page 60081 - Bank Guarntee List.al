page 60081 "Bank Guarntee List"
{
    // version B2B1.0

    CardPageID = "Bank Guarntee";
    Editable = false;
    PageType = List;
    SourceTable = "Bank Guarantee";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Control1102152000)
            {
                ShowCaption = false;
                field("BG No."; Rec."BG No.")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Issuing Bank"; Rec."Issuing Bank")
                {
                    ApplicationArea = All;
                }
                field(Extended; Rec.Extended)
                {
                    ApplicationArea = All;
                }
                field("Customer Order No."; Rec."Customer Order No.")
                {
                    ApplicationArea = All;
                }
                field(Closed; Rec.Closed)
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field(Branch; Rec.Branch)
                {
                    ApplicationArea = All;
                }
                field("Transaction Type"; Rec."Transaction Type")
                {
                    ApplicationArea = All;
                }
                field("Issued to/Received from"; Rec."Issued to/Received from")
                {
                    ApplicationArea = All;
                }
                field("Customer Name"; Rec."Customer Name")
                {
                    ApplicationArea = All;
                }
                field("Doc No."; Rec."Doc No.")
                {
                    ApplicationArea = All;
                }
                field("Date of Issue"; Rec."Date of Issue")
                {
                    ApplicationArea = All;
                }
                field("Expiry Date"; Rec."Expiry Date")
                {
                    ApplicationArea = All;
                }
                field("Claim Date"; Rec."Claim Date")
                {
                    ApplicationArea = All;
                }
                field("Type of BG"; Rec."Type of BG")
                {
                    ApplicationArea = All;
                }
                field("BG Value"; Rec."BG Value")
                {
                    ApplicationArea = All;
                }
                field("Tender No."; Rec."Tender No.")
                {
                    ApplicationArea = All;
                }
                field("Confirmed BY"; Rec."Confirmed BY")
                {
                    ApplicationArea = All;
                }
                field("Confirmed BY Name"; Rec."Confirmed BY Name")
                {
                    ApplicationArea = All;
                }
                field("Security Deposit No."; Rec."Security Deposit No.")
                {
                    ApplicationArea = All;
                }
                field("Final Railway Bill Date"; Rec."Final Railway Bill Date")
                {
                    ApplicationArea = All;
                }
                field("Warranty Period"; Rec."Warranty Period")
                {
                    ApplicationArea = All;
                }
                field("BG Warranty Completion Date"; Rec."BG Warranty Completion Date")
                {
                    ApplicationArea = All;
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }
}

