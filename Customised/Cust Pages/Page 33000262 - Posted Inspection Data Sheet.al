page 33000262 "Posted Inspection Data Sheet"
{
    // version QC1.1,Cal1.0,RQC1.0,Rev01

    Editable = true;
    InsertAllowed = false;
    PageType = Document;
    SourceTable = "Posted Inspect DatasheetHeader";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = All;
                }
                field("Item Description"; Rec."Item Description")
                {
                    ApplicationArea = All;
                }
                field("Unit Of Measure Code"; Rec."Unit Of Measure Code")
                {
                    ApplicationArea = All;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                }
                field("Spec ID"; Rec."Spec ID")
                {
                    ApplicationArea = All;
                }
                field(Make; Rec.Make)
                {
                    Editable = true;
                    ApplicationArea = All;
                }
                field("Lot No."; Rec."Lot No.")
                {
                    ApplicationArea = All;
                }
                field(Location; Rec.Location)
                {
                    ApplicationArea = All;
                }
                field("Inspection Group Code"; Rec."Inspection Group Code")
                {
                    ApplicationArea = All;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                }
                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = All;
                }
                field("Rework Reference No."; Rec."Rework Reference No.")
                {
                    ApplicationArea = All;
                }
                field("Source Type"; Rec."Source Type")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    OptionCaption = '<Open,Released,Calibration>';
                    ApplicationArea = All;
                }
                field("Actual Time"; Rec."Actual Time")
                {
                    ApplicationArea = All;
                }
                field("Time Taken"; Rec."Time Taken")
                {
                    ApplicationArea = All;
                }
                field("Planning Date"; Rec."Planning Date")
                {
                    ApplicationArea = All;
                }
                field("Assigned User"; Rec."Assigned User")
                {
                    ApplicationArea = All;
                }
                field("Posted By Name"; Rec."Posted By Name")
                {
                    Caption = 'Posted By';
                    Editable = false;
                    ApplicationArea = All;
                }
            }
            part(DataSheetLine; "PostedInspec DataSheet Subform")
            {
                SubPageLink = "Document No." = FIELD("No.");
                ApplicationArea = All;
            }
            group(Receipt)
            {
                Caption = 'Receipt';
                field("Vendor No."; Rec."Vendor No.")
                {
                    ApplicationArea = All;
                }
                field("Vendor Name"; Rec."Vendor Name")
                {
                    ApplicationArea = All;
                }
                field("Vendor Name 2"; Rec."Vendor Name 2")
                {
                    ApplicationArea = All;
                }
                field(Address; Rec.Address)
                {
                    ApplicationArea = All;
                }
                field("Address 2"; Rec."Address 2")
                {
                    ApplicationArea = All;
                }
                field("Contact Person"; Rec."Contact Person")
                {
                    ApplicationArea = All;
                }
                field("Receipt No."; Rec."Receipt No.")
                {
                    ApplicationArea = All;
                }
                field("Order No."; Rec."Order No.")
                {
                    ApplicationArea = All;
                }
                field("Purch Line No"; Rec."Purch Line No")
                {
                    ApplicationArea = All;
                }
                field("External Document No."; Rec."External Document No.")
                {
                    ApplicationArea = All;
                }
                field("Purchase Consignment No."; Rec."Purchase Consignment No.")
                {
                    ApplicationArea = All;
                }
                field("Inspection Receipt No."; Rec."Inspection Receipt No.")
                {
                    ApplicationArea = All;
                }
                field("Quality Before Receipt"; Rec."Quality Before Receipt")
                {
                    ApplicationArea = All;
                }
                field(Indented_Person; Indented_Person)
                {
                    ApplicationArea = All;
                }
            }
            group(Production)
            {
                Caption = 'Production';
                field("Prod. Order No."; Rec."Prod. Order No.")
                {
                    ApplicationArea = All;
                }
                field("Prod. Order Line"; Rec."Prod. Order Line")
                {
                    ApplicationArea = All;
                }
                field("Routing No."; Rec."Routing No.")
                {
                    ApplicationArea = All;
                }
                field("Routing Reference No."; Rec."Routing Reference No.")
                {
                    ApplicationArea = All;
                }
                field("Operation No."; Rec."Operation No.")
                {
                    ApplicationArea = All;
                }
                field("Prod. Description"; Rec."Prod. Description")
                {
                    ApplicationArea = All;
                }
                field("Operation Description"; Rec."Operation Description")
                {
                    ApplicationArea = All;
                }
                field("Production Batch No."; Rec."Production Batch No.")
                {
                    ApplicationArea = All;
                }
                field("Sub Assembly Code"; Rec."Sub Assembly Code")
                {
                    ApplicationArea = All;
                }
                field("Sub Assembly Description"; Rec."Sub Assembly Description")
                {
                    ApplicationArea = All;
                }
                field("Issues For Pending"; Rec."Issues For Pending")
                {
                    ApplicationArea = All;
                }
                field("In Process"; Rec."In Process")
                {
                    ApplicationArea = All;
                }
                field(Resource; Rec.Resource)
                {
                    ApplicationArea = All;
                }
                field("OutPut Jr Serial No."; Rec."OutPut Jr Serial No.")
                {
                    ApplicationArea = All;
                }
                field("Finished Product Sr No"; Rec."Finished Product Sr No")
                {
                    ApplicationArea = All;
                }
                field("Rework User"; Rec."Rework User")
                {
                    ApplicationArea = All;
                }
            }
            group("Sales Cr.Memo")
            {
                Caption = 'Sales Cr.Memo';
                field("Sales Order No."; Rec."Sales Order No.")
                {
                    ApplicationArea = All;
                }
                field("Posted Sales Order No."; Rec."Posted Sales Order No.")
                {
                    ApplicationArea = All;
                }
                field("Sales Line No"; Rec."Sales Line No")
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
                field("Customer Name 2"; Rec."Customer Name 2")
                {
                    ApplicationArea = All;
                }
                field("Customer Address"; Rec."Customer Address")
                {
                    ApplicationArea = All;
                }
                field("Customer Address2"; Rec."Customer Address2")
                {
                    ApplicationArea = All;
                }
            }
            group(Transfer)
            {
                Caption = 'Transfer';
                field("Trans. Order No."; Rec."Trans. Order No.")
                {
                    ApplicationArea = All;
                }
                field("Trans. Order Line"; Rec."Trans. Order Line")
                {
                    ApplicationArea = All;
                }
                field("Trans. Description"; Rec."Trans. Description")
                {
                    ApplicationArea = All;
                }
                field("Transfer-from Code"; Rec."Transfer-from Code")
                {
                    ApplicationArea = All;
                }
                field("Transfer-to Code"; Rec."Transfer-to Code")
                {
                    ApplicationArea = All;
                }
            }
            group(Calibration)
            {
                Caption = 'Calibration';
                field("<Vendor No.2>"; Rec."Vendor No.")
                {
                    ApplicationArea = All;
                }
                field("<Vendor Name2>"; Rec."Vendor Name")
                {
                    ApplicationArea = All;
                }
                field("<Address2>"; Rec.Address)
                {
                    ApplicationArea = All;
                }
                field("<Address 22>"; Rec."Address 2")
                {
                    ApplicationArea = All;
                }
                field("<Contact Person2>"; Rec."Contact Person")
                {
                    ApplicationArea = All;
                }
                field("Calibration Party"; Rec."Calibration Party")
                {
                    ApplicationArea = All;
                }
                field("<Resource2>"; Rec.Resource)
                {
                    ApplicationArea = All;
                }
                field("Eqpt. Serial No."; Rec."Eqpt. Serial No.")
                {
                    ApplicationArea = All;
                }
                field(Department; Rec.Department)
                {
                    ApplicationArea = All;
                }
                field("Std. Reference"; Rec."Std. Reference")
                {
                    ApplicationArea = All;
                }
                field("Least Count"; Rec."Least Count")
                {
                    ApplicationArea = All;
                }
                field("Measuring Range"; Rec."Measuring Range")
                {
                    ApplicationArea = All;
                }
                field("Model No."; Rec."Model No.")
                {
                    ApplicationArea = All;
                }
            }
            group(Others)
            {
                Caption = 'Others';
                field("Item Category Code"; Rec."Item Category Code")
                {
                    ApplicationArea = All;
                }
                field("Product Group Code"; Rec."Product Group Code")
                {
                    ApplicationArea = All;
                }
                field("Item Sub Group Code"; Rec."Item Sub Group Code")
                {
                    ApplicationArea = All;
                }
                field("Item Sub Sub Group Code"; Rec."Item Sub Sub Group Code")
                {
                    ApplicationArea = All;
                }
                field("No. of Opportunities"; Rec."No. of Opportunities")
                {
                    ApplicationArea = All;
                }
                field("No.of Fixing Holes"; Rec."No.of Fixing Holes")
                {
                    ApplicationArea = All;
                }
                field("No. of Soldering Points"; Rec."No. of Soldering Points")
                {
                    ApplicationArea = All;
                }
                field("No. of Pins"; Rec."No. of Pins")
                {
                    ApplicationArea = All;
                }
                field("Reason for Pending"; Rec."Reason for Pending")
                {
                    ApplicationArea = All;
                }
            }
            group("LED Details")
            {
                Caption = 'LED Details';
                field("LED Part No."; Rec."LED Part No.")
                {
                    ApplicationArea = All;
                }
                field(Color; Rec.Color)
                {
                    ApplicationArea = All;
                }
                field("Intensity Code"; Rec."Intensity Code")
                {
                    ApplicationArea = All;
                }
                field("Intensity Value"; Rec."Intensity Value")
                {
                    ApplicationArea = All;
                }
                field("Color Code"; Rec."Color Code")
                {
                    ApplicationArea = All;
                }
                field("Color Value"; Rec."Color Value")
                {
                    ApplicationArea = All;
                }
                field("Voltage Code"; Rec."Voltage Code")
                {
                    ApplicationArea = All;
                }
                field("Voltage Value"; Rec."Voltage Value")
                {
                    ApplicationArea = All;
                }
                field("Ext Batch No"; Rec."Ext Batch No")
                {
                    ApplicationArea = All;
                }
                field("Ext Lot No"; Rec."Ext Lot No")
                {
                    ApplicationArea = All;
                }
                field("Date Code"; Rec."Date Code")
                {
                    ApplicationArea = All;
                }
                field(Date; Rec.Date)
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
            group("&Data Sheet")
            {
                Caption = '&Data Sheet';
                action("&Attachments")
                {
                    Caption = '&Attachments';
                    Image = Attach;
                    ApplicationArea = All;

                    trigger OnAction();
                    begin

                        attachment.RESET;
                        attachment.SETRANGE("Table ID", DATABASE::"Posted Inspect DatasheetHeader");
                        attachment.SETRANGE("Document No.", Rec."No.");
                        //attachment.SETRANGE("Ids Reference No.","Ids Reference No.");
                        //Attachment.SETRANGE("Document Type","Document Type");
                        PAGE.RUN(PAGE::"ESPL Attachments", attachment);
                    end;
                }
            }
        }
        area(processing)
        {
            action(Comment)
            {
                Caption = 'Comment';
                Image = Comment;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "Quality Comment Sheet";
                ApplicationArea = All;
                RunPageLink = Type = CONST("Posted Inspection Data Sheets"), "No." = FIELD("No.");
                ToolTip = 'Comment';
            }
        }
    }

    trigger OnAfterGetRecord();
    begin
        Indented_Person := '';
        PurchLineGrec.RESET;
        PurchLineGrec.SETFILTER(PurchLineGrec."Document No.", "Order No.");
        PurchLineGrec.SETFILTER(PurchLineGrec."Line No.", '%1', "Purch Line No");
        IF PurchLineGrec.FINDFIRST THEN BEGIN
            IF PurchLineGrec."Indent No." <> '' THEN BEGIN
                Indent_header.RESET;
                IF Indent_header.GET(PurchLineGrec."Indent No.") THEN
                    Indented_Person := Indent_header."User Id";
            END;
        END;
    end;

    trigger OnOpenPage();
    begin



        CALCFIELDS("Total Qty in IDS");
    end;

    var
        attachment: Record Attachments;
        Indented_Person: Code[50];
        Indent_header: Record "Indent Header";
        PurchLineGrec: Record "Purchase Line";
}

