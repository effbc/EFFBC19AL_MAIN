page 60256 "Convert Sale Order"
{
    PageType = Card;
    SourceTable = "Production Order";

    layout
    {
        area(content)
        {
            group(Present)
            {
                field("No."; Rec."No.")
                {
                    Editable = false;
                    TableRelation = "Production Order"."No." WHERE(Status = CONST(Released));
                    ApplicationArea = All;
                }
                field("RPO Range"; RPOList)
                {
                    Caption = 'RPO Range';
                    TableRelation = "Production Order"."No." WHERE(Status = CONST(Released));
                    Visible = true;
                    ApplicationArea = All;

                    trigger OnValidate();
                    begin
                        MESSAGE(RPOList);
                        IF (RPOList = '') OR (RPOList = ' ') THEN
                            RPOList := "No.";
                    end;
                }
                field("Sales Order No"; PrevSO)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Sales Order Line No"; PrevSOL)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Schedule Line No"; PrevSchLNo)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Source Type"; PrevST)
                {
                    Editable = false;
                    ApplicationArea = All;

                    trigger OnValidate();
                    begin
                        //NewSourceType := "Source Type";
                    end;
                }
                field("Source No"; PrevSorceNo)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Quantity; PrevQty)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
            }
            group("To RPOs")
            {
                Visible = RPOListVisible;
                field("TO RPO Range"; ToRPOList)
                {
                    Caption = 'RPO Range';
                    TableRelation = "Production Order"."No." WHERE(Status = CONST(Released));
                    ApplicationArea = All;

                    trigger OnValidate();
                    begin
                        To_Prod_Order.RESET;
                        To_Prod_Order.SETCURRENTKEY(Status, "No.");
                        IF Status = Status::Released THEN
                            To_Prod_Order.SETFILTER(To_Prod_Order.Status, '%1', To_Prod_Order.Status::Released)
                        ELSE
                            IF Status = Status::Finished THEN
                                To_Prod_Order.SETFILTER(To_Prod_Order.Status, '%1', To_Prod_Order.Status::Finished);
                        To_Prod_Order.SETFILTER(To_Prod_Order."No.", ToRPOList);
                        IF To_Prod_Order.FINDSET THEN
                            REPEAT
                                ToQty := ToQty + To_Prod_Order.Quantity;
                                ToSOrderno := To_Prod_Order."Sales Order No.";
                                ToSOrderLineNo := To_Prod_Order."Sales Order Line No.";
                                ToScheduleLineNo := To_Prod_Order."Schedule Line No.";
                                ToSourceNo := To_Prod_Order."Source No.";
                            UNTIL To_Prod_Order.NEXT = 0;
                    end;
                }
                field("To Sale Order No"; ToSOrderno)
                {
                    Caption = 'Sale Order No';
                    Editable = false;
                    ApplicationArea = All;
                }
                field("To Sale Order Line No"; ToSOrderLineNo)
                {
                    Caption = 'Sale Order Line No';
                    Editable = false;
                    ApplicationArea = All;
                }
                field("To Schedule Line No"; ToScheduleLineNo)
                {
                    Caption = 'Schedule Line No';
                    Editable = false;
                    ApplicationArea = All;
                }
                field("To Source No"; ToSourceNo)
                {
                    Caption = 'To Source No';
                    Editable = false;
                    ApplicationArea = All;
                }
                field("To Quantity"; ToQty)
                {
                    Caption = 'To Quantity';
                    Editable = false;
                    ApplicationArea = All;
                }
            }
            group(New)
            {
                field("Sales Order No1"; "Sales Order No.")
                {
                    Caption = 'New Sales Order No';
                    Editable = true;
                    ApplicationArea = All;

                    trigger OnValidate();
                    begin
                        IF "Sales Order No." <> xRec."Sales Order No." THEN BEGIN
                            Changed := TRUE;
                            //  MESSAGE('order no changed!');
                            "Sales Order Line No." := 0;
                            "Schedule Line No." := 0;
                            //"Source No." := '';
                        END;
                    end;
                }
                field("Sales Order Line No1"; "Sales Order Line No.")
                {
                    Caption = 'New Sales Order Line No';
                    Editable = true;
                    ApplicationArea = All;

                    trigger OnValidate();
                    begin
                        //IF "Sales Order Line No." <> xRec."Sales Order Line No." THEN
                        //BEGIN

                        SL.RESET;
                        SL.SETFILTER(SL."Document No.", "Sales Order No.");
                        SL.SETFILTER(SL."Line No.", '%1', "Sales Order Line No.");
                        IF SL.FINDFIRST THEN BEGIN
                            IF FORMAT(SL."Pending By") IN ['R&D', 'Sales', 'LMD', 'Customer', 'Purchase', 'CUS'] THEN
                                ERROR('You can not select ' + SL."No." + 'as it is pending by: ' + FORMAT(SL."Pending By"));
                            NewSorceNo := SL."No.";
                            //"Source No." := SL."No.";
                        END;
                        "Schedule Line No." := 0;
                        Changed := TRUE;
                        //  MESSAGE('order line no changed!');
                        //END;
                    end;
                }
                field("Schedule Line No1"; "Schedule Line No.")
                {
                    Caption = 'New Schedule Line No';
                    ApplicationArea = All;

                    trigger OnValidate();
                    begin
                        IF "Schedule Line No." <> xRec."Schedule Line No." THEN BEGIN
                            Schedule2.RESET;                            //Added by Pranavi on 06-09-2015
                            Schedule2.SETFILTER(Schedule2."Document No.", "Sales Order No.");
                            Schedule2.SETFILTER(Schedule2."Document Line No.", '%1', "Sales Order Line No.");
                            Schedule2.SETFILTER(Schedule2."Line No.", '%1', "Schedule Line No.");
                            IF Schedule2.FINDFIRST THEN BEGIN
                                //"Source No." := Schedule2."No.";
                                // Added by Pranavi on 20-Feb-2016 for not allowing to select default schedule line no.
                                IF Schedule2."Line No." = Schedule2."Document Line No." THEN BEGIN
                                    SLt.RESET;
                                    SLt.SETRANGE(SLt."Document No.", Schedule2."Document No.");
                                    SLt.SETRANGE(SLt."Line No.", Schedule2."Document Line No.");
                                    IF SLt.FINDFIRST THEN BEGIN
                                        IF Schedule2."No." = SLt."No." THEN
                                            ERROR('You cannot select this schedule line no.!\As it is default Line!');
                                    END;
                                END;
                                // End by Pranavi
                                NewSorceNo := Schedule2."No.";
                            END;
                            Changed := TRUE;
                        END;
                    end;
                }
                field("Source Type1"; "Source Type")
                {
                    CaptionML = ENU = 'New Source Type',
                                ENN = 'Source Type';
                    Editable = false;
                    ApplicationArea = All;

                    trigger OnValidate();
                    begin
                        //NewSourceType := "Source Type";
                        IF "Source Type" <> xRec."Source Type" THEN BEGIN
                            Changed := TRUE;
                            //  MESSAGE('source type changed!');
                        END;
                    end;
                }
                field("Source No1"; NewSorceNo)
                {
                    CaptionML = ENU = 'New Source No.',
                                ENN = 'Source No.';
                    Editable = false;
                    ApplicationArea = All;

                    trigger OnValidate();
                    begin
                        IF xRec."Source No." <> "Source No." THEN BEGIN
                            Changed := TRUE;
                            //  MESSAGE('source no changed!');
                        END;
                    end;
                }
                field(Quantity1; Quantity)
                {
                    CaptionML = ENU = 'New Quantity',
                                ENN = 'Quantity';
                    Editable = QTYEDIT;
                    ApplicationArea = All;

                    trigger OnValidate();
                    begin


                        IF Quantity <> xRec.Quantity THEN BEGIN
                            Changed := TRUE;
                            //  MESSAGE('quantity changed!');
                        END;
                    end;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group(Action1102152015)
            {
                action(Convert)
                {
                    Caption = 'Convert Order';
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        //Added By Pranavi On 23-09-2015 to restrict Source No picking if sale order qty is already RPO generated.
                        test := '';
                        TotRPOQty := 0;
                        IF CONFIRM('Are Sure, You Want to Convert the Order!', FALSE) THEN BEGIN
                            IF ToRPOList = '' THEN BEGIN
                                IF "Sales Order No." = '' THEN
                                    ERROR('Please select Sale Order No.!');
                                IF "Sales Order Line No." = 0 THEN
                                    ERROR('Please select Sale Order Line Number!');
                                IF "Source No." = '' THEN
                                    ERROR('Please select Source No.!');
                                IF (RPOList = '') OR (RPOList = ' ') THEN
                                    ERROR('Please select RPO Range No.!');
                                Prod_Order.RESET;
                                Prod_Order.SETFILTER(Prod_Order."Sales Order No.", "Sales Order No.");
                                Prod_Order.SETFILTER(Prod_Order."Sales Order Line No.", '%1', "Sales Order Line No.");
                                Prod_Order.SETFILTER(Prod_Order."Source No.", "Source No.");
                                IF STRLEN(RPOList) >= STRLEN("No.") THEN BEGIN
                                    // Prod_Order.SETFILTER(Prod_Order."No.",'<>%1',RPOList);
                                    Prod_Order.SETFILTER(Prod_Order."No.", '<>%1', "No.");
                                    Prod_OrderList.RESET;
                                    Prod_OrderList.SETFILTER(Prod_OrderList."No.", RPOList);
                                    IF Prod_OrderList.FINDSET THEN
                                        REPEAT
                                            QtyList := QtyList + Prod_OrderList.Quantity;
                                        UNTIL Prod_OrderList.NEXT = 0;
                                END
                                ELSE
                                    Prod_Order.SETFILTER(Prod_Order."No.", '<>%1', "No.");
                                IF Prod_Order.FINDSET THEN
                                    REPEAT
                                        TotRPOQty := TotRPOQty + Prod_Order.Quantity;
                                    //    test := test+Prod_Order."No.";
                                    UNTIL Prod_Order.NEXT = 0;
                                //  MESSAGE(FORMAT(TotRPOQty)+'\'+test);
                                /* SalesLine.RESET;
                                 SalesLine.SETFILTER(SalesLine."Document No.","Sales Order No.");
                                 SalesLine.SETFILTER(SalesLine."Line No.",'%1',"Sales Order Line No.");
                                 SalesLine.SETFILTER(SalesLine."No.","Source No.");
                                 IF SalesLine.FINDFIRST THEN
                                 BEGIN  *///commented by pranavi
                                IF STRLEN(RPOList) >= STRLEN("No.") THEN BEGIN
                                    /*  IF SalesLine.Quantity < TotRPOQty+QtyList THEN
                                        ERROR('You can not select the Item'+"Source No."+'as already RPO completed for Sale Order Quantity:'+FORMAT(SalesLine.Quantity)+'\ in sale Order: '+SalesLine."Document No.")
                                      ELSE    */
                                    BEGIN
                                        //Multiple RPO changes
                                        Prod_OrderList.RESET;
                                        Prod_OrderList.SETFILTER(Prod_OrderList."No.", RPOList);
                                        IF Prod_OrderList.FINDSET THEN
                                            REPEAT
                                                Prod_OrderList."Sales Order No." := "Sales Order No.";
                                                Prod_OrderList."Sales Order Line No." := "Sales Order Line No.";
                                                Prod_OrderList."Schedule Line No." := "Schedule Line No.";
                                                Prod_OrderList."Source Type" := "Source Type";
                                                IF Prod_OrderList."Source No." <> NewSorceNo THEN
                                                    Prod_OrderList."Source No." := NewSorceNo;
                                                Prod_OrderList.Refreshdate := 0D;
                                                Prod_OrderList.MODIFY;
                                            UNTIL Prod_OrderList.NEXT = 0;
                                        Changed := FALSE;
                                    END;
                                END     //len Compare_end
                                ELSE BEGIN
                                    /* IF SalesLine.Quantity < TotRPOQty+Quantity THEN
                                       ERROR('You can not select the Item'+"Source No."+'as already RPO completed for Sale Order Quantity:'+FORMAT(SalesLine.Quantity)+'\ in sale Order: '+SalesLine."Document No.")
                                     ELSE      */
                                    BEGIN
                                        //Multiple RPO changes
                                        Prod_OrderList.RESET;
                                        Prod_OrderList.SETFILTER(Prod_OrderList."No.", RPOList);
                                        IF Prod_OrderList.FINDSET THEN
                                            REPEAT
                                                Prod_OrderList."Sales Order No." := "Sales Order No.";
                                                Prod_OrderList."Sales Order Line No." := "Sales Order Line No.";
                                                Prod_OrderList."Schedule Line No." := "Schedule Line No.";
                                                Prod_OrderList."Source Type" := "Source Type";
                                                IF Prod_OrderList."Source No." <> NewSorceNo THEN
                                                    Prod_OrderList."Source No." := NewSorceNo;
                                                Prod_OrderList.Refreshdate := 0D;
                                                Prod_OrderList.MODIFY;
                                            UNTIL Prod_OrderList.NEXT = 0;
                                        Changed := FALSE;
                                    END;
                                END;
                                //  END;  //SalesLine_End
                            END  //If_ToRPOList_End
                            ELSE BEGIN

                            END;
                        END; //confirm_end
                        //End By Pranavi

                    end;
                }
            }
        }
    }

    trigger OnClosePage();
    begin
        //MESSAGE('closing!\'+FORMAT(Changed));
    end;

    trigger OnOpenPage();
    begin
        //By Pranavi on 24-09-2015 for sale order conversion in RPO
        Changed := FALSE;
        PrevSO := "Sales Order No.";
        PrevSOL := "Sales Order Line No.";
        PrevST := "Source Type";
        PrevSorceNo := "Source No.";
        PrevQty := Quantity;
        PrevSchLNo := "Schedule Line No.";
        NewSorceNo := "Source No.";
        IF USERID = 'EFFTRONICS\SUJANI' THEN
            RPOListVisible := TRUE
        ELSE
            RPOListVisible := FALSE;
        RPOList := "No.";

        IF USERID IN ['EFFTRONICS\VSNGEETHA', 'EFFTRONICS\SARDHAR', 'EFFTRONICS\VISHNUPRIYA', 'EFFTRONICS\PKOTESWARARAO'] THEN
            QTYEDIT := TRUE
        ELSE
            QTYEDIT := FALSE;
    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean;
    begin
        IF Changed THEN BEGIN
            "Sales Order No." := PrevSO;
            "Sales Order Line No." := PrevSOL;
            "Schedule Line No." := PrevSchLNo;
            "Source Type" := PrevST;
            "Source No." := PrevSorceNo;
            Quantity := PrevQty;
            MODIFY;
        END;
    end;

    var
        NewSaleOrderNo: Code[20];
        NewSaleOrderLineNo: Integer;
        NewSourceType: Option Item,Family,"Sales Header";
        NewSourceNo: Code[20];
        NewQuantity: Decimal;
        SH: Record "Sales Header";
        SL: Record "Sales Line";
        Changed: Boolean;
        PrevSO: Code[20];
        PrevSOL: Integer;
        PrevST: Enum "Prod. Order Source Type";
        PrevSorceNo: Code[20];
        PrevQty: Decimal;
        TotRPOQty: Decimal;
        SalesLine: Record "Sales Line";
        Prod_Order: Record "Production Order";
        PrevSchLNo: Integer;
        test: Text;
        NewSorceNo: Code[20];
        RPOList: Code[1000];
        RPOListVisible: Boolean;
        RPrevSO: Code[20];
        RPrevSOL: Integer;
        RPrevST: Option Item,Family,"Sales Header";
        RPrevSorceNo: Code[20];
        RPrevQty: Decimal;
        RNewSaleOrderNo: Code[20];
        RNewSaleOrderLineNo: Integer;
        RNewSourceType: Option Item,Family,"Sales Header";
        RNewSourceNo: Code[20];
        RNewQuantity: Decimal;
        RNewSorceNo: Code[20];
        RPrevSchLNo: Integer;
        Prod_OrderList: Record "Production Order";
        QtyList: Decimal;
        Schedule2: Record Schedule2;
        ToRPOList: Code[1000];
        ToSOrderno: Code[25];
        ToSOrderLineNo: Integer;
        ToScheduleLineNo: Integer;
        ToSourceNo: Code[30];
        ToQty: Decimal;
        To_Prod_Order: Record "Production Order";
        SLt: Record "Sales Line";
        QTYEDIT: Boolean;
}

