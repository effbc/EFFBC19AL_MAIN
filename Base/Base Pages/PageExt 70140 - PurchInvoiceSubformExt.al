pageextension 70140 PurchInvoiceSubformExt extends "Purch. Invoice Subform"
{

    layout
    {
        /* modify("Control 1")
        {
            ShowCaption = false;
        }
        modify(Control39)
        {
            ShowCaption = false;
        }
        modify(Control33)
        {
            ShowCaption = false;
        }
        modify(Control15)
        {
            ShowCaption = false;
        }
        modify(RefreshTotals)
        {
            ShowCaption = false;
        } */
        modify("Line No.")
        {
            Visible = false;
        }
        addafter("No.")
        {
            field("Purchase_Order No."; Rec."Purchase_Order No.")
            {
                DrillDown = false;
                Lookup = true;
                LookupPageID = 50;
                ApplicationArea = All;

                trigger OnDrillDown();
                begin
                    /*IF PAGE.RUNMODAL(PAGE::"Purchase Order") = ACTION::DrillDown
                      THEN
                        "Purchase_Order No." := "Purchase Order".No_;*/
                    //CODEUNIT.RUN(CODEUNIT::"Show Avg. Calc. - Item",Rec);
                    // PAGE.RUN(PAGE::"Purchase Order",Rec);

                end;

                trigger OnLookup(var Text: Text): Boolean;
                begin
                    PH.RESET;
                    PH.SETFILTER("No.", Rec."Purchase_Order No.");
                    IF PH.FINDFIRST THEN
                        PAGE.RUNMODAL(50, PH);
                end;
            }
        }
        /*  field("Excise Amount"; "Excise Amount")
          {
              ApplicationArea = All;
          }
          field("CESS Amount"; "CESS Amount")
          {
              ApplicationArea = All;
          }
          field("VAT Calculation Type"; "VAT Calculation Type")
          {
              ApplicationArea = All;
          }
          field("Frieght Charges"; "Frieght Charges")
          {
              ApplicationArea = All;
          }
          field("Tax Amount"; "Tax Amount")
          {
              ApplicationArea = All;
          }
          field("Gen. Bus. Posting Group"; "Gen. Bus. Posting Group")
          {
              ApplicationArea = All;
          }
          field("Service Tax Group"; "Service Tax Group")
          {
              ApplicationArea = All;
          }
          field("Currency Code"; "Currency Code")
          {
              ApplicationArea = All;
          }
          field("QC Enabled"; "QC Enabled")
          {
              ApplicationArea = All;
          }
          field("Excise Bus. Posting Group"; "Excise Bus. Posting Group")
          {
              Editable = true;
              ApplicationArea = All;
          }
          field("Charges To Vendor"; "Charges To Vendor")
          {
              ApplicationArea = All;
          }
          field("VAT Bus. Posting Group"; "VAT Bus. Posting Group")
          {
              ApplicationArea = All;
          }
          field("Excise Prod. Posting Group"; "Excise Prod. Posting Group")
          {
              ApplicationArea = All;
          }

          field("Amount To Vendor"; "Amount To Vendor")
          {
              ApplicationArea = All;
          }
          field("Tax %"; "Tax %")
          {
              ApplicationArea = All;
          }
          field("Tax Base Amount"; "Tax Base Amount")
          {
              ApplicationArea = All;
          }
      }
      addafter("Indirect Cost %")
      {
          field("Unit Cost"; "Unit Cost")
          {
              ApplicationArea = All;
          }
      }
      addafter("Line Amount")
      {
          field("TDS Amount"; "TDS Amount")
          {
              ApplicationArea = All;
          }
          field("TDS %"; "TDS %")
          {
              ApplicationArea = All;
          }
      }
      addbefore("Job No.")
      {
          field("GST %"; "GST %")
          {
              ApplicationArea = All;
          }

      }*/
        addafter("Job Line Discount %")
        {
            field("GST Reverse Charge"; Rec."GST Reverse Charge")
            {
                Editable = true;
                ApplicationArea = All;
            }
        }
        addafter("Shortcut Dimension 2 Code")
        {
            field(Sample; Rec.Sample)
            {
                ApplicationArea = All;
            }
        }
        addafter(ShortcutDimCode8)
        {
            /* field("TDS Group"; "TDS Group")
             {
                 ApplicationArea = All;
             }
             field("Assessee Code"; "Assessee Code")
             {
                 ApplicationArea = All;
             }*/
            field("Receipt No."; Rec."Receipt No.")
            {
                Lookup = true;
                LookupPageID = 136;
                ApplicationArea = All;

                trigger OnLookup(var Text: Text): Boolean;
                begin
                    PRH.RESET;
                    PRH.SETFILTER("No.", Rec."Receipt No.");
                    IF PRH.FINDFIRST THEN BEGIN
                        PAGE.RUNMODAL(136, PRH);
                    END;
                end;
            }
        }
    }
    actions
    {
        modify(GetReceiptLines)
        {
            trigger OnBeforeAction()
            begin
                TotalPurchaseHeader.RESET;
                TotalPurchaseHeader.SETRANGE("No.", Rec."Document No.");
                IF TotalPurchaseHeader.FINDFIRST THEN BEGIN
                    IF TotalPurchaseHeader."Purchase Journal" = TRUE
                      THEN
                        ERROR('Final Print Already Taken You can not pick the Receipts now')
                    ELSE
                        ;
                end;
            end;
        }


    }


    trigger OnOpenPage()
    begin
        /* IF PurchHeader."Purchase Journal" = TRUE
                    THEN BEGIN
             CurrPage.EDITABLE(FALSE);
             CurrPage.UPDATE;
         END; */
    end;

    var
        "--B2b--": Integer;
        PurchInfoPaneMgt: Codeunit "Purchases Info-Pane Management";
        PH: Record "Purchase Header";
        PRH: Record "Purch. Rcpt. Header";


    procedure StrOrderLineDetailsPage();
    begin
    end;
}

