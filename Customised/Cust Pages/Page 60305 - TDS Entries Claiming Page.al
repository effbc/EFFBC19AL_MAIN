page 60305 "TDS Entries Claiming Page"
{
    PageType = List;
    Permissions = TableData "G/L Entry" = rm;
    SourceTable = "G/L Entry";
    SourceTableView = SORTING("G/L Account No.", "Posting Date") ORDER(Ascending) WHERE("G/L Account No." = CONST('24634..24639'), Amount = FILTER(> 0), "GST TDS Claimed Date" = FILTER(''));
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            field("xRec.COUNT"; xRec.COUNT)
            {
                Style = Standard;
                StyleExpr = TRUE;
                ApplicationArea = All;
            }
            repeater(Group)
            {
                field(GSTTDSNUMBER; GSTTDSNUMBER)
                {
                    Caption = 'GST TDS Number';
                    Editable = false;
                    ApplicationArea = All;
                }
                field("CUstomer Number"; "CUstomer Number")
                {
                    Caption = 'Customer Numner';
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Customer Name"; "Customer Name")
                {
                    Caption = 'Customer Name';
                    Editable = false;
                    ApplicationArea = All;
                }
                field("G/L Account No."; "G/L Account No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("G/L Account Name"; "G/L Account Name")
                {
                    ApplicationArea = All;
                }
                field("System Date"; "System Date")
                {
                    ApplicationArea = All;
                }
                field("Posting Date"; "Posting Date")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Document Type"; "Document Type")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Document No."; "Document No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Description; Description)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Amount; Amount)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Global Dimension 1 Code"; "Global Dimension 1 Code")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Global Dimension 2 Code"; "Global Dimension 2 Code")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("User ID"; "User ID")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Source Code"; "Source Code")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Source No."; "Source No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Sale Order No."; "Sale Order No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("GST TDS Claimed Date"; "GST TDS Claimed Date")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord();
    begin
        GLE.RESET;
        GLE.SETFILTER("G/L Account No.", '%1|%2', '20300', '20400');
        GLE.SETFILTER("Document No.", Rec."Document No.");
        IF GLE.FINDSET THEN BEGIN
            "CUstomer Number" := GLE."Source No.";
            Cust.RESET;
            Cust.SETFILTER("No.", "CUstomer Number");
            IF Cust.FINDFIRST THEN BEGIN
                "Customer Name" := Cust.Name;
                GSTTDSNUMBER := Cust."GST TDS Number";
            END;

        END;
    end;

    trigger OnOpenPage();
    begin
        // Written by Vishnu Priya on 15-02-2019

        IF USERID IN ['EFFTRONICS\SUJANI', 'EFFTRONICS\RAJANI', 'EFFTRONICS\SITARAJYAM', 'EFFTRONICS\ASWINI', 'EFFTRONICS\VISHNUPRIYA'] THEN
            CurrPage.EDITABLE := TRUE
        ELSE
            CurrPage.EDITABLE := FALSE;

    end;

    var
        "CUstomer Number": Code[15];
        Cust: Record Customer;
        GLE: Record "G/L Entry";
        GSTTDSNUMBER: Code[30];
        "Customer Name": Text[100];
        GLE1: Record "G/L Entry";
}

