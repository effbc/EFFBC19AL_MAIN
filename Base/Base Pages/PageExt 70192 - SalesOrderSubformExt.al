pageextension 70192 SalesOrderSubformExt extends "Sales Order Subform"
{
    layout
    {
        /* modify(Control1)
        {
            ShowCaption = false;
        } */
        modify(Type)
        {
            Editable = editableflag;
        }
        
        modify("No.")
        {
            Editable = editableflag;
            ShowMandatory = TypeChosen;
            trigger OnLookup(var Text: Text): Boolean
            begin
                IF Rec.Type = Rec.Type::Item THEN BEGIN
                    item.RESET;
                    item.SETFILTER(item."Item Status", '<>In-Active');
                    item.SETFILTER(item.Blocked, 'NO');
                    IF Rec."No." <> '' THEN
                        item.SETRANGE("No.", Rec."No.");
                    IF PAGE.RUNMODAL(31, item) = ACTION::LookupOK THEN
                        Rec.VALIDATE("No.", item."No.");
                END                      // copied code by swathi on 25-sep-13
                ELSE
                    IF Rec.Type = Rec.Type::"G/L Account" THEN BEGIN
                        GLAccount.RESET;
                        IF Rec."No." <> '' THEN
                            GLAccount.SETRANGE("No.", Rec."No.");
                        IF PAGE.RUNMODAL(18, GLAccount) = ACTION::LookupOK THEN
                            Rec.VALIDATE("No.", GLAccount."No.");
                    END;                      // copied code by swathi on 25-sep-13
                IF (xRec."No." <> Rec."No.") AND (editableflag = FALSE) THEN BEGIN
                    Rec."No." := xRec."No.";
                    ERROR('You Donot have rights to modify Item!');
                END;
            end;
        }
        modify("IC Partner Code")
        {
            Editable = editableflag;
        }
        /*  modify("Service Tax Group")
         {
           Editable=editableflag;
         } */
        modify("IC Partner Ref. Type")
        {
            Editable = editableflag;
        }
        modify("IC Item Reference")
        {
            Editable = editableflag;
        }
        modify("Variant Code")
        {
            Editable = editableflag;
        }
        modify("Purchasing Code")
        {
            Editable = editableflag;
        }
        modify(Description)
        {
            Editable = editableflag;
        }
        modify("Drop Shipment")
        {
            Editable = editableflag;
        }
        modify("Location Code")
        {
            Editable = editableflag;
        }
        modify("Bin Code")
        {
            Editable = editableflag;
        }
        /* modify(Control45)
        {
            ShowCaption = false;
        }
        modify(Control28)
        {
            ShowCaption = false;
        } */
        modify(Control50)
        {
            Editable = editableflag;
        }
        modify(Quantity)
        {
            Editable = editableflag;
            trigger OnAfterValidate()
            begin
                // Pranavi
                IF Rec.Quantity <> xRec.Quantity THEN BEGIN
                    IF Rec.Quantity < Rec."Quantity Shipped" THEN
                        ERROR('Qty must not be less than Quantity Shipped!');
                    Schedule.RESET;
                    Schedule.SETRANGE(Schedule."Document No.", rec."Document No.");
                    Schedule.SETRANGE(Schedule."Document Line No.", rec."Line No.");
                    IF Schedule.FINDSET THEN
                        REPEAT
                            IF Schedule."Document Line No." = Schedule."Line No." THEN BEGIN
                                Schedule.Quantity := Rec.Quantity;
                                Schedule."Qty. Per" := 1;
                                Schedule.VALIDATE(Quantity);
                            END
                            ELSE BEGIN
                                Schedule.Quantity := Rec.Quantity * Schedule."Qty. Per";
                                Schedule.VALIDATE(Quantity);
                            END;
                            Schedule.MODIFY;
                        UNTIL Schedule.NEXT = 0;
                END;
                // Pranavi End
            end;
        }
        modify("Qty. to Assemble to Order")
        {
            Editable = editableflag;
        }
        modify("Unit of Measure Code")
        {
            Editable = editableflag;
        }
        modify("Unit Cost (LCY)")
        {
            Editable = editableflag;
        }
        modify("Line Amount")
        {
            Editable = editableflag;
        }
        modify("Line Discount %")
        {
            Editable = editableflag;
        }
        modify("Prepayment %")
        {
            Editable = editableflag;
        }
        modify("Qty. to Ship")
        {
            Editable = editableflag;
            trigger OnAfterValidate()
            begin
                // Pranavi on 02-mar-2016 for auto calc of qty to ship in schedls
                Schedule.RESET;
                Schedule.SETRANGE(Schedule."Document No.", Rec."Document No.");
                Schedule.SETRANGE(Schedule."Document Line No.", Rec."Line No.");
                Schedule.SETFILTER(Schedule."No.", '<>%1', '');
                IF Schedule.FINDSET THEN
                    REPEAT
                        IF Schedule."Document Line No." <> Schedule."Line No." THEN BEGIN
                            Schedule."Qty. to Ship" := ROUND(Schedule."Qty. Per" * Rec."Qty. to Ship", 1, '>');
                            Schedule.VALIDATE("Qty. to Ship");
                            Schedule.MODIFY;
                        END;
                    UNTIL Schedule.NEXT = 0;
                // end by pranavi
            end;
        }
        modify("Quantity Shipped")
        {
            Editable = false;
        }
        modify("Qty. to Invoice")
        {
            Editable = editableflag;
        }
        modify("Quantity Invoiced")
        {
            Editable = FALSE;
        }
        modify("Planned Delivery Date")
        {
            Editable = editableflag;
        }
        modify("Planned Shipment Date")
        {
            Editable = editableflag;
        }

        /*modify(RefreshTotals)
        {
            ShowCaption = false;
        }*/
        modify("Return Reason Code")
        {
            Visible = false;
        }
        modify("Reserved Quantity")
        {
            Visible = false;
        }
        modify(Control51)
        {
            Visible = false;
        }
        addafter(Type)
        {
            field("Schedule Type"; rec."Schedule Type")
            {
                Editable = editableflag;
                Visible = false;
                ApplicationArea = All;
            }
            field("Gen. Bus. Posting Group"; rec."Gen. Bus. Posting Group")
            {
                Editable = editableflag;
                ApplicationArea = All;
            }
            field("Posting Group"; rec."Posting Group")
            {
                Editable = true;
                ApplicationArea = All;
            }
            field("Unit Cost"; rec."Unit Cost")
            {
                ApplicationArea = All;
            }
            field("Schedule No"; rec."Schedule No")
            {
                Editable = editableflag;
                ApplicationArea = All;

            }
            field(Date_Confirm;Date_Confirm)
            {
                ApplicationArea = All;
            }
        }
        addbefore("No.")
        {
            /*field("Tax %"; "Tax %")
            {
                Editable = false;
                ApplicationArea = All;
            }*/
            field("VAT Bus. Posting Group"; rec."VAT Bus. Posting Group")
            {
                Editable = editableflag;
                ApplicationArea = All;
            }

        }
        addafter("No.")
        {
            field("RDSO Inspection Required"; rec."RDSO Inspection Required")
            {
                Editable = editableflag;
                ApplicationArea = All;
            }
        }
        addafter("IC Partner Code")
        {
            field("VAT %"; rec."VAT %")
            {
                Editable = false;
                ApplicationArea = All;
            }
        }
        addafter("Drop Shipment")
        {
            field("BOI Status"; rec."BOI Status")
            {
                Editable = editableflag;
                Visible = "BOI StatusVisible";
                ApplicationArea = All;
            }
        }
        addafter(ShortcutDimCode8)
        {
            field("Qty. Shipped Not Invoiced"; rec."Qty. Shipped Not Invoiced")
            {
                ApplicationArea = All;
            }
            field("Outstanding Quantity"; rec."Outstanding Quantity")
            {
                Editable = false;
                ApplicationArea = All;
            }
            field("Unitcost(LOA)"; rec."Unitcost(LOA)")
            {
                Editable = editableflag;
                ApplicationArea = All;

                trigger OnValidate();
                begin
                    IF rec."Quantity Invoiced" > 0 THEN
                        ERROR('You cannot change the unit cost loa after the item is invoiced!');
                end;
            }
            field("OutStanding(LOA)"; rec."OutStanding(LOA)")
            {
                Editable = false;
                ApplicationArea = All;
            }
            field("Line Amount(LOA)"; rec."Line Amount(LOA)")
            {
                Editable = false;
                ApplicationArea = All;
            }
            field("Gen. Prod. Posting Group"; rec."Gen. Prod. Posting Group")
            {
                Editable = editableflag;
                ApplicationArea = All;
            }
            field("Retention Portion"; rec."Retention Portion")
            {
                Editable = editableflag;
                ApplicationArea = All;

                trigger OnValidate();
                begin
                    /*
                    IF "Retention Portion"+"Supply Portion" <> 100 THEN
                      ERROR('Total Supply & Retention Portions should be 100 %');
                    */

                end;
            }
            field("Supply Portion"; rec."Supply Portion")
            {
                Editable = editableflag;
                ApplicationArea = All;

                trigger OnValidate();
                begin
                    Rec."Retention Portion" := 100 - rec."Supply Portion";
                end;
            }
            field("Material Reuired Date"; rec."Material Reuired Date")
            {
                Editable = editableflag;
                ApplicationArea = All;
            }
            field("CL_CNSGN  rcvd Qty"; rec."CL_CNSGN  rcvd Qty")
            {
                ApplicationArea = All;
            }
            field("Call Letter Exp Date"; rec."Call Letter Exp Date")
            {
                Caption = '<Cust Exp Date>';
                ApplicationArea = All;
            }
            field("Call Letter Status"; rec."Call Letter Status")
            {
                ApplicationArea = All;
            }
            field("Type of Item"; rec."Type of Item")
            {
                Editable = editableflag;
                ApplicationArea = All;
            }
            field("Dummy Unit Cost"; rec."Dummy Unit Cost")
            {
                Editable = editableflag;
                ApplicationArea = All;
            }
            field("RDSO Charges"; rec."RDSO Charges")
            {
                Editable = editableflag;
                ApplicationArea = All;
            }
            field("To Be Shipped Qty"; rec."To Be Shipped Qty")
            {
                Editable = editableflag;
                ApplicationArea = All;
            }
            field("Packet No"; rec."Packet No")
            {
                Editable = editableflag;
                ApplicationArea = All;
            }
            /*field("Service Tax Amount"; "Service Tax Amount")
            {
                Editable = editableflag;
                ApplicationArea = All;
            }*/
            field("Outstanding Amount"; rec."Outstanding Amount")
            {
                ApplicationArea = All;
            }
            /*field("Excise Bus. Posting Group"; "Excise Bus. Posting Group")
            {
                Editable = editableflag;
                ApplicationArea = All;
            }
            field("Excise Prod. Posting Group"; "Excise Prod. Posting Group")
            {
                Editable = editableflag;
                ApplicationArea = All;
            }*/
        }
        addafter("Unit of Measure")
        {
            field("Prod. Order Quantity"; rec."Prod. Order Quantity")
            {
                ApplicationArea = All;
            }
            field("Prod. Due Date"; rec."Prod. Due Date")
            {
                ApplicationArea = All;
            }
            field("Prod. Qty"; rec."Prod. Qty")
            {
                ApplicationArea = All;
            }
            field("Production BOM No."; rec."Production BOM No.")
            {
                Editable = editableflag;
                ApplicationArea = All;
            }
            /* field("Form Code"; "Form Code")
             {
                 Editable = editableflag;
                 ApplicationArea = All;
             }*/
            field("Quantity (Base)"; rec."Quantity (Base)")
            {
                Editable = true;
                ApplicationArea = All;
            }
            field("Outstanding Qty. (Base)"; rec."Outstanding Qty. (Base)")
            {
                Editable = true;
                ApplicationArea = All;
            }
            field("Qty. to Invoice (Base)"; rec."Qty. to Invoice (Base)")
            {
                Editable = editableflag;
                ApplicationArea = All;
            }
            field("Qty. to Ship (Base)"; rec."Qty. to Ship (Base)")
            {
                Editable = editableflag;
                ApplicationArea = All;
            }
            field("Qty. Shipped Not Invd. (Base)"; rec."Qty. Shipped Not Invd. (Base)")
            {
                Editable = true;
                ApplicationArea = All;
            }
            field("Qty. Shipped (Base)"; rec."Qty. Shipped (Base)")
            {
                Editable = true;
                ApplicationArea = All;
            }
            field("Qty. Invoiced (Base)"; rec."Qty. Invoiced (Base)")
            {
                Editable = true;
                ApplicationArea = All;
            }
            /* field(State; State)
             {
                 Editable = editableflag;
                 ApplicationArea = All;
             }*/
            field("Pending By Removed Date"; rec."Pending By Removed Date")
            {
                Editable = false;
                ApplicationArea = All;
            }
            field("Pending By"; rec."Pending By")
            {
                Editable = editableflag;
                ApplicationArea = All;
            }
            field("Dimension Set ID"; rec."Dimension Set ID")
            {
                ApplicationArea = All;
            }
            field("Purchase Remarks"; rec."Purchase Remarks")
            {
                ApplicationArea = All;
            }
            /*  field("Amount To Customer"; "Amount To Customer")
              {
                  ApplicationArea = All;
              }*/
        }
        addafter("Document No.")
        {
            /* field("GST %"; "GST %")
             {
                 ApplicationArea = All;
             }*/
            field(Reason; rec.Reason)
            {
                ApplicationArea = All;
            }
            field(MainCategory; rec.MainCategory)
            {
                ApplicationArea = All;
            }
            field(SubCategory; rec.SubCategory)
            {
                ApplicationArea = All;
            }
            field(Remarks; rec.Remarks)
            {
                ApplicationArea = All;
            }
            field(ProductGroup; rec.ProductGroup)
            {
                ApplicationArea = All;
            }
            field("Production Confirmed Status"; rec."Production Confirmed Status")
            {
                ApplicationArea = All;
            }
            field("Dispatch Confirm Date"; rec."Dispatch Confirm Date")
            {
                ApplicationArea = All;
            }

            /*field("TDS/TCS Base Amount"; "TDS/TCS Base Amount")
             {
                 ApplicationArea = All;
             }
             field("TDS/TCS Amount"; "TDS/TCS Amount")
             {
                 ApplicationArea = All;
             }*/
            /* field("Total TDS/TCS Incl. SHE CESS"; "Total TDS/TCS Incl. SHE CESS")
             {
                 ApplicationArea = All;
             }*/
            field("Assessee Code"; Rec."Assessee Code")
            {
                Editable = true;
                ApplicationArea = All;
            }
            /*field("TCS Type"; "TCS Type")
            {
                ApplicationArea = All;
            }*/
            field("Sell-to Customer No."; rec."Sell-to Customer No.")
            {
                ApplicationArea = All;
            }
            field("Product Group Code Cust"; Rec."Product Group Code Cust")
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        addafter(SelectItemSubstitution)
        {
            action("Packing Details")
            {
                Caption = 'Packing Details';
                ApplicationArea = All;

                trigger OnAction();
                begin
                    //This functionality was copied from page #42. Unsupported part was commented. Please check it.
                    /*CurrPage.SalesLines.Page.*/
                    ShowPackingDetails;

                end;
            }
            action("Delivery &Challan")
            {
                Caption = 'Delivery &Challan';
                ApplicationArea = All;

                trigger OnAction();
                begin
                    //This functionality was copied from page #42. Unsupported part was commented. Please check it.
                    /*CurrPage.SalesLines.Page.*/
                    ShowDeliveryChallan;

                end;
            }
            action("&Line Attachments")
            {
                Caption = '&Line Attachments';
                Image = Attach;
                Visible = false;
                ApplicationArea = All;

                trigger OnAction();
                begin
                    //This functionality was copied from page #42. Unsupported part was commented. Please check it.
                    /*CurrPage.SalesLines.Page.*/
                    SalesLineAttachments;

                end;
            }
        }
        addbefore("F&unctions")
        {
            action("Design Worksheet")
            {
                Caption = 'Design Worksheet';
                ApplicationArea = All;

                trigger OnAction();
                begin
                    //This functionality was copied from page #42. Unsupported part was commented. Please check it.
                    /*CurrPage.SalesLines.Page.*/
                    ShowSalesOrderWorkSheet;

                end;
            }
            action("Sc&hedule")
            {
                Caption = 'Sc&hedule';
                ApplicationArea = All;

                trigger OnAction();
                begin
                    //This functionality was copied from page #42. Unsupported part was commented. Please check it.
                    /*CurrPage.SalesLines.Page.*/
                    ShowSchedule;

                end;
            }
            action("CreateProd.Order")
            {
                Caption = 'Create Prod. Order';
                ApplicationArea = All;

                trigger OnAction();
                var
                    NewStatus2: Option Simulated,Planned,"Firm Planned",Released;
                    NewOrderType2: Option ItemOrder,ProjectOrder;
                begin
                    /*SalesPlanForm.SetSalesOrder("No.");
                    SalesPlanForm.RUNMODAL;
                    */

                    //IF CreateOrderForm.RUNMODAL <> ACTION::Yes THEN
                    //EXIT;
                    IF FORMAT(Rec."Pending By") <> ' ' THEN             //Added By Pranavi on 23-09-2015 to restrict create RPO if item is Pending by
                        ERROR('You Can not Create Production order for Item: ' + Rec."No." + '--' + Rec.Description + '\ As it Pending By ' + FORMAT(Rec."Pending By"));
                    SalesPlanLine.DELETEALL;
                    //Quantity := MakeLines(SalesLineRec);
                    ProdMakeQty := MakeLines(SalesLineRec);        //Added by Pranavi on 13-10-215 for quantity correction
                    NewStatus2 := NewStatus2::Released;
                    NewOrderType2 := NewOrderType2::ItemOrder;
                    //CreateOrderForm.ReturnPostingInfo(NewStatus2,NewOrderType2);
                    /*IF ("sales header"."Document Type"="sales header"."Document Type"::Order)THEN
                    BEGIN
                    //MESSAGE('hai');
                      IF "Order Assurance"=FALSE THEN
                         ERROR('Order Was not Assured By Sales Dept.');
                    //end ELSE
                    //BEGIN
                      MESSAGE(FORMAT(Quantity));
                      FOR I := 1 TO Quantity
                      DO BEGIN
                       // MESSAGE('hi');
                        Qty := 1;
                        CreateOrders(Qty);
                      END;
                    END;*/

                    //commented by Vishnu Priya
                    /*Saleshdr.RESET;
                    Saleshdr.SETFILTER(Saleshdr."Document Type",'%1',Saleshdr."Document Type"::Order);
                    Saleshdr.SETFILTER(Saleshdr."No.","Document No.");
                    IF Saleshdr.FINDFIRST THEN
                      IF Saleshdr."Order Assurance"=FALSE THEN
                        ERROR('Order Was not Assured By Sales Dept.')
                      ELSE
                      BEGIN
                    
                      FOR I := 1 TO ProdMakeQty
                        DO BEGIN
                          Qty := 1;
                          CreateOrders(Qty);
                        END;
                      END;
                    "Prod. Qty" := 0;*/
                    // ended by Vishnu on 05-02-2019

                    //added by vishnu on 05-02-2019
                    Saleshdr.RESET;
                    Saleshdr.SETFILTER(Saleshdr."Document Type", '%1', Saleshdr."Document Type"::Order);
                    Saleshdr.SETFILTER(Saleshdr."No.", Rec."Document No.");
                    IF Saleshdr.FINDFIRST THEN
                        IF Saleshdr."Order Assurance" = FALSE THEN
                            ERROR('Order Was not Assured By Sales Dept.')
                        ELSE BEGIN
                            IF Rec."Unit of Measure" = 'Pairs' THEN BEGIN
                                FOR I := 1 TO ProdMakeQty * 2
                                  DO BEGIN
                                    Qty := 1;
                                    CreateOrders(Qty);
                                END;
                            END // end for if con of unit of measure
                            ELSE BEGIN
                                FOR I := 1 TO ProdMakeQty
                                  DO BEGIN
                                    Qty := 1;
                                    CreateOrders(Qty);
                                END;
                            END; // end for the else stmt
                        END;
                    Rec."Prod. Qty" := 0;
                    //ended by vishnu on 05-02-2019



                    //IF NOT CreateOrders THEN
                    //MESSAGE(Text001);

                    //SalesPlanLine.SETRANGE("Planning Status");

                    //BuildForm;

                    //CurrForm.UPDATE;

                end;
            }

            action("Create Partial Prod.Order")
            {
                ApplicationArea = All;

                trigger OnAction()
                var
                    NewStatus2: option Simulated,Planned,"Firm Planned",Released;
                    NewOrderType2: option ItemOrder,ProjectOrder;

                begin
                    //MESSAGE('HI');
                    //IF "Prod. Order Quantity" > (Quantity + "Prod. Qty") THEN
                    //ERROR('Cannot create RPOs for more then Quantity : '+FORMAT("Quantity"));
                    IF FORMAT("Pending By") <> ' ' THEN
                        ERROR('You Can not Create Production order for Item: ' + "No." + '--' + Description + '\ As it Pending By ' + FORMAT("Pending By"));
                    SalesPlanLine.DELETEALL;
                    ProdMakeQty := PartialMakeLines(SalesLineRec);
                    NewStatus2 := NewStatus2::Released;
                    NewOrderType2 := NewOrderType2::ItemOrder;
                    Window.OPEN('Action under Progress');
                    Saleshdr.RESET;
                    Saleshdr.SETFILTER(Saleshdr."Document Type", '%1', Saleshdr."Document Type"::Order);
                    Saleshdr.SETFILTER(Saleshdr."No.", "Document No.");
                    SalesLine.SETRANGE(Type, SalesLine.Type::Item);
                    SalesLine.SETFILTER("Prod. Qty", '>%1', 0);
                    IF Saleshdr.FINDFIRST THEN
                        IF Saleshdr."Order Assurance" = FALSE THEN
                            ERROR('Order Was not Assured By Sales Dept.')
                        ELSE BEGIN
                            IF Rec."Unit of Measure" = 'Pairs' THEN BEGIN
                                FOR I := 1 TO ProdMakeQty * 2
                                  DO BEGIN
                                    Qty := 1;
                                    CreateOrders(Qty);
                                END;
                            END // end for if con of unit of measure
                            ELSE BEGIN
                                FOR I := 1 TO ProdMakeQty
                                  DO BEGIN
                                    Qty := 1;
                                    CreateOrders(Qty);
                                    //MESSAGE('HI');
                                END;
                            END; // end for the else stmt
                        END;
                    Window.CLOSE;
                    MESSAGE('RPOs Created for Single Quantity : ' + FORMAT("Prod. Qty"));
                    "Prod. Qty" := 0;



                end;


            }
            action("Create Single Prod. Order")
            {
                ApplicationArea = All;

                trigger OnAction()
                var
                    NewStatus2: option Simulated,Planned,"Firm Planned",Released;
                    NewOrderType2: option ItemOrder,ProjectOrder;
                    ProductionOrder: Record "Production Order";
                begin

                    /*SalesPlanForm.SetSalesOrder("No.");
                             SalesPlanForm.RUNMODAL;
                             */

                    //IF CreateOrderForm.RUNMODAL <> ACTION::Yes THEN
                    //EXIT;
                    // modified by suvarchala on 01-03-2021
                    ProductionOrder.RESET;
                    ProductionOrder.SETRANGE(Status, ProductionOrder.Status::Released);
                    ProductionOrder.SETRANGE("Sales Order No.", "Document No.");
                    ProductionOrder.SETRANGE("Sales Order Line No.", "Line No.");
                    ProductionOrder.SETRANGE(Quantity, "Prod. Order Quantity");//added by Suvarchala
                    IF ProductionOrder.FINDFIRST THEN
                        ERROR('RPO has been Created');

                    IF FORMAT("Pending By") <> ' ' THEN             //Added By Pranavi on 23-09-2015 to restrict create RPO if item is Pending by
                        ERROR('You Can not Create Production order for Item: ' + "No." + '--' + Description + '\ As it Pending By ' + FORMAT("Pending By"));
                    SalesPlanLine.DELETEALL;
                    //Quantity := MakeLines(SalesLineRec);
                    ProdMakeQty := MakeLines(SalesLineRec);        //Added by Pranavi on 13-10-215 for quantity correction
                    NewStatus2 := NewStatus2::Released;
                    NewOrderType2 := NewOrderType2::ItemOrder;
                    //CreateOrderForm.ReturnPostingInfo(NewStatus2,NewOrderType2);
                    /*IF ("sales header"."Document Type"="sales header"."Document Type"::Order)THEN
                    BEGIN
                    //MESSAGE('hai');
                      IF "Order Assurance"=FALSE THEN
                         ERROR('Order Was not Assured By Sales Dept.');
                    //end ELSE
                    //BEGIN
                      MESSAGE(FORMAT(Quantity));
                      FOR I := 1 TO Quantity
                      DO BEGIN
                       // MESSAGE('hi');
                        Qty := 1;
                        CreateOrders(Qty);
                      END;
                    END;*/

                    //commented by Vishnu Priya
                    /*Saleshdr.RESET;
                    Saleshdr.SETFILTER(Saleshdr."Document Type",'%1',Saleshdr."Document Type"::Order);
                    Saleshdr.SETFILTER(Saleshdr."No.","Document No.");
                    IF Saleshdr.FINDFIRST THEN
                      IF Saleshdr."Order Assurance"=FALSE THEN
                        ERROR('Order Was not Assured By Sales Dept.')
                      ELSE
                      BEGIN

                      FOR I := 1 TO ProdMakeQty
                        DO BEGIN
                          Qty := 1;
                          CreateOrders(Qty);
                        END;
                      END;
                    "Prod. Qty" := 0;*/
                    // ended by Vishnu on 05-02-2019

                    //added by vishnu on 05-02-2019
                    Window.OPEN('Action under Progress');
                    Saleshdr.RESET;
                    Saleshdr.SETFILTER(Saleshdr."Document Type", '%1', Saleshdr."Document Type"::Order);
                    Saleshdr.SETFILTER(Saleshdr."No.", "Document No.");
                    IF Saleshdr.FINDFIRST THEN
                        IF Saleshdr."Order Assurance" = FALSE THEN
                            ERROR('Order Was not Assured By Sales Dept.')
                        ELSE BEGIN
                            IF Rec."Unit of Measure" = 'Pairs' THEN BEGIN
                                FOR I := 1 TO ProdMakeQty * 2
                                  DO BEGIN
                                    Qty := 1;
                                    CreateOrders(Qty);
                                END;
                            END // end for if con of unit of measure
                            ELSE BEGIN
                                FOR I := 1 TO ProdMakeQty
                                  DO BEGIN
                                    Qty := 1;
                                    CreateOrders(Qty);
                                END;
                            END; // end for the else stmt
                        END;
                    "Prod. Qty" := 0;
                    Window.CLOSE;
                    MESSAGE('RPOs Created for Single Quantity : ' + FORMAT(Quantity));//by suvarchala on 01-03-2021
                                                                                      //ended by vishnu on 05-02-2019



                    //IF NOT CreateOrders THEN
                    //MESSAGE(Text001);

                    //SalesPlanLine.SETRANGE("Planning Status");

                    //BuildForm;

                    //CurrForm.UPDATE;

                end;
            }

            action("Prod. Order Details")
            {
                Caption = 'Prod. Order Details';
                ApplicationArea = All;

                trigger OnAction();
                begin
                    //This functionality was copied from page #42. Unsupported part was commented. Please check it.
                    /*CurrPage.SalesLines.Page.*/
                    ShowPODetails;

                end;
            }
        }

        addafter(OrderTracking)
        {
            action("&Attachments")
            {
                Caption = '&Attachments';
                ApplicationArea = All;

                trigger OnAction();
                begin
                    //This functionality was copied from page #42. Unsupported part was commented. Please check it.
                    /*CurrPage.SalesLines.Page.*/
                    CustAttachments;

                end;
            }
            action("Production Approve")
            {
                ApplicationArea = All;

                trigger OnAction();
                var
                    SalesHeader: Record "Sales Header";
                begin
                    //Added by Vishnu Priya on  26-05-2020
                    SalesHeader.RESET;
                    SalesHeader.SETFILTER("No.", Rec."Document No.");
                    IF SalesHeader.FINDFIRST THEN BEGIN
                        SalesLine.RESET;
                        SalesLine.SETFILTER("Document No.", SalesHeader."No.");
                        IF SalesLine.FINDSET THEN
                            REPEAT
                            BEGIN
                                SalesLine."Production Confirmed Status" := TRUE;
                                SalesLine.MODIFY;
                            END;
                            UNTIL SalesLine.NEXT = 0;
                    END
                    //Added by Vishnu Priya on  26-05-2020
                end;
            }
            action("Pre Site Visit")
            {
                Caption = 'Pre Site Visit';
                ApplicationArea = All;

                trigger OnAction();
                begin
                    //This functionality was copied from page #42. Unsupported part was commented. Please check it.
                    /*CurrPage.SalesLines.Page.*/
                    _Presite;

                end;
            }
            action("Update New Item")
            {
                Caption = 'Update New Item';
                Description = 'UPG1.3 06Feb2019 Updates Item No. in Current Sales Line and in RPO if exist';
                Image = Change;
                ApplicationArea = All;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = "Report";

                trigger OnAction();
                begin
                    //>>UPG1.3 06Feb2019
                    UpdateItemNo;
                    //<<UPG1.3 06Feb2019
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        IF NOT (UPPERCASE(USERID) IN ['SUPER', '10RD010', '11RD010', '06PD033']) THEN
            "BOI StatusVisible" := FALSE;
        User.RESET;
        IF Rec.SaleDocType <> Rec.SaleDocType::Amc THEN BEGIN//EFFUPG1.5
            IF NOT (USERID IN ['EFFTRONICS\SUJANI', 'EFFTRONICS\VSNGEETHA', 'EFFTRONICS\SRIVALLI', 'EFFTRONICS\GRAVI', 'EFFTRONICS\BHAVANIP',
                               'EFFTRONICS\ANILKUMAR', 'EFFTRONICS\SPURTHI', 'EFFTRONICS\ANVESH', 'EFFTRONICS\BSATISH', 'EFFTRONICS\DURGAMAHESWARI', 'EFFTRONICS\TPRIYANKA', 'EFFTRONICS\SUVARCHALADEVI', 'EFFTRONICS\GURULAKSHMI', 'EFFTRONICS\B2BOTS']) THEN BEGIN
                User.SETFILTER(User."User ID", USERID); //B2BUPG
                IF User.FINDFIRST THEN BEGIN
                    IF NOT (User.Dept IN ['SAL', 'MAR']) THEN
                        editableflag := FALSE
                    ELSE
                        editableflag := TRUE;
                END;
            END
            ELSE
                editableflag := TRUE;
        END
        ELSE
            editableflag := TRUE;
    end;

    trigger OnAfterGetRecord()
    begin
        IF (Rec.Type = Rec.Type::Item) AND (Rec.ProductGroup = '') THEN BEGIN
            item.RESET;
            item.SETFILTER("No.", Rec."No.");
            IF item.FINDSET THEN BEGIN
                Rec.ProductGroup := item."Item Sub Group Code";
                //Rec.MODIFY;
            END;
        END;
        IF Rec.MainCategory = Rec.MainCategory::"  " THEN BEGIN
            Rec.MainCategory := Rec.MainCategory::"Need to Specify";
            // Rec.MODIFY;
        END;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    var
        SalesHeader: Record "Sales Header";
    begin
        // added by pranavi on 01-sep-2016 for payment terms
        IF Rec."Document Type" = Rec."Document Type"::Order THEN BEGIN
            SalesHeader.RESET;
            SalesHeader.SETRANGE(SalesHeader."No.", Rec."Document No.");
            IF SalesHeader.FINDFIRST THEN
                IF SalesHeader."Customer Posting Group" IN ['PRIVATE', 'OTHERS'] THEN
                    IF Rec.Type = Rec.Type::Item THEN BEGIN
                        Rec."Supply Portion" := 100;
                        Rec."Retention Portion" := 0;
                    END ELSE BEGIN
                        Rec."Supply Portion" := 0;
                        Rec."Retention Portion" := 100;
                    END;
        END;
        // end by pranavi
    end;

    trigger OnModifyRecord(): Boolean
    begin
        //Added By Pranavi On 23-09-2015 to restrict sales line modify/delete except sales & ERP

        /* User.RESET;
        IF "Document Type" <> "Document Type"::Amc THEN
        BEGIN
          IF NOT (USERID IN ['EFFTRONICS\PRANAVI','EFFTRONICS\GRAVI','EFFTRONICS\ANILKUMAR','EFFTRONICS\NAGALAKSHMI','EFFTRONICS\SRIVALLI','EFFTRONICS\SPURTHI','EFFTRONICS\ANVESH']) THEN
          BEGIN
            User.SETFILTER(User."User Name",USERID);
            IF User.FINDFIRST THEN
            BEGIN
              IF NOT (User.Dept IN ['SAL','MAR']) THEN
                editableflag := FALSE
              ELSE editableflag := TRUE;
                //IF ("Product Group Code" <> 'B OUT') AND (User.Dept <> '') THEN
                  //ERROR('You Do Not Right to Modify!');
            END;
          END
          ELSE editableflag := TRUE;
        END;

        Saleshdr.RESET;
        Saleshdr.SETRANGE(Saleshdr."No.","Document No.");
        IF Saleshdr.FINDFIRST THEN
          IF (Saleshdr.Order_After_CF_Integration = TRUE) AND NOT (SalesHeader."Sell-to Customer No." IN['CUST00536','CUST01164']) THEN
            IF "Retention Portion"+"Supply Portion" <> 100 THEN
              ERROR('Total Supply & Retention Portions should be 100 %'); */

        //End By Pranavi
    end;

    trigger OnDeleteRecord(): Boolean
    begin
        //Added By Pranavi On 23-09-2015 to restrict sales line modify/delete except sales & ERP
        User.RESET;
        IF Rec.SaleDocType <> Rec.SaleDocType::Amc THEN BEGIN //EFFUPG1.5
            IF NOT (USERID IN ['EFFTRONICS\VISHNUPRIYA', 'EFFTRONICS\GRAVI', 'EFFTRONICS\ANILKUMAR', 'EFFTRONICS\BHAVANIP', 'EFFTRONICS\SRIVALLI', 'EFFTRONICS\SPURTHI', 'EFFTRONICS\ANVESH', 'EFFTRONICS\VIJAYA', 'EFFTRONICS\SUVARCHALADEVI', 'EFFTRONICS\TPRIYANKA', 'EFFTRONICS\DURGAMAHESWARI']) THEN BEGIN
                User.SETFILTER(User."User ID", USERID);
                IF User.FINDFIRST THEN BEGIN
                    IF NOT (User.Dept IN ['SAL', 'MAR']) THEN
                        ERROR('You Do Not Right to Delete!');
                END;
            END;
        END;
        //End By Pranavi
        // Added by pranavi on 12-09-2016 for not allowing to delete if outstanding qty > 0 after partially billed
        IF (Rec.Quantity <> Rec."Quantity Shipped") AND (Rec."Quantity Shipped" > 0) THEN
            ERROR('You cannot delete the line as there is outstanding qty!');
        // end by pranavi
    end;

    var
        SalesPlanLine: Record "Sales Planning Line";
        item: Record Item;
        GLAccount: Record "G/L Account";
        SalesLine: Record "Sales Line";
        NewOrderType: Option ItemOrder,ProjectOrder;
        NewStatus: Option Simulated,Planned,"Firm Planned",Released;
        //NewStatus: Enum "Production Order Status";
        SalesLineRec: Record "Sales Line";
        I: Integer;
        Qty: Integer;
        Saleshdr: Record "Sales Header";
        User: Record "User Setup";
        ProdMakeQty: Integer;
        editableflag: Boolean;
        Schedule: Record Schedule2;
        TypeChosen: Boolean;
        "BOI StatusVisible": Boolean;

        Text001: Label 'You cannot use the Explode BOM function because a prepayment of the sales order has been invoiced.';



    procedure "---B2B--"();
    begin
    end;

    procedure CustAttachments();
    var
        CustAttach: Record Attachments;
    begin
        CustAttach.RESET;
        CustAttach.SETRANGE("Table ID", DATABASE::"Sales Header");
        CustAttach.SETRANGE("Document No.", Rec."Document No.");
        CustAttach.SETRANGE("Document Type", Rec."Document Type");

        PAGE.RUN(PAGE::"ESPL Attachments", CustAttach);
    end;

    procedure _Presite();
    var
        PreSiteCheckList: Record "Inst. PreSite Check List";
    begin
        PreSiteCheckList.RESET;
        PreSiteCheckList.SETRANGE("Sales Order No.", Rec."Document No.");
        PreSiteCheckList.SETRANGE("Sales Order Line No.", Rec."Line No.");
        PAGE.RUN(PAGE::"Inst. PreSite Check List", PreSiteCheckList);
    end;

    procedure Presite();
    var
        PreSiteCheckList: Record "Inst. PreSite Check List";
    begin
        PreSiteCheckList.RESET;
        PreSiteCheckList.SETRANGE("Sales Order No.", Rec."Document No.");
        PreSiteCheckList.SETRANGE("Sales Order Line No.", Rec."Line No.");
        PAGE.RunModal(PAGE::"Inst. PreSite Check List", PreSiteCheckList);
    end;

    procedure ShowPackingDetails();
    var
        PackingDetails: Record "Shortage Management Audit Data";
    begin
        /*
        PackingDetails.SETRANGE(Week,PackingDetails.Week :: "0");
        PackingDetails.SETRANGE("Sale Order","Document No.");
        PackingDetails.SETRANGE(Customer,"Line No.");
        Page.RUNMODAL(PAGE :: "Shortage Mng Audit Data",PackingDetails);
                                                                          */

    end;

    procedure SalesLineAttachments();
    var
        CustAttach: Record Attachments;
    begin
        CustAttach.RESET;
        CustAttach.SETRANGE("Table ID", DATABASE::"Sales Header");
        CustAttach.SETRANGE("Document No.", Rec."Document No.");
        CustAttach.SETRANGE("Document Type", Rec."Document Type"::Order);
        CustAttach.SETRANGE("Document Line No.", Rec."Line No.");

        PAGE.RUN(PAGE::"ESPL Attachments", CustAttach);
    end;

    procedure ShowSalesOrderWorkSheet();
    var
        DesignWorksheetHeader: Record "Design Worksheet Header";
        DesignWorksheetLine: Record "Design Worksheet Line";
        Item: Record Item;
        ItemDesignWorksheetHeader: Record "Item Design Worksheet Header";
        ItemDesignWorksheetLine: Record "Item Design Worksheet Line";
    begin
        /*
        TESTFIELD("Document Type");
        TESTFIELD("Document No.");
        TESTFIELD("Line No.");
        
        CLEAR(DesignWorksheetHeader);
        DesignWorksheetHeader.SETRANGE("Document Type",DesignWorksheetHeader."Document Type"::Order);
        DesignWorksheetHeader.SETRANGE("Document No.","Document No.");
        DesignWorksheetHeader.SETRANGE("Document Line No.","Line No.");
        DesignWorksheetHeader.FILTERGROUP(2);
        IF DesignWorksheetHeader.FINDFIRST THEN
          Page.RUNMODAL(60122,DesignWorksheetHeader);
        DesignWorksheetHeader.FILTERGROUP(0);
        */
        Rec.TESTFIELD("Document Type");
        Rec.TESTFIELD("Document No.");
        Rec.TESTFIELD("Line No.");
        ItemDesignWorksheetHeader.RESET;
        IF ItemDesignWorksheetHeader.GET(Rec."No.") THEN BEGIN
            DesignWorksheetHeader.INIT;
            DesignWorksheetHeader.TRANSFERFIELDS(ItemDesignWorksheetHeader);
            DesignWorksheetHeader."Document No." := Rec."Document No.";
            DesignWorksheetHeader."Document Line No." := Rec."Line No.";
            DesignWorksheetHeader."Document Type" := DesignWorksheetHeader."Document Type"::Order;
            IF DesignWorksheetHeader.INSERT THEN;
            ItemDesignWorksheetLine.RESET;
            ItemDesignWorksheetLine.SETRANGE(ItemDesignWorksheetLine."Item No", ItemDesignWorksheetHeader."Item No.");
            IF ItemDesignWorksheetLine.FINDSET THEN
                REPEAT
                    DesignWorksheetLine.INIT;
                    DesignWorksheetLine.TRANSFERFIELDS(ItemDesignWorksheetLine);
                    DesignWorksheetLine."Document No." := Rec."Document No.";
                    DesignWorksheetLine."Document Line No." := Rec."Line No.";
                    DesignWorksheetLine."Document Type" := DesignWorksheetLine."Document Type"::Order;
                    IF DesignWorksheetLine.INSERT THEN;
                UNTIL ItemDesignWorksheetLine.NEXT = 0;
        END;
        COMMIT;

        CLEAR(DesignWorksheetHeader);
        DesignWorksheetHeader.SETRANGE("Document Type", DesignWorksheetHeader."Document Type"::Order);
        DesignWorksheetHeader.SETRANGE("Document No.", Rec."Document No.");
        DesignWorksheetHeader.SETRANGE("Document Line No.", Rec."Line No.");
        DesignWorksheetHeader.FILTERGROUP(2);
        IF DesignWorksheetHeader.FINDFIRST THEN
            PAGE.RUNMODAL(60122, DesignWorksheetHeader);
        DesignWorksheetHeader.FILTERGROUP(0);

    end;

    procedure ShowDeliveryChallan();
    var
        DeliveryChallan: Record "DC Header";
    begin
        DeliveryChallan.SETRANGE(Status, DeliveryChallan.Status::Open);
        DeliveryChallan.SETRANGE("Sales Order No.", Rec."Document No.");
        //DeliveryChallan.SETRANGE("Document Line No.","Line No.");
        PAGE.RUNMODAL(PAGE::"DC Header", DeliveryChallan);
    end;

    procedure ShowSchedule2();
    var
        Schedule: Record Schedule2;
    begin
        IF (Rec."Tender No." = '') AND (Rec."Tender Line No." = 0) THEN BEGIN
            Schedule.RESET;
            Schedule.SETRANGE("Document Type", Schedule."Document Type"::Order);
            Schedule.SETRANGE("Document No.", Rec."Document No.");
            Schedule.SETRANGE("Document Line No.", Rec."Line No.");
            //Schedule.SETRANGE("Item No.","No.");
            //Schedule.SETRANGE(Quantity,Quantity);
            Schedule.FILTERGROUP(2);
            PAGE.RUN(60125, Schedule);
            Schedule.FILTERGROUP(0);
        END ELSE BEGIN
            Schedule.RESET;
            Schedule.SETRANGE("Document Type", Schedule."Document Type"::Tender);
            Schedule.SETRANGE("Document No.", Rec."Tender No.");
            Schedule.SETRANGE("Document Line No.", Rec."Tender Line No.");
            //Schedule.SETRANGE("Item No.","No.");
            //Schedule.SETRANGE(Quantity,Quantity);
            Schedule.FILTERGROUP(2);
            PAGE.RUN(60127, Schedule);
            Schedule.FILTERGROUP(0);
        END;
    end;

    procedure ShowPODetails();
    var
        SOPodetails: Record "SO Prod.Order Details";
    begin
        SOPodetails.SETRANGE("Sales Order No.", Rec."Document No.");
        SOPodetails.SETRANGE("Sales Order Line No.", Rec."Line No.");
        PAGE.RUNMODAL(60126, SOPodetails);
    end;

    procedure MakeLines(var SalesLineparam: Record "Sales Line"): Decimal;
    var
        SalesLine: Record "Sales Line";
        ProdOrderLine: Record "Prod. Order Line";
        PurchLine: Record "Purchase Line";
        ReqLine: Record "Requisition Line";
        ReservEntry2: Record "Reservation Entry";
        Item: Record Item;
    begin
        SalesPlanLine.DELETEALL;
        ValidateProdOrder;
        SalesLine.SETRANGE("Document Type", SalesLine."Document Type"::Order);
        SalesLine.SETRANGE("Document No.", Rec."Document No.");
        //NSS 301207
        SalesLine.SETRANGE("Line No.", Rec."Line No.");
        //NSS
        SalesLine.SETRANGE(Type, SalesLine.Type::Item);

        IF SalesLine.FINDFIRST THEN BEGIN
            //REPEAT
            SalesLine.TESTFIELD("Prod. Qty");
            SalesLine.TESTFIELD("Prod. Due Date");
            SalesPlanLine.INIT;
            SalesPlanLine."Sales Order No." := SalesLine."Document No.";
            SalesPlanLine."Sales Order Line No." := SalesLine."Line No.";
            SalesPlanLine."Item No." := SalesLine."No.";

            SalesPlanLine."Variant Code" := SalesLine."Variant Code";
            Item.RESET;
            IF Item.GET(SalesLine."No.") THEN
                SalesPlanLine.Description := Item.Description
            ELSE
                SalesPlanLine.Description := SalesLine.Description;
            SalesPlanLine."Shipment Date" := SalesLine."Shipment Date";
            SalesPlanLine."Planning Status" := SalesPlanLine."Planning Status"::Released;
            SalesLine.CALCFIELDS("Reserved Qty. (Base)");
            SalesPlanLine."Planned Quantity" := SalesLine."Reserved Qty. (Base)";
            /*ReservEngineMgt.InitFilterAndSortingLookupFor(ReservEntry,FALSE);
            ReserveSalesline.FilterReservFor(ReservEntry,SalesLine);
            ReservEntry.SETRANGE("Reservation Status",ReservEntry."Reservation Status"::Reservation);
            IF ReservEntry.FINDSET THEN
              REPEAT
                IF ReservEntry2.GET(ReservEntry."Entry No.",NOT ReservEntry.Positive) THEN
                  CASE ReservEntry2."Source Type" OF
                    DATABASE::"Item Ledger Entry":
                      BEGIN
                        SalesPlanLine."Planning Status" := SalesPlanLine."Planning Status"::Inventory;
                      END;
                    DATABASE::"Requisition Line":
                      BEGIN
                        ReqLine.GET(
                          ReservEntry2."Source ID",
                          ReservEntry2."Source Batch Name",
                          ReservEntry2."Source Ref. No.");
                        SalesPlanLine."Planning Status" := SalesPlanLine."Planning Status"::Planned;
                        SalesPlanLine."Expected Delivery Date" := ReqLine."Due Date";
                      END;
                    DATABASE::"Purchase Line":
                      BEGIN
                        PurchLine.GET(
                          ReservEntry2."Source Subtype",
                          ReservEntry2."Source ID",
                          ReservEntry2."Source Ref. No.");
                        SalesPlanLine."Planning Status" := SalesPlanLine."Planning Status"::"Firm Planned";
                        SalesPlanLine."Expected Delivery Date" := PurchLine."Expected Receipt Date";
                      END;
                    DATABASE::"Prod. Order Line":
                      BEGIN
                        ProdOrderLine.GET(
                          ReservEntry2."Source Subtype",
                          ReservEntry2."Source ID",
                          ReservEntry2."Source Prod. Order Line");
                        IF ProdOrderLine."Ending Date" > SalesPlanLine."Expected Delivery Date" THEN
                          SalesPlanLine."Expected Delivery Date" := ProdOrderLine."Ending Date";
                        IF ((ProdOrderLine.Status + 1) < SalesPlanLine."Planning Status") OR
                           (SalesPlanLine."Planning Status" = SalesPlanLine."Planning Status"::None)
                        THEN
                          SalesPlanLine."Planning Status" := ProdOrderLine.Status + 1;
                      END;
                  END;
              UNTIL ReservEntry.NEXT = 0;*/
            SalesPlanLine."Needs Replanning" :=
              (SalesPlanLine."Planned Quantity" <> SalesLine."Outstanding Qty. (Base)") OR
              (SalesPlanLine."Expected Delivery Date" > SalesPlanLine."Shipment Date");
            /*CalculateDisposalPlan(
              SalesLine."Variant Code",
              SalesLine."Location Code",SalesLine."Bin Code");*/
            SalesPlanLine.INSERT;
            EXIT(SalesLine."Prod. Qty");
            //UNTIL SalesLine.NEXT = 0;
        END;

    end;

    procedure ValidateProdOrder();
    begin
        Rec.CALCFIELDS("Prod. Order Quantity");
        IF Rec."Prod. Order Quantity" > Rec.Quantity THEN
            ERROR(Text001);
    end;

    procedure ShowSchedule();
    var
        Schedule: Record Schedule2;
        SalesLine: Record "Sales Line";
    begin
        IF Rec.Type = Rec.Type::Item THEN BEGIN
            IF ((Rec."Tender No." <> '') AND (Rec."Tender Line No." <> 0)) THEN BEGIN
                Schedule.RESET;
                Schedule.SETRANGE("Document Type", Schedule."Document Type"::Order);
                Schedule.SETRANGE("Document No.", Rec."Document No.");
                Schedule.SETRANGE("Document Line No.", Rec."Line No.");
                //Schedule.SETRANGE("Item No.","No.");
                //Schedule.SETRANGE(Quantity,Quantity);
                Schedule.FILTERGROUP(2);
                IF Schedule.FINDFIRST THEN BEGIN
                    PAGE.RunModal(60125, Schedule);
                    Schedule.FILTERGROUP(0);
                END ELSE BEGIN
                    SalesLine.RESET;
                    SalesLine.SETRANGE("Document No.", Rec."Document No.");
                    SalesLine.SETRANGE("Line No.", Rec."Line No.");
                    IF SalesLine.FINDSET THEN
                        REPEAT
                            Schedule.INIT;
                            Schedule."Document Type" := Schedule."Document Type"::Order;
                            Schedule."Document No." := SalesLine."Document No.";
                            Schedule."Document Line No." := SalesLine."Line No.";
                            Schedule."Line No." := SalesLine."Line No.";
                            //Schedule."Line No.":=10000;     // Pranavi
                            Schedule.Type := Schedule.Type::Item;
                            Schedule.VALIDATE("No.", SalesLine."No.");
                            Schedule."Qty. Per" := 1;
                            Schedule.Quantity := SalesLine.Quantity;
                            Schedule.VALIDATE(Quantity);
                            Schedule."Unit of Measure Code" := SalesLine."Unit of Measure Code";
                            Schedule.VALIDATE("Unit of Measure Code");
                            Schedule."Location Code" := SalesLine."Location Code";
                            //salesLine.CALCFIELDS("Estimated Unit Cost");
                            IF Schedule.INSERT THEN;
                        UNTIL SalesLine.NEXT = 0;
                    COMMIT;
                    Schedule.RESET;
                    Schedule.SETRANGE("Document Type", Schedule."Document Type"::Order);
                    Schedule.SETRANGE("Document No.", Rec."Document No.");
                    Schedule.SETRANGE("Document Line No.", Rec."Line No.");
                    Schedule.FILTERGROUP(2);
                    PAGE.RUN(60125, Schedule);
                    Schedule.FILTERGROUP(0);
                END
            END ELSE
                IF ((Rec."Blanket Order No." <> '') AND (Rec."Blanket Order Line No." <> 0)) THEN BEGIN
                    Schedule.RESET;
                    Schedule.SETRANGE("Document Type", Schedule."Document Type"::Order);
                    Schedule.SETRANGE("Document No.", Rec."Document No.");
                    Schedule.SETRANGE("Document Line No.", Rec."Line No.");
                    Schedule.FILTERGROUP(2);
                    PAGE.RUN(60125, Schedule);
                    Schedule.FILTERGROUP(0);
                END ELSE BEGIN
                    SalesLine.RESET;
                    SalesLine.SETRANGE("Document No.", Rec."Document No.");
                    SalesLine.SETRANGE("Line No.", Rec."Line No.");
                    IF SalesLine.FINDSET THEN
                        REPEAT
                            Schedule.INIT;
                            Schedule."Document Type" := Schedule."Document Type"::Order;
                            Schedule."Document No." := SalesLine."Document No.";
                            Schedule."Document Line No." := SalesLine."Line No.";
                            Schedule."Line No." := SalesLine."Line No.";
                            //Schedule."Line No.":=10000;  // Pranavi
                            Schedule.Type := Schedule.Type::Item;
                            Schedule.VALIDATE("No.", SalesLine."No.");
                            Schedule."Qty. Per" := 1;
                            Schedule.Quantity := SalesLine.Quantity;
                            Schedule.VALIDATE(Quantity);
                            Schedule."Unit of Measure Code" := SalesLine."Unit of Measure Code";
                            Schedule.VALIDATE("Unit of Measure Code");
                            Schedule."Location Code" := SalesLine."Location Code";
                            Schedule."Estimated Total Unit Price" := Schedule."Estimated Unit Price" * Rec.Quantity;
                            //salesLine.CALCFIELDS("Estimated Unit Cost");
                            IF Schedule.INSERT THEN;
                        UNTIL SalesLine.NEXT = 0;
                    COMMIT;
                    Schedule.RESET;
                    Schedule.SETRANGE("Document Type", Schedule."Document Type"::Order);
                    Schedule.SETRANGE("Document No.", Rec."Document No.");
                    Schedule.SETRANGE("Document Line No.", Rec."Line No.");
                    Schedule.FILTERGROUP(2);
                    PAGE.RUN(60125, Schedule);
                    Schedule.FILTERGROUP(0);
                END
        END ELSE
            IF Rec.Type = Rec.Type::"G/L Account" THEN BEGIN
                Schedule.RESET;
                Schedule.SETRANGE("Document Type", Schedule."Document Type"::Order);
                Schedule.SETRANGE("Document No.", Rec."Document No.");
                Schedule.SETRANGE("Document Line No.", Rec."Line No.");
                Schedule.FILTERGROUP(2);
                PAGE.RUN(60125, Schedule);
                Schedule.FILTERGROUP(0);
            END;
    end;

    procedure CreateOrders(Qtyparam: Decimal) OrdersCreated: Boolean;
    var
        Item: Record Item;
        SalesLine: Record "Sales Line";
        ProdOrderFromSale: Codeunit "Event Handling Cust";
    begin
        IF NOT SalesPlanLine.FINDSET THEN
            EXIT;

        REPEAT
            SalesLine.GET(
              SalesLine."Document Type"::Order,
              SalesPlanLine."Sales Order No.",
              SalesPlanLine."Sales Order Line No.");
            //SalesLine.TESTFIELD("Shipment Date");
            SalesLine.CALCFIELDS("Reserved Qty. (Base)");
            //IF SalesLine."Outstanding Qty. (Base)" > SalesLine."Reserved Qty. (Base)" THEN BEGIN
            Item.GET(SalesLine."No.");
            IF Item."Replenishment System" = Item."Replenishment System"::"Prod. Order" THEN BEGIN
                OrdersCreated := TRUE;
                ProdOrderFromSale.CreateProdOrder2(SalesLine, NewStatus::Released, NewOrderType::ItemOrder, 1);
                IF NewOrderType = NewOrderType::ProjectOrder THEN
                    EXIT;
            END;
        //END;
        UNTIL (SalesPlanLine.NEXT = 0);
    end;

    local procedure UpdateItemNo();
    var
        UpdateSalesItem: Report "Update Sales/ Schedule Item11";
    begin
        //>>UPG1.3 06Feb2019
        Rec.TESTFIELD(Type, Rec.Type::Item);
        Rec.TESTFIELD("No.");
        Rec.TESTFIELD("Quantity Shipped", 0);
        CLEAR(UpdateSalesItem);
        UpdateSalesItem.USEREQUESTPAGE(TRUE);
        UpdateSalesItem.SetValues(Rec."Document No.", Rec."Line No.", 0);
        UpdateSalesItem.RUN;
        CurrPage.UPDATE(FALSE);
        //<<UPG1.3 06Feb2019
    end;

    procedure MakeLinesSingle(var SalesLineparam: Record "Sales Line"): Decimal;
    var
        SalesLine: Record "Sales Line";
        ProdOrderLine: Record "Prod. Order Line";
        PurchLine: Record "Purchase Line";
        ReqLine: Record "Requisition Line";
        ReservEntry2: Record "Reservation Entry";
        Item: Record Item;
    begin
        SalesPlanLine.DELETEALL;
        ValidateProdOrderSingle(SalesLineparam);
        SalesLine.SETRANGE("Document Type", SalesLine."Document Type"::Order);
        SalesLine.SETRANGE("Document No.", SalesLineparam."Document No.");
        SalesLine.SETRANGE("Line No.", SalesLineparam."Line No.");
        SalesLine.SETRANGE(Type, SalesLine.Type::Item);
        IF SalesLine.FINDSET THEN BEGIN
            REPEAT
                //SalesLine.TESTFIELD("Prod. Qty");
                //SalesLine.TESTFIELD("Prod. Due Date");
                SalesPlanLine.INIT;
                SalesPlanLine."Sales Order No." := SalesLine."Document No.";
                SalesPlanLine."Sales Order Line No." := SalesLine."Line No.";
                SalesPlanLine."Item No." := SalesLine."No.";

                SalesPlanLine."Variant Code" := SalesLine."Variant Code";
                Item.RESET;
                IF Item.GET(SalesLine."No.") THEN
                    SalesPlanLine.Description := Item.Description
                ELSE
                    SalesPlanLine.Description := SalesLine.Description;
                SalesPlanLine."Shipment Date" := SalesLine."Shipment Date";
                SalesPlanLine."Planning Status" := SalesPlanLine."Planning Status"::Released;
                SalesLine.CALCFIELDS("Reserved Qty. (Base)");
                SalesPlanLine."Planned Quantity" := SalesLine."Reserved Qty. (Base)";
                /*ReservEngineMgt.InitFilterAndSortingLookupFor(ReservEntry,FALSE);
                ReserveSalesline.FilterReservFor(ReservEntry,SalesLine);
                ReservEntry.SETRANGE("Reservation Status",ReservEntry."Reservation Status"::Reservation);
                IF ReservEntry.FINDSET THEN
                  REPEAT
                    IF ReservEntry2.GET(ReservEntry."Entry No.",NOT ReservEntry.Positive) THEN
                      CASE ReservEntry2."Source Type" OF
                        DATABASE::"Item Ledger Entry":
                          BEGIN
                            SalesPlanLine."Planning Status" := SalesPlanLine."Planning Status"::Inventory;
                          END;
                        DATABASE::"Requisition Line":
                          BEGIN
                            ReqLine.GET(
                              ReservEntry2."Source ID",
                              ReservEntry2."Source Batch Name",
                              ReservEntry2."Source Ref. No.");
                            SalesPlanLine."Planning Status" := SalesPlanLine."Planning Status"::Planned;
                            SalesPlanLine."Expected Delivery Date" := ReqLine."Due Date";
                          END;
                        DATABASE::"Purchase Line":
                          BEGIN
                            PurchLine.GET(
                              ReservEntry2."Source Subtype",
                              ReservEntry2."Source ID",
                              ReservEntry2."Source Ref. No.");
                            SalesPlanLine."Planning Status" := SalesPlanLine."Planning Status"::"Firm Planned";
                            SalesPlanLine."Expected Delivery Date" := PurchLine."Expected Receipt Date";
                          END;
                        DATABASE::"Prod. Order Line":
                          BEGIN
                            ProdOrderLine.GET(
                              ReservEntry2."Source Subtype",
                              ReservEntry2."Source ID",
                              ReservEntry2."Source Prod. Order Line");
                            IF ProdOrderLine."Ending Date" > SalesPlanLine."Expected Delivery Date" THEN
                              SalesPlanLine."Expected Delivery Date" := ProdOrderLine."Ending Date";
                            IF ((ProdOrderLine.Status + 1) < SalesPlanLine."Planning Status") OR
                               (SalesPlanLine."Planning Status" = SalesPlanLine."Planning Status"::None)
                            THEN
                              SalesPlanLine."Planning Status" := ProdOrderLine.Status + 1;
                          END;
                      END;
                  UNTIL ReservEntry.NEXT = 0;*/
                SalesPlanLine."Needs Replanning" :=
                  (SalesPlanLine."Planned Quantity" <> SalesLine."Outstanding Qty. (Base)") OR
                  (SalesPlanLine."Expected Delivery Date" > SalesPlanLine."Shipment Date");
                /*CalculateDisposalPlan(
                  SalesLine."Variant Code",
                  SalesLine."Location Code",SalesLine."Bin Code");*/
                SalesPlanLine.INSERT;
            UNTIL SalesLine.NEXT = 0;
            EXIT(SalesLine."Outstanding Quantity");
        END;

    end;

    procedure ValidateProdOrderSingle(SalesLineLRec: Record "Sales Line");
    begin
        SalesLineLRec.CALCFIELDS("Prod. Order Quantity");
        IF SalesLineLRec."Prod. Order Quantity" > SalesLineLRec.Quantity THEN
            ERROR(Text001);
    end;

    procedure MakeLinesSingleQuantity(var SalesLineparam: Record "Sales Line"): Decimal;
    var
        SalesLine: Record "Sales Line";
        ProdOrderLine: Record "Prod. Order Line";
        PurchLine: Record "Purchase Line";
        ReqLine: Record "Requisition Line";
        ReservEntry2: Record "Reservation Entry";
        Item: Record Item;
    begin
        SalesPlanLine.DELETEALL;
        ValidateProdOrderSingle(SalesLineparam);
        SalesLine.SETRANGE("Document Type", SalesLine."Document Type"::Order);
        SalesLine.SETRANGE("Document No.", SalesLineparam."Document No.");
        SalesLine.SETRANGE("Line No.", SalesLineparam."Line No.");
        SalesLine.SETRANGE(Type, SalesLine.Type::Item);
        IF SalesLine.FINDSET THEN BEGIN
            REPEAT
                SalesLine.TESTFIELD("Prod. Qty");
                SalesLine.TESTFIELD("Prod. Due Date");
                SalesPlanLine.INIT;
                SalesPlanLine."Sales Order No." := SalesLine."Document No.";
                SalesPlanLine."Sales Order Line No." := SalesLine."Line No.";
                SalesPlanLine."Item No." := SalesLine."No.";

                SalesPlanLine."Variant Code" := SalesLine."Variant Code";
                Item.RESET;
                IF Item.GET(SalesLine."No.") THEN
                    SalesPlanLine.Description := Item.Description
                ELSE
                    SalesPlanLine.Description := SalesLine.Description;
                SalesPlanLine."Shipment Date" := SalesLine."Shipment Date";
                SalesPlanLine."Planning Status" := SalesPlanLine."Planning Status"::Released;
                SalesLine.CALCFIELDS("Reserved Qty. (Base)");
                SalesPlanLine."Planned Quantity" := SalesLine."Reserved Qty. (Base)";
                /*ReservEngineMgt.InitFilterAndSortingLookupFor(ReservEntry,FALSE);
                ReserveSalesline.FilterReservFor(ReservEntry,SalesLine);
                ReservEntry.SETRANGE("Reservation Status",ReservEntry."Reservation Status"::Reservation);
                IF ReservEntry.FINDSET THEN
                  REPEAT
                    IF ReservEntry2.GET(ReservEntry."Entry No.",NOT ReservEntry.Positive) THEN
                      CASE ReservEntry2."Source Type" OF
                        DATABASE::"Item Ledger Entry":
                          BEGIN
                            SalesPlanLine."Planning Status" := SalesPlanLine."Planning Status"::Inventory;
                          END;
                        DATABASE::"Requisition Line":
                          BEGIN
                            ReqLine.GET(
                              ReservEntry2."Source ID",
                              ReservEntry2."Source Batch Name",
                              ReservEntry2."Source Ref. No.");
                            SalesPlanLine."Planning Status" := SalesPlanLine."Planning Status"::Planned;
                            SalesPlanLine."Expected Delivery Date" := ReqLine."Due Date";
                          END;
                        DATABASE::"Purchase Line":
                          BEGIN
                            PurchLine.GET(
                              ReservEntry2."Source Subtype",
                              ReservEntry2."Source ID",
                              ReservEntry2."Source Ref. No.");
                            SalesPlanLine."Planning Status" := SalesPlanLine."Planning Status"::"Firm Planned";
                            SalesPlanLine."Expected Delivery Date" := PurchLine."Expected Receipt Date";
                          END;
                        DATABASE::"Prod. Order Line":
                          BEGIN
                            ProdOrderLine.GET(
                              ReservEntry2."Source Subtype",
                              ReservEntry2."Source ID",
                              ReservEntry2."Source Prod. Order Line");
                            IF ProdOrderLine."Ending Date" > SalesPlanLine."Expected Delivery Date" THEN
                              SalesPlanLine."Expected Delivery Date" := ProdOrderLine."Ending Date";
                            IF ((ProdOrderLine.Status + 1) < SalesPlanLine."Planning Status") OR
                               (SalesPlanLine."Planning Status" = SalesPlanLine."Planning Status"::None)
                            THEN
                              SalesPlanLine."Planning Status" := ProdOrderLine.Status + 1;
                          END;
                      END;
                  UNTIL ReservEntry.NEXT = 0;*/
                SalesPlanLine."Needs Replanning" :=
                  (SalesPlanLine."Planned Quantity" <> SalesLine."Outstanding Qty. (Base)") OR
                  (SalesPlanLine."Expected Delivery Date" > SalesPlanLine."Shipment Date");
                /*CalculateDisposalPlan(
                  SalesLine."Variant Code",
                  SalesLine."Location Code",SalesLine."Bin Code");*/
                SalesPlanLine.INSERT;
            UNTIL SalesLine.NEXT = 0;
            EXIT(SalesLine."Prod. Qty");
        END;

    end;

    PROCEDURE PartialMakeLines(VAR SalesLineparam: Record 37): Decimal;
    BEGIN
        SalesPlanLine.DELETEALL;
        ValidateProdOrder;
        SalesLine.SETRANGE("Document Type", SalesLine."Document Type"::Order);
        SalesLine.SETRANGE("Document No.", "Document No.");
        //NSS 301207
        SalesLine.SETRANGE("Line No.", "Line No.");
        //NSS
        SalesLine.SETRANGE(Type, SalesLine.Type::Item);

        IF SalesLine.FINDFIRST THEN BEGIN
            REPEAT
                SalesLine.TESTFIELD("Prod. Qty");
                SalesLine.TESTFIELD("Prod. Due Date");
                SalesPlanLine.INIT;
                SalesPlanLine."Sales Order No." := SalesLine."Document No.";
                SalesPlanLine."Sales Order Line No." := SalesLine."Line No.";
                SalesPlanLine."Item No." := SalesLine."No.";

                SalesPlanLine."Variant Code" := SalesLine."Variant Code";
                item.RESET;
                IF item.GET(SalesLine."No.") THEN
                    SalesPlanLine.Description := item.Description
                ELSE
                    SalesPlanLine.Description := SalesLine.Description;
                SalesPlanLine."Shipment Date" := SalesLine."Shipment Date";
                SalesPlanLine."Planning Status" := SalesPlanLine."Planning Status"::Released;
                SalesLine.CALCFIELDS("Reserved Qty. (Base)");
                SalesPlanLine."Planned Quantity" := SalesLine."Reserved Qty. (Base)";
                /*ReservEngineMgt.InitFilterAndSortingLookupFor(ReservEntry,FALSE);
                ReserveSalesline.FilterReservFor(ReservEntry,SalesLine);
                ReservEntry.SETRANGE("Reservation Status",ReservEntry."Reservation Status"::Reservation);
                IF ReservEntry.FINDSET THEN
                  REPEAT
                    IF ReservEntry2.GET(ReservEntry."Entry No.",NOT ReservEntry.Positive) THEN
                      CASE ReservEntry2."Source Type" OF
                        DATABASE::"Item Ledger Entry":
                          BEGIN
                            SalesPlanLine."Planning Status" := SalesPlanLine."Planning Status"::Inventory;
                          END;
                        DATABASE::"Requisition Line":
                          BEGIN
                            ReqLine.GET(
                              ReservEntry2."Source ID",
                              ReservEntry2."Source Batch Name",
                              ReservEntry2."Source Ref. No.");
                            SalesPlanLine."Planning Status" := SalesPlanLine."Planning Status"::Planned;
                            SalesPlanLine."Expected Delivery Date" := ReqLine."Due Date";
                          END;
                        DATABASE::"Purchase Line":
                          BEGIN
                            PurchLine.GET(
                              ReservEntry2."Source Subtype",
                              ReservEntry2."Source ID",
                              ReservEntry2."Source Ref. No.");
                            SalesPlanLine."Planning Status" := SalesPlanLine."Planning Status"::"Firm Planned";
                            SalesPlanLine."Expected Delivery Date" := PurchLine."Expected Receipt Date";
                          END;
                        DATABASE::"Prod. Order Line":
                          BEGIN
                            ProdOrderLine.GET(
                              ReservEntry2."Source Subtype",
                              ReservEntry2."Source ID",
                              ReservEntry2."Source Prod. Order Line");
                            IF ProdOrderLine."Ending Date" > SalesPlanLine."Expected Delivery Date" THEN
                              SalesPlanLine."Expected Delivery Date" := ProdOrderLine."Ending Date";
                            IF ((ProdOrderLine.Status + 1) < SalesPlanLine."Planning Status") OR
                               (SalesPlanLine."Planning Status" = SalesPlanLine."Planning Status"::None)
                            THEN
                              SalesPlanLine."Planning Status" := ProdOrderLine.Status + 1;
                          END;
                      END;
                  UNTIL ReservEntry.NEXT = 0;
                  */
                SalesPlanLine."Needs Replanning" :=
                  (SalesPlanLine."Planned Quantity" <> SalesLine."Outstanding Qty. (Base)") OR
                  (SalesPlanLine."Expected Delivery Date" > SalesPlanLine."Shipment Date");
                /*CalculateDisposalPlan(
                  SalesLine."Variant Code",
                  SalesLine."Location Code",SalesLine."Bin Code");*/
                SalesPlanLine.INSERT;
                EXIT(SalesLine."Prod. Qty");
            UNTIL SalesLine.NEXT = 0;
        END;
    END;

    var
        SalesHeadet: Record "Sales Header";
        Window: Dialog;



}

