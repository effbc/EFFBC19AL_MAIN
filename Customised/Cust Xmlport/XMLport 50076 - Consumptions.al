xmlport 50076 Consumptions
{
    Direction = Import;
    Format = VariableText;

    schema
    {
        textelement(Reservation_Entries)
        {
            tableelement(Integer; Integer)
            {
                AutoSave = false;
                XmlName = 'Integer';
                textelement(ProdOrderNo)
                {
                }
                textelement(ItemNo)
                {
                }
                textelement(SerialNo)
                {

                    trigger OnAfterAssignVariable();
                    begin
                        if (ProdOrderNo <> '') and (ItemNo <> '') and (SerialNo <> '') then begin
                            ItemJnlLine.SetFilter(ItemJnlLine."Journal Template Name", 'CONSUMPTIO');
                            //ItemJnlLine.SETFILTER(ItemJnlLine."Journal Batch Name",'MPRCJ');
                            ItemJnlLine.SetFilter(ItemJnlLine."Order No.", ProdOrderNo);
                            ItemJnlLine.SetFilter(ItemJnlLine."Item No.", ItemNo);
                            if ItemJnlLine.FindFirst then begin
                                EntryNo += 1;
                                reservationEntry.Init;
                                reservationEntry."Entry No." := EntryNo;
                                reservationEntry."Created By" := UserId;
                                reservationEntry."Creation Date" := WorkDate;

                                reservationEntry.Positive := true;
                                reservationEntry."Item No." := ItemJnlLine."Item No.";
                                reservationEntry.Validate(reservationEntry."Item No.", ItemJnlLine."Item No.");
                                reservationEntry."Location Code" := ItemJnlLine."Location Code";
                                reservationEntry."Quantity (Base)" := -1;
                                reservationEntry.Validate("Location Code", ItemJnlLine."Location Code");
                                reservationEntry.Validate("Reservation Status", reservationEntry."Reservation Status"::Prospect);

                                reservationEntry."Reservation Status" := reservationEntry."Reservation Status"::Prospect;
                                reservationEntry."Source Type" := 83;
                                reservationEntry."Source Subtype" := 5;
                                reservationEntry."Source ID" := 'CONSUMPTIO';
                                reservationEntry."Source Batch Name" := ItemJnlLine."Journal Batch Name";
                                reservationEntry."Source Ref. No." := ItemJnlLine."Line No.";
                                reservationEntry."Serial No." := SerialNo;
                                reservationEntry.Validate("Expected Receipt Date", WorkDate);
                                reservationEntry.Validate("Qty. per Unit of Measure", 1);
                                reservationEntry.Validate("Suppressed Action Msg.", false);
                                reservationEntry."Qty. to Handle (Base)" := -1;
                                reservationEntry."Qty. to Invoice (Base)" := -1;
                                reservationEntry.Validate("Planning Flexibility", reservationEntry."Planning Flexibility"::Unlimited);
                                reservationEntry.Insert;
                            end;
                        end;
                    end;
                }
            }
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    trigger OnPreXmlPort();
    begin
        reservationEntry.Reset;
        if reservationEntry.FindLast then
            EntryNo := reservationEntry."Entry No." + 1
        else
            EntryNo := 1;
    end;

    var
        reservationEntry: Record "Reservation Entry";
        EntryNo: Integer;
        ItemJnlLine: Record "Item Journal Line";
}

