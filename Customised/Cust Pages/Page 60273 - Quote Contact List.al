page 60273 "Quote Contact List"
{
    // version B2BQTO

    CaptionML = ENU = 'Contact List',
                ENN = 'Contact List';
    DataCaptionFields = "Company No.";
    PageType = List;
    SourceTable = Contact;
    SourceTableView = SORTING("Company Name", "Company No.", Type, Name);
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            field("xRec.COUNT"; xRec.COUNT)
            {
                Style = Strong;
                StyleExpr = TRUE;
                ApplicationArea = All;
            }
            repeater(Control1)
            {
                IndentationColumn = NameIndent;
                IndentationControls = Name;
                ShowCaption = false;
                field("No."; Rec."No.")
                {
                    Style = Strong;
                    StyleExpr = StyleIsStrong;
                    ApplicationArea = All;
                }
                field("Govt./Private"; Rec."Govt./Private")
                {
                    ApplicationArea = All;
                }
                field("Domestic/Foreign"; Rec."Domestic/Foreign")
                {
                    ApplicationArea = All;
                }
                field("Product Type"; Rec."Product Type")
                {
                    ApplicationArea = All;
                }
                field(Name; Rec.Name)
                {
                    Style = Strong;
                    StyleExpr = StyleIsStrong;
                    ApplicationArea = All;
                }
                field("Company Name"; Rec."Company Name")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Post Code"; Rec."Post Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Country/Region Code"; Rec."Country/Region Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Phone No."; Rec."Phone No.")
                {
                    ApplicationArea = All;
                }
                field("Mobile Phone No."; Rec."Mobile Phone No.")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Fax No."; Rec."Fax No.")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Salesperson Code"; Rec."Salesperson Code")
                {
                    ApplicationArea = All;
                }
                field("Territory Code"; Rec."Territory Code")
                {
                    ApplicationArea = All;
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Language Code"; Rec."Language Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Search Name"; Rec."Search Name")
                {
                    ApplicationArea = All;
                }
                field("Make A Quote"; Rec."Make A Quote")
                {
                    ApplicationArea = All;
                }
            }
        }
        area(factboxes)
        {
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
            group("C&ontact")
            {
                CaptionML = ENU = 'C&ontact',
                            ENN = 'C&ontact';
                Image = ContactPerson;
                group("Comp&any")
                {
                    CaptionML = ENU = 'Comp&any',
                                ENN = 'Comp&any';
                    Enabled = CompanyGroupEnabled;
                    Image = Company;
                    action("Business Relations")
                    {
                        CaptionML = ENU = 'Business Relations',
                                    ENN = 'Business Relations';
                        Image = BusinessRelation;
                        RunObject = Page "Contact Business Relations";
                        RunPageLink = "Contact No." = FIELD("Company No.");
                        ApplicationArea = All;
                    }
                    action("Industry Groups")
                    {
                        CaptionML = ENU = 'Industry Groups',
                                    ENN = 'Industry Groups';
                        Image = IndustryGroups;
                        RunObject = Page 5067;
                        RunPageLink = "Contact No." = FIELD("Company No.");
                        ApplicationArea = All;
                    }
                    action("Web Sources")
                    {
                        CaptionML = ENU = 'Web Sources',
                                    ENN = 'Web Sources';
                        Image = Web;
                        RunObject = Page "Contact Web Sources";
                        RunPageLink = "Contact No." = FIELD("Company No.");
                        ApplicationArea = All;
                    }
                }
                group("P&erson")
                {
                    CaptionML = ENU = 'P&erson',
                                ENN = 'P&erson';
                    Enabled = PersonGroupEnabled;
                    Image = User;
                    action("Job Responsibilities")
                    {
                        CaptionML = ENU = 'Job Responsibilities',
                                    ENN = 'Job Responsibilities';
                        Image = Job;
                        ApplicationArea = All;

                        trigger OnAction();
                        var
                            ContJobResp: Record "Contact Job Responsibility";
                        begin
                            TESTFIELD(Type, Type::Person);
                            ContJobResp.SETRANGE("Contact No.", "No.");
                            PAGE.RUNMODAL(PAGE::"Contact Job Responsibilities", ContJobResp);
                        end;
                    }
                }
                action("Pro&files")
                {
                    CaptionML = ENU = 'Pro&files',
                                ENN = 'Pro&files';
                    Image = Answers;
                    ApplicationArea = All;

                    trigger OnAction();
                    var
                        ProfileManagement: Codeunit ProfileManagement;
                    begin
                        ProfileManagement.ShowContactQuestionnaireCard(Rec, '', 0);
                    end;
                }
                action("&Picture")
                {
                    CaptionML = ENU = '&Picture',
                                ENN = '&Picture';
                    Image = Picture;
                    RunObject = Page "Contact Picture";
                    RunPageLink = "No." = FIELD("No.");
                    ApplicationArea = All;
                }
                action("Co&mments")
                {
                    CaptionML = ENU = 'Co&mments',
                                ENN = 'Co&mments';
                    Image = ViewComments;
                    RunObject = Page "Rlshp. Mgt. Comment Sheet";
                    RunPageLink = "Table Name" = CONST(Contact), "No." = FIELD("No."), "Sub No." = CONST(0);
                    ApplicationArea = All;
                }
                group("Alternati&ve Address")
                {
                    CaptionML = ENU = 'Alternati&ve Address',
                                ENN = 'Alternati&ve Address';
                    Image = Addresses;
                    action(Card)
                    {
                        CaptionML = ENU = 'Card',
                                    ENN = 'Card';
                        Image = EditLines;
                        RunObject = Page "Contact Alt. Address List";
                        RunPageLink = "Contact No." = FIELD("No.");
                        ApplicationArea = All;
                    }
                    action("Date Ranges")
                    {
                        CaptionML = ENU = 'Date Ranges',
                                    ENN = 'Date Ranges';
                        Image = DateRange;
                        RunObject = Page 5059;
                        RunPageLink = "Contact No." = FIELD("No.");
                        ApplicationArea = All;
                    }
                }
                separator(Action48)
                {
                    CaptionML = ENU = '',
                                ENN = '';
                }
            }
            group(ActionGroupCRM)
            {
                CaptionML = ENU = 'Dynamics CRM',
                            ENN = 'Dynamics CRM';
                Visible = CRMIntegrationEnabled;
                action(CRMGotoContact)
                {
                    CaptionML = ENU = 'Contact',
                                ENN = 'Contact';
                    Enabled = (Type <> Type::Company) AND ("Company No." <> '');
                    Image = CoupledContactPerson;
                    ToolTipML = ENU = 'Open the coupled Microsoft Dynamics CRM contact.',
                                ENN = 'Open the coupled Microsoft Dynamics CRM contact.';
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
                    Enabled = (Type <> Type::Company) AND ("Company No." <> '');
                    Image = Refresh;
                    ToolTipML = ENU = 'Send or get updated data to or from Microsoft Dynamics CRM.',
                                ENN = 'Send or get updated data to or from Microsoft Dynamics CRM.';
                    ApplicationArea = All;

                    trigger OnAction();
                    var
                        Contact: Record Contact;
                        CRMIntegrationManagement: Codeunit 5330;
                        ContactRecordRef: RecordRef;
                    begin
                        CurrPage.SETSELECTIONFILTER(Contact);
                        Contact.NEXT;

                        IF Contact.COUNT = 1 THEN
                            CRMIntegrationManagement.UpdateOneNow(Contact.RECORDID)
                        ELSE BEGIN
                            ContactRecordRef.GETTABLE(Contact);
                            CRMIntegrationManagement.UpdateMultipleNow(ContactRecordRef);
                        END
                    end;
                }
                group(Coupling)
                {
                    CaptionML = Comment = 'Coupling is a noun',
                                ENU = 'Coupling',
                                ENN = 'Coupling';
                    Enabled = (Type <> Type::Company) AND ("Company No." <> '');
                    Image = LinkAccount;
                    ToolTipML = ENU = 'Create, change, or delete a coupling between the Microsoft Dynamics NAV record and a Microsoft Dynamics CRM record.',
                                ENN = 'Create, change, or delete a coupling between the Microsoft Dynamics NAV record and a Microsoft Dynamics CRM record.';
                    action(ManageCRMCoupling)
                    {
                        AccessByPermission = TableData "CRM Integration Record" = IM;
                        CaptionML = ENU = 'Set Up Coupling',
                                    ENN = 'Set Up Coupling';
                        Image = LinkAccount;
                        ToolTipML = ENU = 'Create or modify the coupling to a Microsoft Dynamics CRM contact.',
                                    ENN = 'Create or modify the coupling to a Microsoft Dynamics CRM contact.';
                        ApplicationArea = All;

                        trigger OnAction();
                        var
                            CRMIntegrationManagement: Codeunit "CRM Integration Management";
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
                        ToolTipML = ENU = 'Delete the coupling to a Microsoft Dynamics CRM contact.',
                                    ENN = 'Delete the coupling to a Microsoft Dynamics CRM contact.';
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
                        CaptionML = ENU = 'Create Contact in Dynamics CRM',
                                    ENN = 'Create Contact in Dynamics CRM';
                        Enabled = (Type <> Type::Company) AND ("Company No." <> '');
                        Image = NewCustomer;
                        ApplicationArea = All;

                        trigger OnAction();
                        var
                            Contact: Record Contact;
                            CRMIntegrationManagement: Codeunit 5330;
                            ContactRecordRef: RecordRef;
                        begin
                            CurrPage.SETSELECTIONFILTER(Contact);
                            Contact.NEXT;

                            IF Contact.COUNT = 1 THEN
                                CRMIntegrationManagement.CreateNewRecordInCRM(RECORDID, FALSE)
                            ELSE BEGIN
                                ContactRecordRef.GETTABLE(Contact);
                                CRMIntegrationManagement.CreateNewRecordsInCRM(ContactRecordRef);
                            END
                        end;
                    }
                    action(CreateFromCRM)
                    {
                        CaptionML = ENU = 'Create Contact in Dynamics NAV',
                                    ENN = 'Create Contact in Dynamics NAV';
                        Image = NewCustomer;
                        ApplicationArea = All;

                        trigger OnAction();
                        var
                            CRMIntegrationManagement: Codeunit 5330;
                        begin
                            CRMIntegrationManagement.ManageCreateNewRecordFromCRM(DATABASE::Contact);
                        end;
                    }
                }
            }
            group("Related Information")
            {
                CaptionML = ENU = 'Related Information',
                            ENN = 'Related Information';
                Image = Users;
                action("Relate&d Contacts")
                {
                    CaptionML = ENU = 'Relate&d Contacts',
                                ENN = 'Relate&d Contacts';
                    Image = Users;
                    RunObject = Page 5052;
                    RunPageLink = "Company No." = FIELD("Company No.");
                    ApplicationArea = All;
                }
                action("Segmen&ts")
                {
                    CaptionML = ENU = 'Segmen&ts',
                                ENN = 'Segmen&ts';
                    Image = Segment;
                    RunObject = Page 5150;
                    RunPageLink = "Contact Company No." = FIELD("Company No."), "Contact No." = FILTER(<> ''), "Contact No." = FIELD(FILTER("Lookup Contact No."));
                    RunPageView = SORTING("Contact No.", "Segment No.");
                    ApplicationArea = All;
                }
                action("Mailing &Groups")
                {
                    CaptionML = ENU = 'Mailing &Groups',
                                ENN = 'Mailing &Groups';
                    Image = DistributionGroup;
                    RunObject = Page 5064;
                    RunPageLink = "Contact No." = FIELD("No.");
                    ApplicationArea = All;
                }
                action("C&ustomer/Vendor/Bank Acc.")
                {
                    CaptionML = ENU = 'C&ustomer/Vendor/Bank Acc.',
                                ENN = 'C&ustomer/Vendor/Bank Acc.';
                    Image = ContactReference;
                    ApplicationArea = All;

                    trigger OnAction();
                    var

                    begin
                        ShowCustVendBank;

                    end;
                }
            }
            group(Tasks)
            {
                CaptionML = ENU = 'Tasks',
                            ENN = 'Tasks';
                Image = Task;
                action("T&o-dos")
                {
                    CaptionML = ENU = 'T&o-dos',
                                ENN = 'T&o-dos';
                    Image = TaskList;
                    RunObject = Page 5096;
                    RunPageLink = "Contact Company No." = FIELD("Company No."), "Contact No." = FIELD(FILTER("Lookup Contact No.")), "System To-do Type" = FILTER("Contact Attendee");
                    RunPageView = SORTING("Contact Company No.", "Contact No.");
                    ApplicationArea = All;
                }
                action("Oppo&rtunities")
                {
                    CaptionML = ENU = 'Oppo&rtunities',
                                ENN = 'Oppo&rtunities';
                    Image = OpportunityList;
                    RunObject = Page "Opportunity List";
                    RunPageLink = "Contact Company No." = FIELD("Company No."), "Contact No." = FILTER(<> ''), "Contact No." = FIELD(FILTER("Lookup Contact No."));
                    RunPageView = SORTING("Contact Company No.", "Contact No.");
                    ApplicationArea = All;
                }
                separator(Action52)
                {
                    CaptionML = ENU = '',
                                ENN = '';
                }
            }
            group(Documents)
            {
                CaptionML = ENU = 'Documents',
                            ENN = 'Documents';
                Image = Documents;
                action("Sales &Quotes")
                {
                    CaptionML = ENU = 'Sales &Quotes',
                                ENN = 'Sales &Quotes';
                    Image = Quote;
                    RunObject = Page "Sales Quotes";
                    RunPageLink = "Sell-to Contact No." = FIELD("No.");
                    RunPageView = SORTING("Document Type", "Sell-to Contact No.");
                    ApplicationArea = All;
                }
                separator(Action69)
                {
                }
            }
            group(History)
            {
                CaptionML = ENU = 'History',
                            ENN = 'History';
                Image = History;
                action("Postponed &Interactions")
                {
                    CaptionML = ENU = 'Postponed &Interactions',
                                ENN = 'Postponed &Interactions';
                    Image = PostponedInteractions;
                    RunObject = Page "Postponed Interactions";
                    RunPageLink = "Contact Company No." = FIELD("Company No."), "Contact No." = FILTER(<> ''), "Contact No." = FIELD(FILTER("Lookup Contact No."));
                    RunPageView = SORTING("Contact Company No.", "Contact No.");
                    ApplicationArea = All;
                }
                action("Interaction Log E&ntries")
                {
                    CaptionML = ENU = 'Interaction Log E&ntries',
                                ENN = 'Interaction Log E&ntries';
                    Image = InteractionLog;
                    RunObject = Page "Interaction Log Entries";
                    RunPageLink = "Contact Company No." = FIELD("Company No."), "Contact No." = FILTER(<> ''), "Contact No." = FIELD(FILTER("Lookup Contact No."));
                    RunPageView = SORTING("Contact Company No.", "Contact No.");
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
                    RunObject = Page "Contact Statistics";
                    RunPageLink = "No." = FIELD("No.");
                    ShortCutKey = 'F7';
                    ApplicationArea = All;
                }
            }
        }
        area(processing)
        {
            group("F&unctions")
            {
                CaptionML = ENU = 'F&unctions',
                            ENN = 'F&unctions';
                Image = "Action";
                action("Make &Phone Call")
                {
                    CaptionML = ENU = 'Make &Phone Call',
                                ENN = 'Make &Phone Call';
                    Image = Calls;
                    ApplicationArea = All;

                    trigger OnAction();
                    var
                        TAPIManagement: Codeunit TAPIManagement;
                    begin
                        TAPIManagement.DialContCustVendBank(DATABASE::Contact, "No.", "Phone No.", '');
                    end;
                }
                action("Launch &Web Source")
                {
                    CaptionML = ENU = 'Launch &Web Source',
                                ENN = 'Launch &Web Source';
                    Image = LaunchWeb;
                    ApplicationArea = All;

                    trigger OnAction();
                    var
                        ContactWebSource: Record "Contact Web Source";
                    begin
                        ContactWebSource.SETRANGE("Contact No.", "Company No.");
                        IF PAGE.RUNMODAL(PAGE::"Web Source Launch", ContactWebSource) = ACTION::LookupOK THEN
                            ContactWebSource.Launch;
                    end;
                }
                action("Print Cover &Sheet")
                {
                    CaptionML = ENU = 'Print Cover &Sheet',
                                ENN = 'Print Cover &Sheet';
                    Image = PrintCover;
                    ApplicationArea = All;

                    trigger OnAction();
                    var
                        Cont: Record Contact;
                    begin
                        Cont := Rec;
                        Cont.SETRECFILTER;
                        REPORT.RUN(REPORT::"Contact - Cover Sheet", TRUE, FALSE, Cont);
                    end;
                }
                group("Create as")
                {
                    CaptionML = ENU = 'Create as',
                                ENN = 'Create as';
                    Image = CustomerContact;
                    action(Customer)
                    {
                        CaptionML = ENU = 'Customer',
                                    ENN = 'Customer';
                        Image = Customer;
                        ApplicationArea = All;

                        trigger OnAction();
                        begin
                            CreateCustomer(ChooseCustomerTemplate);
                        end;
                    }
                    action(Vendor)
                    {
                        CaptionML = ENU = 'Vendor',
                                    ENN = 'Vendor';
                        Image = Vendor;
                        ApplicationArea = All;

                        trigger OnAction();
                        begin
                            CreateVendor;
                        end;
                    }
                    action(Bank)
                    {
                        AccessByPermission = TableData "Bank Account" = R;
                        CaptionML = ENU = 'Bank',
                                    ENN = 'Bank';
                        Image = Bank;
                        ApplicationArea = All;

                        trigger OnAction();
                        begin
                            CreateBankAccount;
                        end;
                    }
                }
                group("Link with existing")
                {
                    CaptionML = ENU = 'Link with existing',
                                ENN = 'Link with existing';
                    Image = Links;
                    action(Action63)
                    {
                        CaptionML = ENU = 'Customer',
                                    ENN = 'Customer';
                        Image = Customer;
                        ApplicationArea = All;

                        trigger OnAction();
                        begin
                            CreateCustomerLink;
                        end;
                    }
                    action(Action64)
                    {
                        CaptionML = ENU = 'Vendor',
                                    ENN = 'Vendor';
                        Image = Vendor;
                        ApplicationArea = All;

                        trigger OnAction();
                        begin
                            CreateVendorLink;
                        end;
                    }
                    action(Action65)
                    {
                        AccessByPermission = TableData "Bank Account" = R;
                        CaptionML = ENU = 'Bank',
                                    ENN = 'Bank';
                        Image = Bank;
                        ApplicationArea = All;

                        trigger OnAction();
                        begin
                            CreateBankAccountLink;
                        end;
                    }
                }
            }
            action("Create &Interact")
            {
                AccessByPermission = TableData Attachment = R;
                CaptionML = ENU = 'Create &Interact',
                            ENN = 'Create &Interact';
                Image = CreateInteraction;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction();
                begin
                    CreateInteraction;
                end;
            }
        }
        area(creation)
        {
            action("New Sales Quote")
            {
                CaptionML = ENU = 'New Sales Quote',
                            ENN = 'New Sales Quote';
                Image = Quote;
                Promoted = true;
                PromotedCategory = New;
                RunObject = Page "Sales Quote";
                RunPageLink = "Sell-to Contact No." = FIELD("No.");
                RunPageMode = Create;
                ApplicationArea = All;
            }
        }
        area(reporting)
        {
            action("Contact Cover Sheet")
            {
                CaptionML = ENU = 'Contact Cover Sheet',
                            ENN = 'Contact Cover Sheet';
                Image = "Report";
                Promoted = false;
                ApplicationArea = All;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = "Report";

                trigger OnAction();
                begin
                    Cont := Rec;
                    Cont.SETRECFILTER;
                    REPORT.RUN(REPORT::"Contact - Cover Sheet", TRUE, FALSE, Cont);
                end;
            }
            action("Contact Company Summary")
            {
                CaptionML = ENU = 'Contact Company Summary',
                            ENN = 'Contact Company Summary';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                RunObject = Report "Contact - Company Summary";
                ApplicationArea = All;
            }
            action("Contact Labels")
            {
                CaptionML = ENU = 'Contact Labels',
                            ENN = 'Contact Labels';
                Image = "Report";
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = "Report";
                RunObject = Report "Contact - Labels";
                ApplicationArea = All;
            }
            action("Questionnaire Handout")
            {
                CaptionML = ENU = 'Questionnaire Handout',
                            ENN = 'Questionnaire Handout';
                Image = "Report";
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = "Report";
                RunObject = Report "Questionnaire - Handouts";
                ApplicationArea = All;
            }
            action("Sales Cycle Analysis")
            {
                CaptionML = ENU = 'Sales Cycle Analysis',
                            ENN = 'Sales Cycle Analysis';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                RunObject = Report "Sales Cycle - Analysis";
                ApplicationArea = All;
            }
        }
    }

    trigger OnAfterGetRecord();
    var
        CRMCouplingManagement: Codeunit "CRM Coupling Management";
    begin
    end;

    trigger OnOpenPage();
    var
        CRMIntegrationManagement: Codeunit "CRM Integration Management";
    begin
        SETFILTER("No.", '>CONT001720');
    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean;
    var
        Contact: Record Contact;
        CustomerContactData: Record "Customer/Contact Data";
        NoLVar: Integer;
    begin
        IF CloseAction IN [ACTION::OK, ACTION::LookupOK] THEN BEGIN
            CustomerContactData.RESET;
            CustomerContactData.SETRANGE("Sales Quote No.", QuoteNoGVar);
            IF CustomerContactData.FINDLAST THEN
                NoLVar := CustomerContactData."No." + 1
            ELSE
                NoLVar := 1;


            Contact.RESET;
            Contact.SETRANGE("Make A Quote", TRUE);
            IF Contact.FINDSET THEN
                REPEAT
                    CustomerContactData.INIT;
                    CustomerContactData."No." := NoLVar;
                    CustomerContactData."Sales Quote No." := QuoteNoGVar;
                    CustomerContactData."Customer\Contact" := Contact."No.";
                    CustomerContactData."Email Id" := Contact."E-Mail";
                    CustomerContactData.Name := Contact.Name;
                    CustomerContactData.Place := Contact.City;
                    CustomerContactData.Type := CustomerContactData.Type::Contact;
                    CustomerContactData.INSERT;
                    NoLVar += 1;
                    Contact."Make A Quote" := FALSE;
                    Contact.MODIFY;
                UNTIL Contact.NEXT = 0;
        END;
    end;

    var
        Cont: Record Contact;

        StyleIsStrong: Boolean;

        NameIndent: Integer;
        CompanyGroupEnabled: Boolean;
        PersonGroupEnabled: Boolean;
        CRMIntegrationEnabled: Boolean;
        CRMIsCoupledToRecord: Boolean;
        QuoteNoGVar: Code[20];


    local procedure EnableFields();
    begin
        CompanyGroupEnabled := Type = Type::Company;
        PersonGroupEnabled := Type = Type::Person;
    end;


    procedure SendQuoteNo(QuoLpar: Code[20]);
    begin
        QuoteNoGVar := QuoLpar;
    end;
}

