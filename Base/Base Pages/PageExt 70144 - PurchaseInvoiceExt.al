pageextension 70144 PurchaseInvoiceExt extends "Purchase Invoice"
{
    layout
    {
        modify("Vendor Invoice No.")
        {
            ShowMandatory = VendorInvoiceNoMandatory;
            trigger OnBeforeValidate()
            begin
                Rec."Actual Invoiced Date" := TODAY;
                // Added by Pranavi on 07-Jul-2016
                /*IF (COPYSTR(Structure, 2, 2) IN ['+E', '-E']) OR (COPYSTR(Structure, 4, 2) IN ['+E', '-E']) OR
                (COPYSTR(Structure, 6, 2) IN ['+E', '-E']) OR (COPYSTR(Structure, 5, 2) IN ['+E', '-E']) THEN
                    Rec."Vendor Excise Invoice No." := Rec."Vendor Invoice No.";*/ //EFFug
                // End by Pranavi
            end;
        }
        addafter("Vendor Invoice No.")
        {
            field("Posting No. Series"; Rec."Posting No. Series")
            {
                ApplicationArea = All;
            }
        }
        addafter("Order Address Code")
        {
            field("Vendor Invoice Date"; Rec."Vendor Invoice Date")
            {
                ApplicationArea = All;
            }
        }
        addafter("Responsibility Center")
        {
            field("Inclusive of All Taxes"; Rec."Inclusive of All Taxes")
            {
                ApplicationArea = All;
            }
        }
        addafter(Status)
        {
            field("Purchase Journal"; Rec."Purchase Journal")
            {
                Editable = false;
                ApplicationArea = All;
            }
            field("Amount to Vendor"; "Amount to Vendor")
            {
                ApplicationArea = All;
            }
            field("Tarrif Heading No"; Rec."Tarrif Heading No")
            {
                ApplicationArea = All;
            }
            field("Last Modified User"; Rec."USER ID")
            {
                Caption = 'Last Modified User';
                ApplicationArea = All;
            }

            field("Sales Order Ref No."; Rec."Sales Order Ref No.")
            {
                ApplicationArea = All;

                trigger OnLookup(var Text: Text): Boolean;
                begin
                    Salinv.RESET;// Rev01
                                 //IF "Account Type" = "Account Type" :: Customer THEN
                                 //Salinv.SETRANGE("Sell-to Customer No.","Account No.");// Rev01
                    IF PAGE.RUNMODAL(60219, Salinv) = ACTION::LookupOK THEN BEGIN
                        Rec."Sale Order No" := Salinv."No.";
                        // MODIFY;
                    END;
                end;
            }
        }
        addafter("Pmt. Discount Date")
        {
            field("Vendor Excise Invoice No."; Rec."Vendor Excise Invoice No.")
            {
                ApplicationArea = All;
            }
            field("Additional Duty Value"; Rec."Additional Duty Value")
            {
                ApplicationArea = All;
            }
            field("Type of Supplier"; Rec."Type of Supplier")
            {
                ApplicationArea = All;
            }
            field("<Location Code 2>"; Rec."Location Code")
            {
                Importance = Promoted;
                ApplicationArea = All;

                trigger OnValidate();
                begin
                    //SetLocGSTRegNoEditable;
                end;
            }
        }

        addafter("Ship-to Contact")
        {
            field("MSPT Date"; Rec."MSPT Date")
            {
                ApplicationArea = All;
            }
            field("MSPT Code"; Rec."MSPT Code")
            {
                ApplicationArea = All;
            }
            field("<On Hold2>"; Rec."On Hold")
            {
                ApplicationArea = All;
            }
        }
        addafter("Expected Receipt Date")
        {
            field("Vehicle Number"; Rec."Vehicle Number")
            {
                ApplicationArea = All;
            }
            field("Vend. Excise Inv. Date"; Rec."Vend. Excise Inv. Date")
            {
                ApplicationArea = All;
            }
            field("Transporter Name"; Rec."Transporter Name")
            {
                ApplicationArea = All;
            }
        }
        addafter("Area")
        {
            field(State; Rec.State)
            {
                ApplicationArea = All;
            }
            field("Currency Factor"; Rec."Currency Factor")
            {
                ApplicationArea = All;
            }
            /*group(GST)
            {
                CaptionML = ENU = 'GST',
                             ENN = 'GST';
                field("Nature of Supply"; Rec."Nature of Supply")
                {
                    ApplicationArea = All;
                }
            }
            field("Bill of Entry No."; Rec."Bill of Entry No.")
            {
                ApplicationArea = All;
            }
            field("Bill of Entry Date"; Rec."Bill of Entry Date")
            {
                ApplicationArea = All;
            }
            field("Bill of Entry Value"; Rec."Bill of Entry Value")
            {
                ApplicationArea = All;
            }
            field("Without Bill Of Entry"; Rec."Without Bill Of Entry")
            {
                ApplicationArea = All;

        }*/  //alredy defined in page Extension
        }  //B2BUPH

    }
    actions
    {
        modify(Statistics)
        {
            Promoted = true;
        }
        modify(Approve)
        {
            Promoted = true;
            PromotedIsBig = true;
        }
        modify(Reject)
        {
            Promoted = true;
            PromotedIsBig = true;
        }
        modify(Delegate)
        {
            Promoted = true;
        }
        modify(Comment)
        {
            Promoted = true;
        }
        modify("Re&lease")
        {
            Promoted = true;
            trigger OnBeforeAction()
            begin
                RCM_CHECKING;
                CONSTRUCTION_HEAD_CHECKING;
                GSTROUNDINGPRECISION;
                ForeignBills_LCY_CHECKING(Rec."No."); //added by Vishnu Priya on 30-07-2019
                NewlyAdded_Lines_Details_Checking; // added by Vishnu Priya for the New Lines Insertion in the Invoice
            end;
        }
        /*  modify("Calc&ulate Structure Values")
          {
              trigger OnBeforeAction()
              begin
                  RCM_CHECKING;
                  CONSTRUCTION_HEAD_CHECKING;
                  GSTROUNDINGPRECISION;
                  NewlyAdded_Lines_Details_Checking; // added by Vishnu Priya for the New Lines Insertion in the Invoice
                  ForeignBills_LCY_CHECKING(Rec."No."); //added by Vishnu Priya on 30-07-2019
                  "G|L".GET;
                  IF "G|L"."Active ERP-CF Connection" THEN BEGIN
                      //VERIFYING THE PURCHASE LINES WHETHER TAX STRUCTURE WAS SAME OR NOT;
                      PurchaseLine.SETRANGE(PurchaseLine."Document No.", Rec."No.");
                      IF PurchaseLine.FINDSET THEN
                          REPEAT
                              "Purch.Rcpt.Line".RESET;
                              "Purch.Rcpt.Line".SETRANGE("Purch.Rcpt.Line"."Document No.", PurchaseLine."Receipt No.");
                              "Purch.Rcpt.Line".SETRANGE("Purch.Rcpt.Line"."Line No.", PurchaseLine."Receipt Line No.");
                              IF "Purch.Rcpt.Line".FINDFIRST THEN BEGIN
                                  Purchline2.RESET;
                                  Purchline2.SETRANGE(Purchline2."Document No.", "Purch.Rcpt.Line"."Order No.");
                                  Purchline2.SETRANGE(Purchline2."Line No.", "Purch.Rcpt.Line"."Order Line No.");
                                  IF Purchline2.FINDFIRST THEN BEGIN
                                      PH.RESET;
                                      PH.SETRANGE(PH."No.", Purchline2."Document No.");
                                      IF PH.FINDFIRST THEN BEGIN
                                          //IF (PH.Structure<>Structure) AND (PH."Order Date">310110D) THEN
                                          //  ERROR('"TAX STRUCTRURE" IN INVOICE WAS MISMATCHED WITH "TAX STRUCTURE" IN ORDER');
                                      END;
                                  END;
                              END;
                          UNTIL PurchaseLine.NEXT = 0;
                      // NAVIN
                  END;
              end;
    }*/
        /*modify("Calculate TDS")
        {
            trigger OnBeforeAction()
            begin
                RCM_CHECKING;
                CONSTRUCTION_HEAD_CHECKING;
                GSTROUNDINGPRECISION;
            end;
        }*/
        modify(CopyDocument)
        {
            Promoted = true;
        }
        /*modify("Update Reference Invoice No")
        {
            Promoted = true;
        }*/
        modify(Post)
        {
            Promoted = true;
            PromotedIsBig = true;
            trigger OnBeforeAction()
            var
            User: Record User;
            Pstdt: Date;
            begin

                // NAVIN
                //sreenivas
                //by durga 0n 11-08-2021
                User.RESET;
                User.SETFILTER("User Name", USERID);
                IF User.FINDFIRST THEN
                    Pstdt := 20220331D;
                IF User."User Name" IN ['EFFTRONICS\21TE072', 'EFFTRONICS\GRAVI'] THEN
                    IF (Rec."Posting Date" <= Pstdt) AND (Rec."Vendor Invoice Date" <= Pstdt) THEN
                        ERROR('Posting Date is not in allowed range.');
                Narration_Check();
                Location_Mismatch_Not;
                RCM_CHECKING;
                ForeignBills_LCY_CHECKING(Rec."No."); //added by Vishnu Priya on 30-07-2019
                NewlyAdded_Lines_Details_Checking; // added by Vishnu Priya for the New Lines Insertion in the Invoice
                CONSTRUCTION_HEAD_CHECKING;
                GSTROUNDINGPRECISION;
                //Rec.TESTFIELD(Structure);
                Rec.TESTFIELD("Payment Terms Code");
                Rec.TESTFIELD("Vendor Invoice Date");
                //IF "Form Code"='' THEN
                //ERROR('Please Enter Form Code');

                /* IF "Transporter Name" = '' THEN
                ERROR('Enter Transporter Name');

                IF "Vehicle Number" = '' THEN
                ERROR('Enter Vehicle Number'); */


                month1 := TODAY;
                day1 := DATE2DMY(TODAY, 1);
                IF day1 = 15 THEN
                    month2 := TODAY() - 15
                ELSE
                    month2 := TODAY() - 45;

                IF (Rec."Posting Date" <= month2) then //AND (Structure = 'PUR-VAT') THEN//EFFUPG
                    ERROR('You are Not Supposed to Post this Bill with this posting date which was already included in the Previous month Vat Returns');
                IF Rec."Vendor Invoice Date" > TODAY() THEN // Condition Added by Pranavi on 13-Jan-16 for not allowing to post with future vendor inv date
                    ERROR('Vendor Invoice Date must be <= today!');

                /* IF (Structure='PUR-VAT') OR (Structure='PURC-E+VAT')THEN
                BEGIN
                 IF PurchaseLine."VAT %age"=4.00 THEN
                 BEGIN
                   IF PurchaseLine."VAT Prod. Posting Group"<>'4%' THEN
                   ERROR('Vat Prod. Posting Group is not same with vat percentage');
                 END;
                 IF PurchaseLine."VAT %age"=12.5 THEN
                 BEGIN
                   IF PurchaseLine."VAT Prod. Posting Group"<>'12.50%' THEN
                   ERROR('Vat Prod. Posting Group is not same with vat percentage');
                 END;
                 IF PurchaseLine."VAT %age"=14.5 THEN
                 BEGIN
                   IF PurchaseLine."VAT Prod. Posting Group"<>'14.5%' THEN
                   ERROR('Vat Prod. Posting Group is not same with vat percentage');
                 END;

                END; */
                //Commented by Damu Because fields does not exists

                /* IF (State<>'ANP') THEN
                BEGIN
                IF PurchaseLine."VAT Amount"<>0 THEN
                ERROR('Your Taken Wrong Strcture for the Supplier whose state belongs other than AndhraPradesh');
                END; */
                //sreenivas
                //Commented by Damu Because fields does not exists
                Non_Availment_chk(); // added by sujani on 11-06-2018
                Narration_Check();// added by sujani on 17-02-2019
                Location_Mismatch_Not;
                PurchLine.RESET;
                PurchLine.SETRANGE(PurchLine."Document No.", Rec."No.");
                PurchLine.SETFILTER(PurchLine."No.", '<>%1', '');
                IF PurchLine.FINDSET THEN
                    REPEAT
                        IF (PurchLine."Shortcut Dimension 1 Code" <> Rec."Shortcut Dimension 1 Code") THEN
                            ERROR('Select again the Department Code at Header');

                        IF (PurchLine."Gen. Bus. Posting Group" = 'FOREIGN') THEN BEGIN
                            IF (PurchLine."Direct Unit Cost" = PurchLine."Unit Cost (LCY)") THEN
                                ERROR('"Direct Unit Cost" & "Unit Cost(LCY)" will not be Equal for the "Foriegn Vendor"');
                        END;

                        IF PurchLine."Direct Unit Cost" = 0 THEN
                            ERROR('Item Should Have Minimum Value');

                        IF PurchLine."Tax Group Code" = '2%' THEN BEGIN
                            IF Rec."Transporter Name" = '' THEN
                                ERROR('Enter Transporter Name');

                            IF Rec."Vehicle Number" = '' THEN
                                ERROR('Enter Vehicle Number');
                        END;
                    //IF (PurchLine."Excise Amount" > 0) AND (Rec."Tarrif Heading No" = '') THEN    // Added by Pranavi on 23-Nov-2016//EFFUPG
                    //IF (PurchLine."Location Code"<>"Location Code") THEN
                    //   ERROR('Enter Excise Tarrif Heading No. in general Tab!');//EFFUPG
                    //IF (PurchLine."Location Code"<>"Location Code") THEN
                    // ERROR('Select same Purchase Line Location code at Header Part');
                    UNTIL PurchLine.NEXT = 0;

                PurchLine.RESET;
                PurchLine.SETRANGE(PurchLine."Document No.", Rec."No.");
                PurchLine.SETFILTER(PurchLine."Receipt No.", '<>%1', '');
                IF PurchLine.FINDSET THEN
                    REPEAT
                        "Purch.Rcpt.Header".RESET;
                        "Purch.Rcpt.Header".SETFILTER("Purch.Rcpt.Header"."No.", PurchLine."Receipt No.");
                        "Purch.Rcpt.Header".SETFILTER("Purch.Rcpt.Header"."Bill Received", '%1', FALSE);
                        IF "Purch.Rcpt.Header".FINDFIRST THEN BEGIN
                            ERROR('Bill is Not Received for receipt %1', PurchLine."Receipt No.");
                        END;
                        "Purch.Rcpt.Header".RESET;
                        "Purch.Rcpt.Header".SETFILTER("Purch.Rcpt.Header"."No.", PurchLine."Receipt No.");
                        "Purch.Rcpt.Header".SETFILTER("Purch.Rcpt.Header"."Bill Transfered", '%1', FALSE);
                        IF "Purch.Rcpt.Header".FINDFIRST THEN BEGIN
                            ERROR('Bill is Not Transferred for receipt %1', PurchLine."Receipt No.");
                        END;
                    UNTIL PurchLine.NEXT = 0;

                PurchLine.RESET;
                PurchLine.SETRANGE(PurchLine."Document No.", Rec."No.");
                PurchLine.SETFILTER(PurchLine."Purchase_Order No.", '<>%1', '');
                IF PurchLine.FINDSET THEN
                    REPEAT
                        PH.RESET;
                        PH.SETFILTER(PH."No.", PurchLine."Purchase_Order No.");
                        PH.SETFILTER(PH.Status, '%1', 1);
                        IF NOT PH.FINDFIRST THEN
                            ERROR('%1 must be in released mode', PurchLine."Purchase_Order No.");
                    UNTIL PurchLine.NEXT = 0;



                /*IF Structure <> '' THEN BEGIN
                    PurchLine.CalculateStructures(Rec);
                    PurchLine.AdjustStructureAmounts(Rec);
                    PurchLine.UpdatePurchLines(Rec);
                    COMMIT;
            END;*/
                PH.SETRANGE(PH."No.", Rec."No.");
                IF PH.FINDFIRST THEN BEGIN
                    /*  IF (PH.Structure = 'PURC-E+CST') OR (PH.Structure = 'PURC-E+VAT') OR (PH.Structure = 'PUR+EF+VAT') OR (PH.Structure = 'P-E+CST+AD') OR
                         (PH.Structure = 'P-E+VAT+AD') THEN BEGIN*/
                    /* IF PH."Type of Supplier" = PH."Type of Supplier"::"First Stage Dealer" THEN BEGIN
          IF PH."Additional Duty Value" = 0 THEN
              ERROR('Please Fill The Additional Duty Value');
      END; */

                    VENDOR.RESET;
                    VENDOR.SETRANGE(VENDOR."No.", Rec."Buy-from Vendor No.");
                    IF VENDOR.FINDFIRST THEN BEGIN
                        //IF VENDOR."E.C.C. No." = '' THEN//EFFUPG
                        //     ERROR('You need to give Supplier ECC No at Vendor Card');//EFFUPG
                        IF VENDOR."Currency Code" <> Rec."Currency Code" THEN
                            ERROR('CURRENCY CODE IN VENDOR & INVOCIE MUST BE SAME');

                    END;
                    /*IF PH."Vendor Excise Invoice No." = '' THEN
                        ERROR('Please Fill the Excise Invoice No.');*/
                END;
                /*  IF (PH.Structure = 'PURC-E+CST') OR (PH.Structure = 'P-C-E-CST') OR (PH.Structure = 'P-SERV+CST') OR (PH.Structure = 'P-E+CST+AD') OR
                     (PH.Structure = 'PURC-CST') OR (PH.Structure = 'PURCH-CST1') OR (PH.Structure = 'PUR-CST-SH') OR (PH.Structure = 'PUR+CST+PF') THEN BEGIN
                      PurchLine.RESET;
                      PurchLine.SETRANGE(PurchLine."Document No.", Rec."No.");
                      PurchLine.SETFILTER(PurchLine."No.", '<>%1', '');
                      IF PurchLine.FINDSET THEN BEGIN
                          IF PurchLine."Tax %" <= 2 THEN BEGIN
                              IF PH."Form Code" <> 'C' THEN
                                  ERROR('THE FORM CODE MUST BE C');
                          END
                          ELSE
                              IF PH."Form Code" = 'C' THEN
                                  ERROR('THE FORM CODE MUST NOT BE C');
                      END;
                  END;*/ //B2BUPG


                IF ((Rec."Posting No. Series" <> 'JV') AND (Rec."Posting No. Series" <> 'JV_INV_CF')) THEN BEGIN
                    PurchLine.RESET;
                    PurchLine.SETRANGE(PurchLine."Document No.", Rec."No.");
                    PurchLine.SETFILTER(PurchLine."No.", '<>%1', '');
                    PurchLine.SETFILTER(Quantity, '>%1', 0);
                    PurchLine.SETRANGE("Purchase_Order No.", '');
                    PurchLine.SETFILTER(Type, '<>%1', PurchLine.Type::"Charge (Item)");
                    IF PurchLine.FINDFIRST THEN BEGIN
                        ERROR('Please select Option JV or JV_INV_CF because there is no Purchase Order');
                    END;
                END;

                IF (NOT Rec."Purchase Journal") AND ((Rec."Posting No. Series" <> 'JV') OR (Rec."Posting No. Series" <> 'JV_INV_CF')) THEN
                    ERROR('Please Take the Purchase Journal')

            end;
        }
        modify(PostAndPrint)
        {
            Promoted = true;
            PromotedIsBig = true;
            trigger OnBeforeAction()
            var
                PurachaseLin: Record "Purchase Line";
                GLE: Record "G/L Entry";
                lastinvocieno: Text;
            begin
                // NAVIN
                Narration_Check();// added by sujani on 17-02-2019
                Location_Mismatch_Not;
                // Rec.TESTFIELD(Structure);
                Rec.TESTFIELD("Payment Terms Code");
                Rec.TESTFIELD("Vendor Invoice Date");
                RCM_CHECKING;
                ForeignBills_LCY_CHECKING(Rec."No."); //added by Vishnu Priya on 30-07-2019
                CONSTRUCTION_HEAD_CHECKING;
                GSTROUNDINGPRECISION;
                Non_Availment_chk(); // added by sujani on 11-06-2018

                IF ((Rec."Posting No. Series" <> 'JV') AND (Rec."Posting No. Series" <> 'JV_INV_CF')) THEN BEGIN
                    PurchLine.RESET;
                    PurchLine.SETRANGE(PurchLine."Document No.", Rec."No.");
                    PurchLine.SETFILTER(PurchLine."No.", '<>%1', '');
                    PurchLine.SETFILTER(Quantity, '>%1', 0);
                    PurchLine.SETRANGE("Purchase_Order No.", '');
                    IF PurchLine.FINDSET THEN BEGIN
                        ERROR('Please select Option JV or JV_INV_CF because there is no Purchase Order');
                    END;
                END;
                IF (Rec."Posting No. Series" <> 'JV') AND (Rec."Posting No. Series" <> 'JV_INV_CF') THEN
                    ERROR('Please choose JV Series');
                /*  IF Structure <> '' THEN BEGIN
                      PurchLine.CalculateStructures(Rec);
                      PurchLine.AdjustStructureAmounts(Rec);
                      PurchLine.UpdatePurchLines(Rec);
                      COMMIT;
                  END;*/
            end;

            trigger OnAfterAction()
            begin
                MESSAGE('Entry posted Success fully');
                COMMIT;
                GLE.RESET;
                GLE.SETFILTER(GLE."Document No.", Rec."Last Posting No.");
                IF GLE.FINDFIRST THEN BEGIN
                    REPORT.RUNMODAL(33000907, TRUE, FALSE, GLE);
                END;
            end;
        }
        modify(Preview)
        {
            trigger OnBeforeAction()
            begin
                Narration_Check();// added by sujani on 17-02-2019
                Location_Mismatch_Not;
                RCM_CHECKING;
                CONSTRUCTION_HEAD_CHECKING;
                GSTROUNDINGPRECISION;
                ForeignBills_LCY_CHECKING(Rec."No."); //added by Vishnu Priya on 30-07-2019
                NewlyAdded_Lines_Details_Checking; // added by Vishnu Priya for the New Lines Insertiopren in the Invoice
                Commit;//EFFUPG1.2
            end;
        }
        modify(TestReport)
        {
            trigger OnBeforeAction()
            begin
                IF "Posting Date" < "Document Date" THEN
                    ERROR('POsting date should be greater or equal to the document date.PLease check');
                Location_Mismatch_Not;
                RCM_CHECKING;
                ForeignBills_LCY_CHECKING(Rec."No."); //added by Vishnu Priya on 30-07-2019
                NewlyAdded_Lines_Details_Checking; // added by Vishnu Priya for the New Lines Insertion in the Invoice
                CONSTRUCTION_HEAD_CHECKING;
                GSTROUNDINGPRECISION;
                Non_Availment_chk(); // added by sujani on 11-06-2018
                Commit(); //B2BUpg
            end;
        }
        addafter(Approvals)
        {
            action("&MSPT Order Details")
            {
                Caption = '&MSPT Order Details';
                RunObject = Page "MSPT Order Details";
                RunPageLink = Type = CONST(Purchase), "Document Type" = FIELD("Document Type"), "Document No." = FIELD("No."), "MSPT Header Code" = FIELD("MSPT Code"), "Party Type" = CONST(Vendor), "Party No." = FIELD("Buy-from Vendor No.");
                ApplicationArea = All;
            }
        }
        addafter(Comment)
        {
            separator(Action1102152004)
            {
            }
            action(Action1102152005)
            {
                Caption = '&MSPT Order Details';
                RunObject = Page "MSPT Order Details";
                RunPageLink = Type = CONST(Purchase), "Document Type" = FIELD("Document Type"), "Document No." = FIELD("No."), "MSPT Header Code" = FIELD("MSPT Code"), "Party Type" = CONST(Vendor), "Party No." = FIELD("Buy-from Vendor No.");
                ApplicationArea = All;
            }
        }
        addafter(PostBatch)
        {
            action(TestAction)
            {
                ApplicationArea = All;

                trigger OnAction();
                var
                    GLE: Record "G/L Entry";
                    lastinvocieno: Text;
                begin
                    lastinvocieno := Rec."Last Posting No.";
                    GLE.RESET;
                    GLE.SETFILTER("Document No.", lastinvocieno);
                    IF GLE.FINDFIRST THEN BEGIN
                        //REPORT.RUN(33000907,FALSE,TRUE,GLE);
                        REPORT.RUNMODAL(33000907, TRUE, FALSE, GLE);
                    END;
                end;
            }
            action(TestCu)
            {
                Caption = 'TestCus';
                ApplicationArea = All;

                trigger OnAction();
                begin
                    //RCM_CHECKING;
                    CONSTRUCTION_HEAD_CHECKING;
                    GSTROUNDINGPRECISION;
                end;
            }
            action(LocationCodeTrack)
            {
                ApplicationArea = All;

                trigger OnAction();
                begin
                    MESSAGE('Dummy');
                end;
            }
        }
    }


    trigger OnOpenPage()
    begin

        /*  IF "Purchase Journal" = TRUE
           THEN
             CurrPage.EDITABLE := FALSE; */
        //SetDocNoVisible;
        DocNoVisible := TRUE;   // Pranavi on 19-Apr-2017
        IF Rec."Buy-from Vendor No." <> '' THEN BEGIN
            VENDOR.RESET;
            VENDOR.SETFILTER(VENDOR."No.", Rec."Buy-from Vendor No.");
            IF VENDOR.FINDFIRST THEN
                Rec."GST Vendor Type" := VENDOR."GST Vendor Type";
            Rec.MODIFY;
            IF (Rec.Status = Rec.Status::Open) THEN BEGIN
                PL.RESET;
                PL.SETFILTER(PL."Document No.", Rec."No.");
                IF PL.FINDSET THEN
                    REPEAT
                        IF (PL.Type = PL.Type::Item) AND (PL."No." <> '') THEN BEGIN
                            item.GET(PL."No.");
                            IF (PL."HSN/SAC Code" = '') THEN
                                PL."HSN/SAC Code" := item."HSN/SAC Code";
                            IF (PL."GST Group Code" = '') THEN
                                PL."GST Group Code" := item."GST Group Code";
                            PL.VALIDATE(Quantity, PL.Quantity);
                        END;
                    UNTIL PL.NEXT = 0;
            END;
        END;
    end;

    trigger OnAfterGetRecord()
    begin
        IF Rec."Purchase Journal" = TRUE
                           THEN BEGIN
            editable_pg := FALSE;
            purinvsubform.EDITABLE := editable_pg;
            purinvsubform.UPDATE;
        END
        ELSE BEGIN
            editable_pg := TRUE;
            purinvsubform.EDITABLE := editable_pg;
            purinvsubform.UPDATE;
        END;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Vehicle Number" := 'BY COURIER';   // Added by Pranavi on 07-Jul-2016
    end;

    var
        MLTransactionType: Option Purchase,Sale;
        "--B2B--": Integer;
        PurchaseLine: Record "Purchase Line";
        PH: Record "Purchase Header";
        VENDOR: Record Vendor;
        month1: Date;
        month2: Date;
        day1: Integer;
        day2: Integer;
        "G|L": Record "General Ledger Setup";
        tEMP: Text[1000];
        Purchline2: Record "Purchase Line";
        "Purch.Rcpt.Line": Record "Purch. Rcpt. Line";
        "Purch.Rcpt.Header": Record "Purch. Rcpt. Header";
        Text19023272: Label 'Buy-from Vendor';
        Text19005663: Label 'Pay-to Vendor';
        PL: Record "Purchase Line";
        item: Record Item;
        editable_pg: Boolean;
        VendorInvoiceNoMandatory: Boolean;
        Salinv: Record "Sales Invoice-Dummy";
        PurchLine: Record "Purchase Line";
        GLE: Record "G/L Entry";
        purinvsubform: Page "Purch. Invoice Subform";
        DocNoVisible: Boolean;
        GPS: Record "General Posting Setup";
        PCL: Record "Purch. Comment Line";
        PurchaseOrderNumber: Text[30];

    local procedure ReceiptTesting();
    begin
    end;


    local procedure Non_Availment_chk();
    begin
        PL.RESET;
        PL.SETRANGE("Document No.", Rec."No.");
        IF PL.FINDSET THEN BEGIN
            REPEAT
                IF PL.Type = PL.Type::"G/L Account" THEN BEGIN
                    IF PL."No." IN ['19319', '64500', '19324', '39500', '65402'] THEN // food and beverages and Staff Welfare GST Credit Non Availment checking
                      BEGIN
                        IF PL."GST Credit" <> PL."GST Credit"::"Non-Availment" THEN
                            ERROR('GST Credit must be Non-Availment for the Line-%1 & Head-%2', PL."Line No.", PL."No.");
                    END;
                END
                ELSE
                    IF PL.Type = PL.Type::Item THEN BEGIN
                        GPS.RESET;
                        GPS.SETRANGE("Gen. Bus. Posting Group", PL."Gen. Bus. Posting Group");
                        GPS.SETRANGE("Gen. Prod. Posting Group", PL."Gen. Prod. Posting Group");
                        IF GPS.FINDFIRST THEN BEGIN
                            IF GPS."Purch. Account" IN ['19319', '64500', '19324', '39500', '65402'] THEN // food and beverages and Staff Welfare GST Credit Non Availment checking
                            BEGIN
                                IF PL."GST Credit" <> PL."GST Credit"::"Non-Availment" THEN
                                    ERROR('GST Credit must be Non-Availment for the Line-%1 & Item-%2', PL."Line No.", PL."No.");
                            END;
                        END;
                    END;
            UNTIL PL.NEXT = 0;
        END;
    end;


    local procedure RCM_CHECKING();
    begin
        //commented by Vishnu

        PurchLine.RESET;
        PurchLine.SETRANGE("Document No.", Rec."No.");
        PurchLine.SETFILTER("No.", '%1|%2|%3|%4', '19315', '48200', '51400', '58500');
        IF PurchLine.FINDSET THEN BEGIN
            REPEAT
                IF PurchLine."Amount To Vendor" > 1500 THEN BEGIN
                    IF Rec."GST Vendor Type" <> Rec."GST Vendor Type"::Registered THEN BEGIN
                        IF NOT (PurchLine."GST Group Code" IN ['RCM', '5% RCM', 'RCM-5%']) THEN
                            ERROR('Kindly raise RCM invoice for freight charges above Rs:1,500/- ')
                    END
                END

            UNTIL PurchLine.NEXT = 0
        END;


        //Commented by Vishnu
    end;

    local procedure CONSTRUCTION_HEAD_CHECKING();
    begin
        //added by Vishnu Priya on 02-02-2019
        PurchLine.RESET;
        PurchLine.SETFILTER("Document No.", Rec."No.");
        PurchLine.SETRANGE(PurchLine.Type, PurchLine.Type::"G/L Account");
        PurchLine.SETRANGE("No.", '19301', '19341');
        IF PurchLine.FINDSET THEN BEGIN
            IF Rec."Location Code" <> 'CONSTRUCTI' THEN
                ERROR('GL Heads are of Construction. So please pick Construction Head in the header');
        END;
    end;

    procedure Narration_Check();
    begin
        IF ("Posting No. Series" IN ['JV', 'JV_INV_CF']) THEN BEGIN
            PCL.RESET;
            PCL.SETFILTER("No.", Rec."No.");
            IF PCL.FINDSET THEN BEGIN
                MESSAGE(PCL."No.");
                IF (PCL.Comment = '') THEN
                    ERROR('Please write the narration in comment')
                ELSE
                    MESSAGE(PCL.Comment);
            END
            ELSE
                //MESSAGE(PCL.Comment);
                ERROR('Please write the narration in comment')
            //MESSAGE(Rec."No.");

        END;
    end;

    local procedure ForeignBills_LCY_CHECKING(InvoiceNumber: Code[25]);
    begin
        /* IF Rec.Structure = 'PUR_FR_GST' THEN BEGIN
            Structurehead.RESET;
            Structurehead.SETFILTER("Document No.", InvoiceNumber);
            Structurehead.SETFILTER("Calculation Value", '>%1', 0);
            Structurehead.SETFILTER("Tax/Charge Group", 'CUSTOMS DU');
            Structurehead.SETRANGE(LCY, FALSE);
            IF Structurehead.FINDFIRST THEN BEGIN
                ERROR('Please select the LCY Tickmark for the Line Number- ' + FORMAT(Structurehead."Document No."));
            END;
        END; */
    end;

    local procedure NewlyAdded_Lines_Details_Checking();
    begin

        PL.RESET;
        PL.SETFILTER("Document No.", Rec."No.");
        PL.SETFILTER("No.", '<>%1', '');
        PL.SETFILTER("Purchase_Order No.", '=%1', '');
        IF PL.FINDSET THEN
            REPEAT
            BEGIN
                PurchaseOrderNumber := FirstPurchaseOrderNumber;
                PurchLine.RESET;
                PurchLine.SETFILTER("Document No.", Rec."No.");
                PurchLine.SETFILTER("No.", '<>%1', '');
                PurchLine.SETFILTER("Purchase_Order No.", '<>%1&<>%2', PurchaseOrderNumber, '');
                IF PurchLine.FINDFIRST THEN
                    ERROR('There are 2 Purchase Orders in the Lines. So Please Pick valid Pur Order Number for the Line:' + FORMAT(PL."Line No."))
                ELSE
                    PL."Purchase_Order No." := PurchaseOrderNumber;
                PL.MODIFY;
            END
            UNTIL PL.NEXT = 0;

        PL.RESET;
        PL.SETFILTER("Document No.", Rec."No.");
        PL.SETFILTER("No.", '<>%1', '');
        PL.SETFILTER("Purchase_Order No.", '<>%1', '');
        IF PL.FINDSET THEN
            REPEAT
                IF PL."Gen. Bus. Posting Group" = '' THEN
                    ERROR('Please enter the Gen. Bus. Posting Group for the line:' + FORMAT(PL."Line No."))
                ELSE
                    IF PL."Gen. Prod. Posting Group" = '' THEN
                        ERROR('Please enter the Gen. Prod. Posting Group for the line:' + FORMAT(PL."Line No."));
            UNTIL PL.NEXT = 0
    end;


    local procedure FirstPurchaseOrderNumber() PONUMBER: Text[30];
    begin
        Purchline2.RESET;
        Purchline2.SETFILTER("Document No.", Rec."No.");
        Purchline2.SETFILTER("No.", '<>%1', '');
        Purchline2.SETFILTER("Purchase_Order No.", '<>%1', '');
        IF Purchline2.FINDFIRST THEN
            PONUMBER := Purchline2."Purchase_Order No.";
    end;


    procedure Location_Mismatch_Not();
    begin
        // Added by Vishnu Priya on 03-12-2020
        PurchLine.RESET;
        PurchLine.SETFILTER("Document No.", Rec."No.");
        PurchLine.SETFILTER(Quantity, '>%1', 0);
        IF PurchLine.FINDSET THEN
            REPEAT
                IF Rec."Location Code" <> PurchLine."Location Code" THEN
                    ERROR('Select the same Location code in both Header and Line. In Line Number %1 is  different with Header Location', FORMAT(PurchLine."Line No."));
            UNTIL PurchLine.NEXT = 0;
        // Added by Vishnu Priya on 03-12-2020
    end;

    procedure GSTROUNDINGPRECISION();
    begin
        //added by Vishnu priya on 22-12-2020
        IF (Rec."GST Inv. Rounding Precision" = 0) AND (Rec."Currency Factor" > 0) THEN
            ERROR('Please fill the GST Rounding Precision Value in the Tax Information Tab');
    end;
}

