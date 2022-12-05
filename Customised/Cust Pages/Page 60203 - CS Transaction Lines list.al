page 60203 "CS Transaction Lines list"
{
    PageType = ListPart;
    SourceTable = "CS Transaction Line";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Line No."; Rec."Line No.")
                {
                    Enabled = false;
                    StyleExpr = ItemStyleExp;
                    ApplicationArea = All;
                }
                field("Item No."; Rec."Item No.")
                {
                    Editable = RecEditable;
                    StyleExpr = ItemStyleExp;
                    ApplicationArea = All;

                    trigger OnValidate();
                    begin
                        /*
                        Item.RESET;
                        Item.SETFILTER(Item."No.","Item No.");
                        IF Item.FINDFIRST THEN
                        BEGIN
                          Description:=Item.Description;
                          UOM:= Item."Base Unit of Measure";
                          Working:= cardCalc.Cards_Calc(Item."No.",Status::Working);
                          NonWorking:= cardCalc.Cards_Calc(Item."No.",Status::"Non Working");
                        END;
                        */

                    end;
                }
                field(Description; Rec.Description)
                {
                    Enabled = false;
                    ApplicationArea = All;
                }
                field(Quantity; Rec.Quantity)
                {
                    Editable = RecEditable;
                    ApplicationArea = All;
                }
                field(UOM; Rec.UOM)
                {
                    Enabled = false;
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field(Reason; Rec.Reason)
                {
                    ApplicationArea = All;
                }
                field(Station; Rec.Station)
                {
                    ApplicationArea = All;

                    trigger OnLookup(Var Text: Text): Boolean;
                    begin
                        Header.RESET;
                        Header.SETFILTER(Header."Transaction ID", Rec."Transaction ID");
                        IF Header.FINDFIRST THEN BEGIN
                            StationGRec.RESET;
                            StationGRec.SETFILTER(StationGRec."Division code", Header."Transfer From Location");
                            IF StationGRec.FINDFIRST THEN BEGIN
                                IF PAGE.RUNMODAL(60206, StationGRec) = ACTION::LookupOK THEN
                                    Rec.Station := StationGRec."Station Code";
                            END;
                        END;
                    end;
                }
                field("Order No"; Rec."Order No")
                {
                    ApplicationArea = All;
                }
                field("Qty to be Receive"; Rec."Qty to be Receive")
                {
                    Caption = 'Qty to Receive';
                    Editable = RcvVisible;
                    //Numeric = true;
                    Visible = RcvVisible;
                    ApplicationArea = All;

                    trigger OnValidate();
                    begin
                        IF Rec."Qty to be Receive" + Rec."Qty Received" > Rec.Quantity THEN    //Added by Pranavi on 27-10-2015
                            ERROR('You can not receive more the quantity: ' + FORMAT(Rec.Quantity - Rec."Qty Received"));
                    end;
                }
                field("Qty Received"; Rec."Qty Received")
                {
                    Caption = 'Qty Received';
                    Editable = false;
                    //Numeric = true;
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
        Ledger.RESET;
        Ledger.SETFILTER(Ledger."Transaction ID", Rec."Transaction ID");
        Ledger.SETFILTER(Ledger."Line No.", '%1', Rec."Line No.");
        Ledger.SETFILTER(Ledger."Item No", Rec."Item No.");
        IF Ledger.FINDFIRST THEN BEGIN
            IF Ledger.NonReturnable THEN BEGIN
                ItemStyleExp := 'Ambiguous';
            END
            ELSE BEGIN
                ItemStyleExp := '';
            END;
        END;
        //Added by Pranavi on 27-10-2015 not to edit item and qty after posted


        Header.RESET;
        Header.GET(Rec."Transaction ID");
        IF Header."Transaction Status" = Header."Transaction Status"::"In-Transit" THEN
            RecEditable := FALSE
        ELSE
            RecEditable := TRUE;



        //End by Pranavi
    end;

    trigger OnDeleteRecord(): Boolean;
    begin
        IF Header."Transfer To Location" <> 'SERVICE' THEN
            IF NOT (USERID IN ['EFFTRONICS\SUJANI', 'EFFTRONICS\VISHNUPRIYA']) THEN BEGIN
                ERROR('You Can''t delete the Line. Contact ERP Administrator');
            END;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean;
    var
        CsTransactionLine: Record "CS Transaction Line";
    begin
    end;

    trigger OnOpenPage();
    begin
        /*
        IF  UPPERCASE(USERID) IN ['EFFTRONICS\MNRAJU','EFFTRONICS\SRIVALLI','EFFTRONICS\NAGALAKSHMI','EFFTRONICS\RAMADEVI'] THEN
        BEGIN
           RcvVisible:=TRUE;
        END
        ELSE
        BEGIN
          RcvVisible:=FALSE;
        END;
        */
        RcvVisible := TRUE;
        RecEditable := TRUE;    //pranavi

    end;

    var
        StationGRec: Record Station;
        Header: Record "CS Transaction Header";
        Item: Record Item;
        cardCalc: Page "CS Transaction Card";
        QtyToRcv: Integer;
        QtyRcvd: Integer;
        RcvVisible: Boolean;
        ItemStyleExp: Text;
        Ledger: Record "CS Stock Ledger";
        RecEditable: Boolean;
}

