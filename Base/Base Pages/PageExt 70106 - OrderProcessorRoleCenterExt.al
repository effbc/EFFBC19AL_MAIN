pageextension 70106 OrderProcessorRoleCenterExt extends "Order Processor Role Center"
{

    layout
    {


        /* modify(Control1900724808)
         {



             ShowCaption = false;
         }



         modify(Control1900724708)
         {



             ShowCaption = false;
         }

         modify(Control 1903012608)
         {


             Enabled = FALSE;



         }*/



    }
    actions
    {


        modify("Sales &Quote")
        {


            Promoted = false;

        }
        modify("Sales &Invoice")
        {


            Promoted = false;


        }
        modify("Sales &Order")
        {


            Promoted = false;


        }
        modify("Sales &Return Order")
        {


            Promoted = false;


        }
        modify("Sales &Credit Memo")
        {


            Promoted = false;


        }


        addafter("Sales &Quote")
        {
            action("Sales - Invoice")
            {
                RunObject = Report "Sales invoices";
                ApplicationArea = All;
            }

            action("AMC orders")
            {
                RunObject = page 60188;
                ApplicationArea = All;
            }
            action("To be Excecuted Order")
            {
                RunObject = page 50019;
                ApplicationArea = All;
            }



        }
        addafter("Purchase Invoices")
        {
            action("General Journal")
            {
                CaptionML = ENU = 'General Journal',
                            ENN = 'Purchase Invoices';
                RunObject = Page "General Journal Batches";
                ApplicationArea = All;
            }
            action("Indent list")
            {

                RunObject = Page 60044;
                ApplicationArea = All;
            }

            action("Indent Card")
            {

                RunObject = Page 60042;
                ApplicationArea = All;
            }
            action("To be released indent card")
            {

                RunObject = Page 60088;
                ApplicationArea = All;
            }
            action("Purchase order inventory list")
            {

                RunObject = Page 60179;
                ApplicationArea = All;
            }
            action("Purchase to be receive items")
            {

                RunObject = Page 50006;
                ApplicationArea = All;
            }
            action("Indent requisition")
            {

                RunObject = Page 60135;
                ApplicationArea = All;
            }
        }
        addafter("Posted Documents")
        {
            group("Thin Client")
            {
                Caption = 'Thin Client';
                separator(General)
                {
                    Caption = 'General';
                    IsHeader = true;
                }
                action(" Item List")
                {
                    CaptionML = ENU = ' Item List',
                                ENN = 'Items';
                    Image = Item;
                    RunObject = Page "Item List";
                    ApplicationArea = All;
                }
                action("Material Requests List")
                {
                    CaptionML = ENU = 'Material Requests List',
                                ENN = 'Items';
                    Image = Item;
                    RunObject = Page "Material Requests List";
                    ApplicationArea = All;
                }
                action("DC List")
                {
                    CaptionML = ENU = 'DC List',
                                ENN = 'Items';
                    Image = Item;
                    RunObject = Page "DC List";
                    ApplicationArea = All;
                }
                action("Posted Material Issue List")
                {
                    CaptionML = ENU = 'Posted Material Issue List',
                                ENN = 'Items';
                    Image = Item;
                    RunObject = Page "Posted Material Issue List";
                    ApplicationArea = All;
                }
                separator(Service)
                {
                    Caption = 'Service';
                    IsHeader = true;
                }
                action("Site Issues List")
                {
                    CaptionML = ENU = 'Site Issues List',
                                ENN = 'Items';
                    Image = Item;
                    RunObject = Page "Site Issues List";
                    ApplicationArea = All;
                }
                action("<Page CS Transaction List>")
                {
                    Caption = 'CS Site Transactions';
                    RunObject = Page "CS Transaction List";
                    ApplicationArea = All;
                }
                action("Page Service List")
                {
                    CaptionML = ENU = 'Service Order',
                                ENN = 'Items';
                    Image = Item;
                    RunObject = Page "Service List";
                    Scope = Page;
                    ApplicationArea = All;
                }
                action("Service Item")
                {
                    CaptionML = ENU = 'Service Item',
                                ENN = 'Items';
                    Image = Item;
                    RunObject = Page "Service Item List";
                    ApplicationArea = All;
                }
                action("Service Tasks")
                {
                    Caption = 'Service Tasks';
                    RunObject = Page "Service Item Lines";
                    ApplicationArea = All;
                }
                action("Page Site Stock Updation")
                {
                    Caption = 'Site Stock Updation';
                    RunObject = Page "Site Stock Updation";
                    ApplicationArea = All;
                }
                action("CS Site ttransactions")
                {
                    Caption = 'CS Site ttransactions';
                    RunObject = Page 60243;
                    ApplicationArea = All;
                }
                action("Site issue lists")
                {
                    Caption = 'Site issue lists';
                    RunObject = Page 60124;
                    ApplicationArea = All;
                }
                action("Troubleshooting")
                {
                    Caption = 'Troubleshooting';
                    RunObject = Page 5990;
                    ApplicationArea = All;
                }

                action("Mat.Issues Track.Specification")
                {
                    Caption = 'Mat.Issues Track.Specification';
                    RunObject = Page "Mat.Issues Track.Specification";
                    ApplicationArea = All;
                }

                action("MaterialIssues Entry Summary")
                {
                    Caption = 'MaterialIssues Entry Summary';
                    RunObject = page "MaterialIssues Entry Summary";
                    ApplicationArea = All;
                }


                separator(Finance)
                {
                    Caption = 'Finance';
                }
                action("Chart of Accounts")
                {
                    CaptionML = ENU = 'Chart of Accounts',
                                ENN = 'Items';
                    Image = Item;
                    RunObject = Page "Chart of Accounts";
                    ApplicationArea = All;
                }
                action(Action1102152008)
                {
                    CaptionML = ENU = 'Posted Sales Invoices',
                                ENN = 'Items';
                    Image = Item;
                    RunObject = Page 132;
                    ApplicationArea = All;
                }
                action("Inspection Data Sheet List")
                {
                    CaptionML = ENU = 'Inspection Data Sheet List',
                                ENN = 'Items';
                    Image = Item;
                    RunObject = Page "Inspection Data Sheet List";
                    ApplicationArea = All;
                }
                action("Inspection Receipt List")
                {
                    CaptionML = ENU = 'Inspection Receipt List',
                                ENN = 'Items';
                    Image = Item;
                    RunObject = Page "Inspection Receipt List";
                    ApplicationArea = All;
                }
                action("Posted Inspect Data Sheet List")
                {
                    CaptionML = ENU = 'Posted Inspect Data Sheet List',
                                ENN = 'Items';
                    Image = Item;
                    RunObject = Page "Posted Inspect Data Sheet List";
                    ApplicationArea = All;
                }
                action("<Page Posted Inspect. Receipt List>")
                {
                    CaptionML = ENU = 'Posted Inspect. Receipt List',
                                ENN = 'Items';
                    Image = Item;
                    RunObject = Page "Posted Inspect. Receipt List";
                    ApplicationArea = All;
                }

                action("Product wise issues")
                {

                    Image = Item;
                    RunObject = Page "Product wise issues";
                    ApplicationArea = All;
                }
                action("Shortage")
                {

                    Image = Item;
                    RunObject = Page 60073;
                    ApplicationArea = All;
                }

                action("Shortage cumulative1")
                {

                    Image = Item;
                    RunObject = Page 50012;
                    ApplicationArea = All;
                }
                action("Inwards Planning Form")
                {

                    Image = Planning;
                    RunObject = Page 60264;
                    ApplicationArea = All;
                }
                action("QC Flagged Items - Vendor wise")
                {

                    Image = Vendor;
                    RunObject = Page 60265;
                    ApplicationArea = All;
                }


            }
        }
    }


}

