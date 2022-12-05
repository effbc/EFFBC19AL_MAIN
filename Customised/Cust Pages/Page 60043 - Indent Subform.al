page 60043 "Indent Subform"
{
    // version B2B1.0,POAU

    AutoSplitKey = true;
    PageType = ListPart;
    SaveValues = true;
    SourceTable = "Indent Line";

    layout
    {
        area(content)
        {
            repeater(Control1102152000)
            {
                ShowCaption = false;
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                }
                field("Line No."; Rec."Line No.")
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
                field("Unit of Measure"; Rec."Unit of Measure")
                {
                    ApplicationArea = All;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                }
                field("Delivery Location"; Rec."Delivery Location")
                {
                    ApplicationArea = All;
                }
                field("Store Qty"; Rec."Store Qty")
                {
                    ApplicationArea = All;
                }
                field(Make; Rec.Make)
                {
                    ApplicationArea = All;
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = All;
                }
                field("Purchase Remarks"; Rec."Purchase Remarks")
                {
                    ApplicationArea = All;
                }
                field("Indent Status"; Rec."Indent Status")
                {
                    Editable = "Indent StatusEditable";
                    Enabled = "Indent StatusEnable";
                    ApplicationArea = All;
                }
                field("ICN No."; Rec."ICN No.")
                {
                    ApplicationArea = All;
                }
                field("Sale Order No."; Rec."Sale Order No.")
                {
                    ApplicationArea = All;
                }
                field("Part Number"; Rec."Part Number")
                {
                    ApplicationArea = All;
                }
                field("Suitable Vendor"; Rec."Suitable Vendor")
                {
                    ApplicationArea = All;
                }
                field("Unit Cost"; Rec."Unit Cost")
                {
                    ApplicationArea = All;
                }
                field("G/L Account"; Rec."G/L Account")
                {
                    ApplicationArea = All;
                }
                field("Production Order"; Rec."Production Order")
                {
                    ApplicationArea = All;
                }
                field("Production Order Line No."; Rec."Production Order Line No.")
                {
                    ApplicationArea = All;
                }
                field("Production Start date"; Rec."Production Start date")
                {
                    ApplicationArea = All;
                }
                field("Purchase Order Number"; Rec."Purchase Order Number")
                {
                    ApplicationArea = All;
                }
                field("Purchase Order Line Number"; Rec."Purchase Order Line Number")
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
        IndentStatusOnFormat;
    end;

    trigger OnInit();
    begin
        "Indent StatusEnable" := TRUE;
        "Indent StatusEditable" := TRUE;
    end;

    var
        IndentHeader: Record "Indent Header";
        [InDataSet]
        "Indent StatusEditable": Boolean;
        [InDataSet]
        "Indent StatusEnable": Boolean;


    local procedure IndentStatusOnInputChange(var Text: Text[1024]);
    begin
        IF FORMAT(Rec."Indent Status") = 'Cancel' THEN
            Rec.TESTFIELD(Remarks);

        IF (USERID <> '07TE024') AND (USERID <> 'SUPER') AND (USERID <> '10RD010') THEN BEGIN
            IF FORMAT(Rec."Indent Status") = 'Order' THEN
                ERROR('You are Changing the Indent Status Which has Ordered');
        END;
    end;


    local procedure IndentStatusOnFormat();
    begin
        IF ((USERID<>'EFFTRONICS\RENUKACH') AND  (USERID<>'EFFTRONICS\GRAVI') AND  (USERID<>'EFFTRONICS\BRAHMAIAH') AND (USERID<>'EFFTRONICS\PADMASRI') AND
          (USERID<>'EFFTRONICS\DURGAMAHESWARI')  AND (USERID<>'EFFTRONICS\PARDHU') AND  (USERID<>'EFFTRONICS\ANILKUMAR')AND (USERID<>'EFFTRONICS\PRANAVI') AND (USERID<>'EFFTRONICS\VIJAYA')AND (USERID<>'EFFTRONICS\JHANSI')) THEN
      BEGIN
            "Indent StatusEditable" := FALSE;
            //CurrForm."Indent Status".VISIBLE:=FALSE;
            "Indent StatusEnable" := FALSE;
        END ELSE BEGIN
            "Indent StatusEditable" := TRUE;
            //CurrForm."Indent Status".VISIBLE:=FALSE;
            "Indent StatusEnable" := TRUE;
        END;
    end;
}

