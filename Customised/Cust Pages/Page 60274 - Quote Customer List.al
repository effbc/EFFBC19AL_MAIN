page 60274 "Quote Customer List"
{
    // version B2BQTO

    CaptionML = ENU = 'Customer List',
                ENN = 'Customer List';
    PageType = List;
    PromotedActionCategoriesML = ENU = 'New,Process,Report,Approve',
                                 ENN = 'New,Process,Report,Approve';
    SourceTable = Customer;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field("No."; Rec."No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Name; Rec.Name)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Service Zone Code"; Rec."Service Zone Code")
                {
                    ApplicationArea = All;
                }
                field("Territory Code"; Rec."Territory Code")
                {
                    ApplicationArea = All;
                }
                field(Address; Rec.Address)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Make A Quote"; Rec."Make A Quote")
                {
                    ApplicationArea = All;
                }
                field("Tally Ref"; Rec."Tally Ref")
                {
                    ApplicationArea = All;
                }
                field(SalBalance; Rec.SalBalance)
                {
                    ApplicationArea = All;
                }
                field(CSBalance; Rec.CSBalance)
                {
                    ApplicationArea = All;
                }
                field("Address 2"; Rec."Address 2")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("State Code"; Rec."State Code")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(City; Rec.City)
                {
                    ApplicationArea = All;
                }
                field("Primary Contact No."; Rec."Primary Contact No.")
                {
                    ApplicationArea = All;
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    ApplicationArea = All;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                }
                field("Post Code"; Rec."Post Code")
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Country/Region Code"; Rec."Country/Region Code")
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                /* field("Phone "No."; Rec."Phone "No.")
                 {
                     Editable = false;
                     ApplicationArea = All;
                 }
                 field("Fax "No."; Rec."Fax "No.")
                 {
                     Editable = false;
                     Visible = false;
                     ApplicationArea = All;
                 }*/
                field("IC Partner Code"; Rec."IC Partner Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field(Contact; Rec.Contact)
                {
                    ApplicationArea = All;
                }
                field("Salesperson Code"; Rec."Salesperson Code")
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Customer Posting Group"; Rec."Customer Posting Group")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Gen. Bus. Posting Group"; Rec."Gen. Bus. Posting Group")
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Customer Price Group"; Rec."Customer Price Group")
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Customer Disc. Group"; Rec."Customer Disc. Group")
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Payment Terms Code"; Rec."Payment Terms Code")
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Reminder Terms Code"; Rec."Reminder Terms Code")
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Fin. Charge Terms Code"; Rec."Fin. Charge Terms Code")
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Language Code"; Rec."Language Code")
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Search Name"; Rec."Search Name")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Credit Limit (LCY)"; Rec."Credit Limit (LCY)")
                {
                    Style = None;
                    Visible = false;
                    ApplicationArea = All;
                }
                field(Blocked; Rec.Blocked)
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Last Date Modified"; Rec."Last Date Modified")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Application Method"; Rec."Application Method")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Combine Shipments"; Rec."Combine Shipments")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field(Reserve; Rec.Reserve)
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Shipping Advice"; Rec."Shipping Advice")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Shipping Agent Code"; Rec."Shipping Agent Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Base Calendar Code"; Rec."Base Calendar Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("E-Mail"; Rec."E-Mail")
                {
                    ApplicationArea = All;
                }
                field("VAT Bus. Posting Group"; Rec."VAT Bus. Posting Group")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                /* field("Excise Bus. Posting Group"; "Excise Bus. Posting Group")
                 {
                     Editable = false;
                     ApplicationArea = All;
                 }*/
                field("Tax Area Code"; Rec."Tax Area Code")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Balance (LCY)"; Rec."Balance (LCY)")
                {
                    ApplicationArea = All;
                }
                /*field("T.I.N. No."; "T.I.N. No.")
                {
                    ApplicationArea = All;
                }*/
                field("Payment Realization Period"; Rec."Payment Realization Period")
                {
                    ApplicationArea = All;
                }
            }
            group(Control1102152012)
            {
                Editable = false;
                ShowCaption = false;
                grid(Control1102152011)
                {
                    ShowCaption = false;
                    group(Control1102152010)
                    {
                        ShowCaption = false;
                        field("TotalCustomers+FORMAT(Rec.COUNT)"; TotalCustomers + FORMAT(Rec.COUNT))
                        {
                            Editable = false;
                            ApplicationArea = All;
                        }
                    }
                    group(Control1102152001)
                    {
                        ShowCaption = false;
                        field(Color_GST_Update_C; Color_GST_Update_C)
                        {
                            Editable = false;
                            Style = StrongAccent;
                            StyleExpr = TRUE;
                            ApplicationArea = All;
                        }
                    }
                }
            }
        }
        area(factboxes)
        {

            part(Control99; "CRM Statistics FactBox")
            {
                ApplicationArea = All;
                SubPageLink = "No." = FIELD("No.");
                Visible = CRMIsCoupledToRecord;

            }
            part(Control35; "Social Listening FactBox")
            {
                SubPageLink = "Source Type" = CONST(Customer), "Source No." = FIELD("No.");
                Visible = SocialListeningVisible;
                ApplicationArea = All;
            }
            part(Control33; "Social Listening Setup FactBox")
            {
                SubPageLink = "Source Type" = CONST(Customer), "Source No." = FIELD("No.");
                UpdatePropagation = Both;
                Visible = SocialListeningSetupVisible;
                ApplicationArea = All;
            }
            part(Control1903720907; "Sales Hist. Sell-to FactBox")
            {
                SubPageLink = "No." = FIELD("No."), "Currency Filter" = FIELD("Currency Filter"), "Date Filter" = FIELD("Date Filter"), "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"), "Global Dimension 2 Filter" = FIELD("Global Dimension 2 Filter");
                Visible = true;
                ApplicationArea = All;
            }
            part(Control1907234507; "Sales Hist. Bill-to FactBox")
            {
                SubPageLink = "No." = FIELD("No."), "Currency Filter" = FIELD("Currency Filter"), "Date Filter" = FIELD("Date Filter"), "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"), "Global Dimension 2 Filter" = FIELD("Global Dimension 2 Filter");
                Visible = false;
                ApplicationArea = All;
            }
            part(Control1902018507; "Customer Statistics FactBox")
            {
                SubPageLink = "No." = FIELD("No."), "Currency Filter" = FIELD("Currency Filter"), "Date Filter" = FIELD("Date Filter"), "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"), "Global Dimension 2 Filter" = FIELD("Global Dimension 2 Filter");
                Visible = true;
                ApplicationArea = All;
            }
            part(Control1900316107; "Customer Details FactBox")
            {
                SubPageLink = "No." = FIELD("No."), "Currency Filter" = FIELD("Currency Filter"), "Date Filter" = FIELD("Date Filter"), "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"), "Global Dimension 2 Filter" = FIELD("Global Dimension 2 Filter");
                Visible = false;
                ApplicationArea = All;
            }
            part(Control1907829707; "Service Hist. Sell-to FactBox")
            {
                SubPageLink = "No." = FIELD("No."), "Currency Filter" = FIELD("Currency Filter"), "Date Filter" = FIELD("Date Filter"), "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"), "Global Dimension 2 Filter" = FIELD("Global Dimension 2 Filter");
                Visible = false;
                ApplicationArea = All;
            }
            part(Control1902613707; "Service Hist. Bill-to FactBox")
            {
                SubPageLink = "No." = FIELD("No."), "Currency Filter" = FIELD("Currency Filter"), "Date Filter" = FIELD("Date Filter"), "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"), "Global Dimension 2 Filter" = FIELD("Global Dimension 2 Filter");
                Visible = false;
                ApplicationArea = All;
            }
            systempart(Control1900383207; Links)
            {
                Visible = true;
                ApplicationArea = All;
            }
            systempart(Control1905767507; Notes)
            {
                Visible = true;
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Customer")
            {
                CaptionML = ENU = '&Customer',
                            ENN = '&Customer';
                Image = Customer;
                action("Co&mments")
                {
                    CaptionML = ENU = 'Co&mments',
                                ENN = 'Co&mments';
                    Image = ViewComments;
                    RunObject = Page 124;
                    RunPageLink = "Table Name" = CONST(Customer), "No." = FIELD("No.");
                    ApplicationArea = All;
                }
                group(Dimensions)
                {
                    CaptionML = ENU = 'Dimensions',
                                ENN = 'Dimensions';
                    Image = Dimensions;
                    action("Dimensions-Single")
                    {
                        CaptionML = ENU = 'Dimensions-Single',
                                    ENN = 'Dimensions-Single';
                        Image = Dimensions;
                        RunObject = Page 540;
                        RunPageLink = "Table ID" = CONST(18), "No." = FIELD("No.");
                        ShortCutKey = 'Shift+Ctrl+D';
                        ApplicationArea = All;
                    }
                    action("Dimensions-&Multiple")
                    {
                        AccessByPermission = TableData Dimension = R;
                        CaptionML = ENU = 'Dimensions-&Multiple',
                                    ENN = 'Dimensions-&Multiple';
                        Image = DimensionSets;
                        ApplicationArea = All;

                        trigger OnAction();
                        var
                            Cust: Record Customer;
                            DefaultDimMultiple: Page 542;
                        begin
                            CurrPage.SETSELECTIONFILTER(Cust);
                            DefaultDimMultiple.SetMultiRecord(Cust, FieldNo("No."));//EFFUPG
                                                                                    // DefaultDimMultiple.SetMultiCust(Cust);//EFFUPG
                            DefaultDimMultiple.RUNMODAL;
                        end;
                    }
                }
                action("Bank Accounts")
                {
                    CaptionML = ENU = 'Bank Accounts',
                                ENN = 'Bank Accounts';
                    Image = BankAccount;
                    RunObject = Page "Customer Bank Account List";
                    RunPageLink = "Customer No." = FIELD("No.");
                    ApplicationArea = All;
                }
                action("Direct Debit Mandates")
                {
                    CaptionML = ENU = 'Direct Debit Mandates',
                                ENN = 'Direct Debit Mandates';
                    Image = MakeAgreement;
                    RunObject = Page "SEPA Direct Debit Mandates";
                    RunPageLink = "Customer No." = FIELD("No.");
                    ApplicationArea = All;
                }
                action("Ship-&to Addresses")
                {
                    CaptionML = ENU = 'Ship-&to Addresses',
                                ENN = 'Ship-&to Addresses';
                    Image = ShipAddress;
                    RunObject = Page 301;
                    RunPageLink = "Customer No." = FIELD("No.");
                    ApplicationArea = All;
                }
                action("C&ontact")
                {
                    AccessByPermission = TableData Contact = R;
                    CaptionML = ENU = 'C&ontact',
                                ENN = 'C&ontact';
                    Image = ContactPerson;
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        ShowContact;
                    end;
                }
                action("Cross Re&ferences")
                {
                    CaptionML = ENU = 'Cross Re&ferences',
                                ENN = 'Cross Re&ferences';
                    Image = Change;
                    RunObject = Page "Cross References";
                    RunPageLink = "Cross-Reference Type" = CONST(Customer), "Cross-Reference Type No." = FIELD("No.");
                    RunPageView = SORTING("Cross-Reference Type", "Cross-Reference Type No.");
                    ApplicationArea = All;
                }
                action(ApprovalEntries)
                {
                    CaptionML = ENU = 'Approvals',
                                ENN = 'Approvals';
                    Image = Approvals;
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        ApprovalsMgmt.OpenApprovalEntriesPage(RECORDID);
                    end;
                }
            }
            group(ActionGroupCRM)
            {
                CaptionML = ENU = 'Dynamics CRM',
                            ENN = 'Dynamics CRM';
                Visible = CRMIntegrationEnabled;
                action(CRMGotoAccount)
                {
                    CaptionML = ENU = 'Account',
                                ENN = 'Account';
                    Image = CoupledCustomer;
                    ToolTipML = ENU = 'Open the coupled Microsoft Dynamics CRM account.',
                                ENN = 'Open the coupled Microsoft Dynamics CRM account.';
                    ApplicationArea = All;

                    trigger OnAction();
                    var
                        CRMIntegrationManagement: Codeunit 5330;
                    begin
                        CRMIntegrationManagement.ShowCRMEntityFromRecordID(RECORDID);
                    end;
                }
                action(CRMSynchronizeNow)
                {
                    AccessByPermission = TableData "CRM Integration Record" = IM;
                    CaptionML = ENU = 'Synchronize Now',
                                ENN = 'Synchronize Now';
                    Image = Refresh;
                    ToolTipML = ENU = 'Send or get updated data to or from Microsoft Dynamics CRM.',
                                ENN = 'Send or get updated data to or from Microsoft Dynamics CRM.';
                    ApplicationArea = All;

                    trigger OnAction();
                    var
                        Customer: Record Customer;
                        CRMIntegrationManagement: Codeunit 5330;
                        CustomerRecordRef: RecordRef;
                    begin
                        CurrPage.SETSELECTIONFILTER(Customer);
                        Customer.NEXT;

                        IF Customer.COUNT = 1 THEN
                            CRMIntegrationManagement.UpdateOneNow(Customer.RECORDID)
                        ELSE BEGIN
                            CustomerRecordRef.GETTABLE(Customer);
                            CRMIntegrationManagement.UpdateMultipleNow(CustomerRecordRef);
                        END
                    end;
                }
                action(UpdateStatisticsInCRM)
                {
                    CaptionML = ENU = 'Update Account Statistics',
                                ENN = 'Update Account Statistics';
                    Enabled = CRMIsCoupledToRecord;
                    Image = UpdateXML;
                    ToolTipML = ENU = 'Send Customer Statistics data to Microsoft Dynamics CRM to update the Account Statistics factbox',
                                ENN = 'Send Customer Statistics data to Microsoft Dynamics CRM to update the Account Statistics factbox';
                    ApplicationArea = All;

                    trigger OnAction();
                    var
                        CRMIntegrationManagement: Codeunit 5330;
                    begin
                        CRMIntegrationManagement.CreateOrUpdateCRMAccountStatistics(Rec);
                    end;
                }
                group(Coupling)
                {
                    CaptionML = Comment = 'Coupling is a noun',
                                ENU = 'Coupling',
                                ENN = 'Coupling';
                    Image = LinkAccount;
                    ToolTipML = ENU = 'Create, change, or delete a coupling between the Microsoft Dynamics NAV record and a Microsoft Dynamics CRM record.',
                                ENN = 'Create, change, or delete a coupling between the Microsoft Dynamics NAV record and a Microsoft Dynamics CRM record.';
                    action(ManageCRMCoupling)
                    {
                        AccessByPermission = TableData "CRM Integration Record" = IM;
                        CaptionML = ENU = 'Set Up Coupling',
                                    ENN = 'Set Up Coupling';
                        Image = LinkAccount;
                        ToolTipML = ENU = 'Create or modify the coupling to a Microsoft Dynamics CRM account.',
                                    ENN = 'Create or modify the coupling to a Microsoft Dynamics CRM account.';
                        ApplicationArea = All;

                        trigger OnAction();
                        var
                            CRMIntegrationManagement: Codeunit 5330;
                        begin

                            //CRMIntegrationManagement.CreateOrUpdateCoupling(RECORDID);//EFFUPG
                            CRMIntegrationManagement.DefineCoupling(RecordId);//EFFUPG
                        end;
                    }
                    action(DeleteCRMCoupling)
                    {
                        AccessByPermission = TableData "CRM Integration Record" = IM;
                        CaptionML = ENU = 'Delete Coupling',
                                    ENN = 'Delete Coupling';
                        Enabled = CRMIsCoupledToRecord;
                        Image = UnLinkAccount;
                        ToolTipML = ENU = 'Delete the coupling to a Microsoft Dynamics CRM account.',
                                    ENN = 'Delete the coupling to a Microsoft Dynamics CRM account.';
                        ApplicationArea = All;

                        trigger OnAction();
                        var
                            CRMCouplingManagement: Codeunit 5331;
                        begin
                            CRMCouplingManagement.RemoveCoupling(RECORDID);
                        end;
                    }
                }
                group(Create)
                {
                    CaptionML = ENU = 'Create',
                                ENN = 'Create';
                    Image = NewCustomer;
                    action(CreateInCRM)
                    {
                        CaptionML = ENU = 'Create Account in Dynamics CRM',
                                    ENN = 'Create Account in Dynamics CRM';
                        Image = NewCustomer;
                        ApplicationArea = All;

                        trigger OnAction();
                        var
                            Customer: Record Customer;
                            CRMIntegrationManagement: Codeunit 5330;
                            CustomerRecordRef: RecordRef;
                        begin
                            CurrPage.SETSELECTIONFILTER(Customer);
                            Customer.NEXT;
                            CustomerRecordRef.GETTABLE(Customer);
                            CRMIntegrationManagement.CreateNewRecordsInCRM(CustomerRecordRef);
                        end;
                    }
                    action(CreateFromCRM)
                    {
                        CaptionML = ENU = 'Create Customer in Dynamics NAV',
                                    ENN = 'Create Customer in Dynamics NAV';
                        Image = NewCustomer;
                        ApplicationArea = All;

                        trigger OnAction();
                        var
                            CRMIntegrationManagement: Codeunit 5330;
                        begin
                            CRMIntegrationManagement.ManageCreateNewRecordFromCRM(DATABASE::Customer);
                        end;
                    }
                }
            }
            group(History)
            {
                CaptionML = ENU = 'History',
                            ENN = 'History';
                Image = History;
                action(CustomerLedgerEntries)
                {
                    CaptionML = ENU = 'Ledger E&ntries',
                                ENN = 'Ledger E&ntries';
                    Image = CustomerLedger;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Customer Ledger Entries";
                    RunPageLink = "Customer No." = FIELD("No.");
                    RunPageView = SORTING("Customer No.");
                    ShortCutKey = 'Ctrl+F7';
                    ApplicationArea = All;
                }
                action(Statistics)
                {
                    CaptionML = ENU = 'Statistics',
                                ENN = 'Statistics';
                    Image = Statistics;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Customer Statistics";
                    RunPageLink = "No." = FIELD("No."), "Date Filter" = FIELD("Date Filter"), "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"), "Global Dimension 2 Filter" = FIELD("Global Dimension 2 Filter");
                    ShortCutKey = 'F7';
                    ApplicationArea = All;
                }
                action("S&ales")
                {
                    CaptionML = ENU = 'S&ales',
                                ENN = 'S&ales';
                    Image = Sales;
                    RunObject = Page "Customer Sales";
                    RunPageLink = "No." = FIELD("No."), "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"), "Global Dimension 2 Filter" = FIELD("Global Dimension 2 Filter");
                    ApplicationArea = All;
                }
                action("Entry Statistics")
                {
                    CaptionML = ENU = 'Entry Statistics',
                                ENN = 'Entry Statistics';
                    Image = EntryStatistics;
                    RunObject = Page "Customer Entry Statistics";
                    RunPageLink = "No." = FIELD("No."), "Date Filter" = FIELD("Date Filter"), "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"), "Global Dimension 2 Filter" = FIELD("Global Dimension 2 Filter");
                    ApplicationArea = All;
                }
                action("Statistics by C&urrencies")
                {
                    CaptionML = ENU = 'Statistics by C&urrencies',
                                ENN = 'Statistics by C&urrencies';
                    Image = Currencies;
                    RunObject = Page "Cust. Stats. by Curr. Lines";
                    RunPageLink = "Customer Filter" = FIELD("No."), "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"), "Global Dimension 2 Filter" = FIELD("Global Dimension 2 Filter"), "Date Filter" = FIELD("Date Filter");
                    ApplicationArea = All;
                }
                action("Item &Tracking Entries")
                {
                    CaptionML = ENU = 'Item &Tracking Entries',
                                ENN = 'Item &Tracking Entries';
                    Image = ItemTrackingLedger;
                    ApplicationArea = All;

                    trigger OnAction();
                    var
                        ItemTrackingDocMgt: Codeunit 6503;
                    begin
                        ItemTrackingDocMgt.ShowItemTrackingForMasterData(1, "No.", '', '', '', '', '');
                    end;
                }
            }
            group(Action24)
            {
                CaptionML = ENU = 'S&ales',
                            ENN = 'S&ales';
                Image = Sales;
                action(Sales_InvoiceDiscounts)
                {
                    CaptionML = ENU = 'Invoice &Discounts',
                                ENN = 'Invoice &Discounts';
                    Image = CalculateInvoiceDiscount;
                    RunObject = Page "Cust. Invoice Discounts";
                    RunPageLink = Code = FIELD("Invoice Disc. Code");
                    ApplicationArea = All;
                }
                action(Sales_Prices)
                {
                    CaptionML = ENU = 'Prices',
                                ENN = 'Prices';
                    Image = Price;
                    RunObject = Page 7002;
                    RunPageLink = "Sales Type" = CONST(Customer), "Sales Code" = FIELD("No.");
                    RunPageView = SORTING("Sales Type", "Sales Code");
                    ApplicationArea = All;
                }
                action(Sales_LineDiscounts)
                {
                    CaptionML = ENU = 'Line Discounts',
                                ENN = 'Line Discounts';
                    Image = LineDiscount;
                    RunObject = Page 7004;
                    RunPageLink = "Sales Type" = CONST(Customer), "Sales Code" = FIELD("No.");
                    RunPageView = SORTING("Sales Type", "Sales Code");
                    ApplicationArea = All;
                }
                action("Prepa&yment Percentages")
                {
                    CaptionML = ENU = 'Prepa&yment Percentages',
                                ENN = 'Prepa&yment Percentages';
                    Image = PrepaymentPercentages;
                    RunObject = Page 664;
                    RunPageLink = "Sales Type" = CONST(Customer), "Sales Code" = FIELD("No.");
                    RunPageView = SORTING("Sales Type", "Sales Code");
                    ApplicationArea = All;
                }
                action("S&td. Cust. Sales Codes")
                {
                    CaptionML = ENU = 'S&td. Cust. Sales Codes',
                                ENN = 'S&td. Cust. Sales Codes';
                    Image = CodesList;
                    RunObject = Page "Standard Customer Sales Codes";
                    RunPageLink = "Customer No." = FIELD("No.");
                    ApplicationArea = All;
                }
            }
            group(Documents)
            {
                CaptionML = ENU = 'Documents',
                            ENN = 'Documents';
                Image = Documents;
                action(Quotes)
                {
                    CaptionML = ENU = 'Quotes',
                                ENN = 'Quotes';
                    Image = Quote;
                    RunObject = Page 9300;
                    RunPageLink = "Sell-to Customer No." = FIELD("No.");
                    RunPageView = SORTING("Sell-to Customer No.");
                    ApplicationArea = All;
                }
                action(Orders)
                {
                    CaptionML = ENU = 'Orders',
                                ENN = 'Orders';
                    Image = Document;
                    RunObject = Page "Sales Order List";
                    RunPageLink = "Sell-to Customer No." = FIELD("No.");
                    RunPageView = SORTING("Sell-to Customer No.");
                    ApplicationArea = All;
                }
                action("Return Orders")
                {
                    CaptionML = ENU = 'Return Orders',
                                ENN = 'Return Orders';
                    Image = ReturnOrder;
                    RunObject = Page "Sales Return Order List";
                    RunPageLink = "Sell-to Customer No." = FIELD("No.");
                    RunPageView = SORTING("Sell-to Customer No.");
                    ApplicationArea = All;
                }
                group("Issued Documents")
                {
                    CaptionML = ENU = 'Issued Documents',
                                ENN = 'Issued Documents';
                    Image = Documents;
                    action("Issued &Reminders")
                    {
                        CaptionML = ENU = 'Issued &Reminders',
                                    ENN = 'Issued &Reminders';
                        Image = OrderReminder;
                        RunObject = Page "Issued Reminder List";
                        RunPageLink = "Customer No." = FIELD("No.");
                        RunPageView = SORTING("Customer No.", "Posting Date");
                        ApplicationArea = All;
                    }
                    action("Issued &Finance Charge Memos")
                    {
                        CaptionML = ENU = 'Issued &Finance Charge Memos',
                                    ENN = 'Issued &Finance Charge Memos';
                        Image = FinChargeMemo;
                        RunObject = Page "Issued Fin. Charge Memo List";
                        RunPageLink = "Customer No." = FIELD("No.");
                        RunPageView = SORTING("Customer No.", "Posting Date");
                        ApplicationArea = All;
                    }
                }
                action("Blanket Orders")
                {
                    CaptionML = ENU = 'Blanket Orders',
                                ENN = 'Blanket Orders';
                    Image = BlanketOrder;
                    RunObject = Page "Blanket Sales Orders";
                    RunPageLink = "Sell-to Customer No." = FIELD("No.");
                    RunPageView = SORTING("Document Type", "Sell-to Customer No.");
                    ApplicationArea = All;
                }
            }

            group("Credit Card")
            {
                CaptionML = ENU = 'Credit Card',
                            ENN = 'Credit Card';
                Image = CreditCard;

                group("Credit Cards")
                {
                    CaptionML = ENU = 'Credit Cards',
                                ENN = 'Credit Cards';
                    Image = CreditCard;
                    action("C&redit Cards")
                    {
                        CaptionML = ENU = 'C&redit Cards',
                                    ENN = 'C&redit Cards';
                        Image = CreditCard;
                        ApplicationArea = All;
                        /* RunObject = Page "DO Payment Credit Card List";
                         RunPageLink = "Customer No." = FIELD("No.");*/
                    }
                    action("Credit Cards Transaction Lo&g Entries")
                    {
                        CaptionML = ENU = 'Credit Cards Transaction Lo&g Entries',
                                    ENN = 'Credit Cards Transaction Lo&g Entries';
                        Image = CreditCardLog;
                        ApplicationArea = All;
                        /*RunObject = Page "DO Payment Trans. Log Entries";
                        RunPageLink = "Customer No." = FIELD("No.");*/
                    }


                }


                group(Service)
                {
                    Caption = 'Service';
                    //Image = ServiceItem;

                    action("Service Orders")
                    {
                        CaptionML = ENU = 'Service Orders',
                                ENN = 'Service Orders';
                        Image = Document;
                        RunObject = Page 9318;
                        RunPageLink = "Customer No." = FIELD("No.");
                        RunPageView = SORTING("Document Type", "Customer No.");
                        ApplicationArea = All;
                    }
                    action("Ser&vice Contracts")
                    {
                        CaptionML = ENU = 'Ser&vice Contracts',
                                ENN = 'Ser&vice Contracts';
                        Image = ServiceAgreement;
                        RunObject = Page 6065;
                        RunPageLink = "Customer No." = FIELD("No.");
                        RunPageView = SORTING("Customer No.", "Ship-to Code");
                        ApplicationArea = All;
                    }
                    action("Service &Items")
                    {
                        CaptionML = ENU = 'Service &Items',
                                ENN = 'Service &Items';
                        Image = ServiceItem;
                        RunObject = Page 5988;
                        RunPageLink = "Customer No." = FIELD("No.");
                        RunPageView = SORTING("Customer No.", "Ship-to Code", "Item No.", "Serial No.");
                        ApplicationArea = All;
                    }


                }
            }

        }

        area(creation)
        {
            action("Blanket Sales Order")
            {
                CaptionML = ENU = 'Blanket Sales Order',
                            ENN = 'Blanket Sales Order';
                Image = BlanketOrder;
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = New;
                RunObject = Page "Blanket Sales Order";
                RunPageLink = "Sell-to Customer No." = FIELD("No.");
                RunPageMode = Create;
                ApplicationArea = All;
            }
            action("Sales Quote")
            {
                CaptionML = ENU = 'Sales Quote',
                            ENN = 'Sales Quote';
                Image = Quote;
                Promoted = true;
                PromotedCategory = New;
                RunObject = Page 41;
                RunPageLink = "Sell-to Customer No." = FIELD("No.");
                RunPageMode = Create;
                ApplicationArea = All;
            }
            action("Sales Invoice")
            {
                CaptionML = ENU = 'Sales Invoice',
                            ENN = 'Sales Invoice';
                Image = Invoice;
                Promoted = true;
                PromotedCategory = New;
                RunObject = Page "Sales Invoice";
                RunPageLink = "Sell-to Customer No." = FIELD("No.");
                RunPageMode = Create;
                ApplicationArea = All;
            }
            action("Sales Order")
            {
                CaptionML = ENU = 'Sales Order',
                            ENN = 'Sales Order';
                Image = Document;
                Promoted = true;
                PromotedCategory = New;
                RunObject = Page 42;
                RunPageLink = "Sell-to Customer No." = FIELD("No.");
                RunPageMode = Create;
                ApplicationArea = All;
            }
            action("Sales Credit Memo")
            {
                CaptionML = ENU = 'Sales Credit Memo',
                            ENN = 'Sales Credit Memo';
                Image = CreditMemo;
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = New;
                RunObject = Page "Sales Credit Memo";
                RunPageLink = "Sell-to Customer No." = FIELD("No.");
                RunPageMode = Create;
                ApplicationArea = All;
            }
            action("Sales Return Order")
            {
                CaptionML = ENU = 'Sales Return Order',
                            ENN = 'Sales Return Order';
                Image = ReturnOrder;
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = New;
                RunObject = Page "Sales Return Order";
                RunPageLink = "Sell-to Customer No." = FIELD("No.");
                RunPageMode = Create;
                ApplicationArea = All;
            }
            action("Service Quote")
            {
                CaptionML = ENU = 'Service Quote',
                            ENN = 'Service Quote';
                Image = Quote;
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = New;
                RunObject = Page "Service Quote";
                RunPageLink = "Customer No." = FIELD("No.");
                RunPageMode = Create;
                ApplicationArea = All;
            }
            action("Service Invoice")
            {
                CaptionML = ENU = 'Service Invoice',
                            ENN = 'Service Invoice';
                Image = Invoice;
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = New;
                RunObject = Page "Service Invoice";
                RunPageLink = "Customer No." = FIELD("No.");
                RunPageMode = Create;
                ApplicationArea = All;
            }
            action("Service Order")
            {
                CaptionML = ENU = 'Service Order',
                            ENN = 'Service Order';
                Image = Document;
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = New;
                RunObject = Page "Service Order";
                RunPageLink = "Customer No." = FIELD("No.");
                RunPageMode = Create;
                ApplicationArea = All;
            }
            action("Service Credit Memo")
            {
                CaptionML = ENU = 'Service Credit Memo',
                            ENN = 'Service Credit Memo';
                Image = CreditMemo;
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = New;
                RunObject = Page "Service Credit Memo";
                RunPageLink = "Customer No." = FIELD("No.");
                RunPageMode = Create;
                ApplicationArea = All;
            }
            action(Reminder)
            {
                CaptionML = ENU = 'Reminder',
                            ENN = 'Reminder';
                Image = Reminder;
                Promoted = true;
                PromotedCategory = New;
                RunObject = Page Reminder;
                RunPageLink = "Customer No." = FIELD("No.");
                RunPageMode = Create;
                ApplicationArea = All;
            }
            action("Finance Charge Memo")
            {
                CaptionML = ENU = 'Finance Charge Memo',
                            ENN = 'Finance Charge Memo';
                Image = FinChargeMemo;
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = New;
                RunObject = Page "Finance Charge Memo";
                RunPageLink = "Customer No." = FIELD("No.");
                RunPageMode = Create;
                ApplicationArea = All;
            }
        }
        area(processing)
        {
            group("Request Approval")
            {
                CaptionML = ENU = 'Request Approval',
                            ENN = 'Request Approval';
                Image = SendApprovalRequest;
                action(SendApprovalRequest)
                {
                    CaptionML = ENU = 'Send A&pproval Request',
                                ENN = 'Send A&pproval Request';
                    Enabled = NOT OpenApprovalEntriesExist;
                    Image = SendApprovalRequest;
                    ApplicationArea = All;

                    trigger OnAction();
                    var
                        ApprovalsMgmt: Codeunit 1535;
                    begin
                        IF ApprovalsMgmt.CheckCustomerApprovalsWorkflowEnabled(Rec) THEN
                            ApprovalsMgmt.OnSendCustomerForApproval(Rec);
                    end;
                }
                action(CancelApprovalRequest)
                {
                    CaptionML = ENU = 'Cancel Approval Re&quest',
                                ENN = 'Cancel Approval Re&quest';
                    Enabled = OpenApprovalEntriesExist;
                    Image = Cancel;
                    ApplicationArea = All;

                    trigger OnAction();
                    var
                        ApprovalsMgmt: Codeunit 1535;
                    begin
                        ApprovalsMgmt.OnCancelCustomerApprovalRequest(Rec);
                    end;
                }
            }
            action("Cash Receipt Journal")
            {
                CaptionML = ENU = 'Cash Receipt Journal',
                            ENN = 'Cash Receipt Journal';
                Image = CashReceiptJournal;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "Cash Receipt Journal";
                ApplicationArea = All;
            }
            action("Sales Journal")
            {
                CaptionML = ENU = 'Sales Journal',
                            ENN = 'Sales Journal';
                Image = Journals;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "Sales Journal";
                ApplicationArea = All;
            }
        }
        area(reporting)
        {
            group(General)
            {
                CaptionML = ENU = 'General',
                            ENN = 'General';
                action("Customer List")
                {
                    CaptionML = ENU = 'Customer List',
                                ENN = 'Customer List';
                    Image = "Report";
                    Promoted = false;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = "Report";
                    RunObject = Report "Customer - List";
                    ApplicationArea = All;
                }
                action("Customer Register")
                {
                    CaptionML = ENU = 'Customer Register',
                                ENN = 'Customer Register';
                    Image = "Report";
                    Promoted = false;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = "Report";
                    RunObject = Report "Customer Register";
                    ApplicationArea = All;
                }
                action("Customer - Top 10 List")
                {
                    CaptionML = ENU = 'Customer - Top 10 List',
                                ENN = 'Customer - Top 10 List';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    RunObject = Report "Customer - Top 10 List";
                    ApplicationArea = All;
                }
            }
            group(Sales)
            {
                CaptionML = ENU = 'Sales',
                            ENN = 'Sales';
                Image = Sales;
                action("Customer - Order Summary")
                {
                    CaptionML = ENU = 'Customer - Order Summary',
                                ENN = 'Customer - Order Summary';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    RunObject = Report "Customer - Order Summary";
                    ApplicationArea = All;
                }
                action("Customer - Order Detail")
                {
                    CaptionML = ENU = 'Customer - Order Detail',
                                ENN = 'Customer - Order Detail';
                    Image = "Report";
                    Promoted = false;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = "Report";
                    RunObject = Report "Customer - Order Detail";
                    ApplicationArea = All;
                }
                action("Customer - Sales List")
                {
                    CaptionML = ENU = 'Customer - Sales List',
                                ENN = 'Customer - Sales List';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    RunObject = Report "Customer - Sales List";
                    ApplicationArea = All;
                }
                action("Sales Statistics")
                {
                    CaptionML = ENU = 'Sales Statistics',
                                ENN = 'Sales Statistics';
                    Image = "Report";
                    Promoted = false;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = "Report";
                    RunObject = Report "Sales Statistics";
                    ApplicationArea = All;
                }
                action("Customer/Item Sales")
                {
                    CaptionML = ENU = 'Customer/Item Sales',
                                ENN = 'Customer/Item Sales';
                    Image = "Report";
                    Promoted = false;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = "Report";
                    RunObject = Report "Customer/Item Sales";
                    ApplicationArea = All;
                }
            }
            group("Financial Management")
            {
                CaptionML = ENU = 'Financial Management',
                            ENN = 'Financial Management';
                Image = "Report";
                action("Customer - Detail Trial Bal.")
                {
                    CaptionML = ENU = 'Customer - Detail Trial Bal.',
                                ENN = 'Customer - Detail Trial Bal.';
                    Image = "Report";
                    Promoted = false;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = "Report";
                    RunObject = Report "Customer - Detail Trial Bal.";
                    ApplicationArea = All;
                }
                action("Customer - Summary Aging")
                {
                    CaptionML = ENU = 'Customer - Summary Aging',
                                ENN = 'Customer - Summary Aging';
                    Image = "Report";
                    Promoted = false;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = "Report";
                    RunObject = Report "Customer - Summary Aging";
                    ApplicationArea = All;
                }
                action("Customer Detailed Aging")
                {
                    CaptionML = ENU = 'Customer Detailed Aging',
                                ENN = 'Customer Detailed Aging';
                    Image = "Report";
                    Promoted = false;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = "Report";
                    RunObject = Report "Customer Detailed Aging";
                    ApplicationArea = All;
                }
                action(Statement)
                {
                    CaptionML = ENU = 'Statement',
                                ENN = 'Statement';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    RunObject = Codeunit "Customer Layout - Statement";
                    ApplicationArea = All;
                }
                action(Action1903839806)
                {
                    CaptionML = ENU = 'Reminder',
                                ENN = 'Reminder';
                    Image = Reminder;
                    Promoted = false;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = "Report";
                    RunObject = Report Reminder;
                    ApplicationArea = All;
                }
                action("Aged Accounts Receivable")
                {
                    CaptionML = ENU = 'Aged Accounts Receivable',
                                ENN = 'Aged Accounts Receivable';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    RunObject = Report "Aged Accounts Receivable";
                    ApplicationArea = All;
                }
                action("Customer - Balance to Date")
                {
                    CaptionML = ENU = 'Customer - Balance to Date',
                                ENN = 'Customer - Balance to Date';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    RunObject = Report "Customer - Balance to Date";
                    ApplicationArea = All;
                }
                action("Customer - Trial Balance")
                {
                    CaptionML = ENU = 'Customer - Trial Balance',
                                ENN = 'Customer - Trial Balance';
                    Image = "Report";
                    Promoted = false;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = "Report";
                    RunObject = Report "Customer - Trial Balance";
                    ApplicationArea = All;
                }
                action("Customer - Payment Receipt")
                {
                    CaptionML = ENU = 'Customer - Payment Receipt',
                                ENN = 'Customer - Payment Receipt';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    RunObject = Report "Customer - Payment Receipt";
                    ApplicationArea = All;
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord();
    var
    // CRMCouplingManagement : Codeunit "CRM Coupling Management";
    begin
    end;


    trigger OnOpenPage()
    var
        myInt: Integer;
    begin
        //>= 20080401D
        Rec.setfilter("CSBalance Filter", '>=%1', DMY2Date(01, 04, 2008));//EFFUPG1.2
                                                                          //> 20080331D
        Rec.setfilter("SalBalance Filter", '>%1', DMY2Date(31, 03, 2008));//EFFUPG1.2

    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean;
    var
        Customer: Record Customer;
        CustomerContactData: Record "Customer/Contact Data";
        NoLVar: Integer;
    begin
        IF CloseAction IN [ACTION::OK, ACTION::LookupOK] THEN BEGIN
            CustomerContactData.RESET;
            CustomerContactData.SETRANGE("Sales Quote No.", QuoteNoGVar);
            IF CustomerContactData.FINDLAST THEN
                NoLVar := CustomerContactData."No."
            ELSE
                NoLVar := 1;


            Customer.RESET;
            Customer.SETRANGE("Make A Quote", TRUE);
            IF Customer.FINDSET THEN
                REPEAT
                    CustomerContactData.INIT;
                    CustomerContactData."No." := NoLVar;
                    CustomerContactData."Sales Quote No." := QuoteNoGVar;
                    CustomerContactData."Customer\Contact" := Customer."No.";
                    CustomerContactData."Email Id" := Customer."E-Mail";
                    CustomerContactData.Name := Customer.Name;
                    CustomerContactData.Place := Customer.City;
                    CustomerContactData.Type := CustomerContactData.Type::Customer;
                    CustomerContactData.INSERT;
                    NoLVar += 1;
                    Customer."Make A Quote" := FALSE;
                    Customer.MODIFY;
                UNTIL Customer.NEXT = 0;
        END;
    end;

    var
        ApprovalsMgmt: Codeunit 1535;
        SocialListeningSetupVisible: Boolean;
        SocialListeningVisible: Boolean;
        CRMIntegrationEnabled: Boolean;
        CRMIsCoupledToRecord: Boolean;
        OpenApprovalEntriesExist: Boolean;
        TotalCustomers: Label '"Total Customers: "';
        Color_GST_Update: Code[30];
        RowCount: Integer;
        //SQLConnection: Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000514-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'.Connection";
        // RecordSet: Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000535-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'.Recordset";
        ConnectionOpen: Integer;
        Color_GST_Update_C: Label 'GST Details Not Updated';
        cus: Record Customer;
        id: Integer;
        QuoteNoGVar: Code[20];


    procedure GetSelectionFilter(): Text;
    var
        Cust: Record Customer;
        SelectionFilterManagement: Codeunit 46;
    begin
        CurrPage.SETSELECTIONFILTER(Cust);
        EXIT(SelectionFilterManagement.GetSelectionFilterForCustomer(Cust));
    end;


    procedure SetSelection(var Cust: Record Customer);
    begin
        CurrPage.SETSELECTIONFILTER(Cust);
    end;

    local procedure SetSocialListeningFactboxVisibility();
    var
        SocialListeningMgt: Codeunit "Social Listening Management";
    begin
        SocialListeningMgt.GetCustFactboxVisibility(Rec, SocialListeningSetupVisible, SocialListeningVisible);
    end;

    procedure GSTMails();
    var
        Type: Code[2];
        No: Code[20];
        Subject: Text[1000];
        Mail_To: Text[1000];
        Mail_From: Text[1000];
        //SMTP_MAIL: Codeunit "SMTP Mail";
        EmailMessage: Codeunit 8904;
        Email: Codeunit 8901;
        Recipients: List of [Text];
        SQLQuery: Text[1024];
        TempText: Text;
        Body: Text;
        Attachment: Text;
    begin
        /*IF ISCLEAR(SQLConnection) THEN
            CREATE(SQLConnection, FALSE, TRUE);

        IF ISCLEAR(RecordSet) THEN
            CREATE(RecordSet, FALSE, TRUE);*/
        //  ConnectionOpen := 0;
        /*  IF ConnectionOpen <> 1 THEN BEGIN
              SQLConnection.ConnectionString := 'DSN=salinvoiceuser;UID=salinvoiceuser;PASSWORD=salinvoiceuser;SERVER=oracle_80;';
              SQLConnection.Open;
              //SQLConnection.BeginTrans;
              ConnectionOpen := 1;
          END;*/
        //SQLQuery := 'select * from Vendor_Cust_List where NO in(''CUST00971'',''CUST00972'') and (MAIL_SEND_COUNT <=0 or MAIL_SEND_COUNT is null) order by type,no;';
        /* SQLQuery := 'select * from Vendor_Cust_List where (GST_REG_NO is null) and NO = ''' + "" No.""+''' order by type,no;';
         //MESSAGE(SQLQuery);
         RecordSet := SQLConnection.Execute(SQLQuery, RowCount);
         IF NOT ((RecordSet.BOF) OR (RecordSet.EOF)) THEN
             RecordSet.MoveFirst;
         WHILE NOT RecordSet.EOF DO BEGIN
             Type := FORMAT(RecordSet.Fields.Item('TYPE').Value);
             No := FORMAT(RecordSet.Fields.Item('NO').Value);*/

        //B2B UPG >>>
        /* IF Type = 'V' THEN BEGIN
            Mail_From := 'purchase@efftronics.com';
            Mail_To := FORMAT(RecordSet.Fields.Item('EMAIL').Value);
        END
        ELSE BEGIN
            Mail_From := 'sales@efftronics.com';
            Mail_To := "E-Mail";
        END;

        //Mail_To := 'pranavi@efftronics.com';

        Subject := 'Reg : GST Information Requirements from Efftronics System Pvt Ltd.,!';
        Body := '<html><head><style> divone{background-color: white; width: 1210px; padding: 20px; border-style:solid ; border-color:#666699;  margin: 20px;} </style></head>';
        Body := Body + '<body><div style="border-color:#666699; margin: 20px; border-width:15px; border-style:solid; padding: 20px; width: 1110px;"><label><font size="6">GST Information Requirements from Efftronics System Pvt Ltd.,!</font></label>';
        Body := Body + '<hr style=solid; color= #3333CC>';
        Body := Body + '<h>Dear Sir/Madam,</h><br><br>';
        Body := Body + '<P> As you are aware, GST Roll out is likely to be from 01st July 2017. </P>';
        Body := Body + '<P> We need to update our records with the Provisional GSTIN Registration Numbers of all our Vendors/Customers. ';
        Body := Body + '<b>Request you to kindly update PAN & GST registration provisional ID in <u>below link</u> immediately.</b></P><br/>';
        //Body := Body+'<b>URL :</b><a href="http://localhost:51203/GSTRegistrationDetails.aspx?&V_C_Num=';
        Body := Body + '<font size="8"><b>URL :</b><a href="http://app.efftronics.org:8567/GST_Registration/GSTRegistrationDetails.aspx?V_C_Num=';
        Body := Body + No + '" target="_blank">GST Registration Details</a></font><br/><br/>';
        Body := Body + 'Please note that this is required to have smooth business transaction after GST implementation effective July 1, 2017.<br/><br/>';
        Body := Body + 'Our Company GST Registration details are also attached for your information.<br/><br/>';
        Body := Body + 'In case you have any queries please contact undersigned.<br/><br/>';
        Body := Body + 'Best Regards,<br/>';
        IF Type = 'V' THEN BEGIN
            Body := Body + 'Renuka CH<br/>';
            Body := Body + 'Purchase Department<br/>';
            Body := Body + 'Efftronics Systems Pvt. Ltd.,<br/>';
            Body := Body + '40-15-9,Brundavan Colony,<br/>';
            Body := Body + 'Vijayawada - 520010,<br/>';
            Body := Body + 'Andhra Pradesh, India.<br/>';
            Body := Body + 'Ph No : 0866-2466679(Direct)/2466699/75<br/>';
        END ELSE BEGIN
            Body := Body + 'S.Ganesh<br/>';
            Body := Body + 'Finance Department<br/>';
            Body := Body + 'Efftronics Systems Pvt. Ltd.,<br/>';
            Body := Body + '40-15-9,Brundavan Colony,<br/>';
            Body := Body + 'Vijayawada - 520010,<br/>';
            Body := Body + 'Andhra Pradesh, India.<br/>';
            Body := Body + 'Mobile : 9394654999<br/>';
            Body := Body + 'Ph No : 0866-2466675(Direct)/2466699/75<br/>';
        END;
        SMTP_MAIL.CreateMessage('ERP', Mail_From, Mail_To, Subject, Body, TRUE);
        Attachment := '\\erpserver\ErpAttachments\Efftronics_GST_Details.pdf';
        SMTP_MAIL.AddAttachment(Attachment, '');
        SMTP_MAIL.AddCC('erp@efftronics.com');
        SMTP_MAIL.Send; 

        IF Type = 'V' THEN BEGIN
            //Mail_From := 'purchase@efftronics.com';
            //Mail_To := FORMAT(RecordSet.Fields.Item('EMAIL').Value);
            Recipients.Add(FORMAT(RecordSet.Fields.Item('EMAIL').Value));
        END
        ELSE BEGIN
            //Mail_From := 'sales@efftronics.com';
            //Mail_To := "E-Mail";
            Recipients.Add("E-Mail");
        END;
*/   //B2B UPG <<<
        //Mail_To := 'pranavi@efftronics.com';

        Subject := 'Reg : GST Information Requirements from Efftronics System Pvt Ltd.,!';
        Body := '<html><head><style> divone{background-color: white; width: 1210px; padding: 20px; border-style:solid ; border-color:#666699;  margin: 20px;} </style></head>';
        Body := Body + '<body><div style="border-color:#666699; margin: 20px; border-width:15px; border-style:solid; padding: 20px; width: 1110px;"><label><font size="6">GST Information Requirements from Efftronics System Pvt Ltd.,!</font></label>';
        Body := Body + '<hr style=solid; color= #3333CC>';
        Body := Body + '<h>Dear Sir/Madam,</h><br><br>';
        Body := Body + '<P> As you are aware, GST Roll out is likely to be from 01st July 2017. </P>';
        Body := Body + '<P> We need to update our records with the Provisional GSTIN Registration Numbers of all our Vendors/Customers. ';
        Body := Body + '<b>Request you to kindly update PAN & GST registration provisional ID in <u>below link</u> immediately.</b></P><br/>';
        //Body := Body+'<b>URL :</b><a href="http://localhost:51203/GSTRegistrationDetails.aspx?&V_C_Num=';
        Body := Body + '<font size="8"><b>URL :</b><a href="http://app.efftronics.org:8567/GST_Registration/GSTRegistrationDetails.aspx?V_C_Num=';
        Body := Body + No + '" target="_blank">GST Registration Details</a></font><br/><br/>';
        Body := Body + 'Please note that this is required to have smooth business transaction after GST implementation effective July 1, 2017.<br/><br/>';
        Body := Body + 'Our Company GST Registration details are also attached for your information.<br/><br/>';
        Body := Body + 'In case you have any queries please contact undersigned.<br/><br/>';
        Body := Body + 'Best Regards,<br/>';
        IF Type = 'V' THEN BEGIN
            Body := Body + 'Renuka CH<br/>';
            Body := Body + 'Purchase Department<br/>';
            Body := Body + 'Efftronics Systems Pvt. Ltd.,<br/>';
            Body := Body + '40-15-9,Brundavan Colony,<br/>';
            Body := Body + 'Vijayawada - 520010,<br/>';
            Body := Body + 'Andhra Pradesh, India.<br/>';
            Body := Body + 'Ph No : 0866-2466679(Direct)/2466699/75<br/>';
        END ELSE BEGIN
            Body := Body + 'S.Ganesh<br/>';
            Body := Body + 'Finance Department<br/>';
            Body := Body + 'Efftronics Systems Pvt. Ltd.,<br/>';
            Body := Body + '40-15-9,Brundavan Colony,<br/>';
            Body := Body + 'Vijayawada - 520010,<br/>';
            Body := Body + 'Andhra Pradesh, India.<br/>';
            Body := Body + 'Mobile : 9394654999<br/>';
            Body := Body + 'Ph No : 0866-2466675(Direct)/2466699/75<br/>';
        END;
        EmailMessage.Create(Recipients, Subject, Body, TRUE);
        Attachment := '\\erpserver\ErpAttachments\Efftronics_GST_Details.pdf';
        EmailMessage.AddAttachment(Attachment, '', '');
        //SMTP_MAIL.AddCC('erp@efftronics.com');
        Recipients.Add('erp@efftronics.com');
        Email.Send(EmailMessage, Enum::"Email Scenario"::Default);

        SQLQuery := 'update Vendor_Cust_List set MAIL_SEND_COUNT = nvl(MAIL_SEND_COUNT,0)+1 where NO = ''' + No + '''';
        //MESSAGE(SQLQuery);
        /* SQLConnection.BeginTrans;
         SQLConnection.Execute(SQLQuery);
         SQLConnection.CommitTrans;
         TempText := TempText + No + ',';
         RowCount := RowCount + 1;
         RecordSet.MoveNext;*/
        //RecordSet.Close;
        //SQLConnection.CommitTrans;
        // SQLConnection.Close;
        ConnectionOpen := 0;
        IF STRLEN(TempText) > 1 THEN
            MESSAGE('Mail Has been send to ' + COPYSTR(TempText, 1, STRLEN(TempText) - 1) + ' - ' + Name + 'at ' + Mail_To);
    end;


    procedure GSTUpdated();
    var
        Type: Code[2];
        No: Code[20];
        Subject: Text[1000];
        Mail_To: Text[1000];
        Mail_From: Text[1000];
        //SMTP_MAIL: Codeunit "SMTP Mail";
        SQLQuery: Text[1024];
        TempText: Text;
        Body: Text;
        Attachment: Text;
    begin
        //SQLQuery := 'select * from Vendor_Cust_List where NO in(''CUST00971'',''CUST00972'') and (MAIL_SEND_COUNT <=0 or MAIL_SEND_COUNT is null) order by type,no;';
        // SQLQuery := 'select * from Vendor_Cust_List where (GST_REG_NO is null) and NO = ''' + "" No.""+''' order by type,no';
        //MESSAGE(SQLQuery);
        /* RecordSet := SQLConnection.Execute(SQLQuery, RowCount);
         IF NOT ((RecordSet.BOF) OR (RecordSet.EOF)) THEN
             RecordSet.MoveFirst;
         WHILE NOT RecordSet.EOF DO BEGIN
             Color_GST_Update := 'StrongAccent';
             RowCount := RowCount + 1;
             RecordSet.MoveNext;
         END;*/
        //RecordSet.Close;
        //SQLConnection.CommitTrans;
    end;


    procedure SendQuoteNo(QuoLpar: Code[20]);
    begin
        QuoteNoGVar := QuoLpar;
    end;


    //event RecordSet(cFields : Integer;"Fields" : Variant;adStatus : Integer;pRecordset : Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000556-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'._Recordset");
    //begin
    /*
    */
    //end;

    //event RecordSet(cFields : Integer;"Fields" : Variant;pError : Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000500-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'.Error";adStatus : Integer;pRecordset : Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000556-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'._Recordset");
    //begin
    /*
    */
    //end;

    //event RecordSet(adReason : Integer;cRecords : Integer;adStatus : Integer;pRecordset : Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000556-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'._Recordset");
    //begin
    /*
    */
    //end;

    //event RecordSet(adReason : Integer;cRecords : Integer;pError : Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000500-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'.Error";adStatus : Integer;pRecordset : Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000556-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'._Recordset");
    //begin
    /*
    */
    //end;

    //event RecordSet(adReason : Integer;adStatus : Integer;pRecordset : Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000556-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'._Recordset");
    //begin
    /*
    */
    //end;

    //event RecordSet(adReason : Integer;pError : Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000500-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'.Error";adStatus : Integer;pRecordset : Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000556-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'._Recordset");
    //begin
    /*
    */
    //end;

    //event RecordSet(adReason : Integer;adStatus : Integer;pRecordset : Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000556-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'._Recordset");
    //begin
    /*
    */
    //end;

    //event RecordSet(adReason : Integer;pError : Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000500-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'.Error";adStatus : Integer;pRecordset : Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000556-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'._Recordset");
    //begin
    /*
    */
    //end;

    //event RecordSet(var fMoreData : Boolean;adStatus : Integer;pRecordset : Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000556-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'._Recordset");
    //begin
    /*
    */
    //end;

    //event RecordSet(Progress : Integer;MaxProgress : Integer;adStatus : Integer;pRecordset : Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000556-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'._Recordset");
    //begin
    /*
    */
    //end;

    //event RecordSet(pError : Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000500-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'.Error";adStatus : Integer;pRecordset : Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000556-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'._Recordset");
    //begin
    /*
    */
    //end;

    //event SQLConnection(pError : Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000500-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'.Error";adStatus : Integer;pConnection : Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000550-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'._Connection");
    //begin
    /*
    */
    //end;

    //event SQLConnection(TransactionLevel : Integer;pError : Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000500-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'.Error";adStatus : Integer;pConnection : Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000550-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'._Connection");
    //begin
    /*
    */
    //end;

    //event SQLConnection(pError : Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000500-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'.Error";adStatus : Integer;pConnection : Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000550-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'._Connection");
    //begin
    /*
    */
    //end;

    //event SQLConnection(pError : Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000500-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'.Error";adStatus : Integer;pConnection : Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000550-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'._Connection");
    //begin
    /*
    */
    //end;

    //event SQLConnection(var Source : Text;CursorType : Integer;LockType : Integer;var Options : Integer;adStatus : Integer;pCommand : Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{B08400BD-F9D1-4D02-B856-71D5DBA123E9}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'._Command";pRecordset : Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000556-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'._Recordset";pConnection : Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000550-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'._Connection");
    //begin
    /*
    */
    //end;

    //event SQLConnection(RecordsAffected : Integer;pError : Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000500-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'.Error";adStatus : Integer;pCommand : Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{B08400BD-F9D1-4D02-B856-71D5DBA123E9}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'._Command";pRecordset : Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000556-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'._Recordset";pConnection : Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000550-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'._Connection");
    //begin
    /*
    */
    //end;

    //event SQLConnection(var ConnectionString : Text;var UserID : Text;var Password : Text;var Options : Integer;adStatus : Integer;pConnection : Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000550-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'._Connection");
    //begin
    /*
    */
    //end;

    //event SQLConnection(pError : Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000500-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'.Error";adStatus : Integer;pConnection : Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000550-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'._Connection");
    //begin
    /*
    */
    //end;

    //event SQLConnection(adStatus : Integer;pConnection : Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000550-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'._Connection");
    //begin
    /*
    */
    //end;
}

