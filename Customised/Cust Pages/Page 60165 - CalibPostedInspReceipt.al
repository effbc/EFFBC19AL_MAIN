page 60165 CalibPostedInspReceipt
{
    // version Cal1.0,Rev01

    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = Document;
    SourceTable = "Inspection Receipt Header";
    SourceTableView = WHERE(Status = FILTER(true));

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("No."; Rec."No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Item No."; Rec."Item No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Item Description"; Rec."Item Description")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Unit Of Measure Code"; Rec."Unit Of Measure Code")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Quantity; Rec.Quantity)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Spec ID"; Rec."Spec ID")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Document Date"; Rec."Document Date")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Rework Reference No."; Rec."Rework Reference No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Rework Inspect DS Created"; Rec."Rework Inspect DS Created")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Source Type"; Rec."Source Type")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Spec Version"; Rec."Spec Version")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Lot No."; Rec."Lot No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
            }
            part(Control1000000032; "Inpection Receipt Line")
            {
                Editable = false;
                SubPageLink = "Document No." = FIELD("No."), "Purch Line No." = FIELD("Purch Line No");
                ApplicationArea = All;
            }
            group(Calibration)
            {
                Caption = 'Calibration';
                field("Vendor No."; "Vendor No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Vendor Name"; "Vendor Name")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Address; Address)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Address 2"; "Address 2")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Contact Person"; "Contact Person")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Calibration Status"; "Calibration Status")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Results; Results)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Recommendations; Recommendations)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Calibration Party"; "Calibration Party")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Resource; Resource)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Eqpt. Serial No."; "Eqpt. Serial No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Department; Department)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Std. Reference"; "Std. Reference")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("IDS Posted By"; "IDS Posted By")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("IR Posted By"; "IR Posted By")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Model No."; "Model No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Receipt")
            {
                Caption = '&Receipt';
                action(List)
                {
                    Caption = 'List';
                    Image = EditList;
                    RunObject = Page "Calib Inspection Receipt List";
                    RunPageLink = "Source Type" = CONST(Calibration);
                    ShortCutKey = 'F5';
                    ApplicationArea = All;
                }
                action("Posted &Inspect. DS Details")
                {
                    Caption = 'Posted &Inspect. DS Details';
                    Image = PostedServiceOrder;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Posted Inspect. DS Details";
                    RunPageLink = "Inspection Receipt No." = FIELD("No.");
                    ApplicationArea = All;
                }
            }
        }
        area(processing)
        {
            action("&Print")
            {
                Caption = '&Print';
                Ellipsis = true;
                Image = Print;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction();
                begin
                    InspectRcpt.SETRANGE(InspectRcpt."No.", "No.");
                    REPORT.RUN(33000254, TRUE, FALSE, InspectRcpt);
                    InspectRcpt.SETRANGE(InspectRcpt."No.");
                end;
            }
        }
    }

    var
        ProdOrderInspectRtng: Record "Ins Prod. Order Routing Line";
        ProdOrderComp: Record "Prod. Order Inspect Component";
        InspectReceipt: Codeunit "Inspection Data Sheets";
        InspectJnlPostLine: Codeunit "Inspection Jnl.-Post Line";
        InspectRcpt: Record "Inspection Receipt Header";
        QualityType: Option Accepted,"Accepted Under Deviation",Rework,Rejected;
        DeliveryReceiptEntry: Record "Delivery/Receipt Entry";
}

