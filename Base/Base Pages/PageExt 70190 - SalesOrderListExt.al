pageextension 70190 SalesOrderListExt extends 9305
{
    layout
    {
        addafter("Sell-to Customer Name")
        {
            field(Product; Rec.Product)
            {
                ApplicationArea = All;
            }
            field("Shipment Type"; Rec."Shipment Type")
            {
                ApplicationArea = All;
            }
            field("Order Released Date"; Rec."Order Released Date")
            {
                ApplicationArea = All;
            }
            field("Call letters Status"; Rec."Call letters Status")
            {
                ApplicationArea = All;
            }
            field(CallLetterRecivedDate; REc.CallLetterRecivedDate)
            {
                ApplicationArea = All;
            }
            field("Customer OrderNo."; Rec."Customer OrderNo.")
            {
                ApplicationArea = All;
            }
            field(Vertical; Rec.Vertical)
            {
                ApplicationArea = All;
            }
        }
        addafter("Sell-to Country/Region Code")
        {
            field("Sell-to City"; Rec."Sell-to City")
            {
                ApplicationArea = All;
            }
        }
        addafter("Ship-to Post Code")
        {
            field("Ship-to City"; Rec."Ship-to City")
            {
                ApplicationArea = All;
            }
        }
        addafter("Job Queue Status")
        {
            field("Total Order(LOA)Value"; Rec."Total Order(LOA)Value")
            {
                ApplicationArea = All;
            }
            field("Pending(LOA)Value"; Rec."Pending(LOA)Value")
            {
                ApplicationArea = All;
            }
            field("Installation Amount"; Rec."Installation Amount")
            {
                ApplicationArea = All;
            }
            field("Software Amount"; Rec."Software Amount")
            {
                ApplicationArea = All;
            }
            field("Blanket Order No"; Rec."Blanket Order No")
            {
                ApplicationArea = All;
            }
            field("Sale Order Total Amount"; Rec."Sale Order Total Amount")
            {
                ApplicationArea = All;
            }
            field("Customer Posting Group"; Rec."Customer Posting Group")
            {
                ApplicationArea = All;
            }
            field("Security Deposit Amount"; Rec."Security Deposit Amount")
            {
                ApplicationArea = All;
            }
            field("SD Status"; Rec."SD Status")
            {
                ApplicationArea = All;
            }
            field("Tender No."; Rec."Tender No.")
            {
                ApplicationArea = All;
            }
            field("Warranty Period"; Rec."Warranty Period")
            {
                ApplicationArea = All;
            }
            field("Project Completion Date"; Rec."Project Completion Date")
            {
                ApplicationArea = All;
            }
            field(Order_After_CF_Integration; Rec.Order_After_CF_Integration)
            {
                ApplicationArea = All;
            }
            field("Customer Order Date"; Rec."Customer Order Date")
            {
                ApplicationArea = All;
            }
            /*
            field(Structure; Rec.Structure)
            {
                ApplicationArea = All;
            }
            */
            field("Customer GST Reg. No."; Rec."Customer GST Reg. No.")
            {
                ApplicationArea = All;
            }
            field("Verification Status"; Rec."Verification Status")
            {
                ApplicationArea = All;
            }

        }
        addafter(Control1)
        {
            group(Control1102152005)
            {
                Editable = false;
                ShowCaption = false;
                grid(Control1102152004)
                {
                    ShowCaption = false;
                    group(Control1102152003)
                    {
                        ShowCaption = false;
                        field("TotalOrders+FORMAT(Rec.COUNT)"; TotalOrders + FORMAT(Rec.COUNT))
                        {
                            Editable = false;
                            ApplicationArea = All;
                        }
                    }
                }
            }
        }
    }
    actions
    {

        // Name on "Action 1102601013". Please convert manually.

        modify(Statistics)
        {
            Promoted = true;
        }



        modify(Release)
        {
            Promoted = true;
        }
        modify(Reopen)
        {
            Promoted = true;
        }


        modify(Post)
        {


            Promoted = true;
            PromotedIsBig = true;
        }

        modify("Post &Batch")
        {



            Promoted = true;


        }



        modify("Print Confirmation")
        {



            Promoted = true;


        }



        modify("Sales Reservation Avail.")
        {


            Promoted = true;



        }
        addafter(CancelApprovalRequest)
        {
            action(OMSDump)
            {
                Image = Export;
                ApplicationArea = All;

                trigger OnAction();
                begin

                    OCount := 0;
                    Orders := '';
                    SH.RESET;
                    SH.SETCURRENTKEY("Document Type", "No.");
                    SH.SETFILTER(SH."Document Type", '%1', SH."Document Type"::Order);
                    SH.SETFILTER(SH.Status, '%1', SH.Status::Released);
                    SH.SETFILTER(SH."No.", '<>%1', 'EFF/SAL/14-15/431');
                    MESSAGE('Total ' + FORMAT(SH.COUNT) + ' orders are Released!');
                    IF SH.FINDSET THEN
                        REPEAT
                            ChngLogEntry.RESET;
                            ChngLogEntry.SETCURRENTKEY("Entry No.");
                            ChngLogEntry.SETFILTER(ChngLogEntry."Primary Key Field 2 Value", FORMAT(SH."No."));
                            ChngLogEntry.SETFILTER(ChngLogEntry."Field No.", '<>%1|%2|%3', 60016, 60017, 60117);
                            IF ChngLogEntry.COUNT > 0 THEN BEGIN
                                SL.RESET;
                                SL.SETRANGE("Document Type", SH."Document Type");
                                SL.SETRANGE("Document No.", SH."No.");
                                IF SL.FINDFIRST THEN BEGIN
                                    IF (OMSIntegrateCode.SaleOrderCreationinOMS(SH)) = FALSE THEN BEGIN
                                        MESSAGE('Error occured in OMS integration and record is not posted for order' + FORMAT(SH."No."));
                                    END;
                                END;
                                OCount := OCount + 1;
                                //    Orders:=Orders+'\'+SH."No.";
                            END;
                        UNTIL SH.NEXT = 0;
                    MESSAGE('Total ' + FORMAT(OCount) + ' orders are forwarded to OMS!');
                    //MESSAGE('Orders are'+Orders);
                    //End by Pranavi
                end;
            }
            action(Private_PT_User_Manual)
            {
                Caption = 'Private_Payment  Terms_User_Manual';
                Image = Document;
                ApplicationArea = All;

                trigger OnAction();
                begin
                    HYPERLINK('\\erpserver\ErpAttachments\Private_Payment_Terms_User Manual.pdf');
                end;
            }
        }
    }



    var
        OCount: Integer;
        Orders: Text[1024];
        ChngLogEntry: Record "Change Log Entry";
        SH: Record "Sales Header";
        SL: Record "Sales Line";
        OMSIntegrateCode: Codeunit SQLIntegration;
        TotalOrders: Label '"Total Orders: "';


    trigger OnOpenPage()
    var

    begin

        setrange(SaleDocType, SaleDocType::Order);//EFFUPG1.5

    end;


}

