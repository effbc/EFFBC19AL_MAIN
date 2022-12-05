pageextension 70080 ItemJournalExt extends 40
{
    Editable = true;
    layout
    {
        /* modify(Control22)
        {
           ShowCaption=false;
        }
        modify(Control1900669001)
        {
            ShowCaption = false;
        } */
        modify("Entry Type")
        {
            trigger OnBeforeValidate()
            begin
                // Added by Rakesh to give Postive Adjustment rights for CSM
                IF UPPERCASE(USERID) IN ['EFFTRONICS\SRIVALLI'] THEN
                    IF (Rec."Journal Batch Name" <> 'POS-CS-SIG') OR (Rec."Entry Type" <> Rec."Entry Type"::"Positive Adjmt.") THEN
                        ERROR('You have only on Batch Name: POS-CS-SIG and Entry Type: Positive Adjmt.');
                //End by Rakesh
            end;
        }
        addafter("Entry Type")
        {
            field("Line No."; Rec."Line No.")
            {
                ApplicationArea = All;
            }
        }
        addafter("Variant Code")
        {
            field("Serial No."; Rec."Serial No.")
            {
                Visible = false;
                ApplicationArea = All;
            }
            field("Lot No."; Rec."Lot No.")
            {
                Visible = false;
                ApplicationArea = All;
            }
        }
        addafter("Item Description")
        {
            field(Tot_Qty; Tot_Qty)
            {
                ApplicationArea = All;
            }
            field(WorkDate; WORKDATE)
            {
                Editable = false;
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        modify(Dimensions)
        {
            Promoted = true;
        }
        modify(ItemTrackingLines)
        {
            Promoted = true;
        }
        modify("Ledger E&ntries")
        {
            Promoted = false;
        }
        modify("E&xplode BOM")
        {
            Promoted = true;
        }

        modify("&Get Standard Journals")
        {
            Promoted = true;
        }
        modify(Post)
        {
            Promoted = true;
            PromotedIsBig = true;
            trigger OnBeforeAction()
            begin
               IF NOT (USERID IN['EFFTRONICS\ANILKUMAR','EFFTRONICS\GRAVI','EFFTRONICS\VISHNUPRIYA','EFFTRONICS\SRIVALLI','EFFTRONICS\SUJANI','EFFTRONICS\DINEEL','EFFTRONICS\TULASI','EFFTRONICS\KRATNABABU','EFFTRONICS\SUVARCHALADEVI','EFFTRONICS\TPRIYANKA']) THEN  // Added by Pranavi on 20-07-2017
                    ERROR('Temperarily Item Adjustments are not permitted!\Contact ERP Team!');

                Ite_Jnl_Line.SETFILTER(Ite_Jnl_Line."Journal Batch Name", Rec."Journal Batch Name");
                IF Ite_Jnl_Line.FINDSET THEN
                    REPEAT
                        reservationEntry.RESET;
                        reservationEntry.SETCURRENTKEY(reservationEntry."Item No.", reservationEntry."Variant Code", reservationEntry."Location Code",
                                                       reservationEntry."Source Type", reservationEntry."Source Subtype",
                                                       reservationEntry."Reservation Status", reservationEntry."Expected Receipt Date");
                        reservationEntry.SETRANGE(reservationEntry."Item No.", Ite_Jnl_Line."Item No.");
                        // reservationEntry.SETRANGE(reservationEntry."Location Code",'CS');
                        reservationEntry.SETFILTER(reservationEntry."Source Type", '83');
                        reservationEntry.SETRANGE(reservationEntry."Source ID", 'Item');
                        reservationEntry.SETRANGE(reservationEntry."Source Batch Name", 'POS-CS-SIG');
                        IF reservationEntry.FINDSET THEN
                            REPEAT
                                IF Item.GET(Ite_Jnl_Line."Item No.") THEN BEGIN
                                    IF Item."Item Tracking Code" <> 'LOT' THEN BEGIN
                                        "ITEMLEDGER ENTRY".SETCURRENTKEY("Item No.", Open, "Variant Code", Positive, "Expiration Date", "Lot No.", "Serial No.");
                                        "ITEMLEDGER ENTRY".SETFILTER("ITEMLEDGER ENTRY"."Item No.", Ite_Jnl_Line."Item No.");
                                        "ITEMLEDGER ENTRY".SETFILTER("ITEMLEDGER ENTRY"."Serial No.", reservationEntry."Serial No.");
                                        "ITEMLEDGER ENTRY".SETFILTER("ITEMLEDGER ENTRY"."Remaining Quantity", '>%1', 0);
                                        IF "ITEMLEDGER ENTRY".FINDFIRST THEN BEGIN
                                            //   MESSAGE(FORMAT("ITEMLEDGER ENTRY"."Entry No."));
                                            ERROR(Ite_Jnl_Line."Item No." + ' with Serial No.' + FORMAT(reservationEntry."Serial No.") + ' Ledger Entry All Ready Exists');
                                        END;
                                        /* ELSE BEGIN
                                              Srev_item.RESET;
                                              Srev_item.SETCURRENTKEY(Srev_item."Item No.", Srev_item."Serial No.");
                                              Srev_item.SETRANGE(Srev_item."Item No.", Ite_Jnl_Line."Item No.");
                                              Srev_item.SETRANGE(Srev_item."Serial No.", reservationEntry."Serial No.");
                                              IF Srev_item.FINDFIRST THEN
                                                  ERROR(Ite_Jnl_Line."Item No." + ' with Serial No.' + FORMAT(reservationEntry."Serial No.") + ' Service Item All Ready Exists');
                                          END; */
                                    END;
                                END;
                            UNTIL reservationEntry.NEXT = 0;
                    UNTIL Ite_Jnl_Line.NEXT = 0;


               IF UPPERCASE(USERID) IN['EFFTRONICS\NAGALAKSHMI','EFFTRONICS\RATNA','EFFTRONICS\DMADHAVI','EFFTRONICS\PADMASRI','EFFTRONICS\SRIVALLI','EFFTRONICS\SUVARCHALADEVI','EFFTRONICS\TPRIYANKA',
                                                       'EFFTRONICS\GRAVI','EFFTRONICS\SUJANI','EFFTRONICS\ANILKUMAR','EFFTRONICS\BHAVANIP','EFFTRONICS\RAMADEVI','EFFTRONICS\VISHNUPRIYA','EFFTRONICS\DINEEL','EFFTRONICS\TULASI','EFFTRONICS\KRATNABABU'] THEN begin
                    Ite_Jnl_Line.RESET;
                    Ite_Jnl_Line.SETFILTER(Ite_Jnl_Line."Journal Batch Name", Rec."Journal Batch Name");
                    IF Ite_Jnl_Line.FINDSET THEN
                        REPEAT
                            IF Item.GET(Ite_Jnl_Line."Item No.") THEN;
                        UNTIL Ite_Jnl_Line.NEXT = 0;
                end;
            end;

            trigger OnAfterAction()
            begin

                // Added by Rakesh for postive adjust for Customer cards on 16-Aug-14

                IF UPPERCASE(USERID) IN ['EFFTRONICS\RAMADEVI'] THEN //  Srivalli mam restirections moved to Ramadevi Mam on 29-01-2018
           BEGIN
                    IF (Rec."Journal Batch Name" <> 'POS-CS-SIG') OR (Rec."Entry Type" <> Rec."Entry Type"::"Positive Adjmt.") THEN
                        ERROR('You have only on Batch Name: POS-CS-SIG and Entry Type: Positive Adjmt.');

                    Ite_Jnl_Line.RESET;
                    Ite_Jnl_Line.SETFILTER(Ite_Jnl_Line."Journal Batch Name", Rec."Journal Batch Name");
                    IF Ite_Jnl_Line.FINDSET THEN
                        REPEAT
                            reservationEntry.RESET;
                            reservationEntry.SETCURRENTKEY(reservationEntry."Item No.", reservationEntry."Variant Code", reservationEntry."Location Code",
                                                           reservationEntry."Source Type", reservationEntry."Source Subtype",
                                                           reservationEntry."Reservation Status", reservationEntry."Expected Receipt Date");
                            reservationEntry.SETRANGE(reservationEntry."Item No.", Ite_Jnl_Line."Item No.");
                            // reservationEntry.SETRANGE(reservationEntry."Location Code",'CS');
                            reservationEntry.SETFILTER(reservationEntry."Source Type", '83');
                            reservationEntry.SETRANGE(reservationEntry."Source ID", 'Item');
                            reservationEntry.SETRANGE(reservationEntry."Source Batch Name", 'POS-CS-SIG');
                            IF reservationEntry.FINDSET THEN
                                REPEAT
                                    ILE.RESET;
                                    ILE.SETCURRENTKEY("Entry No.");
                                    ILE.SETFILTER(ILE."Item No.", Ite_Jnl_Line."Item No.");
                                    ILE.SETFILTER(ILE."Serial No.", reservationEntry."Serial No.");

                                    /* IF ILE.COUNT = 0 THEN  // Data not available in ERP
                                     CODEUNIT.RUN(CODEUNIT::"Item Jnl.-Post", Rec)
                                 ELSE */
                                    // Commented not to allow cards which are not present in ERP
                                    IF ILE.COUNT > 0 THEN BEGIN
                                        IF ILE.FINDLAST THEN BEGIN
                                            IF ILE."Entry Type".AsInteger() = 5 THEN
                                                CODEUNIT.RUN(CODEUNIT::"Item Jnl.-Post", Rec)
                                            ELSE
                                                ERROR('Postive Adjustment allowed only for customer cards');
                                        END;
                                    END
                                    ELSE
                                        ERROR('Card Details of ' + Ite_Jnl_Line."Item No." + ' , serial no: ' + reservationEntry."Serial No." + ' is not present in ERP, contact ERP team');
                                UNTIL reservationEntry.NEXT = 0;
                        UNTIL Ite_Jnl_Line.NEXT = 0;
                END
                // end by Rakesh
                ELSE
                    ERROR('No Permissions to Adjust Item');
            end;
        }
        modify("Post and &Print")
        {
            Promoted = true;
            PromotedIsBig = true;
        }
        modify("&Print")
        {
            Promoted = true;
        }
    }


    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec.ShowShortcutDimCode(ShortcutDimCode);
    end;

    var
        Ite_Jnl_Line: Record "Item Journal Line";
        reservationEntry: Record "Reservation Entry";
        Srev_item: Record "Service Item";
        Tot_Qty: Integer;
        Item: Record Item;
        "ITEMLEDGER ENTRY": Record "Item Ledger Entry";
        ILE: Record "Item Ledger Entry";
}

