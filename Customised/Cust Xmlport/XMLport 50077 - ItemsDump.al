xmlport 50077 ItemsDump
{
    Direction = Import;
    Format = VariableText;
    Permissions = TableData "G/L Entry" = rim,
                  TableData Vendor = rim,
                  TableData "Vendor Ledger Entry" = rim,
                  TableData "Item Ledger Entry" = rimd,
                  TableData "Purch. Inv. Header" = rim,
                  TableData "Purch. Inv. Line" = rim,
                  TableData "Detailed Vendor Ledg. Entry" = rimd,
                  TableData "TDS Entry" = rim,
                  TableData "GST Ledger Entry" = rimd,
                  TableData "Detailed GST Ledger Entry" = rimd,
                  TableData "Quality Item Ledger Entry" = rimd;

    schema
    {
        textelement(Reservation_Entries)
        {
            tableelement(Integer; Integer)
            {
                AutoSave = false;
                XmlName = 'Integer';
                textelement(itemnumber)
                {
                    XmlName = 'itemnumber';

                    trigger OnAfterAssignVariable();
                    begin
                        /*
                        PIH1.RESET;
                        PIH1.SETFILTER("No.",itemnumber);
                        IF PIH1.FINDFIRST THEN
                          BEGIN
                              glent.RESET;
                              glent.SETFILTER("Document No.",PIH1."No.");
                              IF glent.FINDSET THEN
                                REPEAT
                                  BEGIN
                                  glent."External Document No." := '';
                                  glent.Amount := 0;
                                  glent."Debit Amount" := 0;
                                  glent."Credit Amount" := 0;
                                  glent.MODIFY;
                                  END
                                UNTIL glent.NEXT =0;
                        
                            TDSENTRY.RESET;
                            TDSENTRY.SETFILTER("Document No.",PIH1."No.");
                            IF TDSENTRY.FINDSET THEN
                              REPEAT
                                BEGIN
                                  TDSENTRY."TDS Amount" := 0;
                                  TDSENTRY."TDS Base Amount" := 0;
                                  TDSENTRY."TDS %" :=0;
                                  TDSENTRY."Total TDS Including SHE CESS" := 0;
                                  TDSENTRY."Invoice Amount" := 0 ;
                                  TDSENTRY."TDS Amount Including Surcharge" := 0;
                                  TDSENTRY.MODIFY;
                                END
                              UNTIL TDSENTRY.NEXT =0;
                        
                            VLE.RESET;
                            VLE.SETFILTER("Document No.",PIH1."No.");
                            IF VLE.FINDSET THEN
                              REPEAT
                                BEGIN
                                  VLE."Total TDS Including SHE CESS" := 0;
                                  VLE."Purchase (LCY)" := 0;
                                  VLE.MODIFY;
                                END
                              UNTIL VLE.NEXT =0;
                        
                          DVLE.RESET;
                          DVLE.SETFILTER("Document No.",PIH1."No.");
                          IF DVLE.FINDSET THEN
                            REPEAT
                              BEGIN
                                DVLE.Amount := 0;
                                DVLE."Debit Amount" := 0;
                                DVLE."Debit Amount (LCY)" := 0;
                                DVLE."Credit Amount" := 0;
                                DVLE."Credit Amount (LCY)" := 0;
                                DVLE.Amount := 0;
                                DVLE."Amount (LCY)" := 0;
                                DVLE.MODIFY;
                              END
                            UNTIL DVLE.NEXT =0;
                        
                          gstledent.RESET;
                          gstledent.SETFILTER("Document No.",PIH1."No.");
                          IF gstledent.FINDSET THEN
                            REPEAT
                              BEGIN
                                gstledent."GST Base Amount" := 0;
                                gstledent."GST Amount" := 0;
                                gstledent.MODIFY;
                              END
                            UNTIL gstledent.NEXT =0;
                        
                            DGSTLE.RESET;
                            DGSTLE.SETFILTER("Document No.",PIH1."No.");
                            IF DGSTLE.FINDSET THEN
                             REPEAT
                               BEGIN
                                  DGSTLE."GST Base Amount" :=0;
                                  DGSTLE."GST %" := 0;
                                  DGSTLE."GST Amount" := 0;
                                  DGSTLE.Quantity := 0;
                                  DGSTLE."Remaining Base Amount" := 0;
                                  DGSTLE."Remaining GST Amount" := 0;
                                  DGSTLE.MODIFY;
                               END
                            UNTIL DGSTLE.NEXT =  0;
                        
                          PIL1.RESET;
                          PIL1.SETFILTER("Document No.",PIH1."No.");
                          IF PIL1.FINDSET THEN
                            REPEAT
                              BEGIN
                                PIL1.Quantity := 0;
                                PIL1."Quantity (Base)" := 0;
                                PIL1.Amount := 0;
                                PIL1."Amount To Vendor" := 0 ;
                                PIL1."Amount Including VAT" := 0;
                                PIL1."Amount Including Tax" := 0 ;
                                PIL1."VAT Base Amount" :=0;
                                PIL1."Unit Cost" := 0;
                                PIL1."Tax Base Amount" := 0;
                                PIL1."GST Assessable Value" :=0;
                                PIL1."Custom Duty Amount" :=0;
                                PIL1."Charges To Vendor" :=0;
                                PIL1."TDS Amount" :=0;
                                PIL1.MODIFY;
                              END
                            UNTIL PIL1.NEXT =0;
                           MESSAGE(PIH1."No." +' Rec Modified');
                           ItemsCount := +1;
                          END;
                        
                        */


                        /*gle.RESET;
                        gle.SETCURRENTKEY("Document No.","System Date");
                        gle.SETRANGE("Document No.",No);
                        gle.SETFILTER("Source Type",FORMAT(gle."Source Type"::Vendor));
                        IF gle.FINDSET THEN
                          BEGIN
                            REPEAT
                          gle."Source No." := 'V02595';
                          gle.MODIFY;
                          ItemsCount := ItemsCount+1;
                          UNTIL gle.NEXT =0;
                          END;
                        
                        venle.RESET;
                        venle.SETRANGE("Document No.",No);
                        IF venle.FINDSET THEN
                            BEGIN
                              venle."Vendor No." := 'V02595';
                              venle.MODIFY;
                              ItemsCount := ItemsCount+1;
                            END;
                        
                        dvle.RESET;
                        dvle.SETRANGE("Document No.",No);
                        IF dvle.FINDSET THEN
                          BEGIN
                            dvle."Vendor No." := 'V02595';
                            dvle.MODIFY;
                            ItemsCount := ItemsCount+1;
                          END;
                        gstled.RESET;
                        gstled.SETRANGE("Document No.",No);
                        gstled.SETFILTER("Source Type",FORMAT(gstled."Source Type"::Vendor));
                        IF gstled.FINDSET THEN
                            BEGIN
                              REPEAT
                              gstled."Source No." := 'V02595';
                              gstled.MODIFY;
                              ItemsCount := ItemsCount+1;
                              UNTIL gstled.NEXT =0;
                            END;
                        dgstled.RESET;
                        dgstled.SETRANGE("Document No.",No);
                        dgstled.SETFILTER("Source Type",FORMAT(dgstled."Source Type"::Vendor));
                        IF dgstled.FINDSET THEN
                            BEGIN
                                REPEAT
                                dgstled."Source No." := 'V02595';
                                dgstled.MODIFY;
                                ItemsCount := ItemsCount+1;
                                UNTIL dgstled.NEXT =0;
                            END;
                        pinvh.RESET;
                        pinvh.SETRANGE("No.",No);
                        IF pinvh.FINDSET THEN
                            BEGIN
                                pinvh."Buy-from Vendor No." := 'V02595';
                                pinvh.MODIFY;
                                ItemsCount := ItemsCount+1;
                            END;*/
                        //MESSAGE(FORMAT(gle.COUNT));

                        /*Us.RESET;
                        Us.SETFILTER("User Name",No);
                        IF Us.FINDFIRST THEN
                          BEGIN
                            Us.Blocked := TRUE;
                            Us.MODIFY;
                            ItemsCount := ItemsCount+1;
                          END
                        
                        */

                        /*GLA.RESET;
                        GLA.SETFILTER("No.",FORMAT(No));
                        IF GLA.FINDSET THEN
                         // REPEAT
                          BEGIN
                             GLA."PL Minor Head" := BinAddress;
                             GLA."PL IncomeType" := claimeddate;
                             GLA."Type of GL" := state_code;
                             GLA."Nature of GL" := Remarks;
                             GLA."GL Group" := Reason;
                             GLA."GL Sub Group" :=orderdate;
                            GLA.MODIFY;
                          END;
                        //  UNTIL GLA.NEXT =0;
                          ItemsCount := ItemsCount+1;
                          */

                        // for updating the material picked status in both header and lines

                        /*
                        FOR int_i := 1 TO 95 DO
                        BEGIN
                        //config.RESET;
                        config.INIT;
                        config.Sno := int_i;
                        config.Product:= No;
                        config.Configuration := BinAddress;
                        config.INSERT;
                        COMMIT;
                        int_i := int_i +1;
                        END;*/

                        /*PMIH.RESET;
                        PMIH.SETFILTER("No.",No);
                        IF PMIH.FINDFIRST THEN
                          BEGIN
                            PMIH."Material Picked" := TRUE;
                            PMIH."Material Picked Date" := CURRENTDATETIME;
                            //PMIH.VALIDATE("Material Picked");
                            PMIL.RESET;
                            PMIL.SETCURRENTKEY("Document No.");
                            PMIL.SETFILTER("Document No.",PMIH."No.");
                            IF PMIL.FINDSET THEN
                              BEGIN
                                REPEAT
                                  PMIL."Material Picked":=TRUE;
                                  PMIL.MODIFY;
                                UNTIL PMIL.NEXT=0;
                              END;
                            PMIH.MODIFY;
                            ItemsCount := ItemsCount+1;
                         // MESSAGE('Picked Status Updated');
                         END;
                         */




                        // for modifing the PIH Cklaimed Date
                        /*PIH.RESET;
                        PIH.SETFILTER("No.",No);
                        IF PIH.FINDFIRST THEN
                          BEGIN
                            PIH."Excise Claimed Date" := 200918D;
                            PIH.MODIFY;
                            ItemsCount := ItemsCount+1;
                           END
                           */

                        /*
                        //Item BIN Address modifications
                          ITEM.RESET;
                          ITEM.SETFILTER(ITEM."No.",No);
                          IF ITEM.FINDFIRST THEN
                          BEGIN
                            ITEM."BIN Address" := BinAddress;
                            ITEM.MODIFY;
                            ItemsCount := ItemsCount+1;
                            END;
                            */


                        /* BEGIN
                        //MESSAGE(BINAddress);
                        ITEM.ROHS := TRUE;
                        ITEM.MODIFY;
                        ItemsCount := ItemsCount+1;
                      END;
                      */

                    end;
                }
                textelement(sourcenumber)
                {
                    XmlName = 'sourcenumber';

                    trigger OnAfterAssignVariable();
                    begin
                        /*Vendor.RESET;
                        Vendor.SETFILTER("No.",No);
                        IF Vendor.FINDFIRST THEN
                          BEGIN
                            EVALUATE(numint,DESCRIPTION);
                            Vendor."Vendor Type" := numint;
                            Vendor.MODIFY;
                            ItemsCount +=1;
                          END;
                          */
                        /*
                      ITEM.RESET;
                      ITEM.SETFILTER(MSL,'<>%1',0);
                      ITEM.SETFILTER("Operating Temperature",OWNERNAME);
                      IF ITEM.FINDSET THEN
                      REPEAT
                      BEGIN
                        ITEM."Operating Temperature" := Contact;
                        ITEM.MODIFY;
                        ItemsCount+=1;
                        END
                      UNTIL ITEM.NEXT= 0;*/

                    end;
                }
                textelement(document_number)
                {
                    XmlName = 'document_number';

                    trigger OnAfterAssignVariable();
                    begin
                        /*
                        ITEM.RESET;
                        ITEM.SETFILTER("No.",No);
                        IF ITEM.FINDFIRST THEN
                          BEGIN
                            ITEM."CS IGC" := CSIGC;
                            ITEM.MODIFY;
                            ItemsCount += 1;
                          END;
                        */
                        /*
                        ILE.RESET;
                        ILE.SETRANGE("Document No.",'+PRCPT-19-20-12264');
                        ILE.SETRANGE("Item No.",'BOIGENR00311');
                        ILE.SETRANGE("Lot No.",CSIGC);
                        ILE.SETRANGE("Serial No.",No);
                        IF ILE.FINDFIRST THEN BEGIN
                        ILE."Serial No." := DESCRIPTION;
                        ILE.MODIFY;
                        END;
                        
                        QualityItemLedgerEntry.RESET;
                        QualityItemLedgerEntry.SETRANGE("Document No.",'+PRCPT-19-20-12264');
                        QualityItemLedgerEntry.SETRANGE("Item No.",'BOIGENR00311');
                        QualityItemLedgerEntry.SETRANGE(Select,FALSE);
                        QualityItemLedgerEntry.SETRANGE("Lot No.",CSIGC);
                        QualityItemLedgerEntry.SETRANGE("Serial No.",No);
                        IF QualityItemLedgerEntry.FINDFIRST THEN BEGIN
                        QualityItemLedgerEntry."Serial No." := DESCRIPTION;
                        QualityItemLedgerEntry.MODIFY;
                        ItemsCount += 1;
                        END;
                        */

                    end;
                }
                textelement(location_code)
                {
                    XmlName = 'location_code';

                    trigger OnAfterAssignVariable();
                    begin
                        /*ILE.RESET;
                        ILE.SETCURRENTKEY("Location Code","Posting Date","Document No.","Item No.");
                        ILE.SETFILTER("Document No.",BinAddress);
                        ILE.SETFILTER("Location Code",No);
                        ILE.SETFILTER("Item No.",claimeddate);
                        ILE.SETFILTER("Serial No.",state_code);
                        IF ILE.FINDLAST THEN
                          BEGIN
                            ILE."Location Code" := 'DAMAGE';
                            ILE.MODIFY;
                            PMIL.RESET;
                            PMIL.SETCURRENTKEY("Document No.","Item No.");
                            PMIL.SETFILTER("Document No.",BinAddress);
                            PMIL.SETFILTER("Item No.",claimeddate);
                            IF PMIL.FINDFIRST THEN
                              BEGIN
                                PMIL."Transfer-to Code" := 'DAMAGE';
                                PMIL.MODIFY;
                              END;
                              ItemsCount := ItemsCount + 1;
                          END;
                        
                        */
                        /*CUSTLE.RESET;
                        //CUSTLE.SETFILTER(CUSTLE."Posting Date",'>%1',063017D);
                        CUSTLE.SETRANGE(CUSTLE."Customer No.",No);
                        CUSTLE.SETFILTER("Document No.",BinAddress);
                        IF CUSTLE.FINDSET THEN
                          BEGIN
                            REPEAT
                               CUSTLE."Seller GST Reg. No." := claimeddate;
                               CUSTLE."Seller State Code" := state_code;
                               CUSTLE.MODIFY;
                               ItemsCount := ItemsCount + 1;
                            UNTIL CUSTLE.NEXT =0;
                            MESSAGE('CUST Led updtd '+FORMAT(ItemsCount));
                            END;
                        
                        DGSTLE.RESET;
                        //DGSTLE.SETFILTER(DGSTLE."Posting Date",'>%1',063017D);
                        DGSTLE.SETFILTER(DGSTLE."Source No.",No);
                        DGSTLE.SETFILTER("Document No.",BinAddress);
                        //DGSTLE.SETFILTER(DGSTLE."Buyer/Seller Reg. No.",'');
                        IF DGSTLE.FINDSET THEN
                        
                              BEGIN
                                REPEAT
                                DGSTLE."Buyer/Seller Reg. No." := claimeddate ;
                                DGSTLE."Buyer/Seller State Code" := state_code;
                                DGSTLE.MODIFY;
                                ItemsCount := ItemsCount + 1;
                                UNTIL DGSTLE.NEXT =0;
                                MESSAGE('Detailed GST updated '+FORMAT(ItemsCount));
                                END;*/

                        /*SL.RESET;
                        SL.SETCURRENTKEY("Document No.","Line No.","Document Type");
                        SL.SETFILTER("Document No.",No);
                        IF EVALUATE(EntryNo,BinAddress) THEN
                        SL.SETFILTER("Line No.",'%1',EntryNo);
                        SL.SETFILTER("No.",claimeddate);
                        IF SL.FINDFIRST THEN
                        BEGIN
                          //SL.Main_CATEGORY := state_code;
                          IF EVALUATE(SL.Main_CATEGORY,state_code) THEN
                            SL.MODIFY;
                          ItemsCount := ItemsCount+1;
                        END;
                        */
                        //Leadtime := state_code;
                        /*ITEM.RESET;
                        ITEM.SETCURRENTKEY("No.",Description);
                        ITEM.SETFILTER("No.",No);
                        IF ITEM.FINDSET THEN
                        BEGIN
                          IF EVALUATE(Leadtime,state_code) THEN
                          BEGIN
                            ITEM."Safety Lead Time" := Leadtime;
                            ITEM.MODIFY;
                            END;
                          ItemsCount := ItemsCount+1;
                        END;
                        */


                        /*
                        Us.RESET;
                        Us.INIT;
                        Us.EmployeeID := No;
                        Us."User Name" := FORMAT('EFFTRONICS\'+state_code);
                        Us."Full Name" := BinAddress;
                        Us.Dept := claimeddate;
                        Us."User Security ID" := CREATEGUID;
                        Us.TESTFIELD("User Name");
                        //Us."Windows Security ID" :='';
                        Us.VALIDATE("Windows Security ID");
                        //USERSPAGE.VALIDATE("Windows User Name");
                        Us.Dimension := 'CUS-005';
                        Us.INSERT;
                        //USERSPAGE.Autofill(Us);
                        
                        Error_str := '';
                        IF (Error_str = '') THEN
                        BEGIN
                          IF UserSetup.GET(Us."User Name") THEN
                          BEGIN
                            UserSetup."Current UserId":=Us.EmployeeID;
                            UserSetup."E-Mail":=Us.MailID;
                            UserSetup.MODIFY;
                          END
                          ELSE
                          BEGIN
                            UserSetup.INIT;
                            UserSetup."User ID":=Us."User Name";
                            UserSetup."Allow Posting From":=TODAY;
                            UserSetup."Allow Posting To":=TODAY;
                            UserSetup."Current UserId":=Us.EmployeeID;
                            UserSetup."E-Mail":=Us.MailID;
                            UserSetup.INSERT;
                          END;
                        
                          // Data into Employee
                          IF EmployeeGRec.GET(Us.EmployeeID) THEN
                          BEGIN
                             EmployeeGRec."First Name":=Us."Full Name";
                             EmployeeGRec."E-Mail":=Us.MailID;
                             EmployeeGRec."Global Dimension 1 Code":= Us.Dimension;
                             EmployeeGRec."Mobile Phone No.":=Remarks;
                             EmployeeGRec.MODIFY;
                          END
                          ELSE
                          BEGIN
                            EmployeeGRec.INIT;
                            EmployeeGRec."No.":=Us.EmployeeID;
                            EmployeeGRec."First Name":=Us."Full Name";
                            EmployeeGRec."E-Mail":=Us.MailID;
                            EmployeeGRec."Global Dimension 1 Code":=Us.Dimension;
                            EmployeeGRec."Mobile Phone No.":=Remarks;
                            EmployeeGRec.INSERT;
                          END;
                        
                          //data into Resource
                          IF ResourceGRec.GET(Us.EmployeeID) THEN
                          BEGIN
                            ResourceUOM.RESET;
                            ResourceUOM.SETFILTER(ResourceUOM."Resource No.",Us.EmployeeID);
                            ResourceUOM.SETFILTER(ResourceUOM.Code,'HOUR');
                            IF NOT ResourceUOM.FINDFIRST THEN
                            BEGIN
                              ResourceUOM.INIT;
                              ResourceUOM."Resource No." := Us.EmployeeID;
                              ResourceUOM.Code := 'HOUR';
                              ResourceUOM."Qty. per Unit of Measure" := 1;
                              ResourceUOM."Related to Base Unit of Meas." := TRUE;
                              ResourceUOM.INSERT;
                            END;
                            ResourceGRec."User Id":=Us."User Name";
                            ResourceGRec.Name:=Us."Full Name";
                            ResourceGRec."Search Name":=Us."Full Name";
                            ResourceGRec."Global Dimension 1 Code":=Us.Dimension;
                            ResourceGRec."Base Unit of Measure" := 'HOUR';
                            ResourceGRec."Gen. Prod. Posting Group" := 'MISC';
                            IF (Us.Dept='CS') AND (COPYSTR(Us.Dimension,1,3)='CUS') THEN
                              ResourceGRec."VAT Prod. Posting Group":='NO VAT';
                            ResourceGRec.MODIFY;
                          END
                          ELSE
                          BEGIN
                            ResourceUOM.RESET;
                            ResourceUOM.INIT;
                            ResourceUOM."Resource No." := Us.EmployeeID;
                            ResourceUOM.Code := 'HOUR';
                            ResourceUOM."Qty. per Unit of Measure" := 1;
                            ResourceUOM."Related to Base Unit of Meas." := TRUE;
                            ResourceUOM.INSERT;
                        
                            ResourceGRec.RESET;
                            ResourceGRec.INIT;
                            ResourceGRec."No.":=Us.EmployeeID;
                            ResourceGRec."User Id":=Us."User Name";
                            ResourceGRec.Name:=Us."Full Name";
                            ResourceGRec."Search Name":=Us."Full Name";
                            ResourceGRec."Global Dimension 1 Code":= Us.Dept;
                            ResourceGRec."Base Unit of Measure" := 'HOUR';
                            ResourceGRec."Gen. Prod. Posting Group" := 'MISC';
                            ResourceGRec.INSERT;
                          END;
                          //MESSAGE(Department);
                          DimValue.RESET;
                          DimValue.SETFILTER(DimValue.Code,Us.EmployeeID);
                          IF NOT DimValue.FINDFIRST THEN
                          BEGIN
                            // Finding Last Dimenison Value ID>>
                            DimValue2.RESET;
                            DimValue2.SETCURRENTKEY("Dimension Value ID");
                            IF DimValue2.FINDLAST THEN;
                            // Finding Last Dimenison Value ID<<
                            DimValue."Dimension Code":='EMPLOYEE CODES';
                            DimValue.Code:=Us.EmployeeID;
                            DimValue.Name:=Us."Full Name";
                            DimValue."Dimension Value Type":=DimValue."Dimension Value Type"::Standard;
                            DimValue."Dimension Value ID" := DimValue2."Dimension Value ID" + 1;
                            DimValue.INSERT;
                          END;
                          //MESSAGE('Data Entered into User Setup, Employee, Resource Tables');
                        END
                        
                        
                        */

                        /*
                        ITEM.RESET;
                        ITEM.SETFILTER("No.",No);
                        IF ITEM.FINDFIRST THEN
                          BEGIN
                           // ITEM."CS Product" := BinAddress;
                            ITEM."CS Card Type" := state_code;
                            EVALUATE(CSPrd,BinAddress);
                            ITEM."CS Product" := CSPrd;
                            EVALUATE(CSMODEL,claimeddate);
                            ITEM."CS Model" := CSMODEL;
                            ITEM.MODIFY;
                            ItemsCount+= 1;
                          END
                          */

                    end;
                }
                textelement(Quantity)
                {
                }
                textelement(serial_number)
                {
                    XmlName = 'Serial_number';

                    trigger OnAfterAssignVariable();
                    begin

                        /*SL.RESET;
                        SL.SETFILTER("Document No.",No);
                        IF EVALUATE(EntryNo,BinAddress) THEN
                        SL.SETFILTER("Line No.",'%1',EntryNo);
                        IF SL.FINDSET THEN
                          BEGIN
                            SL.MainCategory := claimeddate;
                            SL.SubCategory := state_code;
                            SL.Reason := Remarks;
                            SL.Remarks := Reason;
                            SL.MODIFY;
                            ItemsCount := ItemsCount+1;
                          END;
                          */
                        //EntryNo := FORMAT(BinAddress);


                        /*
                          Vendor.INIT;
                          LastNumner := NoSeriesMgt.GetNextNo('VEND',TODAY,FALSE);
                          IF LastNumner <> '' THEN
                          BEGIN
                          Vendor."No." := LastNumner ;
                          Vendor.Name := 'RR-'+OWNERNAME;
                          Vendor."Our Account No." := account_num;
                          Vendor."RTGS Code" := IFSC_CODE;
                          Vendor."Branch Name" := AC_BRANCH;
                          Vendor."Name of Bank" := BANK_NAME;
                          Vendor."Vendor Posting Group" := 'DOMESTIC';
                          Vendor."Gen. Bus. Posting Group" := 'DOMESTIC';
                          Vendor."Payment Terms Code" := '100-A';
                          Vendor."Purchaser Code" := Contact;
                          Vendor.INSERT;
                          COMMIT;
                          ItemsCount+= 1;
                          //MESSAGE(NoSeriesMgt.TryGetNextNo('VEND',TODAY));
                        END;
                        */
                        /*
                        SH.RESET;
                        SH.SETFILTER("No.",No);
                        IF SH.FINDSET THEN
                          BEGIN
                            SH."Railway Division" := BinAddress;
                            EVALUATE(SH."Tender Published Date",claimeddate);
                            EVALUATE(SH."Tender Due Date",state_code);
                            SH."Customer OrderNo." := Remarks;
                            SH.Structure := Reason;
                            EVALUATE(SH."Order Date",orderdate);
                            SH.Vertical := SH.Vertical::"Smart Signalling";
                            EVALUATE(SH."Sale Order Total Amount" , orderamt);
                            SH.MODIFY;
                            ItemsCount := ItemsCount+1;
                            COMMIT;
                            Sales_Line.RESET;
                            Sales_Line.SETFILTER("Document No.",No);
                            IF Sales_Line.FINDSET THEN
                              BEGIN
                                 // Sales_Line."Line No." :=10000;
                                  Sales_Line.Type := Sales_Line.Type::Item;
                                  Sales_Line."No." := item_no;
                                  Sales_Line.VALIDATE("No.");
                                  EVALUATE(Sales_Line.Quantity ,qty);
                                  Sales_Line.VALIDATE(Quantity);
                                  Sales_Line."Unit of Measure" := 'NOS';
                                  EVALUATE(Sales_Line."Amount To Customer",amount_to_cust);
                                  Sales_Line.MODIFY;
                                  ItemsCount := ItemsCount+1;
                                  COMMIT;
                              END;
                          END;
                          */

                    end;
                }
                textelement(Lotnumber)
                {

                    trigger OnAfterAssignVariable();
                    begin
                        /*
                        ILE.RESET;
                        IF ILE.FINDLAST THEN
                          BEGIN
                        ILE.INIT;
                        ILE."Entry No." := ILE."Entry No." +1;
                        ILE."Item No." := itemnumber;
                        ILE."Entry Type" := 1;
                        ILE."Source No." := sourcenumber;
                        ILE."Document No." := document_number;
                        ILE.Description := 'Manually Dumped by ERP Team on 06-02-2020';
                        ILE."Location Code" := location_code;
                        IF EVALUATE(QtyInt,Quantity) THEN
                        ILE.Quantity := QtyInt;
                        ILE."Remaining Quantity" := 0;
                        IF EVALUATE(QtyInt,Quantity) THEN
                        ILE."Invoiced Quantity" := QtyInt;
                        ILE."Applies-to Entry" := 0;
                        ILE.Open := FALSE;
                        ILE."Global Dimension 1 Code" := 'PRD-010';
                        ILE."Global Dimension 2 Code" := 'PROD';
                        ILE.Positive := FALSE;
                        ILE."Source Type" := 0;
                        ILE."Country/Region Code" := 'IN';
                        //ILE."Document Date" := Postingdate;
                        ItmLedgEnt.RESET;
                        ItmLedgEnt.SETCURRENTKEY("Document No.","Document Type","Document Line No.");
                        ItmLedgEnt.SETFILTER("Document No.",document_number);
                        IF ItmLedgEnt.FINDFIRST THEN
                          BEGIN
                            ILE."External Document No." := ItmLedgEnt."External Document No.";
                            ILE."Posting Date" := ItmLedgEnt."Posting Date";
                            ILE."Document Date" := ItmLedgEnt."Document Date";
                            ILE."Dimension Set ID" := ItmLedgEnt."Dimension Set ID";
                            ILE."User ID" := ItmLedgEnt."User ID";
                            ILE."Last Invoice Date" := ItmLedgEnt."Last Invoice Date";
                          END;
                        
                        ILE."No. Series" := 'EXCISE-INV';
                        ILE."Document Type" := 1;
                        ILE."Document Line No." := 0;
                        ILE."Order Type" := 0;
                        ILE."Order Line No." := 0;
                        ILE."Qty. per Unit of Measure" := 1;
                        ITEM.RESET;
                        ITEM.SETFILTER("No.",itemnumber);
                        IF ITEM.FINDFIRST THEN
                          BEGIN
                          ILE."Unit of Measure Code" := ITEM."Base Unit of Measure";
                          ILE."Item Category Code" := ITEM."Item Category Code";
                          ILE.Nonstock := FALSE;
                          ILE."Product Group Code" := ITEM."Product Group Code";
                          END;
                        ILE."Completely Invoiced" := FALSE;
                        //ILE."Last Invoice Date" := LastInvoiceDAte;
                        IF EVALUATE(QtyInt,Quantity) THEN
                        ILE."Shipped Qty. Not Returned" := QtyInt;
                        ILE."Lot No." := Lotnumber;
                        ILE."Serial No." := SERIAL_NUMBER;
                        ILE.INSERT;
                        ItemsCount +=1;
                        END;
                        */

                    end;
                }
                textelement(Visual_Sampling_Time)
                {
                }
                textelement(Dim_Sampling_Count)
                {
                }
                textelement(Dim_Sampling_Per)
                {
                }
                textelement(Dim_Sampling_Time)
                {
                }
                textelement(Basic_Fun_Sampling_Count)
                {
                }
                textelement(Basic_Fun_Sampling_Per)
                {
                }
                textelement(Basic_Fun_Sampling_Time)
                {
                }
                textelement(Full_Fun_Sampling_Count)
                {
                }
                textelement(Full_Fun_Sampling_Per)
                {
                }
                textelement(Full_Fun_Sampling_Time)
                {
                }
                textelement(Documentation_Time)
                {

                    trigger OnAfterAssignVariable();
                    begin
                        ITEM.Reset;
                        ITEM.SetFilter("Product Group Code Cust", itemnumber);
                        ITEM.SetFilter("Item Sub Group Code", sourcenumber);
                        if ITEM.FindSet then
                            repeat
                            begin
                                if Evaluate(RevSmpCntInt, document_number) then
                                    ITEM."Revised Sampling Count" := RevSmpCntInt;
                                if Evaluate(RevSmpPerInt, location_code) then
                                    ITEM."Revised Sampling Percentage" := RevSmpPerInt;
                                if Evaluate(RevSmpTimeInt, Quantity) then
                                    ITEM."Revised Sampling Time Mins" := RevSmpTimeInt;
                                if Evaluate(VisualSmpCntInt, SERIAL_NUMBER) then
                                    ITEM."Visual Sampling Count" := VisualSmpCntInt;
                                if Evaluate(VisualSmpPerInt, Lotnumber) then
                                    ITEM."Visual Sampling Percentage" := VisualSmpPerInt;
                                if Evaluate(VisualSmpTimeInt, Visual_Sampling_Time) then
                                    ITEM."Visual Sampling Time Mins" := VisualSmpTimeInt;
                                if Evaluate(DimSmpCntInt, Dim_Sampling_Count) then
                                    ITEM."Dimensions Sampling Count" := DimSmpCntInt;
                                if Evaluate(DimSmpPerInt, Dim_Sampling_Per) then
                                    ITEM."Dimensions Sampling Percentage" := DimSmpPerInt;
                                if Evaluate(DimSmpTimeInt, Dim_Sampling_Time) then
                                    ITEM."Dimensions Sampling Time Mins" := DimSmpTimeInt;
                                if Evaluate(BasicFunSmpCntInt, Basic_Fun_Sampling_Count) then
                                    ITEM."Basic Functional Sampling Cnt" := BasicFunSmpCntInt;
                                if Evaluate(BasicFunSmpPerInt, Basic_Fun_Sampling_Per) then
                                    ITEM."Basic Functional Sampling Per" := BasicFunSmpPerInt;
                                if Evaluate(BasicFunSmpTimeInt, Basic_Fun_Sampling_Time) then
                                    ITEM."Basic Func Sampling Time -Mins" := BasicFunSmpTimeInt;
                                if Evaluate(FullFunSmpCntInt, Full_Fun_Sampling_Count) then
                                    ITEM."Sampling Count" := FullFunSmpCntInt;
                                if Evaluate(FullFunSmpPerInt, Full_Fun_Sampling_Per) then
                                    ITEM."Sampling %" := FullFunSmpPerInt;
                                if Evaluate(FullFunSmpTimeInt, Full_Fun_Sampling_Time) then
                                    ITEM."Inspection Bench Mark(In Min)" := FullFunSmpTimeInt;
                                if Evaluate(DocTimeInt, Documentation_Time) then
                                    ITEM."Documentation Time" := DocTimeInt;
                                ITEM.Modify;
                                ItemsCount += 1;
                            end
                            until ITEM.Next = 0;
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
        /*
          reservationEntry.RESET;
        IF reservationEntry.FINDLAST THEN
          EntryNo := reservationEntry."Entry No." + 1
        ELSE
          EntryNo := 1;
        */

    end;

    var
        reservationEntry: Record "Reservation Entry";
        EntryNo: Integer;
        ItemJnlLine: Record "Item Journal Line";
        ITEM: Record Item;
        SStock: Decimal;
        NoOfUnits: Decimal;
        SZ: Record "Service Zone";
        Emp: Record Employee;
        ItemsCount: Integer;
        GLA: Record "G/L Account";
        LeadTm: DateFormula;
        PCBGRec: Record PCB;
        Customer: Record Customer;
        Vendor: Record Vendor;
        PBL: Record "Production BOM Line";
        SH: Record "Sales Header";
        user: Record User;
        Station: Record Station;
        St: Record Station;
        PIH: Record "Purch. Inv. Header";
        IMS: Record "Item Wise Min. Req. Qty at Loc";
        Quaty: Integer;
        PMIH: Record "Posted Material Issues Header";
        CUSTLE: Record "Cust. Ledger Entry";
        DGSTLE1: Record "Detailed GST Ledger Entry";
        SL: Record "Sales Line";
        Leadtime: DateFormula;
        Us: Record User;
        Sales_Line: Record "Sales Line";
        PMIL: Record "Posted Material Issues Line";
        ILE: Record "Item Ledger Entry";
        VLE2: Record "Value Entry";
        config: Record "Product Configurations Master";
        int_i: Integer;
        Error_str: Text;
        UserSetup: Record "User Setup";
        EmployeeGRec: Record Employee;
        ResourceGRec: Record Resource;
        ResourceUOM: Record "Resource Unit of Measure";
        DimValue: Record "Dimension Value";
        DimValue2: Record "Dimension Value";
        QILE: Record "Quality Item Ledger Entry";
        PRod_BOM_Line: Record "Production BOM Line";
        gle: Record "G/L Entry";
        venle1: Record "Vendor Ledger Entry";
        dvle1: Record "Detailed Vendor Ledg. Entry";
        gstled: Record "GST Ledger Entry";
        dgstled1: Record "Detailed GST Ledger Entry";
        pinvh: Record "Purch. Inv. Header";
        QualityItemLedgerEntry: Record "Quality Item Ledger Entry";
        numint: Integer;
        LastNumner: Text;
        // NoSeriesMgt: Codeunit NoSeriesManagement;
        ItmLedgEnt: Record "Item Ledger Entry";
        QtyInt: Integer;
        serialnumbertext: Text;
        PIH1: Record "Purch. Inv. Header";
        PIL1: Record "Purch. Inv. Line";
        DGSTLE: Record "Detailed GST Ledger Entry";
        gstledent: Record "GST Ledger Entry";
        DVLE: Record "Detailed Vendor Ledg. Entry";
        VLE: Record "Vendor Ledger Entry";
        TDSENTRY: Record "TDS Entry";
        glent: Record "G/L Entry";
        VWAM: Record "Vendor Wise Available Makes";
        VendorsMaster: Record Vendor;
        RevSmpCntInt: Integer;
        RevSmpPerInt: Integer;
        RevSmpTimeInt: Decimal;
        VisualSmpCntInt: Integer;
        VisualSmpPerInt: Integer;
        VisualSmpTimeInt: Decimal;
        DimSmpCntInt: Integer;
        DimSmpPerInt: Integer;
        DimSmpTimeInt: Decimal;
        BasicFunSmpCntInt: Integer;
        BasicFunSmpPerInt: Integer;
        BasicFunSmpTimeInt: Decimal;
        FullFunSmpCntInt: Integer;
        FullFunSmpPerInt: Integer;
        FullFunSmpTimeInt: Decimal;
        DocTimeInt: Decimal;
}

