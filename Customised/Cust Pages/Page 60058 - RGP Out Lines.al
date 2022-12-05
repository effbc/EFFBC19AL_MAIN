page 60058 "RGP Out Lines"
{
    // version B2B1.0,Cal1.0

    AutoSplitKey = true;
    PageType = ListPart;
    SourceTable = "RGP Out Line";

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                ShowCaption = false;
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Inspection Receipt PO."; Rec."Inspection Receipt PO.")
                {
                    ApplicationArea = All;
                }
                field("Inspection Receipt No."; Rec."Inspection Receipt No.")
                {
                    ApplicationArea = All;
                }
                field("Vendor Shipment No."; Rec."Vendor Shipment No.")
                {
                    ApplicationArea = All;
                }
                field(UOM; Rec.UOM)
                {
                    ApplicationArea = All;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                }
                field("Production Order"; Rec."Production Order")
                {
                    ApplicationArea = All;
                }
                field("Drawing No."; Rec."Drawing No.")
                {
                    ApplicationArea = All;
                }
                field("Operation No."; Rec."Operation No.")
                {
                    ApplicationArea = All;
                }
                field("Routing No."; Rec."Routing No.")
                {
                    ApplicationArea = All;
                }
                field("Production Order Line No."; Rec."Production Order Line No.")
                {
                    ApplicationArea = All;
                }
                field("Op No."; Rec."Op No.")
                {
                    ApplicationArea = All;
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = All;
                }
                field("RET/NRET"; Rec."RET/NRET")
                {
                    ApplicationArea = All;
                }
                field("Material Group"; Rec."Material Group")
                {
                    ApplicationArea = All;
                }
                field("S.L.No."; Rec."S.L.No.")
                {
                    ApplicationArea = All;
                }
                field(Purpose; Rec.Purpose)
                {
                    ApplicationArea = All;
                }
                field("DC No."; Rec."DC No.")
                {
                    ApplicationArea = All;
                }
                field("Mode of Transport"; Rec."Mode of Transport")
                {
                    ApplicationArea = All;
                }
                field("Sent-to-Person"; Rec."Sent-to-Person")
                {
                    ApplicationArea = All;
                }
                field("Exp.Incurred"; Rec."Exp.Incurred")
                {
                    ApplicationArea = All;
                }
                field("Inform-to-Person"; Rec."Inform-to-Person")
                {
                    ApplicationArea = All;
                }
                field("Inform-to-Date"; Rec."Inform-to-Date")
                {
                    ApplicationArea = All;
                }
                field("Expected Return Date"; Rec."Expected Return Date")
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

