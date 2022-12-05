pageextension 70059 FixedAssetCardExt extends "Fixed Asset Card"
{
    layout
    {
        /* modify("Control 1000000000")
         {
             Visible = false;
         }*/

        modify("FA Subclass Code")
        {
            ShowMandatory = true;
        }
        modify("FA Location Code")
        {
            ShowMandatory = true;
        }
        modify("GST Group Code")
        {
            ShowMandatory = true;
        }

        addafter("No.")
        {
            field("Location Code"; Rec."Location Code")
            {
                ApplicationArea = All;
                ShowMandatory = true;
            }
        }
        addafter("Responsible Employee")
        {
            field("Responsible Emp Name"; Rec."Responsible Emp Name")
            {
                Editable = false;
                ApplicationArea = All;
            }
        }
        addafter("Last Date Modified")
        {
            field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
            {
                ApplicationArea = All;
            }
            field("Global Dimension 1 Code";"Global Dimension 1 Code")
            {
                ApplicationArea =All;
            }
            field(Verified; Rec.Verified)
            {
                ApplicationArea = All;

                trigger OnValidate();
                begin
                    IF NOT (USERID IN ['EFFTRONICS\ANANDA']) THEN
                        ERROR('You dont have rights to Verify');
                end;
            }
            field("Verified Date"; Rec."Verified Date")
            {
                Editable = false;
                ApplicationArea = All;
            }
            
        }
        addbefore(Maintenance)
        {
            /* field("GST Calc. Option on Transfer"; "GST Calc. Option on Transfer")
             {
                 ApplicationArea = All;
             }*/
            field("Service Tax Group Code"; Rec."Service Tax Group Code")
            {
                ApplicationArea = All;
            }
            field("Item Sub Sub Group Code"; Rec."Item Sub Sub Group Code")
            {
                ApplicationArea = All;
            }
            field("QR Code"; Rec."QR Code")
            {
                ApplicationArea = All;
            }
            field("FA Posting Group"; Rec."FA Posting Group")
            {
                ApplicationArea = All;
                ShowMandatory = true;
            }
        }
        addafter("Next Service Date")
        {
            field("AMC No."; Rec."AMC No.")
            {
                ApplicationArea = All;
            }
            field("AMC Date"; Rec."AMC Date")
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {






        /* modify("Action 51")
         {


             Promoted = true;



         }
         modify("Action 40")
         {


             Promoted = true;



         }



         modify("Action 35")
         {



             Promoted = true;


         }






         modify("C&opy Fixed Asset")
         {



             Promoted = true;



         }


         modify("M&ain Asset Components")
         {



             Promoted = true;


         }



         modify("Ledger E&ntries")
         {


             Promoted = false;



         }



         modify("Main&tenance Ledger Entries")
         {


             Promoted = true;



         }


         modify(CalculateDepreciation)
         {
             Promoted = true;
         }



         modify("Action 1907091306")
         {


             Promoted = true;



         }
         modify("Action 1903109606")
         {



             Promoted = false;



         }
         modify(Details)
         {


             Promoted = true;



         }
         modify("Action 1905598506")
         {



             Promoted = false;



         }
         modify("Action 1905598606")
         {


             Promoted = false;


         }
         modify("Action 1901105406")
         {


             Promoted = true;



         }
         modify("Projected Value")
         {



             Promoted = true;



         }
         modify("Action 1903345906")
         {


             Promoted = false;



         }
         modify("Action 1903807106")
         {


             Promoted = true;



         }*/
        addafter("C&opy Fixed Asset")
        {
            separator(Action1102152004)
            {
            }
            action("F&A Location Transfer Entries")
            {
                Caption = 'F&A Location Transfer Entries';
                Image = TransferReceipt;
                ApplicationArea = All;

                trigger OnAction();
                var
                    FixedAssetTransfer: Record "Fixed Asset Transfer";
                    FixedAssetTransferForm: Page "Fixed Asset Transfer";
                begin
                    FixedAssetTransfer.SETRANGE("Fixed Asset No.", Rec."No.");
                    FixedAssetTransfer.SETFILTER("FA New Location", '<>%1', '');
                    IF PAGE.RUNMODAL(60006, FixedAssetTransfer) = ACTION::LookupOK THEN;
                end;
            }
            action("F&A Employee Transfer Entries")
            {
                Caption = 'F&A Employee Transfer Entries';
                Image = EmployeeAgreement;
                ApplicationArea = All;

                trigger OnAction();
                var
                    FixedAssetTransfer: Record "Fixed Asset Transfer";
                begin
                    FixedAssetTransfer.SETRANGE("Fixed Asset No.", Rec."No.");
                    FixedAssetTransfer.SETFILTER("New Responsible Employee", '<>%1', '');
                    IF PAGE.RUNMODAL(60007, FixedAssetTransfer) = ACTION::LookupOK THEN;
                end;
            }
        }
        addafter("FA Posting Types Overview")
        {
            action("Purchase Receipt")
            {
                Caption = 'Purchase Receipt';
                ApplicationArea = All;

                trigger OnAction();
                begin
                    PurchRcptLine.RESET;
                    PurchRcptLine.SETFILTER(PurchRcptLine."No.", Rec."No.");
                    PurchRcptLine.SETFILTER(PurchRcptLine.Quantity, '>%1', 0);
                    IF PurchRcptLine.FINDFIRST THEN BEGIN
                        PurchRcptHead.RESET;
                        PurchRcptHead.SETFILTER(PurchRcptHead."No.", PurchRcptLine."Document No.");
                        IF PurchRcptHead.FINDFIRST THEN BEGIN
                            PAGE.RUN(136, PurchRcptHead);
                        END;
                    END;
                end;
            }
        }
    }
    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    var
        myInt: Integer;
    begin
        /* {
          // Added by Pranavi on 02-Nov-2016
                      "VAT Product Posting Group" := 'NO VAT';
                      "FA Class Code" := 'TANGIBLE';
                      "Gen. Prod. Posting Group" := 'FIXED AST.';
                      "Excise Prod. Posting Group" := '12.5%';    // Need to be updated with excise % updated
                      "Tax Group Code" := 'FIXED ASSE';
                      "Excise Accounting Type" := "Excise Accounting Type"::"With CENTVAT";

                      FADeprBook.INIT;
                      FADeprBook."FA No." := "No.";
                      FADeprBook."Depreciation Book Code" := 'COMPANY';

                      IF COPYSTR("No.",1,4) = 'COMP' THEN
                      BEGIN
                        "FA Subclass Code" := 'COMPUTERS';
                        FADeprBook."FA Posting Group" := 'COMPUTERS';
                      END
                      ELSE IF COPYSTR("No.",1,3) = 'SW-' THEN
                      BEGIN
                        "FA Subclass Code" := 'SOFT WARE';
                        FADeprBook."FA Posting Group" := 'SOFTWARE';
                      END
                      ELSE IF COPYSTR("No.",1,3) = 'VEH' THEN
                      BEGIN
                        "FA Subclass Code" := 'VEHICLES';
                        FADeprBook."FA Posting Group" := 'VEHICLES';
                      END
                      ELSE IF COPYSTR("No.",1,3) = 'P&M' THEN
                      BEGIN
                        "FA Subclass Code" := 'PLANT &MAC';
                        FADeprBook."FA Posting Group" := 'PLA & MACH';
                      END
                      ELSE IF COPYSTR("No.",1,3) = 'O&E' THEN
                      BEGIN
                        "FA Subclass Code" := 'OFFICE';
                        FADeprBook."FA Posting Group" := 'OFF-EQUIP';
                      END
                      ELSE IF COPYSTR("No.",1,3) = 'MI-' THEN
                      BEGIN
                        "FA Subclass Code" := 'MOBILE INS';
                        FADeprBook."FA Posting Group" := 'MOBILE INS';
                      END
                      ELSE IF COPYSTR("No.",1,4) = 'LAND' THEN
                      BEGIN
                        "FA Subclass Code" := 'BUILDINGS';
                        FADeprBook."FA Posting Group" := 'LAND';
                      END
                      ELSE IF COPYSTR("No.",1,3) = 'GW-' THEN
                      BEGIN
                        FADeprBook."FA Posting Group" := 'GOODWILL';
                      END
                      ELSE IF COPYSTR("No.",1,3) = 'F&F' THEN
                      BEGIN
                        "FA Subclass Code" := 'FURNITURES';
                        FADeprBook."FA Posting Group" := 'FURN & FIX';
                      END;

                      FADeprBook.INSERT;
                      // End by Pranavi
                      }*/
    end;




    var
        PurchRcptLine: Record "Purch. Rcpt. Line";
        PurchRcptHead: Record "Purch. Rcpt. Header";



}

