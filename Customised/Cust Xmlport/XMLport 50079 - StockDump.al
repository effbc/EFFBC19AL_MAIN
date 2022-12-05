xmlport 50079 StockDump
{
    Direction = Import;
    // Encoding = ISO-8859-2;
    Format = VariableText;
    FormatEvaluate = Legacy;
    //XMLVersionNo = 1.1;

    schema
    {
        textelement(Reservation_Entries)
        {
            tableelement(Integer; Integer)
            {
                AutoSave = false;
                XmlName = 'Integer';
                textelement(itemno)
                {
                    XmlName = 'ItemNO';

                    trigger OnBeforePassVariable();
                    begin
                        /*PBL.RESET;
                        PBL.SETRANGE("Production BOM No.",ItemNO);
                        PBL.SETFILTER("No.",LocationCode);
                        IF PBL.FINDFIRST THEN
                        BEGIN
                          EVALUATE(PBL."BOM Type",Qty);
                          ItemsCount := ItemsCount+1;
                          PBL.MODIFY;
                        END;*/

                    end;

                    trigger OnAfterAssignVariable();
                    begin
                        PIH.Reset;
                        PIH.SetRange("No.", ItemNO);
                        if PIH.FindFirst then begin
                            PIH."Excise Claimed Date" := 20180420D;
                            ItemsCount := ItemsCount + 1;
                            PIH.Modify;
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

    trigger OnPostXmlPort();
    begin

        Message('Data Updation Completed!\Items Count: ' + Format(ItemsCount));
        //MESSAGE(FORMAT(ITEM."Next Counting Start Date"));
    end;

    trigger OnPreXmlPort();
    begin
        ItemsCount := 0;
    end;

    var
        ItemsCount: Integer;
        ILE: Record "Item Ledger Entry";
        Entry_No_Int: Integer;
        RecordFind: Boolean;
        ILE_SNo: Record "Item Ledger Entry";
        VE: Record "Value Entry";
        VE_Sno: Record "Value Entry";
        VE_Entry_No_Int: Integer;
        Quantity: Decimal;
        // TestCu : Codeunit "Test  (Analysis View Entry )";
        PBL: Record "Production BOM Line";
        PIH: Record "Purch. Inv. Header";
}

