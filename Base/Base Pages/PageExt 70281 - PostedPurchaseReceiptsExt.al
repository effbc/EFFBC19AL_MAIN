pageextension 70281 PostedPurchaseReceiptsExt extends 145
{
    layout
    {
        addfirst(Control1)
        {
            field(COUNT; Rec.COUNT)
            {
                ApplicationArea = All;

            }
        }
        addafter("No.")
        {
            field("Order No."; Rec."Order No.")
            {
                ApplicationArea = All;

            }
            field("Vendor Shipment No."; Rec."Vendor Shipment No.")
            {
                ApplicationArea = All;

            }
            field("Vendor Excise Invoice No."; Rec."Vendor Excise Invoice No.")
            {
                ApplicationArea = All;

            }
            field("Vendor Invoice Date"; Rec."Vendor Invoice Date")
            {
                ApplicationArea = All;

            }
        }

        addafter("Order Address Code")
        {
            field(Control1102152005; Rec."QC Passed")
            {
                Editable = FALSE;
                ApplicationArea = All;
            }
            field("Bill Received"; Rec."Bill Received")
            {
                ApplicationArea = All;

            }
            field("Bill Transfered"; Rec."Bill Transfered")
            {
                ApplicationArea = All;

            }
            field("Bill Transfered Date"; Rec."Bill Transfered Date")
            {
                ApplicationArea = All;

            }
        }
        addafter("Document Date")
        {
            field("User ID"; Rec."User ID")
            {
                ApplicationArea = All;

            }
        }
    }

    actions
    {
        addafter("&Navigate")
        {
            action("<AutoMailToVendors>")
            {
                Caption = 'Pending Bills Auto &Mai Vendors';
                Promoted = true;
                PromotedIsBig = true;
                Image = MailSetup;
                PromotedCategory = Process;
                ApplicationArea = All;
                trigger OnAction()
                begin
                    // Added by Vijaya on 24-May-2016 for Sending Mail For Bill no recieved Vendors
                    Vendor.RESET;
                    IF Vendor.FINDFIRST THEN BEGIN
                        Vendor.MODIFYALL(Vendor."Mail Required", FALSE);
                        COMMIT;
                    END;
                    Rec.RESET;
                    Rec.SETCURRENTKEY("Buy-from Vendor No.", "No.");
                    Rec.SETRANGE("Bill Received", FALSE);
                    Rec.SETRANGE("Bill Transfered", FALSE);
                    Rec.SETRANGE(Pending, FALSE);

                    IF Rec.FINDFIRST THEN
                        REPEAT
                            PRL.RESET;
                            PRL.SETFILTER(PRL."Document No.", Rec."No.");
                            PRL.SETFILTER(PRL."Qty. Rcd. Not Invoiced", '>%1', 0);
                            PRL.SETFILTER(PRL.Sample, '=%1', FALSE);
                            PRL.SETFILTER(PRL.Quantity, '>%1', 0);
                            IF PRL.FINDFIRST THEN BEGIN
                                Vendor.RESET;
                                Vendor.SETRANGE(Vendor."No.", Rec."Buy-from Vendor No.");
                                IF Vendor.FINDFIRST THEN BEGIN
                                    Vendor."Mail Required" := TRUE;
                                    Vendor.MODIFY;
                                END;
                            END;
                        UNTIL Rec.NEXT = 0;
                    VendorList.MailPusposeAssignment('Bill');
                    VendorList.RUN;
                    //End by Vijaya
                end;
            }
            separator(Action1102152004)
            {

            }
            action("QC Passed")
            {
                Caption = 'QC Passed';
                ApplicationArea = All;
                trigger OnAction()
                begin
                    PRH.RESET;
                    PRH.SETCURRENTKEY("No.", "Posting Date");
                    PRH.SETFILTER("Bill Transfered", 'FALSE');
                    PRH.SETFILTER("Bill Received", 'TRUE');
                    PRH.SETFILTER("Vendor Order No.", '<>%1', '');
                    IF PRH.FINDSET THEN
                        REPEAT
                        BEGIN
                            PRL.RESET;
                            PRL.SETCURRENTKEY("Document No.", "Line No.");
                            PRL.SETFILTER("Document No.", PRH."No.");
                            //PRL.SETFILTER("QC Passed",'TRUE');
                            IF PRL.FINDSET THEN
                                REPEAT
                                BEGIN
                                    IF PRL."QC Passed" = TRUE THEN
                                        PRL_QC_PASSED_ALL := TRUE
                                    ELSE
                                        PRL_QC_PASSED_ALL := FALSE;
                                END;
                                UNTIL PRL.NEXT = 0;
                            IF PRL_QC_PASSED_ALL = TRUE THEN BEGIN
                                PRH."QC Passed" := TRUE;
                                PRH.MODIFY;
                                // MESSAGE('QC Passed Updated for ' +PRH."No.");
                            END;
                            //  ELSE
                            //MESSAGE(FORMAT(PRH.COUNT));

                        END
                        UNTIL PRH.NEXT = 0;

                    MESSAGE('QC Passed Updated');
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        qc_passed_color_flag := FALSE;
        IF Rec."QC Passed" = TRUE THEN
            qc_passed_color_flag := TRUE
        ELSE
            qc_passed_color_flag := FALSE;
    end;

    var
        Vendor: Record Vendor;
        VendorList: Page "Purchase Automail VendorsList";
        PRL: Record "Purch. Rcpt. Line";
        PRH: Record "Purch. Rcpt. Header";
        PRL_QC_PASSED_ALL: Boolean;
        qc_passed_color_flag: Boolean;
}