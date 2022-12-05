tableextension 70018 CustGenJournalLineExt extends "Gen. Journal Line"
{
    fields
    {
        modify("Posting Date")
        {
            ClosingDates = true;
        }

        modify("Document Date")
        {
            ClosingDates = true;
        }

        field(60082; "Description1"; Text[250])
        {
            DataClassification = CustomerContent;
        }
        field(60083; "Message to Recipient1"; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(60019; "Vendor Invoice Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(60061; "Sale Order No"; Code[20])
        {
            TableRelation = "Sales Header"."No.";
            DataClassification = CustomerContent;
            ValidateTableRelation = false;
        }
        field(60062; "Sale invoice order no"; Code[20])
        {
            TableRelation = "Sales Invoice Header"."No.";
            DataClassification = CustomerContent;
        }
        field(60063; "Customer Ord no"; Code[65])
        {
            DataClassification = CustomerContent;
        }
        field(60064; "Payment Type"; Enum "CustPayment Type")
        {

            DataClassification = CustomerContent;
        }
        field(60065; "Sale Invoice No"; Code[20])
        {
            TableRelation = "Sales Invoice Header"."No." WHERE("Order No." = FIELD("Sale Order No"));
            DataClassification = CustomerContent;
        }
        field(60066; "Invoice no"; Code[10])
        {
            DataClassification = CustomerContent;
        }
        field(60067; "Purchase Order No."; Code[30])
        {
            Enabled = false;
            TableRelation = "Purchase Header"."No." WHERE("Document Type" = FILTER(Order),
                                                           "Buy-from Vendor No." = FIELD("Account No."));
            DataClassification = CustomerContent;
        }
        field(60068; "Amount Percentage"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(60069; "From Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(60070; "To Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(60071; "Validate Posting"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(60072; "Apply Entry No"; Integer)
        {
            DataClassification = CustomerContent;

            trigger OnLookup();
            begin
                //code added by sreenivas

                //DIM1.0 Start
                //Code Commnet
                /*
                GL.MARKEDONLY(FALSE);
                
                JLD.RESET;
                JLD.SETRANGE(JLD."Journal Line No.","Line No.");
                JLD.SETRANGE(JLD."Journal Batch Name","Journal Batch Name");
                JLD.SETFILTER(JLD."Table ID",'81');
                JLD.SETFILTER(JLD."Dimension Code",'EMPLOYEE CODES');
                IF JLD.FIND('-') THEN
                BEGIN
                LED.SETRANGE(LED."Dimension Value Code",JLD."Dimension Value Code");
                LED.SETFILTER(LED."Table ID",'17');
                LED.SETFILTER(LED."Dimension Code",'EMPLOYEE CODES');//removed comment sgs
                IF LED.FIND('-') THEN
                REPEAT
                IF GL.GET(LED."Entry No.") THEN
                GL.MARK(TRUE);
                UNTIL LED.NEXT=0;
                END;
                 */
                GL.MarkedOnly(false);
                DimensionSetEntryGRec.Reset;
                DimensionSetEntryGRec.SetRange("Dimension Set ID", "Dimension Set ID");
                DimensionSetEntryGRec.SetRange("Dimension Code", 'EMPLOYEE CODES');
                if DimensionSetEntryGRec.FindFirst then
                    DimValue := DimensionSetEntryGRec."Dimension Value Code";

                DimensionSetEntryGRec.Reset;
                DimensionSetEntryGRec.SetRange("Dimension Code", 'EMPLOYEE CODES');
                DimensionSetEntryGRec.SetRange("Dimension Value Code", DimValue);
                if DimensionSetEntryGRec.FindSet then
                    repeat
                        //GLRec.RESET;
                        GLRec.SetRange("Dimension Set ID", DimensionSetEntryGRec."Dimension Set ID");
                        if GLRec.FindSet then
                            repeat
                                GL.Get(GLRec."Entry No.");
                                GL.Mark(true);
                            until GLRec.Next = 0;
                    until DimensionSetEntryGRec.Next = 0;
                //DIM1.0 End

                GL.MarkedOnly(true);

                GL.SetRange(GL."Posting Date", (20090401D), (20100331D));
                GL.SetFilter(GL."Document No.", 'CPV*|BPV*');
                GL.SetFilter(GL.Amount, '>0');
                if PAGE.RunModal(88888, GL) = ACTION::LookupOK then


                    /*
                    BEGIN

                    IF GL.MARK THEN
                    totamt+=GL.Amount;
                    END;
                    */


                "Apply Entry No" := GL."Entry No.";
                /*
                //"Apply Entry No":=totamt;    //code added after comparsion with 12nov db
                 */

            end;
        }
        field(60073; "DD/FDR No."; Code[20])
        {
            Description = 'Rev01';
            DataClassification = CustomerContent;
        }
        field(60074; "Payment Through"; Enum "Payment Through")
        {
            Description = 'Rev01';
            DataClassification = CustomerContent;
        }
        field(60075; "Tender No"; Code[20])
        {
            TableRelation = "Tender Header"."Tender No.";
            DataClassification = CustomerContent;
        }
        field(60076; "Final Bill Payment"; Boolean)
        {
            Description = 'Added by Pranavi for SD Tracking';
            DataClassification = CustomerContent;
        }
        field(60077; "Currency Amount"; Decimal)
        {
            Description = 'Added by Pranavi for foreign currency tracking';
            DataClassification = CustomerContent;
        }
        field(60078; "Currency Rate"; Decimal)
        {
            Description = 'Added by Pranavi for foreign currency tracking';
            DataClassification = CustomerContent;
        }
        field(60079; "Old Order"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(60080; Printed; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(60081; Vertical; Option)
        {
            Description = 'Added by Vijaya for vertical expenditure';
            OptionCaption = '" ,Smart Signalling,Smart Cities,Smart Building,IOT,other,AMC"';
            OptionMembers = " ","Smart Signalling","Smart Cities","Smart Building",IOT,other,AMC;
            DataClassification = CustomerContent;
        }

        field(50054; "Product Group Code Cust"; Code[20])
        {

            Caption = 'Product Group Code';
            DataClassification = CustomerContent;
        }
        //B2BPGOn15Nov2022>>>
        field(60084; "External Document No.1"; Code[98])
        {
            DataClassification = CustomerContent;
        }//B2BPGOn15Nov2022>>>

    }

    var
        "---B2B--": Integer;
        PH: Record "Purchase Header";
        GL: Record "G/L Entry";
        GL1: Record "G/L Entry";
        EntryArray: array[300] of Integer;
        i: Integer;
        j: Integer;
        totamt: Decimal;
        "-DIM1.0-": Integer;
        DimensionSetEntryGRec: Record "Dimension Set Entry";
        DimValue: Code[20];
        GLRec: Record "G/L Entry";
}

