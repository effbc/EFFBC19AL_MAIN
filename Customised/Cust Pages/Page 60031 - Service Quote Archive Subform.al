page 60031 "Service Quote Archive Subform"
{
    // version B2B1.0

    AutoSplitKey = true;
    Caption = 'Service Quote Subform';
    DelayedInsert = true;
    PageType = ListPart;
    SourceTable = "Service Item Line Archive";
    SourceTableView = WHERE("Document Type"=CONST(Quote));

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field("Line No."; Rec."Line No.")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Service Item No."; Rec."Service Item No.")
                {
                    ApplicationArea = All;
                }
                field("Service Item Group Code"; Rec."Service Item Group Code")
                {
                    ApplicationArea = All;
                }
                field("Ship-to Code"; Rec."Ship-to Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = All;
                }
                field("Serial No."; Rec."Serial No.")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Description 2"; Rec."Description 2")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Repair Status Code"; Rec."Repair Status Code")
                {
                    ApplicationArea = All;
                }
                field("Service Shelf No."; Rec."Service Shelf No.")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field(Warranty; Rec.Warranty)
                {
                    ApplicationArea = All;
                }
                field("Warranty Starting Date (Parts)"; Rec."Warranty Starting Date (Parts)")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Warranty Ending Date (Parts)"; Rec."Warranty Ending Date (Parts)")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Warranty % (Parts)"; Rec."Warranty % (Parts)")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Warranty % (Labor)"; Rec."Warranty % (Labor)")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Warranty Starting Date (Labor)"; Rec."Warranty Starting Date (Labor)")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Warranty Ending Date (Labor)"; Rec."Warranty Ending Date (Labor)")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Contract No."; Rec."Contract No.")
                {
                    ApplicationArea = All;
                }
                field("Fault Reason Code"; Rec."Fault Reason Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Service Price Group Code"; Rec."Service Price Group Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Adjustment Type"; Rec."Adjustment Type")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Base Amount to Adjust"; Rec."Base Amount to Adjust")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Fault Area Code"; Rec."Fault Area Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Symptom Code"; Rec."Symptom Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Fault Code"; Rec."Fault Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Resolution Code"; Rec."Resolution Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field(Priority; Rec.Priority)
                {
                    ApplicationArea = All;
                }
                field("Response Date"; Rec."Response Date")
                {
                    ApplicationArea = All;
                }
                field("Response Time"; Rec."Response Time")
                {
                    ApplicationArea = All;
                }
                field("Vendor No."; Rec."Vendor No.")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Vendor Item No."; Rec."Vendor Item No.")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Loaner No."; Rec."Loaner No.")
                {
                    LookupPageID = "Available Loaners";
                    ApplicationArea = All;
                }
                field("Starting Date"; Rec."Starting Date")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Starting Time"; Rec."Starting Time")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Finishing Date"; Rec."Finishing Date")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Finishing Time"; Rec."Finishing Time")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("No. of Previous Services"; Rec."No. of Previous Services")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }

    var
        ServHeader: Record "Service Header";
        ServLoanerMgt: Codeunit ServLoanerManagement;

   
    procedure ShowComments(Type: Option General,Fault,Resolution,Accessory,Internal,"Service Item Loaner");
    begin
    end;

   
    procedure RegisterServInvLines();
    var
        ServInvLine: Record "Service Line";
    begin
    end;

   
    procedure ShowServOrderWorksheet();
    var
        ServItemLine: Record "Service Item Line";
    begin
    end;

   
    procedure AllocateResource();
    var
        ServOrderAlloc: Record "Service Order Allocation";
    begin
    end;

   
    procedure ReceiveLoaner();
    begin
    end;

   
    procedure ShowServItemEventLog();
    var
        ServItemLog: Record "Service Item Log";
    begin
    end;

   
    procedure ShowChecklist();
    var
        TblshtgHeader: Record "Troubleshooting Header";
    begin
    end;

   
    procedure "---B2B--"();
    begin
    end;

   
    procedure OpenAttachments();
    var
        Attachments: Record Attachments;
    begin
    end;
}

