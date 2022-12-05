page 50028 "Dispatch list"
{
    PageType = List;
    SourceTable = "Dispatch Details Logging";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Document No."; "Document No.")
                {
                    Editable = false;
                    Style = Unfavorable;
                    StyleExpr = CFS_Repo;
                    ApplicationArea = All;
                }
                field("Line  Number"; "Line  Number")
                {
                    Editable = false;
                    Style = Unfavorable;
                    StyleExpr = CFS_Repo;
                    ApplicationArea = All;
                }
                field("Schedule Line Number"; "Schedule Line Number")
                {
                    Editable = false;
                    Style = Unfavorable;
                    StyleExpr = CFS_Repo;
                    ApplicationArea = All;
                }
                field(Type; Type)
                {
                    Editable = false;
                    Style = Unfavorable;
                    StyleExpr = CFS_Repo;
                    ApplicationArea = All;
                }
                field("Item Number"; "Item Number")
                {
                    Editable = false;
                    Style = Unfavorable;
                    StyleExpr = CFS_Repo;
                    ApplicationArea = All;
                }
                field(Description; Description)
                {
                    Editable = false;
                    Style = Unfavorable;
                    StyleExpr = CFS_Repo;
                    ApplicationArea = All;
                }
                field(Quantity; Quantity)
                {
                    Editable = false;
                    Style = Unfavorable;
                    StyleExpr = CFS_Repo;
                    ApplicationArea = All;
                }
                field("Outstanding Quantity"; "Outstanding Quantity")
                {
                    Editable = false;
                    Style = Unfavorable;
                    StyleExpr = CFS_Repo;
                    ApplicationArea = All;
                }
                field("Quantity to Ship"; "Quantity to Ship")
                {
                    Editable = false;
                    Style = Unfavorable;
                    StyleExpr = CFS_Repo;
                    ApplicationArea = All;
                }
                field(UOM; UOM)
                {
                    ApplicationArea = All;
                }
                field(Packet; Packet)
                {
                    ApplicationArea = All;
                }
                field(SerialNoGVar; SerialNoGVar)
                {
                    Caption = 'SerialNo';
                    ApplicationArea = All;
                }
                field(ScheSerialNoGvar; ScheSerialNoGvar)
                {
                    Caption = 'LotNo';
                    ApplicationArea = All;
                }
                field(Date; Date)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Report")
            {
                ApplicationArea = All;

                trigger OnAction()
                begin
                    //MESSAGE('Reports');
                    DispatchDetailsLogging.Reset;
                    DispatchDetailsLogging.SetFilter("Document No.", GlobalVariable);
                    if DispatchDetailsLogging.FindSet then
                        REPORT.Run(14125500, true, true, DispatchDetailsLogging);
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        UpdateStyle;
        /*
        CLEAR(SerialNoGVar);
        IF "Schedule Line Number" = 0 THEN BEGIN
          TrackingSpecification.RESET;
          TrackingSpecification.SETRANGE("Source ID","Document No.");
          TrackingSpecification.SETRANGE("Source Ref. No.","Line  Number");
          TrackingSpecification.SETRANGE("Source Type",37);
          TrackingSpecification.SETRANGE("Source Subtype",TrackingSpecification."Source Subtype"::"1");
          TrackingSpecification.SETRANGE("Item No.","Item Number");
          IF TrackingSpecification.FINDSET THEN BEGIN
            REPEAT
              IF TrackingSpecification."Serial No." <>'' THEN
               SerialNoGVar += TrackingSpecification."Serial No."+',';
              IF TrackingSpecification."Lot No." <> '' THEN
               SerialNoGVar += TrackingSpecification."Lot No." + ',';
            UNTIL TrackingSpecification.NEXT = 0;
            END
           ELSE
              ReservationEntry.RESET;
              ReservationEntry.SETRANGE("Source ID","Document No.");
              ReservationEntry.SETRANGE("Source Ref. No.","Line  Number");
              ReservationEntry.SETRANGE("Source Type",37);
              ReservationEntry.SETRANGE("Source Subtype",ReservationEntry."Source Subtype"::"1");
              ReservationEntry.SETRANGE("Item No.","Item Number");
              IF ReservationEntry.FINDSET THEN
                REPEAT
                  IF ReservationEntry."Serial No." <>'' THEN
                   SerialNoGVar += ReservationEntry."Serial No."+',';
                  IF ReservationEntry."Lot No." <> '' THEN
                   SerialNoGVar += ReservationEntry."Lot No." + ',';
                UNTIL ReservationEntry.NEXT = 0;
        //END
        
        END;{
        CLEAR("Serial No.");
        CLEAR("Lot No.");
        IF "Schedule Line Number" = 0 THEN BEGIN
          TrackingSpecification.RESET;
          TrackingSpecification.SETRANGE("Source ID","Document No.");
          TrackingSpecification.SETRANGE("Source Ref. No.","Line  Number");
          TrackingSpecification.SETRANGE("Source Type",37);
          TrackingSpecification.SETRANGE("Source Subtype",TrackingSpecification."Source Subtype"::"1");
          TrackingSpecification.SETRANGE("Item No.","Item Number");
          IF TrackingSpecification.FINDSET THEN BEGIN
            REPEAT
              IF TrackingSpecification."Serial No." <>'' THEN
               SerialNoGVar += TrackingSpecification."Serial No."+',';
              IF TrackingSpecification."Lot No." <> '' THEN
               SerialNoGVar += TrackingSpecification."Lot No." + ',';
            UNTIL TrackingSpecification.NEXT = 0;
            END
           ELSE
              ReservationEntry.RESET;
              ReservationEntry.SETRANGE("Source ID","Document No.");
              ReservationEntry.SETRANGE("Source Ref. No.","Line  Number");
              ReservationEntry.SETRANGE("Source Type",37);
              ReservationEntry.SETRANGE("Source Subtype",ReservationEntry."Source Subtype"::"1");
              ReservationEntry.SETRANGE("Item No.","Item Number");
              IF ReservationEntry.FINDSET THEN
                REPEAT
                  IF ReservationEntry."Serial No." <>'' THEN
                   Rec."Serial No." += ReservationEntry."Serial No."+',';
                  IF ReservationEntry."Lot No." <> '' THEN
                   Rec."Lot No." += ReservationEntry."Lot No." + ',';
                UNTIL ReservationEntry.NEXT = 0;
        //END
        
        END;}
        //CLEAR("Serial No.");
        */
        Clear(SerialNoGVar);
        Clear(ScheSerialNoGvar);
        if "Schedule Line Number" = 0 then begin
            ReservationEntry.Reset;
            ReservationEntry.SetRange("Source ID", "Document No.");
            ReservationEntry.SetRange("Source Ref. No.", "Line  Number");
            ReservationEntry.SetRange("Source Type", 37);
            ReservationEntry.SetRange("Source Subtype", ReservationEntry."Source Subtype"::"1");
            ReservationEntry.SetRange("Item No.", "Item Number");
            if ReservationEntry.FindSet then begin
                repeat
                    if ReservationEntry."Serial No." <> '' then
                        SerialNoGVar += ReservationEntry."Serial No." + ',';
                    if ReservationEntry."Lot No." <> '' then
                        ScheSerialNoGvar += ReservationEntry."Lot No." + ',';
                until ReservationEntry.Next = 0;
            end

            else
                TrackingSpecification.Reset;
            TrackingSpecification.SetRange("Source ID", "Document No.");
            TrackingSpecification.SetRange("Source Ref. No.", "Line  Number");
            TrackingSpecification.SetRange("Source Type", 37);
            TrackingSpecification.SetRange("Source Subtype", TrackingSpecification."Source Subtype"::"1");
            TrackingSpecification.SetRange("Item No.", "Item Number");
            if TrackingSpecification.FindSet then begin
                repeat
                    if TrackingSpecification."Serial No." <> '' then
                        SerialNoGVar += TrackingSpecification."Serial No." + ',';
                    if TrackingSpecification."Lot No." <> '' then
                        ScheSerialNoGvar += TrackingSpecification."Lot No." + ',';
                until TrackingSpecification.Next = 0;
            end

        end;

        //CLEAR(ScheSerialNoGvar);
        if "Schedule Line Number" > 0 then begin
            Schedule2GRec.Reset;
            Schedule2GRec.SetRange("Document No.", "Document No.");
            Schedule2GRec.SetRange("Document Line No.", "Line  Number");
            Schedule2GRec.SetRange("Line No.", "Schedule Line Number");
            if Schedule2GRec.FindFirst then begin
                ReservationEntry.Reset;
                ReservationEntry.SetRange("Source ID", "Document No.");
                ReservationEntry.SetRange("Source Type", 60095);
                ReservationEntry.SetRange("Source Prod. Order Line", Schedule2GRec."Document Line No.");
                ReservationEntry.SetRange("Source Ref. No.", Schedule2GRec."Line No.");
                ReservationEntry.SetRange("Source Subtype", ReservationEntry."Source Subtype"::"0");
                ReservationEntry.SetRange("Item No.", Schedule2GRec."No.");
                if ReservationEntry.FindSet then
                    repeat
                        if ReservationEntry."Serial No." <> '' then
                            SerialNoGVar += ReservationEntry."Serial No." + ',';
                        if ReservationEntry."Lot No." <> '' then
                            ScheSerialNoGvar += ReservationEntry."Lot No." + ',';
                    until ReservationEntry.Next = 0;
            end;
        end;

    end;

    trigger OnOpenPage()
    begin

        //MESSAGE(GlobalVariable);

        Reset;
        SetCurrentKey("Document No.", "Line  Number", "Schedule Line Number");
        SalesLineRec.SetFilter("Document No.", GlobalVariable);
        if SalesLineRec.FindSet then
            SalesLineRec.SetFilter("No.", Item."No.");
        repeat
            DispatchDetailsLogging.Reset;
            DispatchDetailsLogging.SetFilter("Document No.", SalesLineRec."Document No.");
            DispatchDetailsLogging.SetRange("Line  Number", SalesLineRec."Line No.");
            if not (DispatchDetailsLogging.FindFirst) then begin
                Rec."Document No." := SalesLineRec."Document No.";
                Rec."Line  Number" := SalesLineRec."Line No.";
                Rec."Schedule Line Number" := 0;
                Rec."Item Number" := SalesLineRec."No.";
                Item.Reset;
                Item.SetFilter("No.", SalesLineRec."No.");
                if Item.FindFirst then
                    Rec.Make := Item.Make;
                Rec.Description := SalesLineRec.Description;
                Rec.Quantity := SalesLineRec.Quantity;
                Rec."Outstanding Quantity" := SalesLineRec."Outstanding Quantity";
                Rec."Quantity to Ship" := SalesLineRec."Qty. to Ship";
                Rec.Type := SalesLineRec.Type;
                Rec.UOM := SalesLineRec."Unit of Measure";
                Insert;
            end;
        until SalesLineRec.Next = 0;
        Schedule2.SetFilter("Document No.", GlobalVariable);
        if Schedule2.FindSet then
            Schedule2.SetFilter("No.", Item."No.");
        repeat
            DispatchDetailsLogging.Reset;
            DispatchDetailsLogging.SetFilter("Document No.", Schedule2."Document No.");
            DispatchDetailsLogging.SetRange("Line  Number", Schedule2."Document Line No.");
            DispatchDetailsLogging.SetRange("Schedule Line Number", Schedule2."Line No.");
            if not (DispatchDetailsLogging.FindFirst) then begin
                Rec."Document No." := Schedule2."Document No.";
                Rec."Line  Number" := Schedule2."Document Line No.";
                Rec."Schedule Line Number" := Schedule2."Line No.";
                Rec."Item Number" := Schedule2."No.";
                Rec.Description := Schedule2.Description;
                Item.Reset;
                Item.SetFilter("No.", Schedule2."No.");
                if Item.FindFirst then
                    Rec.Make := Item.Make;
                Rec.Quantity := Schedule2.Quantity;
                Rec."Outstanding Quantity" := Schedule2."Outstanding Qty.";
                Rec."Quantity to Ship" := Schedule2."Qty. to Ship";
                Rec.UOM := Schedule2."Unit of Measure Code";
                if Schedule2.Type = Schedule2.Type::Item then
                    Rec.Type := Rec.Type::Item
                else
                    if Schedule2.Type = Schedule2.Type::"G/l Account" then
                        Rec.Type := Rec.Type::"G/L Account";
                if Schedule2."Line No." <> Schedule2."Document Line No." then
                    Insert;
            end;
        until Schedule2.Next = 0;

        SetFilter("Document No.", GlobalVariable);
    end;

    var
        Schedule2: Record Schedule2;
        SalesHeader: Record "Sales Header";
        SalesLineRec: Record "Sales Line";
        SalesLineRec2: Record "Sales Line";
        GlobalVariable: Code[20];
        ReserveSalesLine: Codeunit "Sales Line-Reserve";
        Item: Record Item;
        [InDataSet]
        CFS_Repo: Boolean;
        DispatchDetailsLogging: Record "Dispatch Details Logging";
        SerialNoGVar: Text[1024];
        ScheSerialNoGvar: Text[1024];
        Schedule2GRec: Record Schedule2;
        TrackingSpecification: Record "Tracking Specification";
        ReservationEntry: Record "Reservation Entry";
        Date: Text[250];
        ByMode: Text[250];

    [Scope('Internal')]
    procedure SetValues(MyVariable: Code[20])
    begin
        GlobalVariable := MyVariable;
    end;

    local procedure UpdateStyle()
    begin
        if "Schedule Line Number" = 0 then
            CFS_Repo := true
        else
            CFS_Repo := false;
    end;
}

