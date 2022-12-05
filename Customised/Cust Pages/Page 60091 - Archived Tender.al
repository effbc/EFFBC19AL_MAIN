page 60091 "Archived Tender"
{
    // version B2B1.0,SH1.0,Rev01

    Editable = false;
    PageType = Document;
    SourceTable = "Tender Header Archive";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Tender No."; Rec."Tender No.")
                {
                    ApplicationArea = All;
                }
                field("Tender Description"; Rec."Tender Description")
                {
                    ApplicationArea = All;
                }
                field("Customer No."; Rec."Customer No.")
                {
                    ApplicationArea = All;
                }
                field("Customer Name"; Rec."Customer Name")
                {
                    ApplicationArea = All;
                }
                field("Customer Tender No."; Rec."Customer Tender No.")
                {
                    ApplicationArea = All;
                }
                field("Tender Source"; Rec."Tender Source")
                {
                    ApplicationArea = All;
                }
                field("Tender Source Name"; Rec."Tender Source Name")
                {
                    ApplicationArea = All;
                }
                field("Tender Source Date"; Rec."Tender Source Date")
                {
                    ApplicationArea = All;
                }
                field("Tender Dated"; Rec."Tender Dated")
                {
                    ApplicationArea = All;
                }
                field("Tender Application No."; Rec."Tender Application No.")
                {
                    ApplicationArea = All;
                }
                field("Tender Application Amount"; Rec."Tender Application Amount")
                {
                    ApplicationArea = All;
                }
                field("Tender doc Issue From"; Rec."Tender doc Issue From")
                {
                    ApplicationArea = All;
                }
                field("Tender doc Issue To"; Rec."Tender doc Issue To")
                {
                    ApplicationArea = All;
                }
                field("Supporting Tender"; Rec."Supporting Tender")
                {
                    ApplicationArea = All;
                }
                field("Tender Position"; Rec."Tender Position")
                {
                    ApplicationArea = All;
                }
            }
            part(TenderLines; "Archived Tender Subform")
            {
                SubPageLink = "Document No." = FIELD("Tender No.");
                ApplicationArea = All;
            }
            group(Customer)
            {
                Caption = 'Customer';
                field("<Customer Name2>"; Rec."Customer Name")
                {
                    ApplicationArea = All;
                }
                field("Customer Name 2"; Rec."Customer Name 2")
                {
                    ApplicationArea = All;
                }
                field("Customer Address"; Rec."Customer Address")
                {
                    ApplicationArea = All;
                }
                field("Customer Address 2"; Rec."Customer Address 2")
                {
                    ApplicationArea = All;
                }
                field(City; Rec.City)
                {
                    ApplicationArea = All;
                }
                field("Post Code"; Rec."Post Code")
                {
                    ApplicationArea = All;
                }
                field(Country; Rec.Country)
                {
                    ApplicationArea = All;
                }
                field("Country Code"; Rec."Country Code")
                {
                    ApplicationArea = All;
                }
                field(State; Rec.State)
                {
                    ApplicationArea = All;
                }
                field("Phone No."; Rec."Phone No.")
                {
                    ApplicationArea = All;
                }
                field("Telex No."; Rec."Telex No.")
                {
                    ApplicationArea = All;
                }
                field("Fax No."; Rec."Fax No.")
                {
                    ApplicationArea = All;
                }
                field("E-Mail"; Rec."E-Mail")
                {
                    ApplicationArea = All;
                }
                field("Home Page"; Rec."Home Page")
                {
                    ApplicationArea = All;
                }
                field("Customer Contact"; Rec."Customer Contact")
                {
                    ApplicationArea = All;
                }
                field(Territory; Rec.Territory)
                {
                    ApplicationArea = All;
                }
                field("Salesperson Code"; Rec."Salesperson Code")
                {
                    ApplicationArea = All;
                }
            }
            group("Bid Details")
            {
                Caption = 'Bid Details';
                field("Tender Quote Value"; Rec."Tender Quote Value")
                {
                    ApplicationArea = All;
                }
                field("Minimum Bid Amount"; Rec."Minimum Bid Amount")
                {
                    ApplicationArea = All;
                }
                field("Submission Due Date"; Rec."Submission Due Date")
                {
                    ApplicationArea = All;
                }
                field("Submission Due Time"; Rec."Submission Due Time")
                {
                    ApplicationArea = All;
                }
                field("Tech. Bid Opening Date"; Rec."Tech. Bid Opening Date")
                {
                    ApplicationArea = All;
                }
                field("Tech. Bid Opening Time"; Rec."Tech. Bid Opening Time")
                {
                    ApplicationArea = All;
                }
                field("Tender Status"; Rec."Tender Status")
                {
                    ApplicationArea = All;
                }
                field("Tender Posting Group"; Rec."Tender Posting Group")
                {
                    ApplicationArea = All;
                }
                field("Not Participated"; Rec."Not Participated")
                {
                    ApplicationArea = All;
                }
                field("Tender Submitted Date"; Rec."Tender Submitted Date")
                {
                    ApplicationArea = All;
                }
                field("Tender Dispatch Details"; Rec."Tender Dispatch Details")
                {
                    ApplicationArea = All;
                }
                field("Document Position"; Rec."Document Position")
                {
                    ApplicationArea = All;
                }
            }
            group(EMD)
            {
                Caption = 'EMD';
                field("EMD Amount"; Rec."EMD Amount")
                {
                    ApplicationArea = All;
                }
                field("EMD Payment Date"; Rec."EMD Payment Date")
                {
                    ApplicationArea = All;
                }
                field("EMD Received Date"; Rec."EMD Received Date")
                {
                    ApplicationArea = All;
                }
                field("EMD Status"; Rec."EMD Status")
                {
                    ApplicationArea = All;
                }
                field("EMD Requested Date"; Rec."EMD Requested Date")
                {
                    ApplicationArea = All;
                }
                field("EMD Required Date"; Rec."EMD Required Date")
                {
                    ApplicationArea = All;
                }
                field("EMD DD No."; Rec."EMD DD No.")
                {
                    ApplicationArea = All;
                }
                field("EMD Paid Amount"; Rec."EMD Paid Amount")
                {
                    ApplicationArea = All;
                }
                field("EMD Received Amount"; Rec."EMD Received Amount")
                {
                    ApplicationArea = All;
                }
                field("EMD Adjusted Amount"; Rec."EMD Adjusted Amount")
                {
                    ApplicationArea = All;
                }
            }
            group("Security Deposit")
            {
                Caption = 'Security Deposit';
                field("Security Deposit Amount"; Rec."Security Deposit Amount")
                {
                    ApplicationArea = All;
                }
                field("Deposit Payment Due Date"; Rec."Deposit Payment Due Date")
                {
                    ApplicationArea = All;
                }
                field("Deposit Payment Date"; Rec."Deposit Payment Date")
                {
                    ApplicationArea = All;
                }
                field("Security Deposit Status"; Rec."Security Deposit Status")
                {
                    ApplicationArea = All;
                }
                field("SD Requested Date"; Rec."SD Requested Date")
                {
                    ApplicationArea = All;
                }
                field("SD Required Date"; Rec."SD Required Date")
                {
                    ApplicationArea = All;
                }
                field("SecurityDeposit Exp. Rcpt Date"; Rec."SecurityDeposit Exp. Rcpt Date")
                {
                    ApplicationArea = All;
                }
                field("SD Net Pay"; Rec."SD Net Pay")
                {
                    ApplicationArea = All;
                }
                field("Received Amount"; Rec."Received Amount")
                {
                    ApplicationArea = All;
                }
                field("Balance Receivable"; Rec."Balance Receivable")
                {
                    ApplicationArea = All;
                }
                field("Adjusted from EMD"; Rec."Adjusted from EMD")
                {
                    ApplicationArea = All;
                }
                field("Adjusted from Running Bills"; Rec."Adjusted from Running Bills")
                {
                    ApplicationArea = All;
                }
                field("SD Paid Amount"; Rec."SD Paid Amount")
                {
                    ApplicationArea = All;
                }
                field("SD Received Amount"; Rec."SD Received Amount")
                {
                    ApplicationArea = All;
                }
            }
            group(Details)
            {
                Caption = 'Details';
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field("Standard/Customize"; Rec."Standard/Customize")
                {
                    ApplicationArea = All;
                }
                field("Doc. No. Occurrence"; Rec."Doc. No. Occurrence")
                {
                    ApplicationArea = All;
                }
                field("Version No."; Rec."Version No.")
                {
                    ApplicationArea = All;
                }
                field("No. of Archived Versions"; Rec."No. of Archived Versions")
                {
                    ApplicationArea = All;
                }
                field("Product Type"; Rec."Product Type")
                {
                    ApplicationArea = All;
                }
                field("No. of Sales Order"; Rec."No. of Sales Order")
                {
                    ApplicationArea = All;
                }
                field("No. of Posted Sales Order"; Rec."No. of Posted Sales Order")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Line")
            {
                Caption = '&Line';
                action("&List")
                {
                    Caption = '&List';
                    Image = List;
                    RunObject = Page "Archived Tender list";
                    ShortCutKey = 'F5';
                    ApplicationArea = All;
                }
                separator(Action1102152026)
                {
                }
                action("&Attachments")
                {
                    Caption = '&Attachments';
                    Image = Attachments;
                    RunObject = Page "ESPL Attachments Archive";
                    RunPageLink = "Document No." = FIELD("Tender No.");
                    ApplicationArea = All;
                }
            }
        }
    }

    var
        NoSeriesMgt: Codeunit 396;
        SRSetup: Record "Sales & Receivables Setup";
        Tender: Codeunit "Specification-Copy";
        DesignWorksheetHeader: Record "Design Worksheet Header";
        DesignWorksheetLine: Record "Design Worksheet Line";
        DesignWorksheetTender: Record "Design Worksheet Header";
        DesignWorksheetLineTender: Record "Design Worksheet Line";
        TenderPostingLines: Record "Tender Posting Lines";
}

